# 启动

![](https://raw.githubusercontent.com/Niebelungen-D/Imgbed-blog/main/img/20210606141617.png)

在CPU加电后，寄存器CS:IP被强制初始化为`0xf000:0xfff0`，此时CPU处于实模式，有20位地址线可用，可以访问1MB的地址空间，`PC = 16*CS + IP`。这时的地址也是真实的物理地址。

各个段寄存器和IP都是16位的。

## BIOS

在这个位置是一个`jmp far f000：e05b`指令，它会让CPU跳转到BIOS程序的位置。接下来，BIOS就开始运行

BIOS实际上是被固化在计算机ROM（只读存储器）芯片上的一个特殊的软件，为上层软件提供最底层的、最直接的硬件控制与支持。更形象地说，BIOS就是PC计算机硬件与上层软件程序之间的一个"桥梁"，负责访问和控制硬件。它做了这些工作

- 硬件自检POST
  - 检测系统中内存和显卡等关键部件的存在和工作状态
  - 查找并执行显卡等接口卡BIOS，进行设备初始化
- 执行系统BIOS，进行系统检测
  - 检测和配置系统中安装的即插即用设备
  - 检测并初始化外设、在`0x000-0x3ff`建立数据结构，中断向量表IVT并填写中断例程。
- 更新CMOS中的扩展系统配置数据ESCD
- 按照指定启动顺序从软盘、硬盘和光驱启动  
- 加载第一个扇区，MBR，将其512字节加载到内存中
- 跳转到0x7c00的第一条指令开始执行

## MBR（主引导记录）

MBR（主引导记录），它固定在0盘0道1扇区。BIOS结束后，没有直接将CPU的控制权给操作系统，而是给了MBR。MBR知道操作系统被加载到了哪个分区，也会有多个操作系统需要你去选择加载哪一个。
MBR共512字节（一个扇区大小）包含

 - 启动代码：446字节
    - 检查分许表的正确性
    - 加载并跳转到磁盘上的引导程序bootloder
    - 当安装了多个操作系统时，需要选择加载哪个系统，MBR会跳转到对应的分区执行bootloader
 - 硬盘分区表：64字节
    - 描述分区状态和位置
    - 每个分区描述信息占据16字节
 - 结束标志(魔数)：0xaa55
    - 主引导记录的有效标志

## 加载程序（bootloader）

- 切换到保护模式，启用分段机制
- 从文件系统中读取启动配置信息（与操作系统有关）
  - 各分区都有超级块，一般位于本分区的第2个扇区。超级块里面记录了此分区的信息，其中就有文件系统的魔数，一种文件系统对应一个魔数，通过比较即可得知文件系统类型。
  - 对于uCore来说就是ELF格式
- 启动并显示菜单，可选系统内核列表和参数
- 依据选择的配置加载内核

之后，CPU就交给操作系统内核了。下面我们进一步看看bootloader的过程

## 保护模式的开启

在进入保护模式前，要建立各段的映射关系，从而开启段机制。有关其内存管理的细节在lab2中。

### 建立段映射

各段寄存器指向了不同段的基址，而在每个段的开始有段描述符。

##### 段描述符

- 在分段存储管理机制的保护模式下，每个段由如下三个参数进行定义：段基地址(Base Address)、段界限(Limit)和段属性(Attributes)
  - 段基地址：规定线性地址空间中段的起始地址。任何一个段都可以从32位线性地址空间中的任何一个字节开始，不用像实模式下规定边界必须被16整除。
  - 段界限：规定段的大小。可以以字节为单位或以4K字节为单位。
  - 段属性：确定段的各种性质。
    - 段属性中的粒度位（Granularity），用符号G标记。G=0表示段界限以字节位位单位，20位的界限可表示的范围是1字节至1M字节，增量为1字节；G=1表示段界限以4K字节为单位，于是20位的界限可表示的范围是4K字节至4G字节，增量为4K字节。
    - 类型（TYPE）：用于区别不同类型的描述符。可表示所描述的段是代码段还是数据段，所描述的段是否可读/写/执行，段的扩展方向等。其4bit从左到右分别是
      - 执行位：置1时表示可执行，置0时表示不可执行；
      - 一致位：置1时表示一致码段，置0时表示非一致码段；
      - 读写位：置1时表示可读可写，置0时表示只读；
      - 访问位：置1时表示已访问，置0时表示未访问。
    - 描述符特权级（Descriptor Privilege Level）（DPL）：用来实现保护机制。
    - 段存在位（Segment-Present bit）：如果这一位为0，则此描述符为非法的，不能被用来实现地址转换。如果一个非法描述符被加载进一个段寄存器，处理器会立即产生异常。操作系统可以任意的使用被标识为可用（AVAILABLE）的位。
    - 已访问位（Accessed bit）：当处理器访问该段（当一个指向该段描述符的选择子被加载进一个段寄存器）时，将自动设置访问位。操作系统可清除该位。

#### 段选择子

在一个段寄存器中，会保存一块区域叫段选择子。

- 线性地址部分的选择子是用来选择哪个描述符表和在该表中索引哪个描述符的。选择子可以做为指针变量的一部分，从而对应用程序员是可见的，但是一般是由连接加载器来设置的。
- 段选择子结构
  - 索引（Index）：高13位，在描述符表中从8192个描述符中选择一个描述符。处理器自动将这个索引值乘以8（描述符的长度），再加上描述符表的基址来索引描述符表，从而选出一个合适的描述符。
  - 表指示位（Table Indicator，TI）：1位，选择应该访问哪一个描述符表。0代表应该访问全局描述符表（GDT），1代表应该访问局部描述符表（LDT）。
  - 请求特权级（Requested Privilege Level，RPL）：低两位，保护机制。

由段选择子得到的段描述符，再得到段的基址，最后加上偏移就得到了一个线性地址。在未开启分页机制时，线性地址即为物理地址。

#### 全局描述符表（GDT）

我们需要一个大数组来管理那么多的段，这个数组我们称为全局描述符表（GDT），它保存了各段的段描述符，简称段表。

全局描述符表的起始地址保存在全局描述符表寄存器GDTR中。GDTR长48位，其中高32位为基地址，低16位为段界限。

### 保护模式使能

建立映射后，使能保护模式。通过一个特定的寄存器，**系统性寄存器CRT**，将其bit 0置1，则代表CPU进入保护模式。段机制，是在保护模式下自动使能的。

## 加载ELF格式的uCore kernel

这里不是文件系统，因为我们还没有为kernel进行编写。

#### ELF文件格式概述

ELF(Executable and linking format)文件格式是Linux系统下的一种常用目标文件(object file)格式，有三种主要类型:

- 用于执行的可执行文件(executable file)，用于提供程序的进程映像，加载的内存执行。 这也是本实验的OS文件类型。
- 用于连接的可重定位文件(relocatable file)，可与其它目标文件一起创建可执行文件和共享目标文件。
- 共享目标文件(shared object file)，连接器可将它与其它可重定位文件和共享目标文件连接成其它的目标文件，动态连接器又可将它与可执行文件和其它共享目标文件结合起来创建一个进程映像。

这里只分析与本实验相关的ELF可执行文件类型。ELF header在文件开始处描述了整个文件的组织。ELF的文件头包含整个执行文件的控制结构，其定义在elf.h中：

```c
struct elfhdr {
  uint magic;  			// must equal ELF_MAGIC
  uchar elf[12];
  ushort type;
  ushort machine;
  uint version;
  uint entry;  			// 程序入口的虚拟地址
  uint phoff;  			// program header 表的位置偏移
  uint shoff;
  uint flags;
  ushort ehsize;
  ushort phentsize;
  ushort phnum; 		//program header表中的入口数目
  ushort shentsize;
  ushort shnum;
  ushort shstrndx;
};
```

`program header`描述与程序执行直接相关的目标文件结构信息，用来在文件中定位各个段的映像，同时包含其他一些用来为程序创建进程映像所必需的信息。

可执行文件的程序头部是一个`program header`结构的数组， 每个结构描述了一个段或者系统准备程序执行所必需的其它信息。目标文件的 “段” 包含一个或者多个 “节区”（section） ，也就是“段内容（Segment Contents）” 。程序头部仅对于可执行文件和共享目标文件有意义。可执行目标文件在ELF头部的`e_phentsize`和`e_phnum`成员中给出其自身程序头部的大小。程序头部的数据结构如下表所示：

```c
struct proghdr {
  uint type;   			// 段类型
  uint offset;  		// 段相对文件头的偏移值
  uint va;     			// 段的第一个字节将被放到内存中的虚拟地址
  uint pa;
  uint filesz;
  uint memsz;  			// 段在内存映像中占用的字节数
  uint flags;
  uint align;
};
```

根据`elfhdr`和`proghdr`的结构描述，bootloader就可以完成对ELF格式的ucore操作系统的加载过程（参见boot/bootmain.c中的bootmain函数）。

# 中断、异常和系统调用

**为什么需要中断、异常和系统调用？**
- 在计算机运行中，内核是被信任的第三方
- 只有内核可以执行特权指令
- 方便应用程序

中断和异常希望解决，外设连接计算机时的加载问题和应对程序的意外行为。如，当计算机希望你按回车键时，按下键盘的时间是不确定的，计算机不能永远等待。
系统调用希望解决用户使用内核服务时，不会对内核造成威胁的问题。

![image-20210606140809300](https://raw.githubusercontent.com/Niebelungen-D/Imgbed-blog/main/img/20210606140816.png)

## 中断

### BIOS中断、DOS中断、Linux中断的区别

- BIOS和DOS都存在于实模式下，由它们建立的中断调用都是建立在中断向量表（Interrupt Vector Table，IVT）中的，都是通过软中断指令 int 中断号来调用。
- BIOS 中断调用的主要功能是提供了硬件访问的方法，该方法使对硬件的操作变得简单易行。
- DOS 是运行在实模式下的，故其建立的中断调用也建立在中断向量表中，只不过其中断向量号和BIOS的不能冲突。
- Linux 内核是在进入保护模式后才建立中断例程的，不过在保护模式下，中断向量表已经不存在了，取而代之的是中断描述符表（Interrupt Descriptor Table，IDT）。Linux 的系统调用和DOS中断调用类似，不过Linux是通过`int 0x80`指令进入一个中断程序后再根据eax寄存器的值来调用不同的子功能函数的。

### 中断描述符表

- 中断描述符表（Interrupt Descriptor Table, IDT）把每个中断或异常编号和一个指向中断服务例程的描述符联系起来。同GDT一样，IDT是一个8字节的描述符数组，但IDT的第一项可以包含一个描述符。
- IDT可以位于内存的任意位置，CPU通过IDT寄存器（IDTR）的内容来寻址IDT的起始地址。

###  IDT gate descriptors

- 中断/异常应该使用`Interrupt Gate`或`Trap Gate`。其中的唯一区别就是：当调用`Interrupt Gate`时，Interrupt会被CPU自动禁止；而调用`Trap Gate`时，CPU则不会去禁止或打开中断，而是保留原样。

  > 这其中的原理是当CPU跳转至`Interrupt Gate`时，其eflag上的IF位会被清除。而`Trap Gate`则不改变。

- IDT中包含了3种类型的Descriptor

  - Task-gate descriptor
  - Interrupt-gate descriptor （中断方式用到）
  - Trap-gate descriptor（系统调用用到）

### 中断的处理流程

- 产生中断后，会通过其中断号，查找其ISR在IDT的哪一项。
- 找到响应的`Interrupt Gate`或`Trap Gate`，取出段选择子
- 根据段选择子查找GDT，得到基地址
- 基地址+偏移得到中断服务例程的地址。

### 不同特权级的中断切换对堆栈的影响

堆栈的不同特权级记录在段描述符中。如果低两位为0，则运行为内核态，若为3，则运行在用户态。

在用户态产生的中断会进入内核态进行处理，而在内核态产生的中断还是在内核态。这是两种不同的处理方式，因为其中产生了特权级的变化。

#### 内核态中断

- 栈没有变换

- 如果产生的是异常，压入Error code
- 压入cs和eip，即压入pc值
- 压入标志寄存器的值
- 通过`iret`返回，会弹出`EFLAGS`和SS/EIP（根据是否改变特权级）

#### 用户态中断

- 切换到内核堆栈

- 在内核中断的基础上额外压入用户栈的ss和esp，保存用户态的栈信息
- 通过`ret`或`retf`返回，仅弹出EIP，`retf`弹出CS和EIP

## 异常

一般源于程序的错误执行，或非法访问。

异常处理的例程也多数只会中止程序的执行。

## 系统调用

系统调用也是特殊的中断，通过`Trap Gate`进入，所以通过系统调用进入内核态也称为陷入内核。

**一个例子**：在调用`printf`时，会触发系统调用`write`。

- 操作系统的服务的编程接口
- 通常由高级语言编写（C/C++）
- 通常通过更高层次的API封装而不是直接调用

### 实现

- 每个系统调用对应一个系统调用号
  - 系统调用接口根据系统调用号来维护表的索引
- 系统调用接口调用内核态中的系统调用功能实现，并返回系统调用的状态和结果
- 用户不需要知道，系统调用的实现，只需设置参数获取返回结果。

### 系统调用与函数调用

- 系统调用：使用`int`和`iret`，有堆栈切换和特权级的切换（内核堆栈和用户堆栈不同）
- 函数调用：使用`call`和`ret`，没有堆栈和特权级的切换

### 系统调用开销：

- 超过函数调用
- 引导机制，用户到内核
- 建立内核堆栈
- 验证参数
- 内核态映射到用户态的地址空间，更新页面映射权限
- 内核独立地址空间，TLB变化

# C函数调用的实现

- [C 语言函数调用栈 (一)](http://www.cnblogs.com/clover-toeic/p/3755401.html)
- [C 语言函数调用栈 (二)](http://www.cnblogs.com/clover-toeic/p/3756668.html)

# GCC内联汇编

在c语言中插入汇编代码，完成c语言无法做到的指令。

## Syntax

```c
asm(assembler template
    :output operands		(optional)
    :input operands 		(optional)
    :clobbers				(optional)
);
```

## Example 1

对于：

```assembly
movl $0xffff, %eax
```

转化为：

```c
asm("movl $0xffff, %%eax\n");
```

## Example 2

对于：

```assembly
movl %cr0, %ebx
movl %ebx, 12(%esp)
orl  $-2147483648, 12(%esp)
movl 12(%esp), %eax
movl %eax, %cr0
```

转化为：

```c
uint32_t cr0;
asm volatile ("movl %%cr0, %0\n": "=r"(cr0));
cr0 |= 0x80000000;
asm volatile ("movl %0, %%cr0\n":: "=r"(cr0));
```

- volatile：不需要优化，不需要调整顺序
- %0：第一个用到的寄存器
- r：任意寄存器

## Example 3

对于：

```assembly
movl $11, %eax
movl -28(%ebp), %ebx
movl -24(%ebp), %ecx
movl -20(%ebp), %edx
movl -16(%ebp), %esi
int $0x80
movl %edi, -12(%ebp)
```

转化为：

```c
long_res, arg1 = 2, arg2 = 22, arg3 = 222, arg4 = 233;
_asm_volatile("int $0x80"
             :"=a"(_res)
             :"0"(11), "b"(arg1), "c"(arg2), "d"(arg3), "S"(arg4));
```

- a = %eax
- b = %ebx
- c = %ecx
- d = %edx
- S = %esi
- D = %edi 

# Lab 1:

## 练习1

> 理解通过make生成执行文件的过程

这个练习需要对Makefile有一定的了解。

首先，我们使用`make V=`看一下`make`执行了什么命令

```bash
+ cc kern/init/init.c
gcc -Ikern/init/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/init/init.c -o obj/kern/init/init.o
+ cc kern/libs/stdio.c
gcc -Ikern/libs/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/libs/stdio.c -o obj/kern/libs/stdio.o
+ cc kern/libs/readline.c
gcc -Ikern/libs/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/libs/readline.c -o obj/kern/libs/readline.o
+ cc kern/debug/panic.c
gcc -Ikern/debug/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/debug/panic.c -o obj/kern/debug/panic.o
+ cc kern/debug/kdebug.c
gcc -Ikern/debug/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/debug/kdebug.c -o obj/kern/debug/kdebug.o
+ cc kern/debug/kmonitor.c
gcc -Ikern/debug/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/debug/kmonitor.c -o obj/kern/debug/kmonitor.o
+ cc kern/driver/clock.c
gcc -Ikern/driver/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/clock.c -o obj/kern/driver/clock.o
+ cc kern/driver/console.c
gcc -Ikern/driver/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/console.c -o obj/kern/driver/console.o
+ cc kern/driver/picirq.c
gcc -Ikern/driver/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/picirq.c -o obj/kern/driver/picirq.o
+ cc kern/driver/intr.c
gcc -Ikern/driver/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/intr.c -o obj/kern/driver/intr.o
+ cc kern/trap/trap.c
gcc -Ikern/trap/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/trap/trap.c -o obj/kern/trap/trap.o
+ cc kern/trap/vectors.S
gcc -Ikern/trap/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/trap/vectors.S -o obj/kern/trap/vectors.o
+ cc kern/trap/trapentry.S
gcc -Ikern/trap/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/trap/trapentry.S -o obj/kern/trap/trapentry.o
+ cc kern/mm/pmm.c
gcc -Ikern/mm/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/mm/pmm.c -o obj/kern/mm/pmm.o
+ cc libs/string.c
gcc -Ilibs/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/  -c libs/string.c -o obj/libs/string.o
+ cc libs/printfmt.c
gcc -Ilibs/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/  -c libs/printfmt.c -o obj/libs/printfmt.o
+ ld bin/kernel
ld -m    elf_i386 -nostdlib -T tools/kernel.ld -o bin/kernel  obj/kern/init/init.o obj/kern/libs/stdio.o obj/kern/libs/readline.o obj/kern/debug/panic.o obj/kern/debug/kdebug.o obj/kern/debug/kmonitor.o obj/kern/driver/clock.o obj/kern/driver/console.o obj/kern/driver/picirq.o obj/kern/driver/intr.o obj/kern/trap/trap.o obj/kern/trap/vectors.o obj/kern/trap/trapentry.o obj/kern/mm/pmm.o  obj/libs/string.o obj/libs/printfmt.o
+ cc boot/bootasm.S
gcc -Iboot/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Os -nostdinc -c boot/bootasm.S -o obj/boot/bootasm.o
+ cc boot/bootmain.c
gcc -Iboot/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Os -nostdinc -c boot/bootmain.c -o obj/boot/bootmain.o
+ cc tools/sign.c
gcc -Itools/ -g -Wall -O2 -c tools/sign.c -o obj/sign/tools/sign.o
gcc -g -Wall -O2 obj/sign/tools/sign.o -o bin/sign
+ ld bin/bootblock
ld -m    elf_i386 -nostdlib -N -e start -Ttext 0x7C00 obj/boot/bootasm.o obj/boot/bootmain.o -o obj/bootblock.o
'obj/bootblock.out' size: 500 bytes
build 512 bytes boot sector: 'bin/bootblock' success!
dd if=/dev/zero of=bin/ucore.img count=10000
10000+0 records in
10000+0 records out
5120000 bytes (5.1 MB, 4.9 MiB) copied, 0.0333522 s, 154 MB/s
dd if=bin/bootblock of=bin/ucore.img conv=notrunc
1+0 records in
1+0 records out
512 bytes copied, 0.000129699 s, 3.9 MB/s
dd if=bin/kernel of=bin/ucore.img seek=1 conv=notrunc
154+1 records in
154+1 records out
78964 bytes (79 kB, 77 KiB) copied, 0.000418797 s, 189 MB/s
```

### dd命令

dd 命令用于读取、转换并输出数据。dd 可从标准输入或文件中读取数据，根据指定的格式来转换数据，再输出到文件、设备或标准输出。

仅针对出现的参数进行解释：

- if=文件名：输入文件名，默认为标准输入。即指定源文件。
- of=文件名：输出文件名，默认为标准输出。即指定目的文件。
- seek=blocks：从输出文件开头跳过blocks个块后再开始复制。
- count=blocks：仅拷贝blocks个块，块大小等于ibs指定的字节数。

这样可以看出，我们最后生成的文件就是`bin/ucore.img`这个镜像文件，而最后的三个`dd`命令

```bash
dd if=/dev/zero of=bin/ucore.img count=10000
// 将文件bin/ucore.img进行清空
dd if=bin/bootblock of=bin/ucore.img conv=notrunc
// 向img的开始写入512字节的bootloader
dd if=bin/kernel of=bin/ucore.img seek=1 conv=notrunc
// 跳过第一个块512字节，写入内核
```

接着，我们就从Makefile中看看，为了得到`bin/ucore.img`，我们要提前准备那些文件

> Makefile就是这样的，在其中指定了代码编译的规则，更重要的是指定了程序之间的依赖关系，所以从头看是不行的，要从最后的结果来推导整个文件的结构。

### ucore.img

```makefile
# create ucore.img
UCOREIMG	:= $(call totarget,ucore.img)

$(UCOREIMG): $(kernel) $(bootblock)
	$(V)dd if=/dev/zero of=$@ count=10000
	$(V)dd if=$(bootblock) of=$@ conv=notrunc
	$(V)dd if=$(kernel) of=$@ seek=1 conv=notrunc

$(call create_target,ucore.img)
```

为了得到`ucore.img`，需要`kernel`和`bootblock`。

### bootblock

```makefile
# create bootblock
bootfiles = $(call listf_cc,boot)
$(foreach f,$(bootfiles),$(call cc_compile,$(f),$(CC),$(CFLAGS) -Os -nostdinc))
# 这里遍历 boot 目录下的所有文件 asm.h bootasm.S bootmain.c
bootblock = $(call totarget,bootblock)
# 生成目标文件 asm.o bootasm.o bootmain.o sign.o
$(bootblock): $(call toobj,$(bootfiles)) | $(call totarget,sign)
	@echo + ld $@
	$(V)$(LD) $(LDFLAGS) -N -e start -Ttext 0x7C00 $^ -o $(call toobj,bootblock)
	@$(OBJDUMP) -S $(call objfile,bootblock) > $(call asmfile,bootblock)
	@$(OBJDUMP) -t $(call objfile,bootblock) | $(SED) '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(call symfile,bootblock)
	@$(OBJCOPY) -S -O binary $(call objfile,bootblock) $(call outfile,bootblock)
	@$(call totarget,sign) $(call outfile,bootblock) $(bootblock)
# 将目标文件 链接起来 同时指定代码段开始地址 为 0x7c00
$(call create_target,bootblock)
```

生成`bootblock`，需要`bootasm.o`、`bootmain.o`、`sign`

生成`bootasm.o`需要`bootasm.S`，实际执行命令为

```bash
gcc -Iboot/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Os -nostdinc -c boot/bootasm.S -o obj/boot/bootasm.o
```

其中关键的参数为

- -ggdb  生成可供gdb使用的调试信息。这样才能用qemu+gdb来调试bootloader or ucore。
- -m32  生成适用于32位环境的代码。我们用的模拟硬件是32bit的80386，所以ucore也要是32位的软件。
- -gstabs  生成stabs格式的调试信息。这样要ucore的monitor可以显示出便于开发者阅读的函数调用栈信息
- -nostdinc  不使用标准库。标准库是给应用程序用的，我们是编译ucore内核，OS内核是提供服务的，所以所有的服务要自给自足。
- -fno-stack-protector  不生成用于检测缓冲区溢出的代码。这是for 应用程序的，我们是编译内核，ucore内核好像还用不到此功能。
- -Os  为减小代码大小而进行优化。根据硬件spec，主引导扇区只有512字节，我们写的简单bootloader的最终大小不能大于510字节。
- -I\<dir>  添加搜索头文件的路径

生成`bootmain.o`需要`bootmain.c`

实际执行命令为

```bash
gcc -Iboot/ -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Os -nostdinc -c boot/bootmain.c -o obj/boot/bootmain.o
```

- -fno-builtin  除非用\__builtin_前缀，否则不进行builtin函数的优化

### sign

```makefile
# create 'sign' tools
$(call add_files_host,tools/sign.c,sign,sign)
$(call create_target_host,sign,sign)
```

实际执行命令为

```bash
gcc -Itools/ -g -Wall -O2 -c tools/sign.c -o obj/sign/tools/sign.o
gcc -g -Wall -O2 obj/sign/tools/sign.o -o bin/sign
```

首先生成bootblock.o

```bash
ld -m    elf_i386 -nostdlib -N -e start -Ttext 0x7C00 obj/boot/bootasm.o obj/boot/bootmain.o -o obj/bootblock.o
```

其中关键的参数为

- -m \<emulation>  模拟为i386上的连接器
- -nostdlib  不使用标准库
- -N  设置代码段和数据段均可读写
- -e \<entry>  指定入口
- -Ttext  制定代码段开始位置

拷贝二进制代码bootblock.o到bootblock.out

```bash
objcopy -S -O binary obj/bootblock.o obj/bootblock.out
其中关键的参数为
```

- -S  移除所有符号和重定位信息
- -O \<bfdname>  指定输出格式

使用sign工具处理bootblock.out，生成bootblock

```bash
bin/sign obj/bootblock.out bin/bootblock
```

### kernel

```makefile
# create kernel target
kernel = $(call totarget,kernel)

$(kernel): tools/kernel.ld

$(kernel): $(KOBJS)
	@echo + ld $@
	$(V)$(LD) $(LDFLAGS) -T tools/kernel.ld -o $@ $(KOBJS)
	@$(OBJDUMP) -S $@ > $(call asmfile,kernel)
	@$(OBJDUMP) -t $@ | $(SED) '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(call symfile,kernel)

$(call create_target,kernel)
```

`kernel.ld`是已存在的链接器，这一步将`kern`目录下生成的所有`.o`文件，通过`kernel.ld`链接为`kernel`。

- -T\<链接器路径>，使用指定的链接器

其前置命令就是将`kern`下面的所有文件编译，生成目标文件

```makefile
# kernel

KINCLUDE	+= kern/debug/ \
			   kern/driver/ \
			   kern/trap/ \
			   kern/mm/

KSRCDIR		+= kern/init \
			   kern/libs \
			   kern/debug \
			   kern/driver \
			   kern/trap \
			   kern/mm

KCFLAGS		+= $(addprefix -I,$(KINCLUDE))

$(call add_files_cc,$(call listf_cc,$(KSRCDIR)),kernel,$(KCFLAGS))

KOBJS	= $(call read_packet,kernel libs)
```

一个被系统认为是符合规范的硬盘主引导扇区的特征是什么？

code: sign.c

```c
    ...
	buf[510] = 0x55;
    buf[511] = 0xAA;
	...
```

