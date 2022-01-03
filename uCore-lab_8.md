# 文件系统

## 相关概念

- **文件系统是操作系统中管理持久性数据的子系统，提供数据存储和访问功能**
  - 组织、检索、读写访问数据
  - 大多数计算机系统都有文件系统
  - Google也是一个文件系统
- **文件是具有符号名，由字节序列构成的数据项集合**
  - 文件系统的基本数据单位
  - 文件名是文件的标识符号
- 文件系统的功能
  - 分配文件磁盘空间
    - 管理文件块（位置和顺序）
    - 管理空闲空间（位置）
    - 分配算法（策略）
  - 管理文件集合
    - 定位：文件及其内容
    - 命名：通过名字找到文件
    - 文件系统结构：文件组织方式
  - 数据可靠和安全
    - 安全：多层次保护数据
    - 可靠
      - 持久保存文件
      - 避免系统崩溃、媒体错误、攻击等
- 文件属性
  - 名称、类型、大小、位置、保护、创建者、创建时间、最近修改时间
  - 文件头：文件系统元数据中的文件信息
    - 文件属性
    - 文件存储位置和顺序

## 文件描述符

- 打开文件和文件描述符

  - **文件访问模式**：进程访问文件数据前必须先“打开”文件
  - **内核跟踪**进程打开的所有文件
    - 操作系统为每个进程维护一个打开文件表
    - 文件描述符是打开文件的标识

- 操作系统在打开文件表中维护的打开文件状态和信息

  - 文件指针
    - 记录最近一次读写位置
    - 每个进程分别维护自己已打开的文件指针
  - 文件打开次数
    - 当前打开文件的次数
    - 最后一个进程关闭文件时，将其从打开文件表中移除
  - **文件的磁盘信息**：缓存数据访问信息
  - **访问权限**：每个进程的文件访问模式信息

- 文件的**用户视图**和**系统视图**

  - 文件的**用户视图**：持久的**数据结构**

  - 系统访问接口

    - 字节序列的集合（Unix)
    - 系统不关心存储在磁盘上的数据结构

  - 操作系统的**文件视图**

    - 数据块的集合
    - 数据块是逻辑运算单位，而扇区是物理存储单位
    - 块大小通常来说**不等于**扇区大小（通常是几个扇区构成一个数据块）

  - 用户视图到系统视图的转换

    - 进程读文件：获取字节所在的数据块，返回数据块对应部分
    - 进程写文件：获取数据块，修改数据块中对应部分，写回数据块

    > **文件系统中的基本操作单位是数据块**。

- **访问模式**

  - 操作系统需要了解进程如何访问文件

  - **顺序**访问：按字节依次读取。大多数的文件访问都是顺序读取。

  - **随机**访问：从中间读写。不常用但仍然重要，例如虚拟内存中把内存页存储在文件上

  - 索引

    访问：依据数据库特征索引。

    - 通常操作系统不完整提供索引访问
    - 数据库是建立在索引内容的磁盘访问上

- **文件内部结构**

  - 无结构：单词、字节序列
  - 简单记录结构：分列、固定长度、可变长度
  - 复杂结构：格式化的文档、可执行文件、…

- **文件共享和访问控制**

  - **多用户**系统中的文件共享相当重要
  - 访问控制
    - 每个用户能够获得哪些文件的哪些访问权限
    - 访问模式：读、写、执行、删除、列表等
  - 文件访问控制列表（ACL）： <文件实体，权限>
  - Unix模式
    - <用户|组|所有人，读|写|可执行>
    - 用户标识ID：识别用户，表明每个用户所允许的权限及保护模式
    - 组标识ID：允许用户组成组，并指定组访问权限

- **语义一致性**

  - 规定多进程如何同时访问共享文件
    - 与同步算法类似
    - 因磁盘I/O和网络延迟而设计简单
  - Unix文件系统（UFS）语义
    - 对所打开文件的写入内容立即对其他打开同一文件的其他用户可见
    - 共享文件指针允许多用户同时读取和写入文件
  - 会话语义：写入内容只有当文件关闭时可见
  - 读写锁：一些操作系统和文件系统提供该功能

## 目录、文件别名和文件系统的种类

**分层文件系统**

- 文件以目录的方式组织起来
- **目录是一类特殊的文件**：目录的内容是文件索引表 **<文件|指向文件的指针>**
- 目录和文件的**树形结构**（早期的文件系统是扁平的）

![](https://gitee.com/slientNoir/image-bed/raw/master/image-bed/2022-01-03-752029a31ccec2abdb235b14d6e9a66c-6c9fd3.png)

**目录操作**

- 典型目录操作
  - 搜索、创建、删除文件
  - 列目录、重命名、遍历路径
- 操作系统应该只允许内核修改目录
  - 确保映射的完整性
  - 应用程序通过系统调用访问目录

**目录实现**

- 文件名的线性列表，包含了指向数据块的指针。
  - 编程简单
  - 执行耗时。
- 哈希表——哈希数据结构的线性表
  - 减少目录搜索时间
  - 碰撞——两个文件名的哈希值相同
  - 固定大小

**文件别名**

- 两个或多个文件名关联同一个文件
- 硬链接：多个文件项指向一个文件
- 软链接：以“快捷方式”指向其他文件
  - 通过存储其真实文件的逻辑名称来实现

![](https://gitee.com/slientNoir/image-bed/raw/master/image-bed/2022-01-03-0b30159a0ceb397bb5a3ac255cb69f6c-a89379.png)

**文件目录中的循环**

父目录指向子目录，子目录指向父目录

- 如何保证没有循环
  - 只允许到文件的链接，不允许在子目录的链接
  - 增加链接时，用循环检测算法确定是否合理
- 更多实践：**限制路径可遍历文件目录的数量**

![](https://gitee.com/slientNoir/image-bed/raw/master/image-bed/2022-01-03-d5813bdce6663027a7fab84b2fbdfd49-c6bb9a.png)

**名字解析（目录遍历）**

- 名字解析：把逻辑名字转换成物理资源（如文件）

  - 依据路径名，在文件系统中找到实际文件位置
  - 遍历文件目录直到找到目标文件

- 举例：解析`/bin/sh`

  - 读取根目录的文件头（在磁盘固定位置）
  - 读取根目录的数据快，搜索`bin`项
  - 读取`bin`的文件头
  - 读取`bin`的数据块，搜索`ls`项
  - 读取`ls`的文件头

- 当前工作目录（PWD）

  - 每个进程都会指向一个文件目录用于解析文件名
  - 允许用户指定相对路径来代替绝对路径

**文件系统挂载**

- 文件系统需要先挂载才能被访问
- 未挂载的文件系统被挂载在挂载点上

**文件系统种类**

- 磁盘文件系统：文件存储在数据存储设备上，如磁盘。例如：FAT, NTFS， ext2/3, ISO9660等等
- 数据库文件系统：文件特征是可被寻址的，例如WinFS
- 日志文件系统：记录文件系统的修改事件
- 特殊/虚拟文件系统
- 网络/分布式文件系统
  - 文件可以通过网络被共享
    - 文件位于远程服务器
    - 客户端远程挂载服务器文件系统
    - 标准系统文件访问被转换为成远程访问
    - 标准文件共享协议：NFS for Unix, CIFS for Windows。
  - 分布式文件系统的挑战
    - 客户端和客户端上的用户辨别起来很复杂
    - **一致性**问题
    - **错误处理模式**

## 虚拟文件系统

**分层结构**

- 虚拟（逻辑）文件系统（VFS）
- 特定的文件系统模块

由虚拟文件系统提供文件/文件系统的接口

**目的**：对所有不同文件系统的抽象

**功能**

- 提供相同的文件和文件系统**接口**
- 管理所有文件和文件系统关联的**数据结构**
- 高效查询**例程**，遍历文件系统
- 与特定文件系统模块的**交互**

**文件系统基本数据结构**

- 文件卷控制块（Unix：`superblock`)

  - 每个文件系统一个
  - 文件系统详细信息
  - 块、块大小、空余块、计数/指针等

- 文件控制块（Unix:`vnode`or`inode`)
  - 每个文件一个
  - 文件详细信息
  - 访问权限、拥有者、大小、数据块位置等

- 目录项（Linux:`dentry`)

  - 每个目录项一个（目录和文件）
  - 将目录项数据结构及树型布局编码成树型数据结构
  - 指向文件控制块、父目录、子目录等

**文件系统的存储结构**

- 文件系统数据结构：**卷控制块、文件控制块、目录节点**
- 持久存储在外存中：存储设备的数据块中
- 当需要时加载进内存
  - 卷控制模块：当文件系统挂载时进入内存
  - 文件控制块：当文件被访问时进入内存
  - 目录节点：在遍历一个文件路径时进入内存

## 文件缓存和打开文件

- 数据块缓存

  - 数据块按需读入内存
    - 提供read()操作
    - 预读：预先读取后面的数据块
  - 数据块使用后被缓存
    - 假设数据将会再次用到
    - 写操作可能被缓存和延迟写入
  - 两种数据块缓存方式
    - 数据块缓存
    - 页缓存：统一缓存数据块和内存页

- 页缓存

  - **虚拟页式存储**：在虚拟地址空间中虚拟页面可映射到本地外存文件中
  - 文件数据块的页缓存
    - 在虚拟内存中文件数据块被映射成页
    - 文件的读写操作被转换成对内存的访问
    - 可能导致缺页或设置为脏页
    - **存在的问题：页置换算法需要协调虚拟存储和页缓存间的页面数**

- 文件系统中打开文件的数据结构

  - 文件描述符
    - 每个被打开的文件都有一个文件描述符
    - 文件状态信息：目录项、当前文件指针、文件操作设置等
  - 打开文件表
    - 每个进程都有一个**进程打开文件表**
    - 一个系统级的打开文件表
    - 有文件被打开时，文件卷就不能被卸载

- 打开文件锁

  > 一些文件系统提供文件锁，用于协调多进程的文件访问

  - **强制**——根据锁保持情况和访问需求确定是否拒绝访问
  - **劝告**——进程可以查找锁的状态来决定怎么处理

## 文件分配

- 文件大小
  - 大多数文件都很小
    - 需要对小文件提供很好的支持
    - 块空间不能太大
  - 一些文件非常大
    - 必须支持大文件（64位文件偏移）
    - 大文件访问需要高效
- 文件分配
  - 如何表示分配给一个文件数据块的位置和顺序
  - 分配方式：连续分配、链式分配、索引分配
  - 指标：存储效率（外部碎片等）、读写性能（访问速度等）

### 连续分配

- 文件头指定起始块和长度
- 分配策略：**最先匹配、最佳匹配**
- 优点：文件读取表现好；**高效的顺序和随机访问**
- 缺点：
  - **碎片严重！**
  - **文件大小如何增长？** 预分配 ？ / 按需分配

### 链式分配

- 文件以数据块链表方式存储
- 文件头包含了到第一块和最后一块的指针
- 优点
  - 创建、增大、缩小很容易
  - 没有碎片
- 缺点
  - 无法实现真正的随机访问
  - 可靠性差：破坏一个链，后面的数据块全部丢失

### 索引分配

- 为每个文件创建一个**索引数据块**，该索引数据块是指向文件数据块的指针列表
- 文件头包含了索引数据块指针列表
- 优点
  - 创建、增大、缩小很容易
  - 没有碎片
  - 支持直接访问
- 缺点
  - 当文件很小时，存储索引的开销大
  - 不便于处理大文件

#### 大文件的索引分配

- 使用链式索引块：将多个索引块以链表的方式串联起来
- 多级索引块：一个一级索引块指向多个二级索引块等等

**UFS多级索引分配**

![](https://gitee.com/slientNoir/image-bed/raw/master/image-bed/2022-01-03-6cb928d8416d87218bc3238ae3d1c0f1-349cdb.png)

- 文件头包含13个指针
  - 前10个指针指向数据块
  - 第11个指针指向索引块
  - 第12个指针指向二级索引块
  - 第13个指针指向三级索引块
- 效果
  - 提高了文件大小限制阈值
  - 动态分配数据块，文件扩展很容易
  - 小文件开销小
  - 只为大文件分配间接数据块，大文件在访问数据块时需要大量查询

## 空闲空间管理

跟踪记录文件卷中未分配的数据块

> 采用什么数据结构表示空闲空间列表？

- 位图
  - 用位图代表空闲数据块列表
    - `11111110011001001010010101`
    - 𝐷𝑖=0Di=0表示数据块𝑖i是空闲，否则表示已分配
  - 使用简单但可能会是一个大的向量表
    - 160GB磁盘 -> 40MB数据块 -> 5MB位图
    - 假定空闲空间在磁盘中均匀分布，则找到`0`前需要扫描**磁盘数据块总数/空闲块数目**
- 链表
- 链式索引

## 冗余磁盘矩阵

### 基本概念

磁盘分区

> 通常磁盘通过分区来最大限度减小寻道时间

- 分区是一组柱面的集合
- 每个分区都可视为逻辑上独立的磁盘

![](https://gitee.com/slientNoir/image-bed/raw/master/image-bed/2022-01-03-5a4bfd0849bdc16d2184c8e21b6ba6c0-8c7882.png)

**一个典型的磁盘文件系统组织**

- 文件卷：一个拥有完整文件系统实例的外存空间，通常常驻在磁盘的单个分区上
- ![](https://gitee.com/slientNoir/image-bed/raw/master/image-bed/2022-01-03-3e5adb1b43105e074a3009ed7c35933f-a18f4e.png)

- 多磁盘管理
  - 使用多磁盘可改善
    - 吞吐量（通过并行）
    - 可靠性和可用性（通过冗余）
  - 冗余磁盘阵列（RAID，Redundant Array of Inexpensive disks）
    - 多种磁盘管理技术
    - RAID分类：RAID-0、RAID-1、RAID-5
  - 冗余磁盘阵列的实现
    - 软件：操作系统内核的文件卷管理
    - 硬件：RAID硬件控制器（I/O）

### RAID0: 磁盘条带化

把数据块分成多个子块，存储在独立的磁盘中。通过独立磁盘上并行数据块访问提供更大的磁盘带宽

![](https://gitee.com/slientNoir/image-bed/raw/master/image-bed/2022-01-03-49431c739d58a8279e499306f245d69f-e46ac6.png)

### RAID1: 磁盘镜像

向两个磁盘写入，从任何一个读取

- 可靠性成倍增加
- 读取性能线性增加

![](https://gitee.com/slientNoir/image-bed/raw/master/image-bed/2022-01-03-42ecd3c25df8b6dec19dadefce7d8918-ba7f65.png)

### RAID4: 带校验的磁盘条带化

> 基于数据块的条带化

数据块级的磁盘条带化加专用奇偶校验磁盘

> 允许从任意一个故障磁盘中恢复

![](https://gitee.com/slientNoir/image-bed/raw/master/image-bed/2022-01-03-40a0774ca58f4f182b9d1987bd0e42a4-6b849c.png)

### RAID5: 带分布式校验的磁盘条带化

![](https://gitee.com/slientNoir/image-bed/raw/master/image-bed/2022-01-03-d7a24d926cdd0c8e8a58803a7f27662a-83eb8f.png)

- RAID-6：每组条带块有两个冗余块，允许两个磁盘错误

可以通过RAID的嵌套使用来进一步提高可靠性和性能。

## uCore文件系统

![](https://gitee.com/slientNoir/image-bed/raw/master/image-bed/2022-01-03-18a7b9de7f1b4e87283c7420ba0bf62f-f073f2.png)

# 练习1

**open流程**

```c
static int
sys_open(uint32_t arg[]) {
    const char *path = (const char *)arg[0];
    uint32_t open_flags = (uint32_t)arg[1];
    return sysfile_open(path, open_flags);
}
```

对`sysfile_open`的简单封装。

```c
/* sysfile_open - open file */
int
sysfile_open(const char *__path, uint32_t open_flags) {
    int ret;
    char *path;
    if ((ret = copy_path(&path, __path)) != 0) {
        return ret;
    }
    ret = file_open(path, open_flags);
    kfree(path);
    return ret;
}

/* copy_path - copy path name */
static int
copy_path(char **to, const char *from) {
    struct mm_struct *mm = current->mm;
    char *buffer;
    if ((buffer = kmalloc(FS_MAX_FPATH_LEN + 1)) == NULL) {
        return -E_NO_MEM;
    }
    lock_mm(mm);
    if (!copy_string(mm, buffer, from, FS_MAX_FPATH_LEN + 1)) {
        unlock_mm(mm);
        goto failed_cleanup;
    }
    unlock_mm(mm);
    *to = buffer;
    return 0;

failed_cleanup:
    kfree(buffer);
    return -E_INVAL;
}
```

为文件的路径动态申请空间保存到内核空间中。之后调用`file_open`。

```c
// open file
int
file_open(char *path, uint32_t open_flags) {
    bool readable = 0, writable = 0;
    switch (open_flags & O_ACCMODE) {
    case O_RDONLY: readable = 1; break;
    case O_WRONLY: writable = 1; break;
    case O_RDWR:
        readable = writable = 1;
        break;
    default:
        return -E_INVAL;
    }

    int ret;
    struct file *file;
    if ((ret = fd_array_alloc(NO_FD, &file)) != 0) {
        return ret;
    }

    struct inode *node;
    if ((ret = vfs_open(path, open_flags, &node)) != 0) {
        fd_array_free(file);
        return ret;
    }

    file->pos = 0;
    if (open_flags & O_APPEND) {
        struct stat __stat, *stat = &__stat;
        if ((ret = vop_fstat(node, stat)) != 0) {
            vfs_close(node);
            fd_array_free(file);
            return ret;
        }
        file->pos = stat->st_size;
    }

    file->node = node;
    file->readable = readable;
    file->writable = writable;
    fd_array_open(file);
    return file->fd;
}

```

`fd_array_alloc`在打开文件表中得到找到一个空的表项。之后调用`vfs->open`打开文件。将文件的信息放入一个inode中。

```c
// open file in vfs, get/create inode for file with filename path.
int
vfs_open(char *path, uint32_t open_flags, struct inode **node_store) {
    bool can_write = 0;
    switch (open_flags & O_ACCMODE) {
    case O_RDONLY:
        break;
    case O_WRONLY:
    case O_RDWR:
        can_write = 1;
        break;
    default:
        return -E_INVAL;
    }

    if (open_flags & O_TRUNC) {	// 文件截断选项
        if (!can_write) {
            return -E_INVAL;
        }
    }

    int ret; 
    struct inode *node;
    bool excl = (open_flags & O_EXCL) != 0;
    bool create = (open_flags & O_CREAT) != 0;
    ret = vfs_lookup(path, &node);

    if (ret != 0) {
        if (ret == -16 && (create)) {
            char *name;
            struct inode *dir;
            if ((ret = vfs_lookup_parent(path, &dir, &name)) != 0) {
                return ret;
            }
            ret = vop_create(dir, name, excl, &node);
        } else return ret;
    } else if (excl && create) {
        return -E_EXISTS;
    }
    assert(node != NULL);
    
    if ((ret = vop_open(node, open_flags)) != 0) {
        vop_ref_dec(node);
        return ret;
    }

    vop_open_inc(node);
    if (open_flags & O_TRUNC || create) {
        if ((ret = vop_truncate(node, 0)) != 0) {
            vop_open_dec(node);
            vop_ref_dec(node);
            return ret;
        }
    }
    *node_store = node;
    return 0;
}

```

- 调用`vfs_lookup`搜索给出的路径，判断是否存在该文件。如果存在，则`vfs_lookup`函数返回该文件所对应的`inode`节点至当前函数`vfs_open`中的局部变量`node`。

- 如果给出的路径不存在，即文件不存在，则根据传入的flag，选择调用`vop_create`创建新文件或直接返回错误信息。

- 执行到此步时，当前函数中的局部变量`node`一定非空，此时进一步调用`vop_open`函数打开文件。

  > SFS中，`vop_open`所对应的`sfs_openfile`不执行任何操作，但该接口仍然需要保留。

- 如果文件打开正常，则根据当前函数传入的`open_flags`参数来判断是否需要将当前文件截断（truncate）至0（即**清空**）。如果需要截断，则执行`vop_truncate`函数。最后函数返回。

```c
/*
 * get_device- Common code to pull the device name, if any, off the front of a
 *             path and choose the inode to begin the name lookup relative to.
 */

static int
get_device(char *path, char **subpath, struct inode **node_store) {
    int i, slash = -1, colon = -1;
    for (i = 0; path[i] != '\0'; i ++) {
        if (path[i] == ':') { colon = i; break; }
        if (path[i] == '/') { slash = i; break; }
    }
    if (colon < 0 && slash != 0) {
        /* *
         * No colon before a slash, so no device name specified, and the slash isn't leading
         * or is also absent, so this is a relative path or just a bare filename. Start from
         * the current directory, and use the whole thing as the subpath.
         * */
        *subpath = path;
        return vfs_get_curdir(node_store);
    }
    if (colon > 0) {
        /* device:path - get root of device's filesystem */
        path[colon] = '\0';

        /* device:/path - skip slash, treat as device:path */
        while (path[++ colon] == '/');
        *subpath = path + colon;
        return vfs_get_root(path, node_store);
    }

    /* *
     * we have either /path or :path
     * /path is a path relative to the root of the "boot filesystem"
     * :path is a path relative to the root of the current filesystem
     * */
    int ret;
    if (*path == '/') {
        if ((ret = vfs_get_bootfs(node_store)) != 0) {
            return ret;
        }
    }
    else {
        assert(*path == ':');
        struct inode *node;
        if ((ret = vfs_get_curdir(&node)) != 0) {
            return ret;
        }
        /* The current directory may not be a device, so it must have a fs. */
        assert(node->in_fs != NULL);
        *node_store = fsop_get_root(node->in_fs);
        vop_ref_dec(node);
    }

    /* ///... or :/... */
    while (*(++ path) == '/');
    *subpath = path;
    return 0;
}

/*
 * vfs_lookup - get the inode according to the path filename
 */
int
vfs_lookup(char *path, struct inode **node_store) {
    int ret;
    struct inode *node;
    if ((ret = get_device(path, &path, &node)) != 0) {
        return ret;
    }
    if (*path != '\0') {
        ret = vop_lookup(node, path, node_store);
        vop_ref_dec(node);
        return ret;
    }
    *node_store = node;
    return 0;
}
```

`vfs_lookup`用于查找传入的路径，并返回其对应的`inode`结点。

- 该函数首先调用`get_device`函数获取设备的`inode`结点。在`get_device`函数中，程序会分析传入的`path`结构并执行不同的函数。传入的`path`与对应的操作有以下三种，分别是

  - `directory/filename`： 相对路径。此时会进一步调用`vfs_get_curdir`，并最终获取到当前进程的工作路径并返回对应的`inode`。

  - `/directory/filename`或者`:directory/filename`：无设备指定的绝对路径。

    - 若路径为`/directory/filename`，此时返回`bootfs`根目录所对应的`inode`。

      > `bootfs`是内核启动盘所对应的文件系统。

    - 若路径为`:/directory/filename`，则获取当前进程工作目录所对应的文件系统根目录，并返回其`inode`数据。

  - `device:directory/filename`或者`device:/directory/filename`： 指定设备的绝对路径。返回所指定设备根目录的对应`inode`。

  > 总的来说，`get_device`返回的是一个目录`inode`结点。

**sys_io_nolock**

```c
    if ((blkoff = offset % SFS_BLKSIZE) != 0) {
        size = (nblks != 0) ? (SFS_BLKSIZE - blkoff) : (endpos - offset);
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
            goto out;
        }
        if ((ret = sfs_buf_op(sfs, buf, size, ino, blkoff)) != 0) {
            goto out;
        }
        alen += size;
        if (nblks == 0) {
            goto out;
        }
        buf += size, blkno ++, nblks --;
    }

    size = SFS_BLKSIZE;
    while (nblks != 0) {
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
            goto out;
        }
        if ((ret = sfs_block_op(sfs, buf, ino, 1)) != 0) {
            goto out;
        }
        alen += size, buf += size, blkno ++, nblks --;
    }

    if ((size = endpos % SFS_BLKSIZE) != 0) {
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
            goto out;
        }
        if ((ret = sfs_buf_op(sfs, buf, size, ino, 0)) != 0) {
            goto out;
        }
        alen += size;
    }
```

思路简单，通过`sfs_bmap_load_nolock`从文件系统将指定块号的数据块进行加载，并将相应的inode信息写入最后一个参数。通过`sfs_buf_op`或`sfs_block_op`读取指定大小或整块的数据到buf中。

由于该文件的开始可能在一个数据块的中间，不是以块大小对齐的，所以要先将这部分数据读出了。之后读取若干个块。文件的结尾也可能不是以块大小对齐的，这时也要再读取这部分数据。

# 练习2

**完成基于文件系统的执行程序机制的实现**

do_fork：添加对文件的拷贝

```c
    if (setup_kstack(proc) != 0) {
        goto bad_fork_cleanup_proc;
    }
    if (copy_files(clone_flags, proc) != 0) { //for LAB8
        goto bad_fork_cleanup_kstack;
    }
    if (copy_mm(clone_flags, proc) != 0) {
        goto bad_fork_cleanup_fs;
    }
    copy_thread(proc, stack, tf);
```

load_icode：从文件中读取数据，而不是内存中

```c
static int
load_icode(int fd, int argc, char **kargv) {
    assert(argc >= 0 && argc <= EXEC_MAX_ARG_NUM);

    if (current->mm != NULL) {
        panic("load_icode: current->mm must be empty.\n");
    }

    int ret = -E_NO_MEM;
    struct mm_struct *mm;
    if ((mm = mm_create()) == NULL) {
        goto bad_mm;
    }
    if (setup_pgdir(mm) != 0) {
        goto bad_pgdir_cleanup_mm;
    }

    struct Page *page;

    struct elfhdr __elf, *elf = &__elf;
  // 此处改为了从文件读文件头
    if ((ret = load_icode_read(fd, elf, sizeof(struct elfhdr), 0)) != 0) {
        goto bad_elf_cleanup_pgdir;
    }

    if (elf->e_magic != ELF_MAGIC) {
        ret = -E_INVAL_ELF;
        goto bad_elf_cleanup_pgdir;
    }

    struct proghdr __ph, *ph = &__ph;
    uint32_t vm_flags, perm, phnum;
    for (phnum = 0; phnum < elf->e_phnum; phnum ++) {
        off_t phoff = elf->e_phoff + sizeof(struct proghdr) * phnum;
        if ((ret = load_icode_read(fd, ph, sizeof(struct proghdr), phoff)) != 0) {
            goto bad_cleanup_mmap;
        }
        if (ph->p_type != ELF_PT_LOAD) {
            continue ;
        }
        if (ph->p_filesz > ph->p_memsz) {
            ret = -E_INVAL_ELF;
            goto bad_cleanup_mmap;
        }
        if (ph->p_filesz == 0) {
            continue ;
        }
        vm_flags = 0, perm = PTE_U;
        if (ph->p_flags & ELF_PF_X) vm_flags |= VM_EXEC;
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
        if (vm_flags & VM_WRITE) perm |= PTE_W;
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0) {
            goto bad_cleanup_mmap;
        }
        off_t offset = ph->p_offset;
        size_t off, size;
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);

        ret = -E_NO_MEM;

        end = ph->p_va + ph->p_filesz;
        while (start < end) {
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
                ret = -E_NO_MEM;
                goto bad_cleanup_mmap;
            }
            off = start - la, size = PGSIZE - off, la += PGSIZE;
            if (end < la) {
                size -= la - end;
            }
            if ((ret = load_icode_read(fd, page2kva(page) + off, size, offset)) != 0) {
                goto bad_cleanup_mmap;
            }
            start += size, offset += size;
        }
        end = ph->p_va + ph->p_memsz;

        if (start < la) {
            /* ph->p_memsz == ph->p_filesz */
            if (start == end) {
                continue ;
            }
            off = start + PGSIZE - la, size = PGSIZE - off;
            if (end < la) {
                size -= la - end;
            }
            memset(page2kva(page) + off, 0, size);
            start += size;
            assert((end < la && start == end) || (end >= la && start == la));
        }
        while (start < end) {
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
                ret = -E_NO_MEM;
                goto bad_cleanup_mmap;
            }
            off = start - la, size = PGSIZE - off, la += PGSIZE;
            if (end < la) {
                size -= la - end;
            }
            memset(page2kva(page) + off, 0, size);
            start += size;
        }
    }
    sysfile_close(fd);

    vm_flags = VM_READ | VM_WRITE | VM_STACK;
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0) {
        goto bad_cleanup_mmap;
    }
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
    
    mm_count_inc(mm);
    current->mm = mm;
    current->cr3 = PADDR(mm->pgdir);
    lcr3(PADDR(mm->pgdir));

    //setup argc, argv
    uint32_t argv_size=0, i;
    for (i = 0; i < argc; i ++) {
        argv_size += strnlen(kargv[i],EXEC_MAX_ARG_LEN + 1)+1;
    }

    uintptr_t stacktop = USTACKTOP - (argv_size/sizeof(long)+1)*sizeof(long);
    char** uargv=(char **)(stacktop  - argc * sizeof(char *));
    
    argv_size = 0;
    for (i = 0; i < argc; i ++) {
        uargv[i] = strcpy((char *)(stacktop + argv_size ), kargv[i]);
        argv_size +=  strnlen(kargv[i],EXEC_MAX_ARG_LEN + 1)+1;
    }
    
    stacktop = (uintptr_t)uargv - sizeof(int);
    *(int *)stacktop = argc;
    
    struct trapframe *tf = current->tf;
    memset(tf, 0, sizeof(struct trapframe));
    tf->tf_cs = USER_CS;
    tf->tf_ds = tf->tf_es = tf->tf_ss = USER_DS;
    tf->tf_esp = stacktop;
    tf->tf_eip = elf->e_entry;
    tf->tf_eflags = FL_IF;
    ret = 0;
out:
    return ret;
bad_cleanup_mmap:
    exit_mmap(mm);
bad_elf_cleanup_pgdir:
    put_pgdir(mm);
bad_pgdir_cleanup_mm:
    mm_destroy(mm);
bad_mm:
    goto out;
}
```

