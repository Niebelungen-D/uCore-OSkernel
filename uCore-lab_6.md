在之前的lab中我们实现了在用户态运行多个进程。但是，对于所有的进程而言，直接将cpu交给进程，直到它结束是非常不合理的。所以我们必须，实现进程的调度算法，为所有的进程/线程分配合理的使用cpu的时间。

## 练习1
```c
// The introduction of scheduling classes is borrrowed from Linux, and makes the 
// core scheduler quite extensible. These classes (the scheduler modules) encapsulate 
// the scheduling policies. 
struct sched_class {
    // the name of sched_class
    const char *name;
    // Init the run queue
    void (*init)(struct run_queue *rq);
    // put the proc into runqueue, and this function must be called with rq_lock
    void (*enqueue)(struct run_queue *rq, struct proc_struct *proc);
    // get the proc out runqueue, and this function must be called with rq_lock
    void (*dequeue)(struct run_queue *rq, struct proc_struct *proc);
    // choose the next runnable task
    struct proc_struct *(*pick_next)(struct run_queue *rq);
    // dealer of the time-tick
    void (*proc_tick)(struct run_queue *rq, struct proc_struct *proc);
    /* for SMP support in the future
     *  load_balance
     *     void (*load_balance)(struct rq* rq);
     *  get some proc from this rq, used in load_balance,
     *  return value is the num of gotten proc
     *  int (*get_proc)(struct rq* rq, struct proc* procs_moved[]);
     */
};
```

- `init`：初始化队列的函数指针
- `enqueue`：将某一进程加入某一队列的函数指针, 则当前进程的rq字段指向这个队列，同时初始化它的时间片大小。该队列进程个数++
- `dequeue`：将某一进程从某一队列中取出的函数指针，该队列进程--
- `pick_next`：取出某一队列中的第一个进程PCB将其返回
- `proc_tick`：时间片处理函数指针，没一个tick使进程的`time_slice--`当为0时，说明该进程的执行时间到，需要调出cpu，进行进程调度。

### 多级反馈队列

多级反馈队列调度根据不同优先级维护不同的优先级队列。每个队列有不同的时间片大小，优先级越高时间片越小。在进行调度时，CPU会首先从高优先级队列中选择进程，高优先级队列为空后才从次优先队列选择。若高优先级级的进程在所分配的时间片内没有执行完毕，则会进入下一优先级的末尾，分配更大的时间片。

```c
struct run_queue {
    list_entry_t run_list;
    unsigned int proc_num;
    int max_time_slice;
    // For LAB6 ONLY
    skew_heap_entry_t *lab6_run_pool;
};
```

通过描述可知，多级反馈队列需要维护多个`run_queue`，每个`run_queue`设置不同的`max_time_slice`。

- 在初始化时为多个队列进程初始化
- 在取出时，需要选择从哪一队列取出
- 在进行调度得到下一个时，需要先遍历高优先级队列
- 在加入某一进程到某一队列时，需要判断多种情况
  - 维护一个指针指向该进程先前存在的队列，如果是新建立的进程则为空
  - 将新建立的进程加入其所属的优先级队列，并设置PCB中相应的字段
  - 将从其他队列取出，需要再次加入的进程，加入到其次一级优先队列中
  - 如果已经是从最低优先级队列取出的，则依然加入到该队列中
  - 进程需要加入到队列尾部
- 低优先级队列的进程在运行时，如果有高优先级进程，必须马上让出CPU
  - 在高优先级进程被加入时，如果当前运行的进程的优先级比新创建的低，马上执行调度
  - 添加新的标志，如果低优先进程时被高优先级进程抢占的，则不分配新的时间片

## 练习2

**init**

```c
static void
stride_init(struct run_queue *rq) {
     list_init(&rq->run_list);
     rq->lab6_run_pool = NULL; 
     rq->proc_num = 0;
}
```

初始化就绪队列，斜堆，进程数

**enqueue**

```c
static void
stride_enqueue(struct run_queue *rq, struct proc_struct *proc) {
     rq->lab6_run_pool = skew_heap_insert(rq->lab6_run_pool, &proc->lab6_run_pool, proc_stride_comp_f);
     if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
          proc->time_slice = rq->max_time_slice;
     }
     proc->rq = rq;
     rq->proc_num ++;
}
```

向队列中加入新的进程，需要通过`skew_heap_insert`，并要更新斜堆。

**dequeue**

```c
static void
stride_dequeue(struct run_queue *rq, struct proc_struct *proc) {
     rq->lab6_run_pool = skew_heap_remove(rq->lab6_run_pool, &proc->lab6_run_pool, proc_stride_comp_f);
     rq->proc_num --;
}
```

将进程从某一队列中取出

**pick_next**

```c
static struct proc_struct *
stride_pick_next(struct run_queue *rq) {
     skew_heap_entry_t *she = rq->lab6_run_pool;
     if(she == NULL)
          return NULL;
     struct proc_struct *p = le2proc(she, lab6_run_pool);
     p->lab6_stride = p->lab6_stride + (BIG_STRIDE/p->lab6_priority);
     return p;

}
```

斜堆事一种小根堆，直接将根结点返回即可，需要判断是否为空。之后更新其步长。

### stride 溢出问题

在ucore中使用32位无符号数描述stride。而当一个进程的stride已经接近最大值，再加上pass后，可以出现溢出。使得当前进程的stride变小，从而打乱了调度顺序。

eg:


|  A.stride(实际值)   | A.stride（理论值） | A.pass |
| :-: | :-: | :-: |
| 65534 | 65534 | 100 |
| B.stride(实际值) | B.stride（理论值） | B.pass |
| 65535 | 65535 | 50 |

经过一轮调度后，队列将如下：

|  A.stride(实际值)   | A.stride（理论值） | A.pass |
| :-: | :-: | :-: |
| 98 | 65634 | 100 |
| B.stride(实际值) | B.stride（理论值） | B.pass |
| 65535 | 65535 | 50 |

明显，A的stride产生了溢出。虽然从数值上98<65535，如果使用16位的带符号整数 98 - 65535 = 99 > 0，从这一点上98比65535要大。

解决这个问题使用的方法是设置一个最大步长，如果超出这个范围，说明产生了溢出。这样我们依然可以进行比较。比较的方法是将两数相减，得到一个有符号的数。通过结果的大小和符号判断比较结果。

我们首先在理论上分析这个问题：令`PASS_MAX`为当前所有进程里最大的步进值。则我们可以证明如下结论：对每次Stride调度器的调度步骤中，有其最大的步进值`STRIDE_MAX`和最小的步进值`STRIDE_MIN`之差：`STRIDE_MAX – STRIDE_MIN <= PASS_MAX`

> 首先，假设该结论不成立。
>
> 则当我们从队列取出一个进程a时，就绪队列存在进程b，使得b->stride - a->stride > PASS_MAX，此时b->stride < a->stride。则说明a其实是溢出后的值。算法发生错误。故结论成立。

根据上述结论我们需要维护一个32位的有符号整数，且`PASS_MAX <= BigStride`，根据定义`priority > 1`不妨就让`PASS_MAX == BigStride/priority`。所以`BigStride == 0x7fffffff`。

```c 
static int
proc_stride_comp_f(void *a, void *b)
{
     struct proc_struct *p = le2proc(a, lab6_run_pool);
     struct proc_struct *q = le2proc(b, lab6_run_pool);
     int32_t c = p->lab6_stride - q->lab6_stride;
     if (c > 0) return 1;
     else if (c == 0) return 0;
     else return -1;
}
```

一旦相减的结果大于我们设立的`BigStride`，就是负数。则`a < b`。

这部分的内容确实有点绕，但是核心就是围绕那个公式进行的。