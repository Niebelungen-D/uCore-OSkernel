# 概述

在前几次实验的基础上，我们将实现CPU的虚拟化。可以理解为让每个用户态进程认为自己“独占”CPU资源。

## 进程

对于进程的**定义**：进程是指一个具有一定独立功能的程序在一个数据集合上的一次动态执行过程。

进程包含了正在运行的一个程序的所有状态信息。（代码，数据，寄存器，进程所占资源等）

**进程与程序**
程序是一个静态可执行文件，是有序代码的集合。而进程是执行中的程序，有内核态和用户态。

### 进程控制块PCB
- PCB描述进程的基本情况以及运行变化的过程
- 进程控制块是进程的唯一标识。
- 调度和状态信息、进程间通信信息、存储管理信息、进程所用的资源和与PCB相关的进程队列。如用链表维护正在就绪态的所有进程。

### 进程状态

进程生命周期的划分：进程创建、进程执行、进程等待、进程抢占、进程唤醒和进程结束。

#### 进程创建

进程创建的情况：
- 系统初始化时
- 用户请求创建一个新进程
- 正在运行的进程执行了创建进程的系统调用

创建的进程，在为其准备好相应的资源后，会加入就绪队列。

#### 进程执行

CPU的分时执行，当一个进程执行了一个时间片后，内核从就绪队列基于某种策略选择一个进程执行。

#### 进程等待

进程等待（阻塞）的情况：
- 请求并等待系统服务，无法马上完成
- 启动某种操作，无法马上完成
- 需要的数据没有到达（例如磁盘读写）

进程进入等待状态只会是进程自身的原因。

#### 进程唤醒
当等待状态的进程所要求的条件（资源准备好，某事件的发生）满足后，会加入到就绪状态。

进程只会被别的进程或操作系统唤醒。

#### 进程结束

释放进程所占的所有资源

结束的情况：正常退出、错误退出、致命错误、被其他进程杀死

#### 进程挂起

系统的内存不足时，需要将某些进程放到磁盘中，称为进程挂起。

-   等待挂起（Blocked-suspend）： 进程在外存并等待某事件的出现。
-   就绪挂起（Ready-suspend）：进程在外存，但只要进入内存，即可运行。
-   挂起（Suspend）：把一个进程从内存转到外存。
    -   等待到等待挂起：没有进程处于就绪状态或就绪进程要求更多内存资源。
    -   就绪到就绪挂起：当有高优先级进程处于等待状态（系统认为很快会就绪的），低优先级就绪进程会挂起，为高优先级进程提供更大的内存空间。
    -   运行到就绪挂起：当有高优先级等待进程因事件出现而进入就绪挂起。
    -   等待挂起到就绪挂起：当有等待挂起进程因相关事件出现而转换状态。
-   激活（Activate）：把一个进程从外存转到内存
    -   就绪挂起到就绪：没有就绪进程或挂起就绪进程优先级高于就绪进程。
    -   等待挂起到等待：当一个进程释放足够内存，并有高优先级等待挂起进程。

## 线程

 线程的出现：我们希望进程之间有更好的并发性，并实现更高程度的数据共享。而这与进程的独立性相矛盾，所以有了线程。

### 概念
线程是进程的一部分，描述指令流执行状态，是进程中的指令执行流最小单位，是CPU调度的基本单位。

- 进程的资源分配角色：进程由一组相关资源构成，包括地址空间、打开的文件等各种资源。

- 线程的处理机调度角色：线程描述在进程资源环境中指令流执行状态。

进程变成了资源分配的单位，线程是CPU调度的单位。

### 优缺点

-   优点：
    -   一个进程中可以存在多个线程
    -   各个线程可以并发执行
    -   各个线程之间可以共享地址空间和文件等资源。
-   缺点：
    -   一个线程崩溃，会导致其所属的进程的所有线程崩溃。

### 用户线程

由一组用户级的线程库函数来完成线程的管理，包括线程的创建、终止、同步和调度等。

#### 特点
用户线程不依赖操作系统，在操作系统的角度面对的依然只有每个进程的PCB。而在用户态，有各个进程内部实现线程控制块TCB。并实现自定义的线程调度算法。

由于不经过操作系统，所有没有了用户态和内核态的切换，减少了很大的开销。且有更自由的线程调用策略。

#### 缺点

线程发起系统调用请求操作系统服务时，对操作系统来说是以一个进程的名义操作的。如果阻塞，整个进程都会进入等待状态。而且不支持基于线程的处理机抢占。操作系统仅分配一个进程的时间片，这样所有线程分配到的执行时间很少，只能按进程分配CPU时间。

### 内核线程

将线程的操作加入到内核中，由内核通过系统调用实现的线程机制，由内核完成线程的创建、终止和管理。

这样解决了用户线程的很多问题，但是加大了线程用户态与内核态之间切换的消耗。

### 轻权线程

-   内核支持的用户线程。一个进程可包含一个或多个轻权进程，每个轻权进程由一个单独的内核线程来支持。
    
-   过于复杂以至于优点没有体现出来，最后演化为单一的内核线程支持。（笑）

### 线程与进程的比较

-   进程是资源分配单元，而线程是CPU调度单位。
-   进程拥有一个完整的资源平台，而线程只独享指令流执行的必要资源，例如寄存器与栈。
-   线程具有就绪、等待和运行三种基本状态和状态间的转换关系。
-   线程能减小并发执行的事件和空闲开销。
    -   线程的创建时间和终止时间比进程短。
    -   同一进程内的线程切换时间比进程短。
    -   由于同一进程的各线程间共享内存和文件资源，可不通过内核进行直接通信。

## 进程切换
暂停当前进程，并从运行状态变成其他状态。调度另一个进程，并从就绪状态转为运行状态。
进程切换要求：
- 切换前，保存上下文
- 切换后，恢复上下文
- 速度要快

### ucore的PCB

```c
enum proc_state {
    PROC_UNINIT = 0,  // 未初始化的     -- alloc_proc
    PROC_SLEEPING,    // 等待状态       -- try_free_pages, do_wait, do_sleep
    PROC_RUNNABLE,    // 就绪/运行状态   -- proc_init, wakeup_proc,
    PROC_ZOMBIE,      // 僵死状态       -- do_exit
};

struct context {  // 保存的上下文寄存器，注意没有eax寄存器和段寄存器
    uint32_t eip;
    uint32_t esp;
    uint32_t ebx;
    uint32_t ecx;
    uint32_t edx;
    uint32_t esi;
    uint32_t edi;
    uint32_t ebp;
};

struct proc_struct {
    enum proc_state state;                      // Process state
    int pid;                                    // Process ID
    int runs;                                   // the running times of Proces
    uintptr_t kstack;                           // Process kernel stack
    volatile bool need_resched;                 // bool value: need to be rescheduled to release CPU?
    struct proc_struct *parent;                 // the parent process
    struct mm_struct *mm;                       // Process's memory management field
    struct context context;                     // Switch here to run process
    struct trapframe *tf;                       // Trap frame for current interrupt
    uintptr_t cr3;                              // CR3 register: the base addr of Page Directroy Table(PDT)
    uint32_t flags;                             // Process flag
    char name[PROC_NAME_LEN + 1];               // Process name
    list_entry_t list_link;                     // Process link list 
    list_entry_t hash_link;                     // Process hash list
};
```

操作系统中进程的切换会非常的频繁，且进程较多，为了提高索引的效率使用了hash表。

### 切换流程

- 开始调度：uCore中，内核的第一个进程`idleproc`会执行`cpu_idle`函数，并从中调用`schedule`函数，准备开始调度进程。
- 清除调度标志：`schedule`清除调度标志，不能再次修改
- 查找就绪进程：`schedule`并从当前进程在链表中的位置开始，遍历进程控制块，直到找出处于**就绪状态**的进程。可能找到的还是当前进程。
- 修改进程状态：`schedule`当前进程进入就绪态或等待状态，新的进程改为运行
- 进程切换：`switch_to`

**swtich_to**
`switch_to`进行进程的切换，为了保证切换速度，这部分的代码使用汇编实现。在不同的操作系统上需要保存的寄存器等信息不同，所以实现也不同。大致为前半段保存进程信息，切换后，从新进程的PCB恢复进程上下文。
```c
.text
.globl switch_to
switch_to:                      # switch_to(from, to)

    # save from's registers
    movl 4(%esp), %eax          # eax points to from
    popl 0(%eax)                # save eip !popl
    movl %esp, 4(%eax)          # save esp::context of from
    movl %ebx, 8(%eax)          # save ebx::context of from
    movl %ecx, 12(%eax)         # save ecx::context of from
    movl %edx, 16(%eax)         # save edx::context of from
    movl %esi, 20(%eax)         # save esi::context of from
    movl %edi, 24(%eax)         # save edi::context of from
    movl %ebp, 28(%eax)         # save ebp::context of from

    # restore to's registers
    movl 4(%esp), %eax          # not 8(%esp): popped return address already
                                # eax now points to to
    movl 28(%eax), %ebp         # restore ebp::context of to
    movl 24(%eax), %edi         # restore edi::context of to
    movl 20(%eax), %esi         # restore esi::context of to
    movl 16(%eax), %edx         # restore edx::context of to
    movl 12(%eax), %ecx         # restore ecx::context of to
    movl 8(%eax), %ebx          # restore ebx::context of to
    movl 4(%eax), %esp          # restore esp::context of to

    pushl 0(%eax)               # push eip

    ret
```

### 进程创建

Windows API：`CreateProcess()`
Unix API：`fork`和`exec`
-   其中，`fork`把一个进程复制成两个**除PID以外完全相同**的进程。
-   `exec`用新进程来重写当前进程，PID没有改变。


fork创建一个继承的子进程。该子进程复制父进程的所有变量和内存，以及父进程的所有CPU寄存器（除了某个特殊寄存器，以区分是子进程还是父进程）。
fork函数一次调用，返回两个值。父进程中返回子进程的PID，子进程中返回0。

fork函数的开销十分昂贵，其实现开销来源于
- 对子进程分配内存。
- 复制父进程的内存和寄存器到子进程中。

而且，在大多数情况下，调用fork函数后就紧接着调用exec，此时fork中的内存复制操作是无用的。因此，fork函数中使用写时复制技术(Copy on Write， COW)。

#### 空闲进程的创建

空闲进程`idle`主要工作是完成内核中各个子系统的初始化，并最后用于调度其他进程。该进程最终会一直在`cpu_idle`函数中判断当前是否可调度。

由于该进程是为了调度进程而创建的，所以其`need_resched`成员初始时为1。

#### 第一个内核线程的创建

第一个内核进程是未来所有新进程的父进程或祖先进程。
- `initproc`：在`proc_init()`创建
- 初始化trapframe：`kernel_thread` --> `do_fork` --> `copy_thread()`
- 初始化initproc：初始化它的PCB，`alloc_proc`
- 初始化内核堆栈：`setup_stack()`
- 内存共享：`copy_stack()`与其他内核线程共享内核地址空间
- 把initproc放到就绪队列
- 唤醒

### 进程终止
#### wait
`wait`系统调用用于父进程等待子进程的结束
- 子进程结束时，通过`exit()`向父进程返回一个值
- 父进程通过`wait`接收并处理返回值

 `wait`函数调用的功能
 - 有子进程存活时，父进程进入等待状态，等待子进程返回结果
   	当某子进程调用 `exit()`时，唤醒父进程，将`exit()`的返回值作为父进程中`wait`的返回值
- 有僵尸子进程等待时，`wait()`立即返回其中一个值
- 无子进程存活时，`wait()`立即返回

#### exit
进程结束时调用`exit()`，完成进程资源回收。
`exit`函数调用的功能

   - 将调用参数作为进程的“结果”
   -   关闭所有打开的文件等占用资源。
   -   释放内存
   -   释放大部分进程相关的内核数据结构
   -   检查父进程是否存活
       -   如果存活，则保留结果的值，直到父进程使用。同时当前进程进入僵尸(zombie)状态。
       -   如果没有，它将释放所有的数据结构，进程结束。
  -   清理所有等待的僵尸进程。
 
  进程终止是最终的垃圾收集（资源回收）。

## uCore进程的初始化

## ucore中exec的实现