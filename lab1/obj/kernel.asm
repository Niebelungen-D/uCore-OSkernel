
bin/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	f3 0f 1e fb          	endbr32 
  100004:	55                   	push   %ebp
  100005:	89 e5                	mov    %esp,%ebp
  100007:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  10000a:	b8 80 1d 11 00       	mov    $0x111d80,%eax
  10000f:	2d 16 0a 11 00       	sub    $0x110a16,%eax
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 16 0a 11 00 	movl   $0x110a16,(%esp)
  100027:	e8 fb 2e 00 00       	call   102f27 <memset>

    cons_init();                // init the console
  10002c:	e8 0f 16 00 00       	call   101640 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 60 37 10 00 	movl   $0x103760,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 7c 37 10 00 	movl   $0x10377c,(%esp)
  100046:	e8 42 02 00 00       	call   10028d <cprintf>

    print_kerninfo();
  10004b:	e8 00 09 00 00       	call   100950 <print_kerninfo>

    grade_backtrace();
  100050:	e8 9a 00 00 00       	call   1000ef <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 7c 2b 00 00       	call   102bd6 <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 36 17 00 00       	call   101795 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 b6 18 00 00       	call   10191a <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 5c 0d 00 00       	call   100dc5 <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 73 18 00 00       	call   1018e1 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  10006e:	e8 80 01 00 00       	call   1001f3 <lab1_switch_test>

    /* do nothing */
    while (1);
  100073:	eb fe                	jmp    100073 <kern_init+0x73>

00100075 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100075:	f3 0f 1e fb          	endbr32 
  100079:	55                   	push   %ebp
  10007a:	89 e5                	mov    %esp,%ebp
  10007c:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  10007f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100086:	00 
  100087:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10008e:	00 
  10008f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100096:	e8 14 0d 00 00       	call   100daf <mon_backtrace>
}
  10009b:	90                   	nop
  10009c:	c9                   	leave  
  10009d:	c3                   	ret    

0010009e <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  10009e:	f3 0f 1e fb          	endbr32 
  1000a2:	55                   	push   %ebp
  1000a3:	89 e5                	mov    %esp,%ebp
  1000a5:	53                   	push   %ebx
  1000a6:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000a9:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000af:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1000b5:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1000b9:	89 54 24 08          	mov    %edx,0x8(%esp)
  1000bd:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1000c1:	89 04 24             	mov    %eax,(%esp)
  1000c4:	e8 ac ff ff ff       	call   100075 <grade_backtrace2>
}
  1000c9:	90                   	nop
  1000ca:	83 c4 14             	add    $0x14,%esp
  1000cd:	5b                   	pop    %ebx
  1000ce:	5d                   	pop    %ebp
  1000cf:	c3                   	ret    

001000d0 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000d0:	f3 0f 1e fb          	endbr32 
  1000d4:	55                   	push   %ebp
  1000d5:	89 e5                	mov    %esp,%ebp
  1000d7:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000da:	8b 45 10             	mov    0x10(%ebp),%eax
  1000dd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000e1:	8b 45 08             	mov    0x8(%ebp),%eax
  1000e4:	89 04 24             	mov    %eax,(%esp)
  1000e7:	e8 b2 ff ff ff       	call   10009e <grade_backtrace1>
}
  1000ec:	90                   	nop
  1000ed:	c9                   	leave  
  1000ee:	c3                   	ret    

001000ef <grade_backtrace>:

void
grade_backtrace(void) {
  1000ef:	f3 0f 1e fb          	endbr32 
  1000f3:	55                   	push   %ebp
  1000f4:	89 e5                	mov    %esp,%ebp
  1000f6:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000f9:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000fe:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  100105:	ff 
  100106:	89 44 24 04          	mov    %eax,0x4(%esp)
  10010a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100111:	e8 ba ff ff ff       	call   1000d0 <grade_backtrace0>
}
  100116:	90                   	nop
  100117:	c9                   	leave  
  100118:	c3                   	ret    

00100119 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100119:	f3 0f 1e fb          	endbr32 
  10011d:	55                   	push   %ebp
  10011e:	89 e5                	mov    %esp,%ebp
  100120:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100123:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100126:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100129:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10012c:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  10012f:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100133:	83 e0 03             	and    $0x3,%eax
  100136:	89 c2                	mov    %eax,%edx
  100138:	a1 20 0a 11 00       	mov    0x110a20,%eax
  10013d:	89 54 24 08          	mov    %edx,0x8(%esp)
  100141:	89 44 24 04          	mov    %eax,0x4(%esp)
  100145:	c7 04 24 81 37 10 00 	movl   $0x103781,(%esp)
  10014c:	e8 3c 01 00 00       	call   10028d <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100151:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100155:	89 c2                	mov    %eax,%edx
  100157:	a1 20 0a 11 00       	mov    0x110a20,%eax
  10015c:	89 54 24 08          	mov    %edx,0x8(%esp)
  100160:	89 44 24 04          	mov    %eax,0x4(%esp)
  100164:	c7 04 24 8f 37 10 00 	movl   $0x10378f,(%esp)
  10016b:	e8 1d 01 00 00       	call   10028d <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100170:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100174:	89 c2                	mov    %eax,%edx
  100176:	a1 20 0a 11 00       	mov    0x110a20,%eax
  10017b:	89 54 24 08          	mov    %edx,0x8(%esp)
  10017f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100183:	c7 04 24 9d 37 10 00 	movl   $0x10379d,(%esp)
  10018a:	e8 fe 00 00 00       	call   10028d <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10018f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100193:	89 c2                	mov    %eax,%edx
  100195:	a1 20 0a 11 00       	mov    0x110a20,%eax
  10019a:	89 54 24 08          	mov    %edx,0x8(%esp)
  10019e:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001a2:	c7 04 24 ab 37 10 00 	movl   $0x1037ab,(%esp)
  1001a9:	e8 df 00 00 00       	call   10028d <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  1001ae:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001b2:	89 c2                	mov    %eax,%edx
  1001b4:	a1 20 0a 11 00       	mov    0x110a20,%eax
  1001b9:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001c1:	c7 04 24 b9 37 10 00 	movl   $0x1037b9,(%esp)
  1001c8:	e8 c0 00 00 00       	call   10028d <cprintf>
    round ++;
  1001cd:	a1 20 0a 11 00       	mov    0x110a20,%eax
  1001d2:	40                   	inc    %eax
  1001d3:	a3 20 0a 11 00       	mov    %eax,0x110a20
}
  1001d8:	90                   	nop
  1001d9:	c9                   	leave  
  1001da:	c3                   	ret    

001001db <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001db:	f3 0f 1e fb          	endbr32 
  1001df:	55                   	push   %ebp
  1001e0:	89 e5                	mov    %esp,%ebp
	asm volatile (
  1001e2:	cd 78                	int    $0x78
	    "int %0 \n"
	    : 
	    : "i"(T_SWITCH_TOU)
	);
}
  1001e4:	90                   	nop
  1001e5:	5d                   	pop    %ebp
  1001e6:	c3                   	ret    

001001e7 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001e7:	f3 0f 1e fb          	endbr32 
  1001eb:	55                   	push   %ebp
  1001ec:	89 e5                	mov    %esp,%ebp
	asm volatile (
  1001ee:	cd 79                	int    $0x79
	    "int %0 \n"
	    : 
	    : "i"(T_SWITCH_TOK)
	);
}
  1001f0:	90                   	nop
  1001f1:	5d                   	pop    %ebp
  1001f2:	c3                   	ret    

001001f3 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001f3:	f3 0f 1e fb          	endbr32 
  1001f7:	55                   	push   %ebp
  1001f8:	89 e5                	mov    %esp,%ebp
  1001fa:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001fd:	e8 17 ff ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  100202:	c7 04 24 c8 37 10 00 	movl   $0x1037c8,(%esp)
  100209:	e8 7f 00 00 00       	call   10028d <cprintf>
    lab1_switch_to_user();
  10020e:	e8 c8 ff ff ff       	call   1001db <lab1_switch_to_user>
    lab1_print_cur_status();
  100213:	e8 01 ff ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  100218:	c7 04 24 e8 37 10 00 	movl   $0x1037e8,(%esp)
  10021f:	e8 69 00 00 00       	call   10028d <cprintf>
    lab1_switch_to_kernel();
  100224:	e8 be ff ff ff       	call   1001e7 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100229:	e8 eb fe ff ff       	call   100119 <lab1_print_cur_status>
}
  10022e:	90                   	nop
  10022f:	c9                   	leave  
  100230:	c3                   	ret    

00100231 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  100231:	f3 0f 1e fb          	endbr32 
  100235:	55                   	push   %ebp
  100236:	89 e5                	mov    %esp,%ebp
  100238:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  10023b:	8b 45 08             	mov    0x8(%ebp),%eax
  10023e:	89 04 24             	mov    %eax,(%esp)
  100241:	e8 2b 14 00 00       	call   101671 <cons_putc>
    (*cnt) ++;
  100246:	8b 45 0c             	mov    0xc(%ebp),%eax
  100249:	8b 00                	mov    (%eax),%eax
  10024b:	8d 50 01             	lea    0x1(%eax),%edx
  10024e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100251:	89 10                	mov    %edx,(%eax)
}
  100253:	90                   	nop
  100254:	c9                   	leave  
  100255:	c3                   	ret    

00100256 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  100256:	f3 0f 1e fb          	endbr32 
  10025a:	55                   	push   %ebp
  10025b:	89 e5                	mov    %esp,%ebp
  10025d:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100260:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100267:	8b 45 0c             	mov    0xc(%ebp),%eax
  10026a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10026e:	8b 45 08             	mov    0x8(%ebp),%eax
  100271:	89 44 24 08          	mov    %eax,0x8(%esp)
  100275:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100278:	89 44 24 04          	mov    %eax,0x4(%esp)
  10027c:	c7 04 24 31 02 10 00 	movl   $0x100231,(%esp)
  100283:	e8 0b 30 00 00       	call   103293 <vprintfmt>
    return cnt;
  100288:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10028b:	c9                   	leave  
  10028c:	c3                   	ret    

0010028d <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  10028d:	f3 0f 1e fb          	endbr32 
  100291:	55                   	push   %ebp
  100292:	89 e5                	mov    %esp,%ebp
  100294:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100297:	8d 45 0c             	lea    0xc(%ebp),%eax
  10029a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  10029d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1002a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1002a7:	89 04 24             	mov    %eax,(%esp)
  1002aa:	e8 a7 ff ff ff       	call   100256 <vcprintf>
  1002af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1002b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002b5:	c9                   	leave  
  1002b6:	c3                   	ret    

001002b7 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  1002b7:	f3 0f 1e fb          	endbr32 
  1002bb:	55                   	push   %ebp
  1002bc:	89 e5                	mov    %esp,%ebp
  1002be:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002c1:	8b 45 08             	mov    0x8(%ebp),%eax
  1002c4:	89 04 24             	mov    %eax,(%esp)
  1002c7:	e8 a5 13 00 00       	call   101671 <cons_putc>
}
  1002cc:	90                   	nop
  1002cd:	c9                   	leave  
  1002ce:	c3                   	ret    

001002cf <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  1002cf:	f3 0f 1e fb          	endbr32 
  1002d3:	55                   	push   %ebp
  1002d4:	89 e5                	mov    %esp,%ebp
  1002d6:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002d9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  1002e0:	eb 13                	jmp    1002f5 <cputs+0x26>
        cputch(c, &cnt);
  1002e2:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1002e6:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002e9:	89 54 24 04          	mov    %edx,0x4(%esp)
  1002ed:	89 04 24             	mov    %eax,(%esp)
  1002f0:	e8 3c ff ff ff       	call   100231 <cputch>
    while ((c = *str ++) != '\0') {
  1002f5:	8b 45 08             	mov    0x8(%ebp),%eax
  1002f8:	8d 50 01             	lea    0x1(%eax),%edx
  1002fb:	89 55 08             	mov    %edx,0x8(%ebp)
  1002fe:	0f b6 00             	movzbl (%eax),%eax
  100301:	88 45 f7             	mov    %al,-0x9(%ebp)
  100304:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  100308:	75 d8                	jne    1002e2 <cputs+0x13>
    }
    cputch('\n', &cnt);
  10030a:	8d 45 f0             	lea    -0x10(%ebp),%eax
  10030d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100311:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  100318:	e8 14 ff ff ff       	call   100231 <cputch>
    return cnt;
  10031d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100320:	c9                   	leave  
  100321:	c3                   	ret    

00100322 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  100322:	f3 0f 1e fb          	endbr32 
  100326:	55                   	push   %ebp
  100327:	89 e5                	mov    %esp,%ebp
  100329:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  10032c:	90                   	nop
  10032d:	e8 6d 13 00 00       	call   10169f <cons_getc>
  100332:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100335:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100339:	74 f2                	je     10032d <getchar+0xb>
        /* do nothing */;
    return c;
  10033b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10033e:	c9                   	leave  
  10033f:	c3                   	ret    

00100340 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100340:	f3 0f 1e fb          	endbr32 
  100344:	55                   	push   %ebp
  100345:	89 e5                	mov    %esp,%ebp
  100347:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  10034a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10034e:	74 13                	je     100363 <readline+0x23>
        cprintf("%s", prompt);
  100350:	8b 45 08             	mov    0x8(%ebp),%eax
  100353:	89 44 24 04          	mov    %eax,0x4(%esp)
  100357:	c7 04 24 07 38 10 00 	movl   $0x103807,(%esp)
  10035e:	e8 2a ff ff ff       	call   10028d <cprintf>
    }
    int i = 0, c;
  100363:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  10036a:	e8 b3 ff ff ff       	call   100322 <getchar>
  10036f:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100372:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100376:	79 07                	jns    10037f <readline+0x3f>
            return NULL;
  100378:	b8 00 00 00 00       	mov    $0x0,%eax
  10037d:	eb 78                	jmp    1003f7 <readline+0xb7>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  10037f:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100383:	7e 28                	jle    1003ad <readline+0x6d>
  100385:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  10038c:	7f 1f                	jg     1003ad <readline+0x6d>
            cputchar(c);
  10038e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100391:	89 04 24             	mov    %eax,(%esp)
  100394:	e8 1e ff ff ff       	call   1002b7 <cputchar>
            buf[i ++] = c;
  100399:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10039c:	8d 50 01             	lea    0x1(%eax),%edx
  10039f:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1003a2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1003a5:	88 90 40 0a 11 00    	mov    %dl,0x110a40(%eax)
  1003ab:	eb 45                	jmp    1003f2 <readline+0xb2>
        }
        else if (c == '\b' && i > 0) {
  1003ad:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  1003b1:	75 16                	jne    1003c9 <readline+0x89>
  1003b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003b7:	7e 10                	jle    1003c9 <readline+0x89>
            cputchar(c);
  1003b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003bc:	89 04 24             	mov    %eax,(%esp)
  1003bf:	e8 f3 fe ff ff       	call   1002b7 <cputchar>
            i --;
  1003c4:	ff 4d f4             	decl   -0xc(%ebp)
  1003c7:	eb 29                	jmp    1003f2 <readline+0xb2>
        }
        else if (c == '\n' || c == '\r') {
  1003c9:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1003cd:	74 06                	je     1003d5 <readline+0x95>
  1003cf:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1003d3:	75 95                	jne    10036a <readline+0x2a>
            cputchar(c);
  1003d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003d8:	89 04 24             	mov    %eax,(%esp)
  1003db:	e8 d7 fe ff ff       	call   1002b7 <cputchar>
            buf[i] = '\0';
  1003e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003e3:	05 40 0a 11 00       	add    $0x110a40,%eax
  1003e8:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003eb:	b8 40 0a 11 00       	mov    $0x110a40,%eax
  1003f0:	eb 05                	jmp    1003f7 <readline+0xb7>
        c = getchar();
  1003f2:	e9 73 ff ff ff       	jmp    10036a <readline+0x2a>
        }
    }
}
  1003f7:	c9                   	leave  
  1003f8:	c3                   	ret    

001003f9 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1003f9:	f3 0f 1e fb          	endbr32 
  1003fd:	55                   	push   %ebp
  1003fe:	89 e5                	mov    %esp,%ebp
  100400:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  100403:	a1 40 0e 11 00       	mov    0x110e40,%eax
  100408:	85 c0                	test   %eax,%eax
  10040a:	75 5b                	jne    100467 <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
  10040c:	c7 05 40 0e 11 00 01 	movl   $0x1,0x110e40
  100413:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100416:	8d 45 14             	lea    0x14(%ebp),%eax
  100419:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  10041c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10041f:	89 44 24 08          	mov    %eax,0x8(%esp)
  100423:	8b 45 08             	mov    0x8(%ebp),%eax
  100426:	89 44 24 04          	mov    %eax,0x4(%esp)
  10042a:	c7 04 24 0a 38 10 00 	movl   $0x10380a,(%esp)
  100431:	e8 57 fe ff ff       	call   10028d <cprintf>
    vcprintf(fmt, ap);
  100436:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100439:	89 44 24 04          	mov    %eax,0x4(%esp)
  10043d:	8b 45 10             	mov    0x10(%ebp),%eax
  100440:	89 04 24             	mov    %eax,(%esp)
  100443:	e8 0e fe ff ff       	call   100256 <vcprintf>
    cprintf("\n");
  100448:	c7 04 24 26 38 10 00 	movl   $0x103826,(%esp)
  10044f:	e8 39 fe ff ff       	call   10028d <cprintf>
    
    cprintf("stack trackback:\n");
  100454:	c7 04 24 28 38 10 00 	movl   $0x103828,(%esp)
  10045b:	e8 2d fe ff ff       	call   10028d <cprintf>
    print_stackframe();
  100460:	e8 3d 06 00 00       	call   100aa2 <print_stackframe>
  100465:	eb 01                	jmp    100468 <__panic+0x6f>
        goto panic_dead;
  100467:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  100468:	e8 80 14 00 00       	call   1018ed <intr_disable>
    while (1) {
        kmonitor(NULL);
  10046d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100474:	e8 5d 08 00 00       	call   100cd6 <kmonitor>
  100479:	eb f2                	jmp    10046d <__panic+0x74>

0010047b <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  10047b:	f3 0f 1e fb          	endbr32 
  10047f:	55                   	push   %ebp
  100480:	89 e5                	mov    %esp,%ebp
  100482:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100485:	8d 45 14             	lea    0x14(%ebp),%eax
  100488:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  10048b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10048e:	89 44 24 08          	mov    %eax,0x8(%esp)
  100492:	8b 45 08             	mov    0x8(%ebp),%eax
  100495:	89 44 24 04          	mov    %eax,0x4(%esp)
  100499:	c7 04 24 3a 38 10 00 	movl   $0x10383a,(%esp)
  1004a0:	e8 e8 fd ff ff       	call   10028d <cprintf>
    vcprintf(fmt, ap);
  1004a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004a8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004ac:	8b 45 10             	mov    0x10(%ebp),%eax
  1004af:	89 04 24             	mov    %eax,(%esp)
  1004b2:	e8 9f fd ff ff       	call   100256 <vcprintf>
    cprintf("\n");
  1004b7:	c7 04 24 26 38 10 00 	movl   $0x103826,(%esp)
  1004be:	e8 ca fd ff ff       	call   10028d <cprintf>
    va_end(ap);
}
  1004c3:	90                   	nop
  1004c4:	c9                   	leave  
  1004c5:	c3                   	ret    

001004c6 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  1004c6:	f3 0f 1e fb          	endbr32 
  1004ca:	55                   	push   %ebp
  1004cb:	89 e5                	mov    %esp,%ebp
    return is_panic;
  1004cd:	a1 40 0e 11 00       	mov    0x110e40,%eax
}
  1004d2:	5d                   	pop    %ebp
  1004d3:	c3                   	ret    

001004d4 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1004d4:	f3 0f 1e fb          	endbr32 
  1004d8:	55                   	push   %ebp
  1004d9:	89 e5                	mov    %esp,%ebp
  1004db:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1004de:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004e1:	8b 00                	mov    (%eax),%eax
  1004e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1004e6:	8b 45 10             	mov    0x10(%ebp),%eax
  1004e9:	8b 00                	mov    (%eax),%eax
  1004eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1004f5:	e9 ca 00 00 00       	jmp    1005c4 <stab_binsearch+0xf0>
        int true_m = (l + r) / 2, m = true_m;
  1004fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100500:	01 d0                	add    %edx,%eax
  100502:	89 c2                	mov    %eax,%edx
  100504:	c1 ea 1f             	shr    $0x1f,%edx
  100507:	01 d0                	add    %edx,%eax
  100509:	d1 f8                	sar    %eax
  10050b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10050e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100511:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100514:	eb 03                	jmp    100519 <stab_binsearch+0x45>
            m --;
  100516:	ff 4d f0             	decl   -0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  100519:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10051c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10051f:	7c 1f                	jl     100540 <stab_binsearch+0x6c>
  100521:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100524:	89 d0                	mov    %edx,%eax
  100526:	01 c0                	add    %eax,%eax
  100528:	01 d0                	add    %edx,%eax
  10052a:	c1 e0 02             	shl    $0x2,%eax
  10052d:	89 c2                	mov    %eax,%edx
  10052f:	8b 45 08             	mov    0x8(%ebp),%eax
  100532:	01 d0                	add    %edx,%eax
  100534:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100538:	0f b6 c0             	movzbl %al,%eax
  10053b:	39 45 14             	cmp    %eax,0x14(%ebp)
  10053e:	75 d6                	jne    100516 <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
  100540:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100543:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100546:	7d 09                	jge    100551 <stab_binsearch+0x7d>
            l = true_m + 1;
  100548:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10054b:	40                   	inc    %eax
  10054c:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10054f:	eb 73                	jmp    1005c4 <stab_binsearch+0xf0>
        }

        // actual binary search
        any_matches = 1;
  100551:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100558:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10055b:	89 d0                	mov    %edx,%eax
  10055d:	01 c0                	add    %eax,%eax
  10055f:	01 d0                	add    %edx,%eax
  100561:	c1 e0 02             	shl    $0x2,%eax
  100564:	89 c2                	mov    %eax,%edx
  100566:	8b 45 08             	mov    0x8(%ebp),%eax
  100569:	01 d0                	add    %edx,%eax
  10056b:	8b 40 08             	mov    0x8(%eax),%eax
  10056e:	39 45 18             	cmp    %eax,0x18(%ebp)
  100571:	76 11                	jbe    100584 <stab_binsearch+0xb0>
            *region_left = m;
  100573:	8b 45 0c             	mov    0xc(%ebp),%eax
  100576:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100579:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  10057b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10057e:	40                   	inc    %eax
  10057f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100582:	eb 40                	jmp    1005c4 <stab_binsearch+0xf0>
        } else if (stabs[m].n_value > addr) {
  100584:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100587:	89 d0                	mov    %edx,%eax
  100589:	01 c0                	add    %eax,%eax
  10058b:	01 d0                	add    %edx,%eax
  10058d:	c1 e0 02             	shl    $0x2,%eax
  100590:	89 c2                	mov    %eax,%edx
  100592:	8b 45 08             	mov    0x8(%ebp),%eax
  100595:	01 d0                	add    %edx,%eax
  100597:	8b 40 08             	mov    0x8(%eax),%eax
  10059a:	39 45 18             	cmp    %eax,0x18(%ebp)
  10059d:	73 14                	jae    1005b3 <stab_binsearch+0xdf>
            *region_right = m - 1;
  10059f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005a2:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005a5:	8b 45 10             	mov    0x10(%ebp),%eax
  1005a8:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1005aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005ad:	48                   	dec    %eax
  1005ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005b1:	eb 11                	jmp    1005c4 <stab_binsearch+0xf0>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1005b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005b6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005b9:	89 10                	mov    %edx,(%eax)
            l = m;
  1005bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005be:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1005c1:	ff 45 18             	incl   0x18(%ebp)
    while (l <= r) {
  1005c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1005ca:	0f 8e 2a ff ff ff    	jle    1004fa <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
  1005d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1005d4:	75 0f                	jne    1005e5 <stab_binsearch+0x111>
        *region_right = *region_left - 1;
  1005d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005d9:	8b 00                	mov    (%eax),%eax
  1005db:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005de:	8b 45 10             	mov    0x10(%ebp),%eax
  1005e1:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1005e3:	eb 3e                	jmp    100623 <stab_binsearch+0x14f>
        l = *region_right;
  1005e5:	8b 45 10             	mov    0x10(%ebp),%eax
  1005e8:	8b 00                	mov    (%eax),%eax
  1005ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1005ed:	eb 03                	jmp    1005f2 <stab_binsearch+0x11e>
  1005ef:	ff 4d fc             	decl   -0x4(%ebp)
  1005f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005f5:	8b 00                	mov    (%eax),%eax
  1005f7:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1005fa:	7e 1f                	jle    10061b <stab_binsearch+0x147>
  1005fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005ff:	89 d0                	mov    %edx,%eax
  100601:	01 c0                	add    %eax,%eax
  100603:	01 d0                	add    %edx,%eax
  100605:	c1 e0 02             	shl    $0x2,%eax
  100608:	89 c2                	mov    %eax,%edx
  10060a:	8b 45 08             	mov    0x8(%ebp),%eax
  10060d:	01 d0                	add    %edx,%eax
  10060f:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100613:	0f b6 c0             	movzbl %al,%eax
  100616:	39 45 14             	cmp    %eax,0x14(%ebp)
  100619:	75 d4                	jne    1005ef <stab_binsearch+0x11b>
        *region_left = l;
  10061b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10061e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100621:	89 10                	mov    %edx,(%eax)
}
  100623:	90                   	nop
  100624:	c9                   	leave  
  100625:	c3                   	ret    

00100626 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100626:	f3 0f 1e fb          	endbr32 
  10062a:	55                   	push   %ebp
  10062b:	89 e5                	mov    %esp,%ebp
  10062d:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100630:	8b 45 0c             	mov    0xc(%ebp),%eax
  100633:	c7 00 58 38 10 00    	movl   $0x103858,(%eax)
    info->eip_line = 0;
  100639:	8b 45 0c             	mov    0xc(%ebp),%eax
  10063c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100643:	8b 45 0c             	mov    0xc(%ebp),%eax
  100646:	c7 40 08 58 38 10 00 	movl   $0x103858,0x8(%eax)
    info->eip_fn_namelen = 9;
  10064d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100650:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100657:	8b 45 0c             	mov    0xc(%ebp),%eax
  10065a:	8b 55 08             	mov    0x8(%ebp),%edx
  10065d:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100660:	8b 45 0c             	mov    0xc(%ebp),%eax
  100663:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  10066a:	c7 45 f4 6c 40 10 00 	movl   $0x10406c,-0xc(%ebp)
    stab_end = __STAB_END__;
  100671:	c7 45 f0 f8 ce 10 00 	movl   $0x10cef8,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100678:	c7 45 ec f9 ce 10 00 	movl   $0x10cef9,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  10067f:	c7 45 e8 0a f0 10 00 	movl   $0x10f00a,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100686:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100689:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10068c:	76 0b                	jbe    100699 <debuginfo_eip+0x73>
  10068e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100691:	48                   	dec    %eax
  100692:	0f b6 00             	movzbl (%eax),%eax
  100695:	84 c0                	test   %al,%al
  100697:	74 0a                	je     1006a3 <debuginfo_eip+0x7d>
        return -1;
  100699:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10069e:	e9 ab 02 00 00       	jmp    10094e <debuginfo_eip+0x328>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  1006a3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1006aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006ad:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1006b0:	c1 f8 02             	sar    $0x2,%eax
  1006b3:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1006b9:	48                   	dec    %eax
  1006ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1006bd:	8b 45 08             	mov    0x8(%ebp),%eax
  1006c0:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006c4:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1006cb:	00 
  1006cc:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1006cf:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006d3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1006d6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006dd:	89 04 24             	mov    %eax,(%esp)
  1006e0:	e8 ef fd ff ff       	call   1004d4 <stab_binsearch>
    if (lfile == 0)
  1006e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006e8:	85 c0                	test   %eax,%eax
  1006ea:	75 0a                	jne    1006f6 <debuginfo_eip+0xd0>
        return -1;
  1006ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006f1:	e9 58 02 00 00       	jmp    10094e <debuginfo_eip+0x328>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006f9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1006fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  100702:	8b 45 08             	mov    0x8(%ebp),%eax
  100705:	89 44 24 10          	mov    %eax,0x10(%esp)
  100709:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  100710:	00 
  100711:	8d 45 d8             	lea    -0x28(%ebp),%eax
  100714:	89 44 24 08          	mov    %eax,0x8(%esp)
  100718:	8d 45 dc             	lea    -0x24(%ebp),%eax
  10071b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10071f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100722:	89 04 24             	mov    %eax,(%esp)
  100725:	e8 aa fd ff ff       	call   1004d4 <stab_binsearch>

    if (lfun <= rfun) {
  10072a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  10072d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100730:	39 c2                	cmp    %eax,%edx
  100732:	7f 78                	jg     1007ac <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  100734:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100737:	89 c2                	mov    %eax,%edx
  100739:	89 d0                	mov    %edx,%eax
  10073b:	01 c0                	add    %eax,%eax
  10073d:	01 d0                	add    %edx,%eax
  10073f:	c1 e0 02             	shl    $0x2,%eax
  100742:	89 c2                	mov    %eax,%edx
  100744:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100747:	01 d0                	add    %edx,%eax
  100749:	8b 10                	mov    (%eax),%edx
  10074b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10074e:	2b 45 ec             	sub    -0x14(%ebp),%eax
  100751:	39 c2                	cmp    %eax,%edx
  100753:	73 22                	jae    100777 <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100755:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100758:	89 c2                	mov    %eax,%edx
  10075a:	89 d0                	mov    %edx,%eax
  10075c:	01 c0                	add    %eax,%eax
  10075e:	01 d0                	add    %edx,%eax
  100760:	c1 e0 02             	shl    $0x2,%eax
  100763:	89 c2                	mov    %eax,%edx
  100765:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100768:	01 d0                	add    %edx,%eax
  10076a:	8b 10                	mov    (%eax),%edx
  10076c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10076f:	01 c2                	add    %eax,%edx
  100771:	8b 45 0c             	mov    0xc(%ebp),%eax
  100774:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100777:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10077a:	89 c2                	mov    %eax,%edx
  10077c:	89 d0                	mov    %edx,%eax
  10077e:	01 c0                	add    %eax,%eax
  100780:	01 d0                	add    %edx,%eax
  100782:	c1 e0 02             	shl    $0x2,%eax
  100785:	89 c2                	mov    %eax,%edx
  100787:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10078a:	01 d0                	add    %edx,%eax
  10078c:	8b 50 08             	mov    0x8(%eax),%edx
  10078f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100792:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100795:	8b 45 0c             	mov    0xc(%ebp),%eax
  100798:	8b 40 10             	mov    0x10(%eax),%eax
  10079b:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10079e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1007a1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  1007a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1007a7:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1007aa:	eb 15                	jmp    1007c1 <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1007ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007af:	8b 55 08             	mov    0x8(%ebp),%edx
  1007b2:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1007b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007b8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1007bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007be:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1007c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007c4:	8b 40 08             	mov    0x8(%eax),%eax
  1007c7:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1007ce:	00 
  1007cf:	89 04 24             	mov    %eax,(%esp)
  1007d2:	e8 c4 25 00 00       	call   102d9b <strfind>
  1007d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  1007da:	8b 52 08             	mov    0x8(%edx),%edx
  1007dd:	29 d0                	sub    %edx,%eax
  1007df:	89 c2                	mov    %eax,%edx
  1007e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007e4:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  1007ea:	89 44 24 10          	mov    %eax,0x10(%esp)
  1007ee:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1007f5:	00 
  1007f6:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1007f9:	89 44 24 08          	mov    %eax,0x8(%esp)
  1007fd:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  100800:	89 44 24 04          	mov    %eax,0x4(%esp)
  100804:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100807:	89 04 24             	mov    %eax,(%esp)
  10080a:	e8 c5 fc ff ff       	call   1004d4 <stab_binsearch>
    if (lline <= rline) {
  10080f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100812:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100815:	39 c2                	cmp    %eax,%edx
  100817:	7f 23                	jg     10083c <debuginfo_eip+0x216>
        info->eip_line = stabs[rline].n_desc;
  100819:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10081c:	89 c2                	mov    %eax,%edx
  10081e:	89 d0                	mov    %edx,%eax
  100820:	01 c0                	add    %eax,%eax
  100822:	01 d0                	add    %edx,%eax
  100824:	c1 e0 02             	shl    $0x2,%eax
  100827:	89 c2                	mov    %eax,%edx
  100829:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10082c:	01 d0                	add    %edx,%eax
  10082e:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  100832:	89 c2                	mov    %eax,%edx
  100834:	8b 45 0c             	mov    0xc(%ebp),%eax
  100837:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10083a:	eb 11                	jmp    10084d <debuginfo_eip+0x227>
        return -1;
  10083c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100841:	e9 08 01 00 00       	jmp    10094e <debuginfo_eip+0x328>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100846:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100849:	48                   	dec    %eax
  10084a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  10084d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100850:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100853:	39 c2                	cmp    %eax,%edx
  100855:	7c 56                	jl     1008ad <debuginfo_eip+0x287>
           && stabs[lline].n_type != N_SOL
  100857:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10085a:	89 c2                	mov    %eax,%edx
  10085c:	89 d0                	mov    %edx,%eax
  10085e:	01 c0                	add    %eax,%eax
  100860:	01 d0                	add    %edx,%eax
  100862:	c1 e0 02             	shl    $0x2,%eax
  100865:	89 c2                	mov    %eax,%edx
  100867:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10086a:	01 d0                	add    %edx,%eax
  10086c:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100870:	3c 84                	cmp    $0x84,%al
  100872:	74 39                	je     1008ad <debuginfo_eip+0x287>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100874:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100877:	89 c2                	mov    %eax,%edx
  100879:	89 d0                	mov    %edx,%eax
  10087b:	01 c0                	add    %eax,%eax
  10087d:	01 d0                	add    %edx,%eax
  10087f:	c1 e0 02             	shl    $0x2,%eax
  100882:	89 c2                	mov    %eax,%edx
  100884:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100887:	01 d0                	add    %edx,%eax
  100889:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10088d:	3c 64                	cmp    $0x64,%al
  10088f:	75 b5                	jne    100846 <debuginfo_eip+0x220>
  100891:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100894:	89 c2                	mov    %eax,%edx
  100896:	89 d0                	mov    %edx,%eax
  100898:	01 c0                	add    %eax,%eax
  10089a:	01 d0                	add    %edx,%eax
  10089c:	c1 e0 02             	shl    $0x2,%eax
  10089f:	89 c2                	mov    %eax,%edx
  1008a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008a4:	01 d0                	add    %edx,%eax
  1008a6:	8b 40 08             	mov    0x8(%eax),%eax
  1008a9:	85 c0                	test   %eax,%eax
  1008ab:	74 99                	je     100846 <debuginfo_eip+0x220>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1008ad:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1008b3:	39 c2                	cmp    %eax,%edx
  1008b5:	7c 42                	jl     1008f9 <debuginfo_eip+0x2d3>
  1008b7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008ba:	89 c2                	mov    %eax,%edx
  1008bc:	89 d0                	mov    %edx,%eax
  1008be:	01 c0                	add    %eax,%eax
  1008c0:	01 d0                	add    %edx,%eax
  1008c2:	c1 e0 02             	shl    $0x2,%eax
  1008c5:	89 c2                	mov    %eax,%edx
  1008c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008ca:	01 d0                	add    %edx,%eax
  1008cc:	8b 10                	mov    (%eax),%edx
  1008ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1008d1:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1008d4:	39 c2                	cmp    %eax,%edx
  1008d6:	73 21                	jae    1008f9 <debuginfo_eip+0x2d3>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1008d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008db:	89 c2                	mov    %eax,%edx
  1008dd:	89 d0                	mov    %edx,%eax
  1008df:	01 c0                	add    %eax,%eax
  1008e1:	01 d0                	add    %edx,%eax
  1008e3:	c1 e0 02             	shl    $0x2,%eax
  1008e6:	89 c2                	mov    %eax,%edx
  1008e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008eb:	01 d0                	add    %edx,%eax
  1008ed:	8b 10                	mov    (%eax),%edx
  1008ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1008f2:	01 c2                	add    %eax,%edx
  1008f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008f7:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1008f9:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1008fc:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1008ff:	39 c2                	cmp    %eax,%edx
  100901:	7d 46                	jge    100949 <debuginfo_eip+0x323>
        for (lline = lfun + 1;
  100903:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100906:	40                   	inc    %eax
  100907:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  10090a:	eb 16                	jmp    100922 <debuginfo_eip+0x2fc>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  10090c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10090f:	8b 40 14             	mov    0x14(%eax),%eax
  100912:	8d 50 01             	lea    0x1(%eax),%edx
  100915:	8b 45 0c             	mov    0xc(%ebp),%eax
  100918:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  10091b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10091e:	40                   	inc    %eax
  10091f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100922:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100925:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  100928:	39 c2                	cmp    %eax,%edx
  10092a:	7d 1d                	jge    100949 <debuginfo_eip+0x323>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  10092c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10092f:	89 c2                	mov    %eax,%edx
  100931:	89 d0                	mov    %edx,%eax
  100933:	01 c0                	add    %eax,%eax
  100935:	01 d0                	add    %edx,%eax
  100937:	c1 e0 02             	shl    $0x2,%eax
  10093a:	89 c2                	mov    %eax,%edx
  10093c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10093f:	01 d0                	add    %edx,%eax
  100941:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100945:	3c a0                	cmp    $0xa0,%al
  100947:	74 c3                	je     10090c <debuginfo_eip+0x2e6>
        }
    }
    return 0;
  100949:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10094e:	c9                   	leave  
  10094f:	c3                   	ret    

00100950 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100950:	f3 0f 1e fb          	endbr32 
  100954:	55                   	push   %ebp
  100955:	89 e5                	mov    %esp,%ebp
  100957:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  10095a:	c7 04 24 62 38 10 00 	movl   $0x103862,(%esp)
  100961:	e8 27 f9 ff ff       	call   10028d <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100966:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10096d:	00 
  10096e:	c7 04 24 7b 38 10 00 	movl   $0x10387b,(%esp)
  100975:	e8 13 f9 ff ff       	call   10028d <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  10097a:	c7 44 24 04 4b 37 10 	movl   $0x10374b,0x4(%esp)
  100981:	00 
  100982:	c7 04 24 93 38 10 00 	movl   $0x103893,(%esp)
  100989:	e8 ff f8 ff ff       	call   10028d <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  10098e:	c7 44 24 04 16 0a 11 	movl   $0x110a16,0x4(%esp)
  100995:	00 
  100996:	c7 04 24 ab 38 10 00 	movl   $0x1038ab,(%esp)
  10099d:	e8 eb f8 ff ff       	call   10028d <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1009a2:	c7 44 24 04 80 1d 11 	movl   $0x111d80,0x4(%esp)
  1009a9:	00 
  1009aa:	c7 04 24 c3 38 10 00 	movl   $0x1038c3,(%esp)
  1009b1:	e8 d7 f8 ff ff       	call   10028d <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1009b6:	b8 80 1d 11 00       	mov    $0x111d80,%eax
  1009bb:	2d 00 00 10 00       	sub    $0x100000,%eax
  1009c0:	05 ff 03 00 00       	add    $0x3ff,%eax
  1009c5:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1009cb:	85 c0                	test   %eax,%eax
  1009cd:	0f 48 c2             	cmovs  %edx,%eax
  1009d0:	c1 f8 0a             	sar    $0xa,%eax
  1009d3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009d7:	c7 04 24 dc 38 10 00 	movl   $0x1038dc,(%esp)
  1009de:	e8 aa f8 ff ff       	call   10028d <cprintf>
}
  1009e3:	90                   	nop
  1009e4:	c9                   	leave  
  1009e5:	c3                   	ret    

001009e6 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1009e6:	f3 0f 1e fb          	endbr32 
  1009ea:	55                   	push   %ebp
  1009eb:	89 e5                	mov    %esp,%ebp
  1009ed:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1009f3:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1009f6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  1009fd:	89 04 24             	mov    %eax,(%esp)
  100a00:	e8 21 fc ff ff       	call   100626 <debuginfo_eip>
  100a05:	85 c0                	test   %eax,%eax
  100a07:	74 15                	je     100a1e <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100a09:	8b 45 08             	mov    0x8(%ebp),%eax
  100a0c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a10:	c7 04 24 06 39 10 00 	movl   $0x103906,(%esp)
  100a17:	e8 71 f8 ff ff       	call   10028d <cprintf>
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100a1c:	eb 6c                	jmp    100a8a <print_debuginfo+0xa4>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100a25:	eb 1b                	jmp    100a42 <print_debuginfo+0x5c>
            fnname[j] = info.eip_fn_name[j];
  100a27:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a2d:	01 d0                	add    %edx,%eax
  100a2f:	0f b6 10             	movzbl (%eax),%edx
  100a32:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a38:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a3b:	01 c8                	add    %ecx,%eax
  100a3d:	88 10                	mov    %dl,(%eax)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a3f:	ff 45 f4             	incl   -0xc(%ebp)
  100a42:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a45:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100a48:	7c dd                	jl     100a27 <print_debuginfo+0x41>
        fnname[j] = '\0';
  100a4a:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100a50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a53:	01 d0                	add    %edx,%eax
  100a55:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100a58:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a5b:	8b 55 08             	mov    0x8(%ebp),%edx
  100a5e:	89 d1                	mov    %edx,%ecx
  100a60:	29 c1                	sub    %eax,%ecx
  100a62:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a65:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a68:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  100a6c:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a72:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a76:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a7a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a7e:	c7 04 24 22 39 10 00 	movl   $0x103922,(%esp)
  100a85:	e8 03 f8 ff ff       	call   10028d <cprintf>
}
  100a8a:	90                   	nop
  100a8b:	c9                   	leave  
  100a8c:	c3                   	ret    

00100a8d <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a8d:	f3 0f 1e fb          	endbr32 
  100a91:	55                   	push   %ebp
  100a92:	89 e5                	mov    %esp,%ebp
  100a94:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a97:	8b 45 04             	mov    0x4(%ebp),%eax
  100a9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100a9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100aa0:	c9                   	leave  
  100aa1:	c3                   	ret    

00100aa2 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100aa2:	f3 0f 1e fb          	endbr32 
  100aa6:	55                   	push   %ebp
  100aa7:	89 e5                	mov    %esp,%ebp
  100aa9:	83 ec 38             	sub    $0x38,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100aac:	89 e8                	mov    %ebp,%eax
  100aae:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
  100ab1:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp = read_ebp();
  100ab4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    uint32_t eip = read_eip();
  100ab7:	e8 d1 ff ff ff       	call   100a8d <read_eip>
  100abc:	89 45 f0             	mov    %eax,-0x10(%ebp)

    for(uint32_t i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i++) {
  100abf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100ac6:	e9 84 00 00 00       	jmp    100b4f <print_stackframe+0xad>
        cprintf("ebp: 0x%08x eip: 0x%08x arg:", ebp, eip);
  100acb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ace:	89 44 24 08          	mov    %eax,0x8(%esp)
  100ad2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ad5:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ad9:	c7 04 24 34 39 10 00 	movl   $0x103934,(%esp)
  100ae0:	e8 a8 f7 ff ff       	call   10028d <cprintf>
        uint32_t *arg = (uint32_t *)ebp + 2;
  100ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ae8:	83 c0 08             	add    $0x8,%eax
  100aeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for(uint32_t j = 0; j< 4; j++) {
  100aee:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100af5:	eb 24                	jmp    100b1b <print_stackframe+0x79>
            cprintf("0x%08x ", arg[j]);
  100af7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100afa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100b04:	01 d0                	add    %edx,%eax
  100b06:	8b 00                	mov    (%eax),%eax
  100b08:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b0c:	c7 04 24 51 39 10 00 	movl   $0x103951,(%esp)
  100b13:	e8 75 f7 ff ff       	call   10028d <cprintf>
        for(uint32_t j = 0; j< 4; j++) {
  100b18:	ff 45 e8             	incl   -0x18(%ebp)
  100b1b:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100b1f:	76 d6                	jbe    100af7 <print_stackframe+0x55>
        }
        cprintf("\n");
  100b21:	c7 04 24 59 39 10 00 	movl   $0x103959,(%esp)
  100b28:	e8 60 f7 ff ff       	call   10028d <cprintf>
        print_debuginfo(eip - 1);
  100b2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b30:	48                   	dec    %eax
  100b31:	89 04 24             	mov    %eax,(%esp)
  100b34:	e8 ad fe ff ff       	call   1009e6 <print_debuginfo>
        eip = *((uint32_t *)ebp + 1);
  100b39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b3c:	83 c0 04             	add    $0x4,%eax
  100b3f:	8b 00                	mov    (%eax),%eax
  100b41:	89 45 f0             	mov    %eax,-0x10(%ebp)
        ebp = *(uint32_t *)ebp;
  100b44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b47:	8b 00                	mov    (%eax),%eax
  100b49:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for(uint32_t i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i++) {
  100b4c:	ff 45 ec             	incl   -0x14(%ebp)
  100b4f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b53:	74 0a                	je     100b5f <print_stackframe+0xbd>
  100b55:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100b59:	0f 86 6c ff ff ff    	jbe    100acb <print_stackframe+0x29>
    }
}
  100b5f:	90                   	nop
  100b60:	c9                   	leave  
  100b61:	c3                   	ret    

00100b62 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100b62:	f3 0f 1e fb          	endbr32 
  100b66:	55                   	push   %ebp
  100b67:	89 e5                	mov    %esp,%ebp
  100b69:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100b6c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b73:	eb 0c                	jmp    100b81 <parse+0x1f>
            *buf ++ = '\0';
  100b75:	8b 45 08             	mov    0x8(%ebp),%eax
  100b78:	8d 50 01             	lea    0x1(%eax),%edx
  100b7b:	89 55 08             	mov    %edx,0x8(%ebp)
  100b7e:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b81:	8b 45 08             	mov    0x8(%ebp),%eax
  100b84:	0f b6 00             	movzbl (%eax),%eax
  100b87:	84 c0                	test   %al,%al
  100b89:	74 1d                	je     100ba8 <parse+0x46>
  100b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  100b8e:	0f b6 00             	movzbl (%eax),%eax
  100b91:	0f be c0             	movsbl %al,%eax
  100b94:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b98:	c7 04 24 dc 39 10 00 	movl   $0x1039dc,(%esp)
  100b9f:	e8 c1 21 00 00       	call   102d65 <strchr>
  100ba4:	85 c0                	test   %eax,%eax
  100ba6:	75 cd                	jne    100b75 <parse+0x13>
        }
        if (*buf == '\0') {
  100ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  100bab:	0f b6 00             	movzbl (%eax),%eax
  100bae:	84 c0                	test   %al,%al
  100bb0:	74 65                	je     100c17 <parse+0xb5>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100bb2:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100bb6:	75 14                	jne    100bcc <parse+0x6a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100bb8:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100bbf:	00 
  100bc0:	c7 04 24 e1 39 10 00 	movl   $0x1039e1,(%esp)
  100bc7:	e8 c1 f6 ff ff       	call   10028d <cprintf>
        }
        argv[argc ++] = buf;
  100bcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bcf:	8d 50 01             	lea    0x1(%eax),%edx
  100bd2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100bd5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100bdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  100bdf:	01 c2                	add    %eax,%edx
  100be1:	8b 45 08             	mov    0x8(%ebp),%eax
  100be4:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100be6:	eb 03                	jmp    100beb <parse+0x89>
            buf ++;
  100be8:	ff 45 08             	incl   0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100beb:	8b 45 08             	mov    0x8(%ebp),%eax
  100bee:	0f b6 00             	movzbl (%eax),%eax
  100bf1:	84 c0                	test   %al,%al
  100bf3:	74 8c                	je     100b81 <parse+0x1f>
  100bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  100bf8:	0f b6 00             	movzbl (%eax),%eax
  100bfb:	0f be c0             	movsbl %al,%eax
  100bfe:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c02:	c7 04 24 dc 39 10 00 	movl   $0x1039dc,(%esp)
  100c09:	e8 57 21 00 00       	call   102d65 <strchr>
  100c0e:	85 c0                	test   %eax,%eax
  100c10:	74 d6                	je     100be8 <parse+0x86>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100c12:	e9 6a ff ff ff       	jmp    100b81 <parse+0x1f>
            break;
  100c17:	90                   	nop
        }
    }
    return argc;
  100c18:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100c1b:	c9                   	leave  
  100c1c:	c3                   	ret    

00100c1d <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100c1d:	f3 0f 1e fb          	endbr32 
  100c21:	55                   	push   %ebp
  100c22:	89 e5                	mov    %esp,%ebp
  100c24:	53                   	push   %ebx
  100c25:	83 ec 64             	sub    $0x64,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100c28:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c2b:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  100c32:	89 04 24             	mov    %eax,(%esp)
  100c35:	e8 28 ff ff ff       	call   100b62 <parse>
  100c3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100c3d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100c41:	75 0a                	jne    100c4d <runcmd+0x30>
        return 0;
  100c43:	b8 00 00 00 00       	mov    $0x0,%eax
  100c48:	e9 83 00 00 00       	jmp    100cd0 <runcmd+0xb3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c4d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c54:	eb 5a                	jmp    100cb0 <runcmd+0x93>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100c56:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100c59:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c5c:	89 d0                	mov    %edx,%eax
  100c5e:	01 c0                	add    %eax,%eax
  100c60:	01 d0                	add    %edx,%eax
  100c62:	c1 e0 02             	shl    $0x2,%eax
  100c65:	05 00 00 11 00       	add    $0x110000,%eax
  100c6a:	8b 00                	mov    (%eax),%eax
  100c6c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100c70:	89 04 24             	mov    %eax,(%esp)
  100c73:	e8 49 20 00 00       	call   102cc1 <strcmp>
  100c78:	85 c0                	test   %eax,%eax
  100c7a:	75 31                	jne    100cad <runcmd+0x90>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c7c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c7f:	89 d0                	mov    %edx,%eax
  100c81:	01 c0                	add    %eax,%eax
  100c83:	01 d0                	add    %edx,%eax
  100c85:	c1 e0 02             	shl    $0x2,%eax
  100c88:	05 08 00 11 00       	add    $0x110008,%eax
  100c8d:	8b 10                	mov    (%eax),%edx
  100c8f:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c92:	83 c0 04             	add    $0x4,%eax
  100c95:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100c98:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  100c9b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100c9e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100ca2:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ca6:	89 1c 24             	mov    %ebx,(%esp)
  100ca9:	ff d2                	call   *%edx
  100cab:	eb 23                	jmp    100cd0 <runcmd+0xb3>
    for (i = 0; i < NCOMMANDS; i ++) {
  100cad:	ff 45 f4             	incl   -0xc(%ebp)
  100cb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cb3:	83 f8 02             	cmp    $0x2,%eax
  100cb6:	76 9e                	jbe    100c56 <runcmd+0x39>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100cb8:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100cbb:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cbf:	c7 04 24 ff 39 10 00 	movl   $0x1039ff,(%esp)
  100cc6:	e8 c2 f5 ff ff       	call   10028d <cprintf>
    return 0;
  100ccb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cd0:	83 c4 64             	add    $0x64,%esp
  100cd3:	5b                   	pop    %ebx
  100cd4:	5d                   	pop    %ebp
  100cd5:	c3                   	ret    

00100cd6 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100cd6:	f3 0f 1e fb          	endbr32 
  100cda:	55                   	push   %ebp
  100cdb:	89 e5                	mov    %esp,%ebp
  100cdd:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100ce0:	c7 04 24 18 3a 10 00 	movl   $0x103a18,(%esp)
  100ce7:	e8 a1 f5 ff ff       	call   10028d <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100cec:	c7 04 24 40 3a 10 00 	movl   $0x103a40,(%esp)
  100cf3:	e8 95 f5 ff ff       	call   10028d <cprintf>

    if (tf != NULL) {
  100cf8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100cfc:	74 0b                	je     100d09 <kmonitor+0x33>
        print_trapframe(tf);
  100cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  100d01:	89 04 24             	mov    %eax,(%esp)
  100d04:	e8 d5 0d 00 00       	call   101ade <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100d09:	c7 04 24 65 3a 10 00 	movl   $0x103a65,(%esp)
  100d10:	e8 2b f6 ff ff       	call   100340 <readline>
  100d15:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d18:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100d1c:	74 eb                	je     100d09 <kmonitor+0x33>
            if (runcmd(buf, tf) < 0) {
  100d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  100d21:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d28:	89 04 24             	mov    %eax,(%esp)
  100d2b:	e8 ed fe ff ff       	call   100c1d <runcmd>
  100d30:	85 c0                	test   %eax,%eax
  100d32:	78 02                	js     100d36 <kmonitor+0x60>
        if ((buf = readline("K> ")) != NULL) {
  100d34:	eb d3                	jmp    100d09 <kmonitor+0x33>
                break;
  100d36:	90                   	nop
            }
        }
    }
}
  100d37:	90                   	nop
  100d38:	c9                   	leave  
  100d39:	c3                   	ret    

00100d3a <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100d3a:	f3 0f 1e fb          	endbr32 
  100d3e:	55                   	push   %ebp
  100d3f:	89 e5                	mov    %esp,%ebp
  100d41:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d44:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d4b:	eb 3d                	jmp    100d8a <mon_help+0x50>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100d4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d50:	89 d0                	mov    %edx,%eax
  100d52:	01 c0                	add    %eax,%eax
  100d54:	01 d0                	add    %edx,%eax
  100d56:	c1 e0 02             	shl    $0x2,%eax
  100d59:	05 04 00 11 00       	add    $0x110004,%eax
  100d5e:	8b 08                	mov    (%eax),%ecx
  100d60:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d63:	89 d0                	mov    %edx,%eax
  100d65:	01 c0                	add    %eax,%eax
  100d67:	01 d0                	add    %edx,%eax
  100d69:	c1 e0 02             	shl    $0x2,%eax
  100d6c:	05 00 00 11 00       	add    $0x110000,%eax
  100d71:	8b 00                	mov    (%eax),%eax
  100d73:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100d77:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d7b:	c7 04 24 69 3a 10 00 	movl   $0x103a69,(%esp)
  100d82:	e8 06 f5 ff ff       	call   10028d <cprintf>
    for (i = 0; i < NCOMMANDS; i ++) {
  100d87:	ff 45 f4             	incl   -0xc(%ebp)
  100d8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d8d:	83 f8 02             	cmp    $0x2,%eax
  100d90:	76 bb                	jbe    100d4d <mon_help+0x13>
    }
    return 0;
  100d92:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d97:	c9                   	leave  
  100d98:	c3                   	ret    

00100d99 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100d99:	f3 0f 1e fb          	endbr32 
  100d9d:	55                   	push   %ebp
  100d9e:	89 e5                	mov    %esp,%ebp
  100da0:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100da3:	e8 a8 fb ff ff       	call   100950 <print_kerninfo>
    return 0;
  100da8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100dad:	c9                   	leave  
  100dae:	c3                   	ret    

00100daf <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100daf:	f3 0f 1e fb          	endbr32 
  100db3:	55                   	push   %ebp
  100db4:	89 e5                	mov    %esp,%ebp
  100db6:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100db9:	e8 e4 fc ff ff       	call   100aa2 <print_stackframe>
    return 0;
  100dbe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100dc3:	c9                   	leave  
  100dc4:	c3                   	ret    

00100dc5 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100dc5:	f3 0f 1e fb          	endbr32 
  100dc9:	55                   	push   %ebp
  100dca:	89 e5                	mov    %esp,%ebp
  100dcc:	83 ec 28             	sub    $0x28,%esp
  100dcf:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100dd5:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dd9:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100ddd:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100de1:	ee                   	out    %al,(%dx)
}
  100de2:	90                   	nop
  100de3:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100de9:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ded:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100df1:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100df5:	ee                   	out    %al,(%dx)
}
  100df6:	90                   	nop
  100df7:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100dfd:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e01:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100e05:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100e09:	ee                   	out    %al,(%dx)
}
  100e0a:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100e0b:	c7 05 08 19 11 00 00 	movl   $0x0,0x111908
  100e12:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100e15:	c7 04 24 72 3a 10 00 	movl   $0x103a72,(%esp)
  100e1c:	e8 6c f4 ff ff       	call   10028d <cprintf>
    pic_enable(IRQ_TIMER);
  100e21:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100e28:	e8 31 09 00 00       	call   10175e <pic_enable>
}
  100e2d:	90                   	nop
  100e2e:	c9                   	leave  
  100e2f:	c3                   	ret    

00100e30 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e30:	f3 0f 1e fb          	endbr32 
  100e34:	55                   	push   %ebp
  100e35:	89 e5                	mov    %esp,%ebp
  100e37:	83 ec 10             	sub    $0x10,%esp
  100e3a:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e40:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e44:	89 c2                	mov    %eax,%edx
  100e46:	ec                   	in     (%dx),%al
  100e47:	88 45 f1             	mov    %al,-0xf(%ebp)
  100e4a:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e50:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e54:	89 c2                	mov    %eax,%edx
  100e56:	ec                   	in     (%dx),%al
  100e57:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e5a:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e60:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e64:	89 c2                	mov    %eax,%edx
  100e66:	ec                   	in     (%dx),%al
  100e67:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e6a:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100e70:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e74:	89 c2                	mov    %eax,%edx
  100e76:	ec                   	in     (%dx),%al
  100e77:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e7a:	90                   	nop
  100e7b:	c9                   	leave  
  100e7c:	c3                   	ret    

00100e7d <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100e7d:	f3 0f 1e fb          	endbr32 
  100e81:	55                   	push   %ebp
  100e82:	89 e5                	mov    %esp,%ebp
  100e84:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100e87:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100e8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e91:	0f b7 00             	movzwl (%eax),%eax
  100e94:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100e98:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e9b:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100ea0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ea3:	0f b7 00             	movzwl (%eax),%eax
  100ea6:	0f b7 c0             	movzwl %ax,%eax
  100ea9:	3d 5a a5 00 00       	cmp    $0xa55a,%eax
  100eae:	74 12                	je     100ec2 <cga_init+0x45>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100eb0:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100eb7:	66 c7 05 66 0e 11 00 	movw   $0x3b4,0x110e66
  100ebe:	b4 03 
  100ec0:	eb 13                	jmp    100ed5 <cga_init+0x58>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100ec2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ec5:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100ec9:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100ecc:	66 c7 05 66 0e 11 00 	movw   $0x3d4,0x110e66
  100ed3:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100ed5:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  100edc:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100ee0:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ee4:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100ee8:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100eec:	ee                   	out    %al,(%dx)
}
  100eed:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100eee:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  100ef5:	40                   	inc    %eax
  100ef6:	0f b7 c0             	movzwl %ax,%eax
  100ef9:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100efd:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100f01:	89 c2                	mov    %eax,%edx
  100f03:	ec                   	in     (%dx),%al
  100f04:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100f07:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f0b:	0f b6 c0             	movzbl %al,%eax
  100f0e:	c1 e0 08             	shl    $0x8,%eax
  100f11:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100f14:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  100f1b:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100f1f:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f23:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f27:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f2b:	ee                   	out    %al,(%dx)
}
  100f2c:	90                   	nop
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100f2d:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  100f34:	40                   	inc    %eax
  100f35:	0f b7 c0             	movzwl %ax,%eax
  100f38:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f3c:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100f40:	89 c2                	mov    %eax,%edx
  100f42:	ec                   	in     (%dx),%al
  100f43:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100f46:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f4a:	0f b6 c0             	movzbl %al,%eax
  100f4d:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100f50:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f53:	a3 60 0e 11 00       	mov    %eax,0x110e60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100f58:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f5b:	0f b7 c0             	movzwl %ax,%eax
  100f5e:	66 a3 64 0e 11 00    	mov    %ax,0x110e64
}
  100f64:	90                   	nop
  100f65:	c9                   	leave  
  100f66:	c3                   	ret    

00100f67 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f67:	f3 0f 1e fb          	endbr32 
  100f6b:	55                   	push   %ebp
  100f6c:	89 e5                	mov    %esp,%ebp
  100f6e:	83 ec 48             	sub    $0x48,%esp
  100f71:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100f77:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f7b:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100f7f:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100f83:	ee                   	out    %al,(%dx)
}
  100f84:	90                   	nop
  100f85:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100f8b:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f8f:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100f93:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100f97:	ee                   	out    %al,(%dx)
}
  100f98:	90                   	nop
  100f99:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100f9f:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fa3:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100fa7:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100fab:	ee                   	out    %al,(%dx)
}
  100fac:	90                   	nop
  100fad:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100fb3:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fb7:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100fbb:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100fbf:	ee                   	out    %al,(%dx)
}
  100fc0:	90                   	nop
  100fc1:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100fc7:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fcb:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100fcf:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100fd3:	ee                   	out    %al,(%dx)
}
  100fd4:	90                   	nop
  100fd5:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100fdb:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fdf:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100fe3:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100fe7:	ee                   	out    %al,(%dx)
}
  100fe8:	90                   	nop
  100fe9:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100fef:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ff3:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100ff7:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100ffb:	ee                   	out    %al,(%dx)
}
  100ffc:	90                   	nop
  100ffd:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101003:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  101007:	89 c2                	mov    %eax,%edx
  101009:	ec                   	in     (%dx),%al
  10100a:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  10100d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  101011:	3c ff                	cmp    $0xff,%al
  101013:	0f 95 c0             	setne  %al
  101016:	0f b6 c0             	movzbl %al,%eax
  101019:	a3 68 0e 11 00       	mov    %eax,0x110e68
  10101e:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101024:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  101028:	89 c2                	mov    %eax,%edx
  10102a:	ec                   	in     (%dx),%al
  10102b:	88 45 f1             	mov    %al,-0xf(%ebp)
  10102e:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101034:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101038:	89 c2                	mov    %eax,%edx
  10103a:	ec                   	in     (%dx),%al
  10103b:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  10103e:	a1 68 0e 11 00       	mov    0x110e68,%eax
  101043:	85 c0                	test   %eax,%eax
  101045:	74 0c                	je     101053 <serial_init+0xec>
        pic_enable(IRQ_COM1);
  101047:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  10104e:	e8 0b 07 00 00       	call   10175e <pic_enable>
    }
}
  101053:	90                   	nop
  101054:	c9                   	leave  
  101055:	c3                   	ret    

00101056 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  101056:	f3 0f 1e fb          	endbr32 
  10105a:	55                   	push   %ebp
  10105b:	89 e5                	mov    %esp,%ebp
  10105d:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101060:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101067:	eb 08                	jmp    101071 <lpt_putc_sub+0x1b>
        delay();
  101069:	e8 c2 fd ff ff       	call   100e30 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  10106e:	ff 45 fc             	incl   -0x4(%ebp)
  101071:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  101077:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10107b:	89 c2                	mov    %eax,%edx
  10107d:	ec                   	in     (%dx),%al
  10107e:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101081:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101085:	84 c0                	test   %al,%al
  101087:	78 09                	js     101092 <lpt_putc_sub+0x3c>
  101089:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101090:	7e d7                	jle    101069 <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
  101092:	8b 45 08             	mov    0x8(%ebp),%eax
  101095:	0f b6 c0             	movzbl %al,%eax
  101098:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  10109e:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010a1:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010a5:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010a9:	ee                   	out    %al,(%dx)
}
  1010aa:	90                   	nop
  1010ab:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  1010b1:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010b5:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010b9:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1010bd:	ee                   	out    %al,(%dx)
}
  1010be:	90                   	nop
  1010bf:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  1010c5:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010c9:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1010cd:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1010d1:	ee                   	out    %al,(%dx)
}
  1010d2:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1010d3:	90                   	nop
  1010d4:	c9                   	leave  
  1010d5:	c3                   	ret    

001010d6 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1010d6:	f3 0f 1e fb          	endbr32 
  1010da:	55                   	push   %ebp
  1010db:	89 e5                	mov    %esp,%ebp
  1010dd:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1010e0:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1010e4:	74 0d                	je     1010f3 <lpt_putc+0x1d>
        lpt_putc_sub(c);
  1010e6:	8b 45 08             	mov    0x8(%ebp),%eax
  1010e9:	89 04 24             	mov    %eax,(%esp)
  1010ec:	e8 65 ff ff ff       	call   101056 <lpt_putc_sub>
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  1010f1:	eb 24                	jmp    101117 <lpt_putc+0x41>
        lpt_putc_sub('\b');
  1010f3:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010fa:	e8 57 ff ff ff       	call   101056 <lpt_putc_sub>
        lpt_putc_sub(' ');
  1010ff:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101106:	e8 4b ff ff ff       	call   101056 <lpt_putc_sub>
        lpt_putc_sub('\b');
  10110b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101112:	e8 3f ff ff ff       	call   101056 <lpt_putc_sub>
}
  101117:	90                   	nop
  101118:	c9                   	leave  
  101119:	c3                   	ret    

0010111a <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  10111a:	f3 0f 1e fb          	endbr32 
  10111e:	55                   	push   %ebp
  10111f:	89 e5                	mov    %esp,%ebp
  101121:	53                   	push   %ebx
  101122:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  101125:	8b 45 08             	mov    0x8(%ebp),%eax
  101128:	25 00 ff ff ff       	and    $0xffffff00,%eax
  10112d:	85 c0                	test   %eax,%eax
  10112f:	75 07                	jne    101138 <cga_putc+0x1e>
        c |= 0x0700;
  101131:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  101138:	8b 45 08             	mov    0x8(%ebp),%eax
  10113b:	0f b6 c0             	movzbl %al,%eax
  10113e:	83 f8 0d             	cmp    $0xd,%eax
  101141:	74 72                	je     1011b5 <cga_putc+0x9b>
  101143:	83 f8 0d             	cmp    $0xd,%eax
  101146:	0f 8f a3 00 00 00    	jg     1011ef <cga_putc+0xd5>
  10114c:	83 f8 08             	cmp    $0x8,%eax
  10114f:	74 0a                	je     10115b <cga_putc+0x41>
  101151:	83 f8 0a             	cmp    $0xa,%eax
  101154:	74 4c                	je     1011a2 <cga_putc+0x88>
  101156:	e9 94 00 00 00       	jmp    1011ef <cga_putc+0xd5>
    case '\b':
        if (crt_pos > 0) {
  10115b:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  101162:	85 c0                	test   %eax,%eax
  101164:	0f 84 af 00 00 00    	je     101219 <cga_putc+0xff>
            crt_pos --;
  10116a:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  101171:	48                   	dec    %eax
  101172:	0f b7 c0             	movzwl %ax,%eax
  101175:	66 a3 64 0e 11 00    	mov    %ax,0x110e64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  10117b:	8b 45 08             	mov    0x8(%ebp),%eax
  10117e:	98                   	cwtl   
  10117f:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101184:	98                   	cwtl   
  101185:	83 c8 20             	or     $0x20,%eax
  101188:	98                   	cwtl   
  101189:	8b 15 60 0e 11 00    	mov    0x110e60,%edx
  10118f:	0f b7 0d 64 0e 11 00 	movzwl 0x110e64,%ecx
  101196:	01 c9                	add    %ecx,%ecx
  101198:	01 ca                	add    %ecx,%edx
  10119a:	0f b7 c0             	movzwl %ax,%eax
  10119d:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  1011a0:	eb 77                	jmp    101219 <cga_putc+0xff>
    case '\n':
        crt_pos += CRT_COLS;
  1011a2:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  1011a9:	83 c0 50             	add    $0x50,%eax
  1011ac:	0f b7 c0             	movzwl %ax,%eax
  1011af:	66 a3 64 0e 11 00    	mov    %ax,0x110e64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  1011b5:	0f b7 1d 64 0e 11 00 	movzwl 0x110e64,%ebx
  1011bc:	0f b7 0d 64 0e 11 00 	movzwl 0x110e64,%ecx
  1011c3:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  1011c8:	89 c8                	mov    %ecx,%eax
  1011ca:	f7 e2                	mul    %edx
  1011cc:	c1 ea 06             	shr    $0x6,%edx
  1011cf:	89 d0                	mov    %edx,%eax
  1011d1:	c1 e0 02             	shl    $0x2,%eax
  1011d4:	01 d0                	add    %edx,%eax
  1011d6:	c1 e0 04             	shl    $0x4,%eax
  1011d9:	29 c1                	sub    %eax,%ecx
  1011db:	89 c8                	mov    %ecx,%eax
  1011dd:	0f b7 c0             	movzwl %ax,%eax
  1011e0:	29 c3                	sub    %eax,%ebx
  1011e2:	89 d8                	mov    %ebx,%eax
  1011e4:	0f b7 c0             	movzwl %ax,%eax
  1011e7:	66 a3 64 0e 11 00    	mov    %ax,0x110e64
        break;
  1011ed:	eb 2b                	jmp    10121a <cga_putc+0x100>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1011ef:	8b 0d 60 0e 11 00    	mov    0x110e60,%ecx
  1011f5:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  1011fc:	8d 50 01             	lea    0x1(%eax),%edx
  1011ff:	0f b7 d2             	movzwl %dx,%edx
  101202:	66 89 15 64 0e 11 00 	mov    %dx,0x110e64
  101209:	01 c0                	add    %eax,%eax
  10120b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  10120e:	8b 45 08             	mov    0x8(%ebp),%eax
  101211:	0f b7 c0             	movzwl %ax,%eax
  101214:	66 89 02             	mov    %ax,(%edx)
        break;
  101217:	eb 01                	jmp    10121a <cga_putc+0x100>
        break;
  101219:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  10121a:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  101221:	3d cf 07 00 00       	cmp    $0x7cf,%eax
  101226:	76 5d                	jbe    101285 <cga_putc+0x16b>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101228:	a1 60 0e 11 00       	mov    0x110e60,%eax
  10122d:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  101233:	a1 60 0e 11 00       	mov    0x110e60,%eax
  101238:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  10123f:	00 
  101240:	89 54 24 04          	mov    %edx,0x4(%esp)
  101244:	89 04 24             	mov    %eax,(%esp)
  101247:	e8 1e 1d 00 00       	call   102f6a <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  10124c:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  101253:	eb 14                	jmp    101269 <cga_putc+0x14f>
            crt_buf[i] = 0x0700 | ' ';
  101255:	a1 60 0e 11 00       	mov    0x110e60,%eax
  10125a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10125d:	01 d2                	add    %edx,%edx
  10125f:	01 d0                	add    %edx,%eax
  101261:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101266:	ff 45 f4             	incl   -0xc(%ebp)
  101269:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  101270:	7e e3                	jle    101255 <cga_putc+0x13b>
        }
        crt_pos -= CRT_COLS;
  101272:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  101279:	83 e8 50             	sub    $0x50,%eax
  10127c:	0f b7 c0             	movzwl %ax,%eax
  10127f:	66 a3 64 0e 11 00    	mov    %ax,0x110e64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101285:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  10128c:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  101290:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101294:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101298:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10129c:	ee                   	out    %al,(%dx)
}
  10129d:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  10129e:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  1012a5:	c1 e8 08             	shr    $0x8,%eax
  1012a8:	0f b7 c0             	movzwl %ax,%eax
  1012ab:	0f b6 c0             	movzbl %al,%eax
  1012ae:	0f b7 15 66 0e 11 00 	movzwl 0x110e66,%edx
  1012b5:	42                   	inc    %edx
  1012b6:	0f b7 d2             	movzwl %dx,%edx
  1012b9:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  1012bd:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012c0:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1012c4:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012c8:	ee                   	out    %al,(%dx)
}
  1012c9:	90                   	nop
    outb(addr_6845, 15);
  1012ca:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  1012d1:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1012d5:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012d9:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1012dd:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012e1:	ee                   	out    %al,(%dx)
}
  1012e2:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  1012e3:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  1012ea:	0f b6 c0             	movzbl %al,%eax
  1012ed:	0f b7 15 66 0e 11 00 	movzwl 0x110e66,%edx
  1012f4:	42                   	inc    %edx
  1012f5:	0f b7 d2             	movzwl %dx,%edx
  1012f8:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  1012fc:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012ff:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101303:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101307:	ee                   	out    %al,(%dx)
}
  101308:	90                   	nop
}
  101309:	90                   	nop
  10130a:	83 c4 34             	add    $0x34,%esp
  10130d:	5b                   	pop    %ebx
  10130e:	5d                   	pop    %ebp
  10130f:	c3                   	ret    

00101310 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  101310:	f3 0f 1e fb          	endbr32 
  101314:	55                   	push   %ebp
  101315:	89 e5                	mov    %esp,%ebp
  101317:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10131a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101321:	eb 08                	jmp    10132b <serial_putc_sub+0x1b>
        delay();
  101323:	e8 08 fb ff ff       	call   100e30 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101328:	ff 45 fc             	incl   -0x4(%ebp)
  10132b:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101331:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101335:	89 c2                	mov    %eax,%edx
  101337:	ec                   	in     (%dx),%al
  101338:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10133b:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10133f:	0f b6 c0             	movzbl %al,%eax
  101342:	83 e0 20             	and    $0x20,%eax
  101345:	85 c0                	test   %eax,%eax
  101347:	75 09                	jne    101352 <serial_putc_sub+0x42>
  101349:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101350:	7e d1                	jle    101323 <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
  101352:	8b 45 08             	mov    0x8(%ebp),%eax
  101355:	0f b6 c0             	movzbl %al,%eax
  101358:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  10135e:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101361:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101365:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101369:	ee                   	out    %al,(%dx)
}
  10136a:	90                   	nop
}
  10136b:	90                   	nop
  10136c:	c9                   	leave  
  10136d:	c3                   	ret    

0010136e <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  10136e:	f3 0f 1e fb          	endbr32 
  101372:	55                   	push   %ebp
  101373:	89 e5                	mov    %esp,%ebp
  101375:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101378:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10137c:	74 0d                	je     10138b <serial_putc+0x1d>
        serial_putc_sub(c);
  10137e:	8b 45 08             	mov    0x8(%ebp),%eax
  101381:	89 04 24             	mov    %eax,(%esp)
  101384:	e8 87 ff ff ff       	call   101310 <serial_putc_sub>
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  101389:	eb 24                	jmp    1013af <serial_putc+0x41>
        serial_putc_sub('\b');
  10138b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101392:	e8 79 ff ff ff       	call   101310 <serial_putc_sub>
        serial_putc_sub(' ');
  101397:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10139e:	e8 6d ff ff ff       	call   101310 <serial_putc_sub>
        serial_putc_sub('\b');
  1013a3:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1013aa:	e8 61 ff ff ff       	call   101310 <serial_putc_sub>
}
  1013af:	90                   	nop
  1013b0:	c9                   	leave  
  1013b1:	c3                   	ret    

001013b2 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  1013b2:	f3 0f 1e fb          	endbr32 
  1013b6:	55                   	push   %ebp
  1013b7:	89 e5                	mov    %esp,%ebp
  1013b9:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  1013bc:	eb 33                	jmp    1013f1 <cons_intr+0x3f>
        if (c != 0) {
  1013be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1013c2:	74 2d                	je     1013f1 <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
  1013c4:	a1 84 10 11 00       	mov    0x111084,%eax
  1013c9:	8d 50 01             	lea    0x1(%eax),%edx
  1013cc:	89 15 84 10 11 00    	mov    %edx,0x111084
  1013d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013d5:	88 90 80 0e 11 00    	mov    %dl,0x110e80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1013db:	a1 84 10 11 00       	mov    0x111084,%eax
  1013e0:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013e5:	75 0a                	jne    1013f1 <cons_intr+0x3f>
                cons.wpos = 0;
  1013e7:	c7 05 84 10 11 00 00 	movl   $0x0,0x111084
  1013ee:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  1013f4:	ff d0                	call   *%eax
  1013f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1013f9:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1013fd:	75 bf                	jne    1013be <cons_intr+0xc>
            }
        }
    }
}
  1013ff:	90                   	nop
  101400:	90                   	nop
  101401:	c9                   	leave  
  101402:	c3                   	ret    

00101403 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  101403:	f3 0f 1e fb          	endbr32 
  101407:	55                   	push   %ebp
  101408:	89 e5                	mov    %esp,%ebp
  10140a:	83 ec 10             	sub    $0x10,%esp
  10140d:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101413:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101417:	89 c2                	mov    %eax,%edx
  101419:	ec                   	in     (%dx),%al
  10141a:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10141d:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101421:	0f b6 c0             	movzbl %al,%eax
  101424:	83 e0 01             	and    $0x1,%eax
  101427:	85 c0                	test   %eax,%eax
  101429:	75 07                	jne    101432 <serial_proc_data+0x2f>
        return -1;
  10142b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101430:	eb 2a                	jmp    10145c <serial_proc_data+0x59>
  101432:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101438:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10143c:	89 c2                	mov    %eax,%edx
  10143e:	ec                   	in     (%dx),%al
  10143f:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  101442:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  101446:	0f b6 c0             	movzbl %al,%eax
  101449:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  10144c:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101450:	75 07                	jne    101459 <serial_proc_data+0x56>
        c = '\b';
  101452:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101459:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10145c:	c9                   	leave  
  10145d:	c3                   	ret    

0010145e <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  10145e:	f3 0f 1e fb          	endbr32 
  101462:	55                   	push   %ebp
  101463:	89 e5                	mov    %esp,%ebp
  101465:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  101468:	a1 68 0e 11 00       	mov    0x110e68,%eax
  10146d:	85 c0                	test   %eax,%eax
  10146f:	74 0c                	je     10147d <serial_intr+0x1f>
        cons_intr(serial_proc_data);
  101471:	c7 04 24 03 14 10 00 	movl   $0x101403,(%esp)
  101478:	e8 35 ff ff ff       	call   1013b2 <cons_intr>
    }
}
  10147d:	90                   	nop
  10147e:	c9                   	leave  
  10147f:	c3                   	ret    

00101480 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  101480:	f3 0f 1e fb          	endbr32 
  101484:	55                   	push   %ebp
  101485:	89 e5                	mov    %esp,%ebp
  101487:	83 ec 38             	sub    $0x38,%esp
  10148a:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101490:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101493:	89 c2                	mov    %eax,%edx
  101495:	ec                   	in     (%dx),%al
  101496:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101499:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  10149d:	0f b6 c0             	movzbl %al,%eax
  1014a0:	83 e0 01             	and    $0x1,%eax
  1014a3:	85 c0                	test   %eax,%eax
  1014a5:	75 0a                	jne    1014b1 <kbd_proc_data+0x31>
        return -1;
  1014a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1014ac:	e9 56 01 00 00       	jmp    101607 <kbd_proc_data+0x187>
  1014b1:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1014b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1014ba:	89 c2                	mov    %eax,%edx
  1014bc:	ec                   	in     (%dx),%al
  1014bd:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1014c0:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1014c4:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1014c7:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1014cb:	75 17                	jne    1014e4 <kbd_proc_data+0x64>
        // E0 escape character
        shift |= E0ESC;
  1014cd:	a1 88 10 11 00       	mov    0x111088,%eax
  1014d2:	83 c8 40             	or     $0x40,%eax
  1014d5:	a3 88 10 11 00       	mov    %eax,0x111088
        return 0;
  1014da:	b8 00 00 00 00       	mov    $0x0,%eax
  1014df:	e9 23 01 00 00       	jmp    101607 <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  1014e4:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014e8:	84 c0                	test   %al,%al
  1014ea:	79 45                	jns    101531 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014ec:	a1 88 10 11 00       	mov    0x111088,%eax
  1014f1:	83 e0 40             	and    $0x40,%eax
  1014f4:	85 c0                	test   %eax,%eax
  1014f6:	75 08                	jne    101500 <kbd_proc_data+0x80>
  1014f8:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014fc:	24 7f                	and    $0x7f,%al
  1014fe:	eb 04                	jmp    101504 <kbd_proc_data+0x84>
  101500:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101504:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101507:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10150b:	0f b6 80 40 00 11 00 	movzbl 0x110040(%eax),%eax
  101512:	0c 40                	or     $0x40,%al
  101514:	0f b6 c0             	movzbl %al,%eax
  101517:	f7 d0                	not    %eax
  101519:	89 c2                	mov    %eax,%edx
  10151b:	a1 88 10 11 00       	mov    0x111088,%eax
  101520:	21 d0                	and    %edx,%eax
  101522:	a3 88 10 11 00       	mov    %eax,0x111088
        return 0;
  101527:	b8 00 00 00 00       	mov    $0x0,%eax
  10152c:	e9 d6 00 00 00       	jmp    101607 <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  101531:	a1 88 10 11 00       	mov    0x111088,%eax
  101536:	83 e0 40             	and    $0x40,%eax
  101539:	85 c0                	test   %eax,%eax
  10153b:	74 11                	je     10154e <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10153d:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101541:	a1 88 10 11 00       	mov    0x111088,%eax
  101546:	83 e0 bf             	and    $0xffffffbf,%eax
  101549:	a3 88 10 11 00       	mov    %eax,0x111088
    }

    shift |= shiftcode[data];
  10154e:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101552:	0f b6 80 40 00 11 00 	movzbl 0x110040(%eax),%eax
  101559:	0f b6 d0             	movzbl %al,%edx
  10155c:	a1 88 10 11 00       	mov    0x111088,%eax
  101561:	09 d0                	or     %edx,%eax
  101563:	a3 88 10 11 00       	mov    %eax,0x111088
    shift ^= togglecode[data];
  101568:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10156c:	0f b6 80 40 01 11 00 	movzbl 0x110140(%eax),%eax
  101573:	0f b6 d0             	movzbl %al,%edx
  101576:	a1 88 10 11 00       	mov    0x111088,%eax
  10157b:	31 d0                	xor    %edx,%eax
  10157d:	a3 88 10 11 00       	mov    %eax,0x111088

    c = charcode[shift & (CTL | SHIFT)][data];
  101582:	a1 88 10 11 00       	mov    0x111088,%eax
  101587:	83 e0 03             	and    $0x3,%eax
  10158a:	8b 14 85 40 05 11 00 	mov    0x110540(,%eax,4),%edx
  101591:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101595:	01 d0                	add    %edx,%eax
  101597:	0f b6 00             	movzbl (%eax),%eax
  10159a:	0f b6 c0             	movzbl %al,%eax
  10159d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1015a0:	a1 88 10 11 00       	mov    0x111088,%eax
  1015a5:	83 e0 08             	and    $0x8,%eax
  1015a8:	85 c0                	test   %eax,%eax
  1015aa:	74 22                	je     1015ce <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  1015ac:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1015b0:	7e 0c                	jle    1015be <kbd_proc_data+0x13e>
  1015b2:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1015b6:	7f 06                	jg     1015be <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  1015b8:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1015bc:	eb 10                	jmp    1015ce <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  1015be:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1015c2:	7e 0a                	jle    1015ce <kbd_proc_data+0x14e>
  1015c4:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1015c8:	7f 04                	jg     1015ce <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  1015ca:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1015ce:	a1 88 10 11 00       	mov    0x111088,%eax
  1015d3:	f7 d0                	not    %eax
  1015d5:	83 e0 06             	and    $0x6,%eax
  1015d8:	85 c0                	test   %eax,%eax
  1015da:	75 28                	jne    101604 <kbd_proc_data+0x184>
  1015dc:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015e3:	75 1f                	jne    101604 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  1015e5:	c7 04 24 8d 3a 10 00 	movl   $0x103a8d,(%esp)
  1015ec:	e8 9c ec ff ff       	call   10028d <cprintf>
  1015f1:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1015f7:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1015fb:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1015ff:	8b 55 e8             	mov    -0x18(%ebp),%edx
  101602:	ee                   	out    %al,(%dx)
}
  101603:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101604:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101607:	c9                   	leave  
  101608:	c3                   	ret    

00101609 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  101609:	f3 0f 1e fb          	endbr32 
  10160d:	55                   	push   %ebp
  10160e:	89 e5                	mov    %esp,%ebp
  101610:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  101613:	c7 04 24 80 14 10 00 	movl   $0x101480,(%esp)
  10161a:	e8 93 fd ff ff       	call   1013b2 <cons_intr>
}
  10161f:	90                   	nop
  101620:	c9                   	leave  
  101621:	c3                   	ret    

00101622 <kbd_init>:

static void
kbd_init(void) {
  101622:	f3 0f 1e fb          	endbr32 
  101626:	55                   	push   %ebp
  101627:	89 e5                	mov    %esp,%ebp
  101629:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  10162c:	e8 d8 ff ff ff       	call   101609 <kbd_intr>
    pic_enable(IRQ_KBD);
  101631:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  101638:	e8 21 01 00 00       	call   10175e <pic_enable>
}
  10163d:	90                   	nop
  10163e:	c9                   	leave  
  10163f:	c3                   	ret    

00101640 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101640:	f3 0f 1e fb          	endbr32 
  101644:	55                   	push   %ebp
  101645:	89 e5                	mov    %esp,%ebp
  101647:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  10164a:	e8 2e f8 ff ff       	call   100e7d <cga_init>
    serial_init();
  10164f:	e8 13 f9 ff ff       	call   100f67 <serial_init>
    kbd_init();
  101654:	e8 c9 ff ff ff       	call   101622 <kbd_init>
    if (!serial_exists) {
  101659:	a1 68 0e 11 00       	mov    0x110e68,%eax
  10165e:	85 c0                	test   %eax,%eax
  101660:	75 0c                	jne    10166e <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
  101662:	c7 04 24 99 3a 10 00 	movl   $0x103a99,(%esp)
  101669:	e8 1f ec ff ff       	call   10028d <cprintf>
    }
}
  10166e:	90                   	nop
  10166f:	c9                   	leave  
  101670:	c3                   	ret    

00101671 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101671:	f3 0f 1e fb          	endbr32 
  101675:	55                   	push   %ebp
  101676:	89 e5                	mov    %esp,%ebp
  101678:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  10167b:	8b 45 08             	mov    0x8(%ebp),%eax
  10167e:	89 04 24             	mov    %eax,(%esp)
  101681:	e8 50 fa ff ff       	call   1010d6 <lpt_putc>
    cga_putc(c);
  101686:	8b 45 08             	mov    0x8(%ebp),%eax
  101689:	89 04 24             	mov    %eax,(%esp)
  10168c:	e8 89 fa ff ff       	call   10111a <cga_putc>
    serial_putc(c);
  101691:	8b 45 08             	mov    0x8(%ebp),%eax
  101694:	89 04 24             	mov    %eax,(%esp)
  101697:	e8 d2 fc ff ff       	call   10136e <serial_putc>
}
  10169c:	90                   	nop
  10169d:	c9                   	leave  
  10169e:	c3                   	ret    

0010169f <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  10169f:	f3 0f 1e fb          	endbr32 
  1016a3:	55                   	push   %ebp
  1016a4:	89 e5                	mov    %esp,%ebp
  1016a6:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1016a9:	e8 b0 fd ff ff       	call   10145e <serial_intr>
    kbd_intr();
  1016ae:	e8 56 ff ff ff       	call   101609 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1016b3:	8b 15 80 10 11 00    	mov    0x111080,%edx
  1016b9:	a1 84 10 11 00       	mov    0x111084,%eax
  1016be:	39 c2                	cmp    %eax,%edx
  1016c0:	74 36                	je     1016f8 <cons_getc+0x59>
        c = cons.buf[cons.rpos ++];
  1016c2:	a1 80 10 11 00       	mov    0x111080,%eax
  1016c7:	8d 50 01             	lea    0x1(%eax),%edx
  1016ca:	89 15 80 10 11 00    	mov    %edx,0x111080
  1016d0:	0f b6 80 80 0e 11 00 	movzbl 0x110e80(%eax),%eax
  1016d7:	0f b6 c0             	movzbl %al,%eax
  1016da:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  1016dd:	a1 80 10 11 00       	mov    0x111080,%eax
  1016e2:	3d 00 02 00 00       	cmp    $0x200,%eax
  1016e7:	75 0a                	jne    1016f3 <cons_getc+0x54>
            cons.rpos = 0;
  1016e9:	c7 05 80 10 11 00 00 	movl   $0x0,0x111080
  1016f0:	00 00 00 
        }
        return c;
  1016f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1016f6:	eb 05                	jmp    1016fd <cons_getc+0x5e>
    }
    return 0;
  1016f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1016fd:	c9                   	leave  
  1016fe:	c3                   	ret    

001016ff <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  1016ff:	f3 0f 1e fb          	endbr32 
  101703:	55                   	push   %ebp
  101704:	89 e5                	mov    %esp,%ebp
  101706:	83 ec 14             	sub    $0x14,%esp
  101709:	8b 45 08             	mov    0x8(%ebp),%eax
  10170c:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  101710:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101713:	66 a3 50 05 11 00    	mov    %ax,0x110550
    if (did_init) {
  101719:	a1 8c 10 11 00       	mov    0x11108c,%eax
  10171e:	85 c0                	test   %eax,%eax
  101720:	74 39                	je     10175b <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
  101722:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101725:	0f b6 c0             	movzbl %al,%eax
  101728:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  10172e:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101731:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101735:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101739:	ee                   	out    %al,(%dx)
}
  10173a:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  10173b:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10173f:	c1 e8 08             	shr    $0x8,%eax
  101742:	0f b7 c0             	movzwl %ax,%eax
  101745:	0f b6 c0             	movzbl %al,%eax
  101748:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  10174e:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101751:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101755:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101759:	ee                   	out    %al,(%dx)
}
  10175a:	90                   	nop
    }
}
  10175b:	90                   	nop
  10175c:	c9                   	leave  
  10175d:	c3                   	ret    

0010175e <pic_enable>:

void
pic_enable(unsigned int irq) {
  10175e:	f3 0f 1e fb          	endbr32 
  101762:	55                   	push   %ebp
  101763:	89 e5                	mov    %esp,%ebp
  101765:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  101768:	8b 45 08             	mov    0x8(%ebp),%eax
  10176b:	ba 01 00 00 00       	mov    $0x1,%edx
  101770:	88 c1                	mov    %al,%cl
  101772:	d3 e2                	shl    %cl,%edx
  101774:	89 d0                	mov    %edx,%eax
  101776:	98                   	cwtl   
  101777:	f7 d0                	not    %eax
  101779:	0f bf d0             	movswl %ax,%edx
  10177c:	0f b7 05 50 05 11 00 	movzwl 0x110550,%eax
  101783:	98                   	cwtl   
  101784:	21 d0                	and    %edx,%eax
  101786:	98                   	cwtl   
  101787:	0f b7 c0             	movzwl %ax,%eax
  10178a:	89 04 24             	mov    %eax,(%esp)
  10178d:	e8 6d ff ff ff       	call   1016ff <pic_setmask>
}
  101792:	90                   	nop
  101793:	c9                   	leave  
  101794:	c3                   	ret    

00101795 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  101795:	f3 0f 1e fb          	endbr32 
  101799:	55                   	push   %ebp
  10179a:	89 e5                	mov    %esp,%ebp
  10179c:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  10179f:	c7 05 8c 10 11 00 01 	movl   $0x1,0x11108c
  1017a6:	00 00 00 
  1017a9:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  1017af:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017b3:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017b7:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017bb:	ee                   	out    %al,(%dx)
}
  1017bc:	90                   	nop
  1017bd:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  1017c3:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017c7:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017cb:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017cf:	ee                   	out    %al,(%dx)
}
  1017d0:	90                   	nop
  1017d1:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017d7:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017db:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017df:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017e3:	ee                   	out    %al,(%dx)
}
  1017e4:	90                   	nop
  1017e5:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  1017eb:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017ef:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017f3:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1017f7:	ee                   	out    %al,(%dx)
}
  1017f8:	90                   	nop
  1017f9:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  1017ff:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101803:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101807:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  10180b:	ee                   	out    %al,(%dx)
}
  10180c:	90                   	nop
  10180d:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  101813:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101817:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  10181b:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  10181f:	ee                   	out    %al,(%dx)
}
  101820:	90                   	nop
  101821:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101827:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10182b:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  10182f:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101833:	ee                   	out    %al,(%dx)
}
  101834:	90                   	nop
  101835:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  10183b:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10183f:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101843:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101847:	ee                   	out    %al,(%dx)
}
  101848:	90                   	nop
  101849:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  10184f:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101853:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101857:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10185b:	ee                   	out    %al,(%dx)
}
  10185c:	90                   	nop
  10185d:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101863:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101867:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10186b:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10186f:	ee                   	out    %al,(%dx)
}
  101870:	90                   	nop
  101871:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101877:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10187b:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10187f:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101883:	ee                   	out    %al,(%dx)
}
  101884:	90                   	nop
  101885:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  10188b:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10188f:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101893:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101897:	ee                   	out    %al,(%dx)
}
  101898:	90                   	nop
  101899:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  10189f:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018a3:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1018a7:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1018ab:	ee                   	out    %al,(%dx)
}
  1018ac:	90                   	nop
  1018ad:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  1018b3:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018b7:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1018bb:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1018bf:	ee                   	out    %al,(%dx)
}
  1018c0:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1018c1:	0f b7 05 50 05 11 00 	movzwl 0x110550,%eax
  1018c8:	3d ff ff 00 00       	cmp    $0xffff,%eax
  1018cd:	74 0f                	je     1018de <pic_init+0x149>
        pic_setmask(irq_mask);
  1018cf:	0f b7 05 50 05 11 00 	movzwl 0x110550,%eax
  1018d6:	89 04 24             	mov    %eax,(%esp)
  1018d9:	e8 21 fe ff ff       	call   1016ff <pic_setmask>
    }
}
  1018de:	90                   	nop
  1018df:	c9                   	leave  
  1018e0:	c3                   	ret    

001018e1 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1018e1:	f3 0f 1e fb          	endbr32 
  1018e5:	55                   	push   %ebp
  1018e6:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1018e8:	fb                   	sti    
}
  1018e9:	90                   	nop
    sti();
}
  1018ea:	90                   	nop
  1018eb:	5d                   	pop    %ebp
  1018ec:	c3                   	ret    

001018ed <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1018ed:	f3 0f 1e fb          	endbr32 
  1018f1:	55                   	push   %ebp
  1018f2:	89 e5                	mov    %esp,%ebp

static inline void
cli(void) {
    asm volatile ("cli");
  1018f4:	fa                   	cli    
}
  1018f5:	90                   	nop
    cli();
}
  1018f6:	90                   	nop
  1018f7:	5d                   	pop    %ebp
  1018f8:	c3                   	ret    

001018f9 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  1018f9:	f3 0f 1e fb          	endbr32 
  1018fd:	55                   	push   %ebp
  1018fe:	89 e5                	mov    %esp,%ebp
  101900:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  101903:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  10190a:	00 
  10190b:	c7 04 24 c0 3a 10 00 	movl   $0x103ac0,(%esp)
  101912:	e8 76 e9 ff ff       	call   10028d <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  101917:	90                   	nop
  101918:	c9                   	leave  
  101919:	c3                   	ret    

0010191a <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  10191a:	f3 0f 1e fb          	endbr32 
  10191e:	55                   	push   %ebp
  10191f:	89 e5                	mov    %esp,%ebp
  101921:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    uint32_t i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101924:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10192b:	e9 c4 00 00 00       	jmp    1019f4 <idt_init+0xda>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  101930:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101933:	8b 04 85 e0 05 11 00 	mov    0x1105e0(,%eax,4),%eax
  10193a:	0f b7 d0             	movzwl %ax,%edx
  10193d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101940:	66 89 14 c5 a0 10 11 	mov    %dx,0x1110a0(,%eax,8)
  101947:	00 
  101948:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10194b:	66 c7 04 c5 a2 10 11 	movw   $0x8,0x1110a2(,%eax,8)
  101952:	00 08 00 
  101955:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101958:	0f b6 14 c5 a4 10 11 	movzbl 0x1110a4(,%eax,8),%edx
  10195f:	00 
  101960:	80 e2 e0             	and    $0xe0,%dl
  101963:	88 14 c5 a4 10 11 00 	mov    %dl,0x1110a4(,%eax,8)
  10196a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10196d:	0f b6 14 c5 a4 10 11 	movzbl 0x1110a4(,%eax,8),%edx
  101974:	00 
  101975:	80 e2 1f             	and    $0x1f,%dl
  101978:	88 14 c5 a4 10 11 00 	mov    %dl,0x1110a4(,%eax,8)
  10197f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101982:	0f b6 14 c5 a5 10 11 	movzbl 0x1110a5(,%eax,8),%edx
  101989:	00 
  10198a:	80 e2 f0             	and    $0xf0,%dl
  10198d:	80 ca 0e             	or     $0xe,%dl
  101990:	88 14 c5 a5 10 11 00 	mov    %dl,0x1110a5(,%eax,8)
  101997:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10199a:	0f b6 14 c5 a5 10 11 	movzbl 0x1110a5(,%eax,8),%edx
  1019a1:	00 
  1019a2:	80 e2 ef             	and    $0xef,%dl
  1019a5:	88 14 c5 a5 10 11 00 	mov    %dl,0x1110a5(,%eax,8)
  1019ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019af:	0f b6 14 c5 a5 10 11 	movzbl 0x1110a5(,%eax,8),%edx
  1019b6:	00 
  1019b7:	80 e2 9f             	and    $0x9f,%dl
  1019ba:	88 14 c5 a5 10 11 00 	mov    %dl,0x1110a5(,%eax,8)
  1019c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019c4:	0f b6 14 c5 a5 10 11 	movzbl 0x1110a5(,%eax,8),%edx
  1019cb:	00 
  1019cc:	80 ca 80             	or     $0x80,%dl
  1019cf:	88 14 c5 a5 10 11 00 	mov    %dl,0x1110a5(,%eax,8)
  1019d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019d9:	8b 04 85 e0 05 11 00 	mov    0x1105e0(,%eax,4),%eax
  1019e0:	c1 e8 10             	shr    $0x10,%eax
  1019e3:	0f b7 d0             	movzwl %ax,%edx
  1019e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019e9:	66 89 14 c5 a6 10 11 	mov    %dx,0x1110a6(,%eax,8)
  1019f0:	00 
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  1019f1:	ff 45 fc             	incl   -0x4(%ebp)
  1019f4:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%ebp)
  1019fb:	0f 86 2f ff ff ff    	jbe    101930 <idt_init+0x16>
    }
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  101a01:	a1 c4 07 11 00       	mov    0x1107c4,%eax
  101a06:	0f b7 c0             	movzwl %ax,%eax
  101a09:	66 a3 68 14 11 00    	mov    %ax,0x111468
  101a0f:	66 c7 05 6a 14 11 00 	movw   $0x8,0x11146a
  101a16:	08 00 
  101a18:	0f b6 05 6c 14 11 00 	movzbl 0x11146c,%eax
  101a1f:	24 e0                	and    $0xe0,%al
  101a21:	a2 6c 14 11 00       	mov    %al,0x11146c
  101a26:	0f b6 05 6c 14 11 00 	movzbl 0x11146c,%eax
  101a2d:	24 1f                	and    $0x1f,%al
  101a2f:	a2 6c 14 11 00       	mov    %al,0x11146c
  101a34:	0f b6 05 6d 14 11 00 	movzbl 0x11146d,%eax
  101a3b:	24 f0                	and    $0xf0,%al
  101a3d:	0c 0e                	or     $0xe,%al
  101a3f:	a2 6d 14 11 00       	mov    %al,0x11146d
  101a44:	0f b6 05 6d 14 11 00 	movzbl 0x11146d,%eax
  101a4b:	24 ef                	and    $0xef,%al
  101a4d:	a2 6d 14 11 00       	mov    %al,0x11146d
  101a52:	0f b6 05 6d 14 11 00 	movzbl 0x11146d,%eax
  101a59:	0c 60                	or     $0x60,%al
  101a5b:	a2 6d 14 11 00       	mov    %al,0x11146d
  101a60:	0f b6 05 6d 14 11 00 	movzbl 0x11146d,%eax
  101a67:	0c 80                	or     $0x80,%al
  101a69:	a2 6d 14 11 00       	mov    %al,0x11146d
  101a6e:	a1 c4 07 11 00       	mov    0x1107c4,%eax
  101a73:	c1 e8 10             	shr    $0x10,%eax
  101a76:	0f b7 c0             	movzwl %ax,%eax
  101a79:	66 a3 6e 14 11 00    	mov    %ax,0x11146e
  101a7f:	c7 45 f8 60 05 11 00 	movl   $0x110560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101a86:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101a89:	0f 01 18             	lidtl  (%eax)
}
  101a8c:	90                   	nop
    lidt(&idt_pd);
}
  101a8d:	90                   	nop
  101a8e:	c9                   	leave  
  101a8f:	c3                   	ret    

00101a90 <trapname>:

static const char *
trapname(int trapno) {
  101a90:	f3 0f 1e fb          	endbr32 
  101a94:	55                   	push   %ebp
  101a95:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101a97:	8b 45 08             	mov    0x8(%ebp),%eax
  101a9a:	83 f8 13             	cmp    $0x13,%eax
  101a9d:	77 0c                	ja     101aab <trapname+0x1b>
        return excnames[trapno];
  101a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  101aa2:	8b 04 85 20 3e 10 00 	mov    0x103e20(,%eax,4),%eax
  101aa9:	eb 18                	jmp    101ac3 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101aab:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101aaf:	7e 0d                	jle    101abe <trapname+0x2e>
  101ab1:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101ab5:	7f 07                	jg     101abe <trapname+0x2e>
        return "Hardware Interrupt";
  101ab7:	b8 ca 3a 10 00       	mov    $0x103aca,%eax
  101abc:	eb 05                	jmp    101ac3 <trapname+0x33>
    }
    return "(unknown trap)";
  101abe:	b8 dd 3a 10 00       	mov    $0x103add,%eax
}
  101ac3:	5d                   	pop    %ebp
  101ac4:	c3                   	ret    

00101ac5 <trap_in_kernel>:
/* temporary trapframe or pointer to trapframe */
struct trapframe switchk2u, *switchu2k;

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101ac5:	f3 0f 1e fb          	endbr32 
  101ac9:	55                   	push   %ebp
  101aca:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101acc:	8b 45 08             	mov    0x8(%ebp),%eax
  101acf:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ad3:	83 f8 08             	cmp    $0x8,%eax
  101ad6:	0f 94 c0             	sete   %al
  101ad9:	0f b6 c0             	movzbl %al,%eax
}
  101adc:	5d                   	pop    %ebp
  101add:	c3                   	ret    

00101ade <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101ade:	f3 0f 1e fb          	endbr32 
  101ae2:	55                   	push   %ebp
  101ae3:	89 e5                	mov    %esp,%ebp
  101ae5:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  101aeb:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aef:	c7 04 24 1e 3b 10 00 	movl   $0x103b1e,(%esp)
  101af6:	e8 92 e7 ff ff       	call   10028d <cprintf>
    print_regs(&tf->tf_regs);
  101afb:	8b 45 08             	mov    0x8(%ebp),%eax
  101afe:	89 04 24             	mov    %eax,(%esp)
  101b01:	e8 8d 01 00 00       	call   101c93 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b06:	8b 45 08             	mov    0x8(%ebp),%eax
  101b09:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b0d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b11:	c7 04 24 2f 3b 10 00 	movl   $0x103b2f,(%esp)
  101b18:	e8 70 e7 ff ff       	call   10028d <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  101b20:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101b24:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b28:	c7 04 24 42 3b 10 00 	movl   $0x103b42,(%esp)
  101b2f:	e8 59 e7 ff ff       	call   10028d <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b34:	8b 45 08             	mov    0x8(%ebp),%eax
  101b37:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b3b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b3f:	c7 04 24 55 3b 10 00 	movl   $0x103b55,(%esp)
  101b46:	e8 42 e7 ff ff       	call   10028d <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  101b4e:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b52:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b56:	c7 04 24 68 3b 10 00 	movl   $0x103b68,(%esp)
  101b5d:	e8 2b e7 ff ff       	call   10028d <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101b62:	8b 45 08             	mov    0x8(%ebp),%eax
  101b65:	8b 40 30             	mov    0x30(%eax),%eax
  101b68:	89 04 24             	mov    %eax,(%esp)
  101b6b:	e8 20 ff ff ff       	call   101a90 <trapname>
  101b70:	8b 55 08             	mov    0x8(%ebp),%edx
  101b73:	8b 52 30             	mov    0x30(%edx),%edx
  101b76:	89 44 24 08          	mov    %eax,0x8(%esp)
  101b7a:	89 54 24 04          	mov    %edx,0x4(%esp)
  101b7e:	c7 04 24 7b 3b 10 00 	movl   $0x103b7b,(%esp)
  101b85:	e8 03 e7 ff ff       	call   10028d <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b8d:	8b 40 34             	mov    0x34(%eax),%eax
  101b90:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b94:	c7 04 24 8d 3b 10 00 	movl   $0x103b8d,(%esp)
  101b9b:	e8 ed e6 ff ff       	call   10028d <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  101ba3:	8b 40 38             	mov    0x38(%eax),%eax
  101ba6:	89 44 24 04          	mov    %eax,0x4(%esp)
  101baa:	c7 04 24 9c 3b 10 00 	movl   $0x103b9c,(%esp)
  101bb1:	e8 d7 e6 ff ff       	call   10028d <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb9:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101bbd:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bc1:	c7 04 24 ab 3b 10 00 	movl   $0x103bab,(%esp)
  101bc8:	e8 c0 e6 ff ff       	call   10028d <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  101bd0:	8b 40 40             	mov    0x40(%eax),%eax
  101bd3:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bd7:	c7 04 24 be 3b 10 00 	movl   $0x103bbe,(%esp)
  101bde:	e8 aa e6 ff ff       	call   10028d <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101be3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101bea:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101bf1:	eb 3d                	jmp    101c30 <print_trapframe+0x152>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  101bf6:	8b 50 40             	mov    0x40(%eax),%edx
  101bf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101bfc:	21 d0                	and    %edx,%eax
  101bfe:	85 c0                	test   %eax,%eax
  101c00:	74 28                	je     101c2a <print_trapframe+0x14c>
  101c02:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c05:	8b 04 85 80 05 11 00 	mov    0x110580(,%eax,4),%eax
  101c0c:	85 c0                	test   %eax,%eax
  101c0e:	74 1a                	je     101c2a <print_trapframe+0x14c>
            cprintf("%s,", IA32flags[i]);
  101c10:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c13:	8b 04 85 80 05 11 00 	mov    0x110580(,%eax,4),%eax
  101c1a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c1e:	c7 04 24 cd 3b 10 00 	movl   $0x103bcd,(%esp)
  101c25:	e8 63 e6 ff ff       	call   10028d <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c2a:	ff 45 f4             	incl   -0xc(%ebp)
  101c2d:	d1 65 f0             	shll   -0x10(%ebp)
  101c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c33:	83 f8 17             	cmp    $0x17,%eax
  101c36:	76 bb                	jbe    101bf3 <print_trapframe+0x115>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101c38:	8b 45 08             	mov    0x8(%ebp),%eax
  101c3b:	8b 40 40             	mov    0x40(%eax),%eax
  101c3e:	c1 e8 0c             	shr    $0xc,%eax
  101c41:	83 e0 03             	and    $0x3,%eax
  101c44:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c48:	c7 04 24 d1 3b 10 00 	movl   $0x103bd1,(%esp)
  101c4f:	e8 39 e6 ff ff       	call   10028d <cprintf>

    if (!trap_in_kernel(tf)) {
  101c54:	8b 45 08             	mov    0x8(%ebp),%eax
  101c57:	89 04 24             	mov    %eax,(%esp)
  101c5a:	e8 66 fe ff ff       	call   101ac5 <trap_in_kernel>
  101c5f:	85 c0                	test   %eax,%eax
  101c61:	75 2d                	jne    101c90 <print_trapframe+0x1b2>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101c63:	8b 45 08             	mov    0x8(%ebp),%eax
  101c66:	8b 40 44             	mov    0x44(%eax),%eax
  101c69:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c6d:	c7 04 24 da 3b 10 00 	movl   $0x103bda,(%esp)
  101c74:	e8 14 e6 ff ff       	call   10028d <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101c79:	8b 45 08             	mov    0x8(%ebp),%eax
  101c7c:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101c80:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c84:	c7 04 24 e9 3b 10 00 	movl   $0x103be9,(%esp)
  101c8b:	e8 fd e5 ff ff       	call   10028d <cprintf>
    }
}
  101c90:	90                   	nop
  101c91:	c9                   	leave  
  101c92:	c3                   	ret    

00101c93 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101c93:	f3 0f 1e fb          	endbr32 
  101c97:	55                   	push   %ebp
  101c98:	89 e5                	mov    %esp,%ebp
  101c9a:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  101ca0:	8b 00                	mov    (%eax),%eax
  101ca2:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ca6:	c7 04 24 fc 3b 10 00 	movl   $0x103bfc,(%esp)
  101cad:	e8 db e5 ff ff       	call   10028d <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  101cb5:	8b 40 04             	mov    0x4(%eax),%eax
  101cb8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cbc:	c7 04 24 0b 3c 10 00 	movl   $0x103c0b,(%esp)
  101cc3:	e8 c5 e5 ff ff       	call   10028d <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  101ccb:	8b 40 08             	mov    0x8(%eax),%eax
  101cce:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cd2:	c7 04 24 1a 3c 10 00 	movl   $0x103c1a,(%esp)
  101cd9:	e8 af e5 ff ff       	call   10028d <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101cde:	8b 45 08             	mov    0x8(%ebp),%eax
  101ce1:	8b 40 0c             	mov    0xc(%eax),%eax
  101ce4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ce8:	c7 04 24 29 3c 10 00 	movl   $0x103c29,(%esp)
  101cef:	e8 99 e5 ff ff       	call   10028d <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101cf4:	8b 45 08             	mov    0x8(%ebp),%eax
  101cf7:	8b 40 10             	mov    0x10(%eax),%eax
  101cfa:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cfe:	c7 04 24 38 3c 10 00 	movl   $0x103c38,(%esp)
  101d05:	e8 83 e5 ff ff       	call   10028d <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  101d0d:	8b 40 14             	mov    0x14(%eax),%eax
  101d10:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d14:	c7 04 24 47 3c 10 00 	movl   $0x103c47,(%esp)
  101d1b:	e8 6d e5 ff ff       	call   10028d <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d20:	8b 45 08             	mov    0x8(%ebp),%eax
  101d23:	8b 40 18             	mov    0x18(%eax),%eax
  101d26:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d2a:	c7 04 24 56 3c 10 00 	movl   $0x103c56,(%esp)
  101d31:	e8 57 e5 ff ff       	call   10028d <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d36:	8b 45 08             	mov    0x8(%ebp),%eax
  101d39:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d3c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d40:	c7 04 24 65 3c 10 00 	movl   $0x103c65,(%esp)
  101d47:	e8 41 e5 ff ff       	call   10028d <cprintf>
}
  101d4c:	90                   	nop
  101d4d:	c9                   	leave  
  101d4e:	c3                   	ret    

00101d4f <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d4f:	f3 0f 1e fb          	endbr32 
  101d53:	55                   	push   %ebp
  101d54:	89 e5                	mov    %esp,%ebp
  101d56:	57                   	push   %edi
  101d57:	56                   	push   %esi
  101d58:	53                   	push   %ebx
  101d59:	83 ec 2c             	sub    $0x2c,%esp
    char c;

    switch (tf->tf_trapno) {
  101d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  101d5f:	8b 40 30             	mov    0x30(%eax),%eax
  101d62:	83 f8 79             	cmp    $0x79,%eax
  101d65:	0f 84 c6 01 00 00    	je     101f31 <trap_dispatch+0x1e2>
  101d6b:	83 f8 79             	cmp    $0x79,%eax
  101d6e:	0f 87 3a 02 00 00    	ja     101fae <trap_dispatch+0x25f>
  101d74:	83 f8 78             	cmp    $0x78,%eax
  101d77:	0f 84 d0 00 00 00    	je     101e4d <trap_dispatch+0xfe>
  101d7d:	83 f8 78             	cmp    $0x78,%eax
  101d80:	0f 87 28 02 00 00    	ja     101fae <trap_dispatch+0x25f>
  101d86:	83 f8 2f             	cmp    $0x2f,%eax
  101d89:	0f 87 1f 02 00 00    	ja     101fae <trap_dispatch+0x25f>
  101d8f:	83 f8 2e             	cmp    $0x2e,%eax
  101d92:	0f 83 4b 02 00 00    	jae    101fe3 <trap_dispatch+0x294>
  101d98:	83 f8 24             	cmp    $0x24,%eax
  101d9b:	74 5e                	je     101dfb <trap_dispatch+0xac>
  101d9d:	83 f8 24             	cmp    $0x24,%eax
  101da0:	0f 87 08 02 00 00    	ja     101fae <trap_dispatch+0x25f>
  101da6:	83 f8 20             	cmp    $0x20,%eax
  101da9:	74 0a                	je     101db5 <trap_dispatch+0x66>
  101dab:	83 f8 21             	cmp    $0x21,%eax
  101dae:	74 74                	je     101e24 <trap_dispatch+0xd5>
  101db0:	e9 f9 01 00 00       	jmp    101fae <trap_dispatch+0x25f>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks++;
  101db5:	a1 08 19 11 00       	mov    0x111908,%eax
  101dba:	40                   	inc    %eax
  101dbb:	a3 08 19 11 00       	mov    %eax,0x111908
        if(ticks % TICK_NUM ==0)
  101dc0:	8b 0d 08 19 11 00    	mov    0x111908,%ecx
  101dc6:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101dcb:	89 c8                	mov    %ecx,%eax
  101dcd:	f7 e2                	mul    %edx
  101dcf:	c1 ea 05             	shr    $0x5,%edx
  101dd2:	89 d0                	mov    %edx,%eax
  101dd4:	c1 e0 02             	shl    $0x2,%eax
  101dd7:	01 d0                	add    %edx,%eax
  101dd9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  101de0:	01 d0                	add    %edx,%eax
  101de2:	c1 e0 02             	shl    $0x2,%eax
  101de5:	29 c1                	sub    %eax,%ecx
  101de7:	89 ca                	mov    %ecx,%edx
  101de9:	85 d2                	test   %edx,%edx
  101deb:	0f 85 f5 01 00 00    	jne    101fe6 <trap_dispatch+0x297>
            print_ticks();
  101df1:	e8 03 fb ff ff       	call   1018f9 <print_ticks>
        break;
  101df6:	e9 eb 01 00 00       	jmp    101fe6 <trap_dispatch+0x297>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101dfb:	e8 9f f8 ff ff       	call   10169f <cons_getc>
  101e00:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101e03:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101e07:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101e0b:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e0f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e13:	c7 04 24 74 3c 10 00 	movl   $0x103c74,(%esp)
  101e1a:	e8 6e e4 ff ff       	call   10028d <cprintf>
        break;
  101e1f:	e9 c9 01 00 00       	jmp    101fed <trap_dispatch+0x29e>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101e24:	e8 76 f8 ff ff       	call   10169f <cons_getc>
  101e29:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101e2c:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101e30:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101e34:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e38:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e3c:	c7 04 24 86 3c 10 00 	movl   $0x103c86,(%esp)
  101e43:	e8 45 e4 ff ff       	call   10028d <cprintf>
        break;
  101e48:	e9 a0 01 00 00       	jmp    101fed <trap_dispatch+0x29e>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) {
  101e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  101e50:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e54:	83 f8 1b             	cmp    $0x1b,%eax
  101e57:	0f 84 8c 01 00 00    	je     101fe9 <trap_dispatch+0x29a>
            switchk2u = *tf;
  101e5d:	8b 55 08             	mov    0x8(%ebp),%edx
  101e60:	b8 20 19 11 00       	mov    $0x111920,%eax
  101e65:	bb 4c 00 00 00       	mov    $0x4c,%ebx
  101e6a:	89 c1                	mov    %eax,%ecx
  101e6c:	83 e1 01             	and    $0x1,%ecx
  101e6f:	85 c9                	test   %ecx,%ecx
  101e71:	74 0c                	je     101e7f <trap_dispatch+0x130>
  101e73:	0f b6 0a             	movzbl (%edx),%ecx
  101e76:	88 08                	mov    %cl,(%eax)
  101e78:	8d 40 01             	lea    0x1(%eax),%eax
  101e7b:	8d 52 01             	lea    0x1(%edx),%edx
  101e7e:	4b                   	dec    %ebx
  101e7f:	89 c1                	mov    %eax,%ecx
  101e81:	83 e1 02             	and    $0x2,%ecx
  101e84:	85 c9                	test   %ecx,%ecx
  101e86:	74 0f                	je     101e97 <trap_dispatch+0x148>
  101e88:	0f b7 0a             	movzwl (%edx),%ecx
  101e8b:	66 89 08             	mov    %cx,(%eax)
  101e8e:	8d 40 02             	lea    0x2(%eax),%eax
  101e91:	8d 52 02             	lea    0x2(%edx),%edx
  101e94:	83 eb 02             	sub    $0x2,%ebx
  101e97:	89 df                	mov    %ebx,%edi
  101e99:	83 e7 fc             	and    $0xfffffffc,%edi
  101e9c:	b9 00 00 00 00       	mov    $0x0,%ecx
  101ea1:	8b 34 0a             	mov    (%edx,%ecx,1),%esi
  101ea4:	89 34 08             	mov    %esi,(%eax,%ecx,1)
  101ea7:	83 c1 04             	add    $0x4,%ecx
  101eaa:	39 f9                	cmp    %edi,%ecx
  101eac:	72 f3                	jb     101ea1 <trap_dispatch+0x152>
  101eae:	01 c8                	add    %ecx,%eax
  101eb0:	01 ca                	add    %ecx,%edx
  101eb2:	b9 00 00 00 00       	mov    $0x0,%ecx
  101eb7:	89 de                	mov    %ebx,%esi
  101eb9:	83 e6 02             	and    $0x2,%esi
  101ebc:	85 f6                	test   %esi,%esi
  101ebe:	74 0b                	je     101ecb <trap_dispatch+0x17c>
  101ec0:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
  101ec4:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
  101ec8:	83 c1 02             	add    $0x2,%ecx
  101ecb:	83 e3 01             	and    $0x1,%ebx
  101ece:	85 db                	test   %ebx,%ebx
  101ed0:	74 07                	je     101ed9 <trap_dispatch+0x18a>
  101ed2:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
  101ed6:	88 14 08             	mov    %dl,(%eax,%ecx,1)
            switchk2u.tf_cs = USER_CS;
  101ed9:	66 c7 05 5c 19 11 00 	movw   $0x1b,0x11195c
  101ee0:	1b 00 
            switchk2u.tf_ds = switchk2u.tf_es = switchk2u.tf_ss = USER_DS;
  101ee2:	66 c7 05 68 19 11 00 	movw   $0x23,0x111968
  101ee9:	23 00 
  101eeb:	0f b7 05 68 19 11 00 	movzwl 0x111968,%eax
  101ef2:	66 a3 48 19 11 00    	mov    %ax,0x111948
  101ef8:	0f b7 05 48 19 11 00 	movzwl 0x111948,%eax
  101eff:	66 a3 4c 19 11 00    	mov    %ax,0x11194c
            switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
  101f05:	8b 45 08             	mov    0x8(%ebp),%eax
  101f08:	83 c0 44             	add    $0x44,%eax
  101f0b:	a3 64 19 11 00       	mov    %eax,0x111964
            switchk2u.tf_eflags |= FL_IOPL_MASK;
  101f10:	a1 60 19 11 00       	mov    0x111960,%eax
  101f15:	0d 00 30 00 00       	or     $0x3000,%eax
  101f1a:	a3 60 19 11 00       	mov    %eax,0x111960
            *((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
  101f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  101f22:	83 e8 04             	sub    $0x4,%eax
  101f25:	ba 20 19 11 00       	mov    $0x111920,%edx
  101f2a:	89 10                	mov    %edx,(%eax)
        }
        break;
  101f2c:	e9 b8 00 00 00       	jmp    101fe9 <trap_dispatch+0x29a>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
  101f31:	8b 45 08             	mov    0x8(%ebp),%eax
  101f34:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f38:	83 f8 08             	cmp    $0x8,%eax
  101f3b:	0f 84 ab 00 00 00    	je     101fec <trap_dispatch+0x29d>
            tf->tf_cs = KERNEL_CS;
  101f41:	8b 45 08             	mov    0x8(%ebp),%eax
  101f44:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  101f4d:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101f53:	8b 45 08             	mov    0x8(%ebp),%eax
  101f56:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  101f5d:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101f61:	8b 45 08             	mov    0x8(%ebp),%eax
  101f64:	8b 40 40             	mov    0x40(%eax),%eax
  101f67:	25 ff cf ff ff       	and    $0xffffcfff,%eax
  101f6c:	89 c2                	mov    %eax,%edx
  101f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  101f71:	89 50 40             	mov    %edx,0x40(%eax)
            switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
  101f74:	8b 45 08             	mov    0x8(%ebp),%eax
  101f77:	8b 40 44             	mov    0x44(%eax),%eax
  101f7a:	83 e8 44             	sub    $0x44,%eax
  101f7d:	a3 6c 19 11 00       	mov    %eax,0x11196c
            memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
  101f82:	a1 6c 19 11 00       	mov    0x11196c,%eax
  101f87:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  101f8e:	00 
  101f8f:	8b 55 08             	mov    0x8(%ebp),%edx
  101f92:	89 54 24 04          	mov    %edx,0x4(%esp)
  101f96:	89 04 24             	mov    %eax,(%esp)
  101f99:	e8 cc 0f 00 00       	call   102f6a <memmove>
            *((uint32_t *)tf - 1) = (uint32_t)switchu2k;
  101f9e:	8b 15 6c 19 11 00    	mov    0x11196c,%edx
  101fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  101fa7:	83 e8 04             	sub    $0x4,%eax
  101faa:	89 10                	mov    %edx,(%eax)
        }
        break;
  101fac:	eb 3e                	jmp    101fec <trap_dispatch+0x29d>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101fae:	8b 45 08             	mov    0x8(%ebp),%eax
  101fb1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101fb5:	83 e0 03             	and    $0x3,%eax
  101fb8:	85 c0                	test   %eax,%eax
  101fba:	75 31                	jne    101fed <trap_dispatch+0x29e>
            print_trapframe(tf);
  101fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  101fbf:	89 04 24             	mov    %eax,(%esp)
  101fc2:	e8 17 fb ff ff       	call   101ade <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101fc7:	c7 44 24 08 95 3c 10 	movl   $0x103c95,0x8(%esp)
  101fce:	00 
  101fcf:	c7 44 24 04 cb 00 00 	movl   $0xcb,0x4(%esp)
  101fd6:	00 
  101fd7:	c7 04 24 b1 3c 10 00 	movl   $0x103cb1,(%esp)
  101fde:	e8 16 e4 ff ff       	call   1003f9 <__panic>
        break;
  101fe3:	90                   	nop
  101fe4:	eb 07                	jmp    101fed <trap_dispatch+0x29e>
        break;
  101fe6:	90                   	nop
  101fe7:	eb 04                	jmp    101fed <trap_dispatch+0x29e>
        break;
  101fe9:	90                   	nop
  101fea:	eb 01                	jmp    101fed <trap_dispatch+0x29e>
        break;
  101fec:	90                   	nop
        }
    }
}
  101fed:	90                   	nop
  101fee:	83 c4 2c             	add    $0x2c,%esp
  101ff1:	5b                   	pop    %ebx
  101ff2:	5e                   	pop    %esi
  101ff3:	5f                   	pop    %edi
  101ff4:	5d                   	pop    %ebp
  101ff5:	c3                   	ret    

00101ff6 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101ff6:	f3 0f 1e fb          	endbr32 
  101ffa:	55                   	push   %ebp
  101ffb:	89 e5                	mov    %esp,%ebp
  101ffd:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  102000:	8b 45 08             	mov    0x8(%ebp),%eax
  102003:	89 04 24             	mov    %eax,(%esp)
  102006:	e8 44 fd ff ff       	call   101d4f <trap_dispatch>
}
  10200b:	90                   	nop
  10200c:	c9                   	leave  
  10200d:	c3                   	ret    

0010200e <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  10200e:	6a 00                	push   $0x0
  pushl $0
  102010:	6a 00                	push   $0x0
  jmp __alltraps
  102012:	e9 69 0a 00 00       	jmp    102a80 <__alltraps>

00102017 <vector1>:
.globl vector1
vector1:
  pushl $0
  102017:	6a 00                	push   $0x0
  pushl $1
  102019:	6a 01                	push   $0x1
  jmp __alltraps
  10201b:	e9 60 0a 00 00       	jmp    102a80 <__alltraps>

00102020 <vector2>:
.globl vector2
vector2:
  pushl $0
  102020:	6a 00                	push   $0x0
  pushl $2
  102022:	6a 02                	push   $0x2
  jmp __alltraps
  102024:	e9 57 0a 00 00       	jmp    102a80 <__alltraps>

00102029 <vector3>:
.globl vector3
vector3:
  pushl $0
  102029:	6a 00                	push   $0x0
  pushl $3
  10202b:	6a 03                	push   $0x3
  jmp __alltraps
  10202d:	e9 4e 0a 00 00       	jmp    102a80 <__alltraps>

00102032 <vector4>:
.globl vector4
vector4:
  pushl $0
  102032:	6a 00                	push   $0x0
  pushl $4
  102034:	6a 04                	push   $0x4
  jmp __alltraps
  102036:	e9 45 0a 00 00       	jmp    102a80 <__alltraps>

0010203b <vector5>:
.globl vector5
vector5:
  pushl $0
  10203b:	6a 00                	push   $0x0
  pushl $5
  10203d:	6a 05                	push   $0x5
  jmp __alltraps
  10203f:	e9 3c 0a 00 00       	jmp    102a80 <__alltraps>

00102044 <vector6>:
.globl vector6
vector6:
  pushl $0
  102044:	6a 00                	push   $0x0
  pushl $6
  102046:	6a 06                	push   $0x6
  jmp __alltraps
  102048:	e9 33 0a 00 00       	jmp    102a80 <__alltraps>

0010204d <vector7>:
.globl vector7
vector7:
  pushl $0
  10204d:	6a 00                	push   $0x0
  pushl $7
  10204f:	6a 07                	push   $0x7
  jmp __alltraps
  102051:	e9 2a 0a 00 00       	jmp    102a80 <__alltraps>

00102056 <vector8>:
.globl vector8
vector8:
  pushl $8
  102056:	6a 08                	push   $0x8
  jmp __alltraps
  102058:	e9 23 0a 00 00       	jmp    102a80 <__alltraps>

0010205d <vector9>:
.globl vector9
vector9:
  pushl $0
  10205d:	6a 00                	push   $0x0
  pushl $9
  10205f:	6a 09                	push   $0x9
  jmp __alltraps
  102061:	e9 1a 0a 00 00       	jmp    102a80 <__alltraps>

00102066 <vector10>:
.globl vector10
vector10:
  pushl $10
  102066:	6a 0a                	push   $0xa
  jmp __alltraps
  102068:	e9 13 0a 00 00       	jmp    102a80 <__alltraps>

0010206d <vector11>:
.globl vector11
vector11:
  pushl $11
  10206d:	6a 0b                	push   $0xb
  jmp __alltraps
  10206f:	e9 0c 0a 00 00       	jmp    102a80 <__alltraps>

00102074 <vector12>:
.globl vector12
vector12:
  pushl $12
  102074:	6a 0c                	push   $0xc
  jmp __alltraps
  102076:	e9 05 0a 00 00       	jmp    102a80 <__alltraps>

0010207b <vector13>:
.globl vector13
vector13:
  pushl $13
  10207b:	6a 0d                	push   $0xd
  jmp __alltraps
  10207d:	e9 fe 09 00 00       	jmp    102a80 <__alltraps>

00102082 <vector14>:
.globl vector14
vector14:
  pushl $14
  102082:	6a 0e                	push   $0xe
  jmp __alltraps
  102084:	e9 f7 09 00 00       	jmp    102a80 <__alltraps>

00102089 <vector15>:
.globl vector15
vector15:
  pushl $0
  102089:	6a 00                	push   $0x0
  pushl $15
  10208b:	6a 0f                	push   $0xf
  jmp __alltraps
  10208d:	e9 ee 09 00 00       	jmp    102a80 <__alltraps>

00102092 <vector16>:
.globl vector16
vector16:
  pushl $0
  102092:	6a 00                	push   $0x0
  pushl $16
  102094:	6a 10                	push   $0x10
  jmp __alltraps
  102096:	e9 e5 09 00 00       	jmp    102a80 <__alltraps>

0010209b <vector17>:
.globl vector17
vector17:
  pushl $17
  10209b:	6a 11                	push   $0x11
  jmp __alltraps
  10209d:	e9 de 09 00 00       	jmp    102a80 <__alltraps>

001020a2 <vector18>:
.globl vector18
vector18:
  pushl $0
  1020a2:	6a 00                	push   $0x0
  pushl $18
  1020a4:	6a 12                	push   $0x12
  jmp __alltraps
  1020a6:	e9 d5 09 00 00       	jmp    102a80 <__alltraps>

001020ab <vector19>:
.globl vector19
vector19:
  pushl $0
  1020ab:	6a 00                	push   $0x0
  pushl $19
  1020ad:	6a 13                	push   $0x13
  jmp __alltraps
  1020af:	e9 cc 09 00 00       	jmp    102a80 <__alltraps>

001020b4 <vector20>:
.globl vector20
vector20:
  pushl $0
  1020b4:	6a 00                	push   $0x0
  pushl $20
  1020b6:	6a 14                	push   $0x14
  jmp __alltraps
  1020b8:	e9 c3 09 00 00       	jmp    102a80 <__alltraps>

001020bd <vector21>:
.globl vector21
vector21:
  pushl $0
  1020bd:	6a 00                	push   $0x0
  pushl $21
  1020bf:	6a 15                	push   $0x15
  jmp __alltraps
  1020c1:	e9 ba 09 00 00       	jmp    102a80 <__alltraps>

001020c6 <vector22>:
.globl vector22
vector22:
  pushl $0
  1020c6:	6a 00                	push   $0x0
  pushl $22
  1020c8:	6a 16                	push   $0x16
  jmp __alltraps
  1020ca:	e9 b1 09 00 00       	jmp    102a80 <__alltraps>

001020cf <vector23>:
.globl vector23
vector23:
  pushl $0
  1020cf:	6a 00                	push   $0x0
  pushl $23
  1020d1:	6a 17                	push   $0x17
  jmp __alltraps
  1020d3:	e9 a8 09 00 00       	jmp    102a80 <__alltraps>

001020d8 <vector24>:
.globl vector24
vector24:
  pushl $0
  1020d8:	6a 00                	push   $0x0
  pushl $24
  1020da:	6a 18                	push   $0x18
  jmp __alltraps
  1020dc:	e9 9f 09 00 00       	jmp    102a80 <__alltraps>

001020e1 <vector25>:
.globl vector25
vector25:
  pushl $0
  1020e1:	6a 00                	push   $0x0
  pushl $25
  1020e3:	6a 19                	push   $0x19
  jmp __alltraps
  1020e5:	e9 96 09 00 00       	jmp    102a80 <__alltraps>

001020ea <vector26>:
.globl vector26
vector26:
  pushl $0
  1020ea:	6a 00                	push   $0x0
  pushl $26
  1020ec:	6a 1a                	push   $0x1a
  jmp __alltraps
  1020ee:	e9 8d 09 00 00       	jmp    102a80 <__alltraps>

001020f3 <vector27>:
.globl vector27
vector27:
  pushl $0
  1020f3:	6a 00                	push   $0x0
  pushl $27
  1020f5:	6a 1b                	push   $0x1b
  jmp __alltraps
  1020f7:	e9 84 09 00 00       	jmp    102a80 <__alltraps>

001020fc <vector28>:
.globl vector28
vector28:
  pushl $0
  1020fc:	6a 00                	push   $0x0
  pushl $28
  1020fe:	6a 1c                	push   $0x1c
  jmp __alltraps
  102100:	e9 7b 09 00 00       	jmp    102a80 <__alltraps>

00102105 <vector29>:
.globl vector29
vector29:
  pushl $0
  102105:	6a 00                	push   $0x0
  pushl $29
  102107:	6a 1d                	push   $0x1d
  jmp __alltraps
  102109:	e9 72 09 00 00       	jmp    102a80 <__alltraps>

0010210e <vector30>:
.globl vector30
vector30:
  pushl $0
  10210e:	6a 00                	push   $0x0
  pushl $30
  102110:	6a 1e                	push   $0x1e
  jmp __alltraps
  102112:	e9 69 09 00 00       	jmp    102a80 <__alltraps>

00102117 <vector31>:
.globl vector31
vector31:
  pushl $0
  102117:	6a 00                	push   $0x0
  pushl $31
  102119:	6a 1f                	push   $0x1f
  jmp __alltraps
  10211b:	e9 60 09 00 00       	jmp    102a80 <__alltraps>

00102120 <vector32>:
.globl vector32
vector32:
  pushl $0
  102120:	6a 00                	push   $0x0
  pushl $32
  102122:	6a 20                	push   $0x20
  jmp __alltraps
  102124:	e9 57 09 00 00       	jmp    102a80 <__alltraps>

00102129 <vector33>:
.globl vector33
vector33:
  pushl $0
  102129:	6a 00                	push   $0x0
  pushl $33
  10212b:	6a 21                	push   $0x21
  jmp __alltraps
  10212d:	e9 4e 09 00 00       	jmp    102a80 <__alltraps>

00102132 <vector34>:
.globl vector34
vector34:
  pushl $0
  102132:	6a 00                	push   $0x0
  pushl $34
  102134:	6a 22                	push   $0x22
  jmp __alltraps
  102136:	e9 45 09 00 00       	jmp    102a80 <__alltraps>

0010213b <vector35>:
.globl vector35
vector35:
  pushl $0
  10213b:	6a 00                	push   $0x0
  pushl $35
  10213d:	6a 23                	push   $0x23
  jmp __alltraps
  10213f:	e9 3c 09 00 00       	jmp    102a80 <__alltraps>

00102144 <vector36>:
.globl vector36
vector36:
  pushl $0
  102144:	6a 00                	push   $0x0
  pushl $36
  102146:	6a 24                	push   $0x24
  jmp __alltraps
  102148:	e9 33 09 00 00       	jmp    102a80 <__alltraps>

0010214d <vector37>:
.globl vector37
vector37:
  pushl $0
  10214d:	6a 00                	push   $0x0
  pushl $37
  10214f:	6a 25                	push   $0x25
  jmp __alltraps
  102151:	e9 2a 09 00 00       	jmp    102a80 <__alltraps>

00102156 <vector38>:
.globl vector38
vector38:
  pushl $0
  102156:	6a 00                	push   $0x0
  pushl $38
  102158:	6a 26                	push   $0x26
  jmp __alltraps
  10215a:	e9 21 09 00 00       	jmp    102a80 <__alltraps>

0010215f <vector39>:
.globl vector39
vector39:
  pushl $0
  10215f:	6a 00                	push   $0x0
  pushl $39
  102161:	6a 27                	push   $0x27
  jmp __alltraps
  102163:	e9 18 09 00 00       	jmp    102a80 <__alltraps>

00102168 <vector40>:
.globl vector40
vector40:
  pushl $0
  102168:	6a 00                	push   $0x0
  pushl $40
  10216a:	6a 28                	push   $0x28
  jmp __alltraps
  10216c:	e9 0f 09 00 00       	jmp    102a80 <__alltraps>

00102171 <vector41>:
.globl vector41
vector41:
  pushl $0
  102171:	6a 00                	push   $0x0
  pushl $41
  102173:	6a 29                	push   $0x29
  jmp __alltraps
  102175:	e9 06 09 00 00       	jmp    102a80 <__alltraps>

0010217a <vector42>:
.globl vector42
vector42:
  pushl $0
  10217a:	6a 00                	push   $0x0
  pushl $42
  10217c:	6a 2a                	push   $0x2a
  jmp __alltraps
  10217e:	e9 fd 08 00 00       	jmp    102a80 <__alltraps>

00102183 <vector43>:
.globl vector43
vector43:
  pushl $0
  102183:	6a 00                	push   $0x0
  pushl $43
  102185:	6a 2b                	push   $0x2b
  jmp __alltraps
  102187:	e9 f4 08 00 00       	jmp    102a80 <__alltraps>

0010218c <vector44>:
.globl vector44
vector44:
  pushl $0
  10218c:	6a 00                	push   $0x0
  pushl $44
  10218e:	6a 2c                	push   $0x2c
  jmp __alltraps
  102190:	e9 eb 08 00 00       	jmp    102a80 <__alltraps>

00102195 <vector45>:
.globl vector45
vector45:
  pushl $0
  102195:	6a 00                	push   $0x0
  pushl $45
  102197:	6a 2d                	push   $0x2d
  jmp __alltraps
  102199:	e9 e2 08 00 00       	jmp    102a80 <__alltraps>

0010219e <vector46>:
.globl vector46
vector46:
  pushl $0
  10219e:	6a 00                	push   $0x0
  pushl $46
  1021a0:	6a 2e                	push   $0x2e
  jmp __alltraps
  1021a2:	e9 d9 08 00 00       	jmp    102a80 <__alltraps>

001021a7 <vector47>:
.globl vector47
vector47:
  pushl $0
  1021a7:	6a 00                	push   $0x0
  pushl $47
  1021a9:	6a 2f                	push   $0x2f
  jmp __alltraps
  1021ab:	e9 d0 08 00 00       	jmp    102a80 <__alltraps>

001021b0 <vector48>:
.globl vector48
vector48:
  pushl $0
  1021b0:	6a 00                	push   $0x0
  pushl $48
  1021b2:	6a 30                	push   $0x30
  jmp __alltraps
  1021b4:	e9 c7 08 00 00       	jmp    102a80 <__alltraps>

001021b9 <vector49>:
.globl vector49
vector49:
  pushl $0
  1021b9:	6a 00                	push   $0x0
  pushl $49
  1021bb:	6a 31                	push   $0x31
  jmp __alltraps
  1021bd:	e9 be 08 00 00       	jmp    102a80 <__alltraps>

001021c2 <vector50>:
.globl vector50
vector50:
  pushl $0
  1021c2:	6a 00                	push   $0x0
  pushl $50
  1021c4:	6a 32                	push   $0x32
  jmp __alltraps
  1021c6:	e9 b5 08 00 00       	jmp    102a80 <__alltraps>

001021cb <vector51>:
.globl vector51
vector51:
  pushl $0
  1021cb:	6a 00                	push   $0x0
  pushl $51
  1021cd:	6a 33                	push   $0x33
  jmp __alltraps
  1021cf:	e9 ac 08 00 00       	jmp    102a80 <__alltraps>

001021d4 <vector52>:
.globl vector52
vector52:
  pushl $0
  1021d4:	6a 00                	push   $0x0
  pushl $52
  1021d6:	6a 34                	push   $0x34
  jmp __alltraps
  1021d8:	e9 a3 08 00 00       	jmp    102a80 <__alltraps>

001021dd <vector53>:
.globl vector53
vector53:
  pushl $0
  1021dd:	6a 00                	push   $0x0
  pushl $53
  1021df:	6a 35                	push   $0x35
  jmp __alltraps
  1021e1:	e9 9a 08 00 00       	jmp    102a80 <__alltraps>

001021e6 <vector54>:
.globl vector54
vector54:
  pushl $0
  1021e6:	6a 00                	push   $0x0
  pushl $54
  1021e8:	6a 36                	push   $0x36
  jmp __alltraps
  1021ea:	e9 91 08 00 00       	jmp    102a80 <__alltraps>

001021ef <vector55>:
.globl vector55
vector55:
  pushl $0
  1021ef:	6a 00                	push   $0x0
  pushl $55
  1021f1:	6a 37                	push   $0x37
  jmp __alltraps
  1021f3:	e9 88 08 00 00       	jmp    102a80 <__alltraps>

001021f8 <vector56>:
.globl vector56
vector56:
  pushl $0
  1021f8:	6a 00                	push   $0x0
  pushl $56
  1021fa:	6a 38                	push   $0x38
  jmp __alltraps
  1021fc:	e9 7f 08 00 00       	jmp    102a80 <__alltraps>

00102201 <vector57>:
.globl vector57
vector57:
  pushl $0
  102201:	6a 00                	push   $0x0
  pushl $57
  102203:	6a 39                	push   $0x39
  jmp __alltraps
  102205:	e9 76 08 00 00       	jmp    102a80 <__alltraps>

0010220a <vector58>:
.globl vector58
vector58:
  pushl $0
  10220a:	6a 00                	push   $0x0
  pushl $58
  10220c:	6a 3a                	push   $0x3a
  jmp __alltraps
  10220e:	e9 6d 08 00 00       	jmp    102a80 <__alltraps>

00102213 <vector59>:
.globl vector59
vector59:
  pushl $0
  102213:	6a 00                	push   $0x0
  pushl $59
  102215:	6a 3b                	push   $0x3b
  jmp __alltraps
  102217:	e9 64 08 00 00       	jmp    102a80 <__alltraps>

0010221c <vector60>:
.globl vector60
vector60:
  pushl $0
  10221c:	6a 00                	push   $0x0
  pushl $60
  10221e:	6a 3c                	push   $0x3c
  jmp __alltraps
  102220:	e9 5b 08 00 00       	jmp    102a80 <__alltraps>

00102225 <vector61>:
.globl vector61
vector61:
  pushl $0
  102225:	6a 00                	push   $0x0
  pushl $61
  102227:	6a 3d                	push   $0x3d
  jmp __alltraps
  102229:	e9 52 08 00 00       	jmp    102a80 <__alltraps>

0010222e <vector62>:
.globl vector62
vector62:
  pushl $0
  10222e:	6a 00                	push   $0x0
  pushl $62
  102230:	6a 3e                	push   $0x3e
  jmp __alltraps
  102232:	e9 49 08 00 00       	jmp    102a80 <__alltraps>

00102237 <vector63>:
.globl vector63
vector63:
  pushl $0
  102237:	6a 00                	push   $0x0
  pushl $63
  102239:	6a 3f                	push   $0x3f
  jmp __alltraps
  10223b:	e9 40 08 00 00       	jmp    102a80 <__alltraps>

00102240 <vector64>:
.globl vector64
vector64:
  pushl $0
  102240:	6a 00                	push   $0x0
  pushl $64
  102242:	6a 40                	push   $0x40
  jmp __alltraps
  102244:	e9 37 08 00 00       	jmp    102a80 <__alltraps>

00102249 <vector65>:
.globl vector65
vector65:
  pushl $0
  102249:	6a 00                	push   $0x0
  pushl $65
  10224b:	6a 41                	push   $0x41
  jmp __alltraps
  10224d:	e9 2e 08 00 00       	jmp    102a80 <__alltraps>

00102252 <vector66>:
.globl vector66
vector66:
  pushl $0
  102252:	6a 00                	push   $0x0
  pushl $66
  102254:	6a 42                	push   $0x42
  jmp __alltraps
  102256:	e9 25 08 00 00       	jmp    102a80 <__alltraps>

0010225b <vector67>:
.globl vector67
vector67:
  pushl $0
  10225b:	6a 00                	push   $0x0
  pushl $67
  10225d:	6a 43                	push   $0x43
  jmp __alltraps
  10225f:	e9 1c 08 00 00       	jmp    102a80 <__alltraps>

00102264 <vector68>:
.globl vector68
vector68:
  pushl $0
  102264:	6a 00                	push   $0x0
  pushl $68
  102266:	6a 44                	push   $0x44
  jmp __alltraps
  102268:	e9 13 08 00 00       	jmp    102a80 <__alltraps>

0010226d <vector69>:
.globl vector69
vector69:
  pushl $0
  10226d:	6a 00                	push   $0x0
  pushl $69
  10226f:	6a 45                	push   $0x45
  jmp __alltraps
  102271:	e9 0a 08 00 00       	jmp    102a80 <__alltraps>

00102276 <vector70>:
.globl vector70
vector70:
  pushl $0
  102276:	6a 00                	push   $0x0
  pushl $70
  102278:	6a 46                	push   $0x46
  jmp __alltraps
  10227a:	e9 01 08 00 00       	jmp    102a80 <__alltraps>

0010227f <vector71>:
.globl vector71
vector71:
  pushl $0
  10227f:	6a 00                	push   $0x0
  pushl $71
  102281:	6a 47                	push   $0x47
  jmp __alltraps
  102283:	e9 f8 07 00 00       	jmp    102a80 <__alltraps>

00102288 <vector72>:
.globl vector72
vector72:
  pushl $0
  102288:	6a 00                	push   $0x0
  pushl $72
  10228a:	6a 48                	push   $0x48
  jmp __alltraps
  10228c:	e9 ef 07 00 00       	jmp    102a80 <__alltraps>

00102291 <vector73>:
.globl vector73
vector73:
  pushl $0
  102291:	6a 00                	push   $0x0
  pushl $73
  102293:	6a 49                	push   $0x49
  jmp __alltraps
  102295:	e9 e6 07 00 00       	jmp    102a80 <__alltraps>

0010229a <vector74>:
.globl vector74
vector74:
  pushl $0
  10229a:	6a 00                	push   $0x0
  pushl $74
  10229c:	6a 4a                	push   $0x4a
  jmp __alltraps
  10229e:	e9 dd 07 00 00       	jmp    102a80 <__alltraps>

001022a3 <vector75>:
.globl vector75
vector75:
  pushl $0
  1022a3:	6a 00                	push   $0x0
  pushl $75
  1022a5:	6a 4b                	push   $0x4b
  jmp __alltraps
  1022a7:	e9 d4 07 00 00       	jmp    102a80 <__alltraps>

001022ac <vector76>:
.globl vector76
vector76:
  pushl $0
  1022ac:	6a 00                	push   $0x0
  pushl $76
  1022ae:	6a 4c                	push   $0x4c
  jmp __alltraps
  1022b0:	e9 cb 07 00 00       	jmp    102a80 <__alltraps>

001022b5 <vector77>:
.globl vector77
vector77:
  pushl $0
  1022b5:	6a 00                	push   $0x0
  pushl $77
  1022b7:	6a 4d                	push   $0x4d
  jmp __alltraps
  1022b9:	e9 c2 07 00 00       	jmp    102a80 <__alltraps>

001022be <vector78>:
.globl vector78
vector78:
  pushl $0
  1022be:	6a 00                	push   $0x0
  pushl $78
  1022c0:	6a 4e                	push   $0x4e
  jmp __alltraps
  1022c2:	e9 b9 07 00 00       	jmp    102a80 <__alltraps>

001022c7 <vector79>:
.globl vector79
vector79:
  pushl $0
  1022c7:	6a 00                	push   $0x0
  pushl $79
  1022c9:	6a 4f                	push   $0x4f
  jmp __alltraps
  1022cb:	e9 b0 07 00 00       	jmp    102a80 <__alltraps>

001022d0 <vector80>:
.globl vector80
vector80:
  pushl $0
  1022d0:	6a 00                	push   $0x0
  pushl $80
  1022d2:	6a 50                	push   $0x50
  jmp __alltraps
  1022d4:	e9 a7 07 00 00       	jmp    102a80 <__alltraps>

001022d9 <vector81>:
.globl vector81
vector81:
  pushl $0
  1022d9:	6a 00                	push   $0x0
  pushl $81
  1022db:	6a 51                	push   $0x51
  jmp __alltraps
  1022dd:	e9 9e 07 00 00       	jmp    102a80 <__alltraps>

001022e2 <vector82>:
.globl vector82
vector82:
  pushl $0
  1022e2:	6a 00                	push   $0x0
  pushl $82
  1022e4:	6a 52                	push   $0x52
  jmp __alltraps
  1022e6:	e9 95 07 00 00       	jmp    102a80 <__alltraps>

001022eb <vector83>:
.globl vector83
vector83:
  pushl $0
  1022eb:	6a 00                	push   $0x0
  pushl $83
  1022ed:	6a 53                	push   $0x53
  jmp __alltraps
  1022ef:	e9 8c 07 00 00       	jmp    102a80 <__alltraps>

001022f4 <vector84>:
.globl vector84
vector84:
  pushl $0
  1022f4:	6a 00                	push   $0x0
  pushl $84
  1022f6:	6a 54                	push   $0x54
  jmp __alltraps
  1022f8:	e9 83 07 00 00       	jmp    102a80 <__alltraps>

001022fd <vector85>:
.globl vector85
vector85:
  pushl $0
  1022fd:	6a 00                	push   $0x0
  pushl $85
  1022ff:	6a 55                	push   $0x55
  jmp __alltraps
  102301:	e9 7a 07 00 00       	jmp    102a80 <__alltraps>

00102306 <vector86>:
.globl vector86
vector86:
  pushl $0
  102306:	6a 00                	push   $0x0
  pushl $86
  102308:	6a 56                	push   $0x56
  jmp __alltraps
  10230a:	e9 71 07 00 00       	jmp    102a80 <__alltraps>

0010230f <vector87>:
.globl vector87
vector87:
  pushl $0
  10230f:	6a 00                	push   $0x0
  pushl $87
  102311:	6a 57                	push   $0x57
  jmp __alltraps
  102313:	e9 68 07 00 00       	jmp    102a80 <__alltraps>

00102318 <vector88>:
.globl vector88
vector88:
  pushl $0
  102318:	6a 00                	push   $0x0
  pushl $88
  10231a:	6a 58                	push   $0x58
  jmp __alltraps
  10231c:	e9 5f 07 00 00       	jmp    102a80 <__alltraps>

00102321 <vector89>:
.globl vector89
vector89:
  pushl $0
  102321:	6a 00                	push   $0x0
  pushl $89
  102323:	6a 59                	push   $0x59
  jmp __alltraps
  102325:	e9 56 07 00 00       	jmp    102a80 <__alltraps>

0010232a <vector90>:
.globl vector90
vector90:
  pushl $0
  10232a:	6a 00                	push   $0x0
  pushl $90
  10232c:	6a 5a                	push   $0x5a
  jmp __alltraps
  10232e:	e9 4d 07 00 00       	jmp    102a80 <__alltraps>

00102333 <vector91>:
.globl vector91
vector91:
  pushl $0
  102333:	6a 00                	push   $0x0
  pushl $91
  102335:	6a 5b                	push   $0x5b
  jmp __alltraps
  102337:	e9 44 07 00 00       	jmp    102a80 <__alltraps>

0010233c <vector92>:
.globl vector92
vector92:
  pushl $0
  10233c:	6a 00                	push   $0x0
  pushl $92
  10233e:	6a 5c                	push   $0x5c
  jmp __alltraps
  102340:	e9 3b 07 00 00       	jmp    102a80 <__alltraps>

00102345 <vector93>:
.globl vector93
vector93:
  pushl $0
  102345:	6a 00                	push   $0x0
  pushl $93
  102347:	6a 5d                	push   $0x5d
  jmp __alltraps
  102349:	e9 32 07 00 00       	jmp    102a80 <__alltraps>

0010234e <vector94>:
.globl vector94
vector94:
  pushl $0
  10234e:	6a 00                	push   $0x0
  pushl $94
  102350:	6a 5e                	push   $0x5e
  jmp __alltraps
  102352:	e9 29 07 00 00       	jmp    102a80 <__alltraps>

00102357 <vector95>:
.globl vector95
vector95:
  pushl $0
  102357:	6a 00                	push   $0x0
  pushl $95
  102359:	6a 5f                	push   $0x5f
  jmp __alltraps
  10235b:	e9 20 07 00 00       	jmp    102a80 <__alltraps>

00102360 <vector96>:
.globl vector96
vector96:
  pushl $0
  102360:	6a 00                	push   $0x0
  pushl $96
  102362:	6a 60                	push   $0x60
  jmp __alltraps
  102364:	e9 17 07 00 00       	jmp    102a80 <__alltraps>

00102369 <vector97>:
.globl vector97
vector97:
  pushl $0
  102369:	6a 00                	push   $0x0
  pushl $97
  10236b:	6a 61                	push   $0x61
  jmp __alltraps
  10236d:	e9 0e 07 00 00       	jmp    102a80 <__alltraps>

00102372 <vector98>:
.globl vector98
vector98:
  pushl $0
  102372:	6a 00                	push   $0x0
  pushl $98
  102374:	6a 62                	push   $0x62
  jmp __alltraps
  102376:	e9 05 07 00 00       	jmp    102a80 <__alltraps>

0010237b <vector99>:
.globl vector99
vector99:
  pushl $0
  10237b:	6a 00                	push   $0x0
  pushl $99
  10237d:	6a 63                	push   $0x63
  jmp __alltraps
  10237f:	e9 fc 06 00 00       	jmp    102a80 <__alltraps>

00102384 <vector100>:
.globl vector100
vector100:
  pushl $0
  102384:	6a 00                	push   $0x0
  pushl $100
  102386:	6a 64                	push   $0x64
  jmp __alltraps
  102388:	e9 f3 06 00 00       	jmp    102a80 <__alltraps>

0010238d <vector101>:
.globl vector101
vector101:
  pushl $0
  10238d:	6a 00                	push   $0x0
  pushl $101
  10238f:	6a 65                	push   $0x65
  jmp __alltraps
  102391:	e9 ea 06 00 00       	jmp    102a80 <__alltraps>

00102396 <vector102>:
.globl vector102
vector102:
  pushl $0
  102396:	6a 00                	push   $0x0
  pushl $102
  102398:	6a 66                	push   $0x66
  jmp __alltraps
  10239a:	e9 e1 06 00 00       	jmp    102a80 <__alltraps>

0010239f <vector103>:
.globl vector103
vector103:
  pushl $0
  10239f:	6a 00                	push   $0x0
  pushl $103
  1023a1:	6a 67                	push   $0x67
  jmp __alltraps
  1023a3:	e9 d8 06 00 00       	jmp    102a80 <__alltraps>

001023a8 <vector104>:
.globl vector104
vector104:
  pushl $0
  1023a8:	6a 00                	push   $0x0
  pushl $104
  1023aa:	6a 68                	push   $0x68
  jmp __alltraps
  1023ac:	e9 cf 06 00 00       	jmp    102a80 <__alltraps>

001023b1 <vector105>:
.globl vector105
vector105:
  pushl $0
  1023b1:	6a 00                	push   $0x0
  pushl $105
  1023b3:	6a 69                	push   $0x69
  jmp __alltraps
  1023b5:	e9 c6 06 00 00       	jmp    102a80 <__alltraps>

001023ba <vector106>:
.globl vector106
vector106:
  pushl $0
  1023ba:	6a 00                	push   $0x0
  pushl $106
  1023bc:	6a 6a                	push   $0x6a
  jmp __alltraps
  1023be:	e9 bd 06 00 00       	jmp    102a80 <__alltraps>

001023c3 <vector107>:
.globl vector107
vector107:
  pushl $0
  1023c3:	6a 00                	push   $0x0
  pushl $107
  1023c5:	6a 6b                	push   $0x6b
  jmp __alltraps
  1023c7:	e9 b4 06 00 00       	jmp    102a80 <__alltraps>

001023cc <vector108>:
.globl vector108
vector108:
  pushl $0
  1023cc:	6a 00                	push   $0x0
  pushl $108
  1023ce:	6a 6c                	push   $0x6c
  jmp __alltraps
  1023d0:	e9 ab 06 00 00       	jmp    102a80 <__alltraps>

001023d5 <vector109>:
.globl vector109
vector109:
  pushl $0
  1023d5:	6a 00                	push   $0x0
  pushl $109
  1023d7:	6a 6d                	push   $0x6d
  jmp __alltraps
  1023d9:	e9 a2 06 00 00       	jmp    102a80 <__alltraps>

001023de <vector110>:
.globl vector110
vector110:
  pushl $0
  1023de:	6a 00                	push   $0x0
  pushl $110
  1023e0:	6a 6e                	push   $0x6e
  jmp __alltraps
  1023e2:	e9 99 06 00 00       	jmp    102a80 <__alltraps>

001023e7 <vector111>:
.globl vector111
vector111:
  pushl $0
  1023e7:	6a 00                	push   $0x0
  pushl $111
  1023e9:	6a 6f                	push   $0x6f
  jmp __alltraps
  1023eb:	e9 90 06 00 00       	jmp    102a80 <__alltraps>

001023f0 <vector112>:
.globl vector112
vector112:
  pushl $0
  1023f0:	6a 00                	push   $0x0
  pushl $112
  1023f2:	6a 70                	push   $0x70
  jmp __alltraps
  1023f4:	e9 87 06 00 00       	jmp    102a80 <__alltraps>

001023f9 <vector113>:
.globl vector113
vector113:
  pushl $0
  1023f9:	6a 00                	push   $0x0
  pushl $113
  1023fb:	6a 71                	push   $0x71
  jmp __alltraps
  1023fd:	e9 7e 06 00 00       	jmp    102a80 <__alltraps>

00102402 <vector114>:
.globl vector114
vector114:
  pushl $0
  102402:	6a 00                	push   $0x0
  pushl $114
  102404:	6a 72                	push   $0x72
  jmp __alltraps
  102406:	e9 75 06 00 00       	jmp    102a80 <__alltraps>

0010240b <vector115>:
.globl vector115
vector115:
  pushl $0
  10240b:	6a 00                	push   $0x0
  pushl $115
  10240d:	6a 73                	push   $0x73
  jmp __alltraps
  10240f:	e9 6c 06 00 00       	jmp    102a80 <__alltraps>

00102414 <vector116>:
.globl vector116
vector116:
  pushl $0
  102414:	6a 00                	push   $0x0
  pushl $116
  102416:	6a 74                	push   $0x74
  jmp __alltraps
  102418:	e9 63 06 00 00       	jmp    102a80 <__alltraps>

0010241d <vector117>:
.globl vector117
vector117:
  pushl $0
  10241d:	6a 00                	push   $0x0
  pushl $117
  10241f:	6a 75                	push   $0x75
  jmp __alltraps
  102421:	e9 5a 06 00 00       	jmp    102a80 <__alltraps>

00102426 <vector118>:
.globl vector118
vector118:
  pushl $0
  102426:	6a 00                	push   $0x0
  pushl $118
  102428:	6a 76                	push   $0x76
  jmp __alltraps
  10242a:	e9 51 06 00 00       	jmp    102a80 <__alltraps>

0010242f <vector119>:
.globl vector119
vector119:
  pushl $0
  10242f:	6a 00                	push   $0x0
  pushl $119
  102431:	6a 77                	push   $0x77
  jmp __alltraps
  102433:	e9 48 06 00 00       	jmp    102a80 <__alltraps>

00102438 <vector120>:
.globl vector120
vector120:
  pushl $0
  102438:	6a 00                	push   $0x0
  pushl $120
  10243a:	6a 78                	push   $0x78
  jmp __alltraps
  10243c:	e9 3f 06 00 00       	jmp    102a80 <__alltraps>

00102441 <vector121>:
.globl vector121
vector121:
  pushl $0
  102441:	6a 00                	push   $0x0
  pushl $121
  102443:	6a 79                	push   $0x79
  jmp __alltraps
  102445:	e9 36 06 00 00       	jmp    102a80 <__alltraps>

0010244a <vector122>:
.globl vector122
vector122:
  pushl $0
  10244a:	6a 00                	push   $0x0
  pushl $122
  10244c:	6a 7a                	push   $0x7a
  jmp __alltraps
  10244e:	e9 2d 06 00 00       	jmp    102a80 <__alltraps>

00102453 <vector123>:
.globl vector123
vector123:
  pushl $0
  102453:	6a 00                	push   $0x0
  pushl $123
  102455:	6a 7b                	push   $0x7b
  jmp __alltraps
  102457:	e9 24 06 00 00       	jmp    102a80 <__alltraps>

0010245c <vector124>:
.globl vector124
vector124:
  pushl $0
  10245c:	6a 00                	push   $0x0
  pushl $124
  10245e:	6a 7c                	push   $0x7c
  jmp __alltraps
  102460:	e9 1b 06 00 00       	jmp    102a80 <__alltraps>

00102465 <vector125>:
.globl vector125
vector125:
  pushl $0
  102465:	6a 00                	push   $0x0
  pushl $125
  102467:	6a 7d                	push   $0x7d
  jmp __alltraps
  102469:	e9 12 06 00 00       	jmp    102a80 <__alltraps>

0010246e <vector126>:
.globl vector126
vector126:
  pushl $0
  10246e:	6a 00                	push   $0x0
  pushl $126
  102470:	6a 7e                	push   $0x7e
  jmp __alltraps
  102472:	e9 09 06 00 00       	jmp    102a80 <__alltraps>

00102477 <vector127>:
.globl vector127
vector127:
  pushl $0
  102477:	6a 00                	push   $0x0
  pushl $127
  102479:	6a 7f                	push   $0x7f
  jmp __alltraps
  10247b:	e9 00 06 00 00       	jmp    102a80 <__alltraps>

00102480 <vector128>:
.globl vector128
vector128:
  pushl $0
  102480:	6a 00                	push   $0x0
  pushl $128
  102482:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102487:	e9 f4 05 00 00       	jmp    102a80 <__alltraps>

0010248c <vector129>:
.globl vector129
vector129:
  pushl $0
  10248c:	6a 00                	push   $0x0
  pushl $129
  10248e:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102493:	e9 e8 05 00 00       	jmp    102a80 <__alltraps>

00102498 <vector130>:
.globl vector130
vector130:
  pushl $0
  102498:	6a 00                	push   $0x0
  pushl $130
  10249a:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  10249f:	e9 dc 05 00 00       	jmp    102a80 <__alltraps>

001024a4 <vector131>:
.globl vector131
vector131:
  pushl $0
  1024a4:	6a 00                	push   $0x0
  pushl $131
  1024a6:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  1024ab:	e9 d0 05 00 00       	jmp    102a80 <__alltraps>

001024b0 <vector132>:
.globl vector132
vector132:
  pushl $0
  1024b0:	6a 00                	push   $0x0
  pushl $132
  1024b2:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  1024b7:	e9 c4 05 00 00       	jmp    102a80 <__alltraps>

001024bc <vector133>:
.globl vector133
vector133:
  pushl $0
  1024bc:	6a 00                	push   $0x0
  pushl $133
  1024be:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  1024c3:	e9 b8 05 00 00       	jmp    102a80 <__alltraps>

001024c8 <vector134>:
.globl vector134
vector134:
  pushl $0
  1024c8:	6a 00                	push   $0x0
  pushl $134
  1024ca:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  1024cf:	e9 ac 05 00 00       	jmp    102a80 <__alltraps>

001024d4 <vector135>:
.globl vector135
vector135:
  pushl $0
  1024d4:	6a 00                	push   $0x0
  pushl $135
  1024d6:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  1024db:	e9 a0 05 00 00       	jmp    102a80 <__alltraps>

001024e0 <vector136>:
.globl vector136
vector136:
  pushl $0
  1024e0:	6a 00                	push   $0x0
  pushl $136
  1024e2:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  1024e7:	e9 94 05 00 00       	jmp    102a80 <__alltraps>

001024ec <vector137>:
.globl vector137
vector137:
  pushl $0
  1024ec:	6a 00                	push   $0x0
  pushl $137
  1024ee:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1024f3:	e9 88 05 00 00       	jmp    102a80 <__alltraps>

001024f8 <vector138>:
.globl vector138
vector138:
  pushl $0
  1024f8:	6a 00                	push   $0x0
  pushl $138
  1024fa:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1024ff:	e9 7c 05 00 00       	jmp    102a80 <__alltraps>

00102504 <vector139>:
.globl vector139
vector139:
  pushl $0
  102504:	6a 00                	push   $0x0
  pushl $139
  102506:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  10250b:	e9 70 05 00 00       	jmp    102a80 <__alltraps>

00102510 <vector140>:
.globl vector140
vector140:
  pushl $0
  102510:	6a 00                	push   $0x0
  pushl $140
  102512:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102517:	e9 64 05 00 00       	jmp    102a80 <__alltraps>

0010251c <vector141>:
.globl vector141
vector141:
  pushl $0
  10251c:	6a 00                	push   $0x0
  pushl $141
  10251e:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  102523:	e9 58 05 00 00       	jmp    102a80 <__alltraps>

00102528 <vector142>:
.globl vector142
vector142:
  pushl $0
  102528:	6a 00                	push   $0x0
  pushl $142
  10252a:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  10252f:	e9 4c 05 00 00       	jmp    102a80 <__alltraps>

00102534 <vector143>:
.globl vector143
vector143:
  pushl $0
  102534:	6a 00                	push   $0x0
  pushl $143
  102536:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  10253b:	e9 40 05 00 00       	jmp    102a80 <__alltraps>

00102540 <vector144>:
.globl vector144
vector144:
  pushl $0
  102540:	6a 00                	push   $0x0
  pushl $144
  102542:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  102547:	e9 34 05 00 00       	jmp    102a80 <__alltraps>

0010254c <vector145>:
.globl vector145
vector145:
  pushl $0
  10254c:	6a 00                	push   $0x0
  pushl $145
  10254e:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  102553:	e9 28 05 00 00       	jmp    102a80 <__alltraps>

00102558 <vector146>:
.globl vector146
vector146:
  pushl $0
  102558:	6a 00                	push   $0x0
  pushl $146
  10255a:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  10255f:	e9 1c 05 00 00       	jmp    102a80 <__alltraps>

00102564 <vector147>:
.globl vector147
vector147:
  pushl $0
  102564:	6a 00                	push   $0x0
  pushl $147
  102566:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  10256b:	e9 10 05 00 00       	jmp    102a80 <__alltraps>

00102570 <vector148>:
.globl vector148
vector148:
  pushl $0
  102570:	6a 00                	push   $0x0
  pushl $148
  102572:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  102577:	e9 04 05 00 00       	jmp    102a80 <__alltraps>

0010257c <vector149>:
.globl vector149
vector149:
  pushl $0
  10257c:	6a 00                	push   $0x0
  pushl $149
  10257e:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102583:	e9 f8 04 00 00       	jmp    102a80 <__alltraps>

00102588 <vector150>:
.globl vector150
vector150:
  pushl $0
  102588:	6a 00                	push   $0x0
  pushl $150
  10258a:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  10258f:	e9 ec 04 00 00       	jmp    102a80 <__alltraps>

00102594 <vector151>:
.globl vector151
vector151:
  pushl $0
  102594:	6a 00                	push   $0x0
  pushl $151
  102596:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  10259b:	e9 e0 04 00 00       	jmp    102a80 <__alltraps>

001025a0 <vector152>:
.globl vector152
vector152:
  pushl $0
  1025a0:	6a 00                	push   $0x0
  pushl $152
  1025a2:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  1025a7:	e9 d4 04 00 00       	jmp    102a80 <__alltraps>

001025ac <vector153>:
.globl vector153
vector153:
  pushl $0
  1025ac:	6a 00                	push   $0x0
  pushl $153
  1025ae:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  1025b3:	e9 c8 04 00 00       	jmp    102a80 <__alltraps>

001025b8 <vector154>:
.globl vector154
vector154:
  pushl $0
  1025b8:	6a 00                	push   $0x0
  pushl $154
  1025ba:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  1025bf:	e9 bc 04 00 00       	jmp    102a80 <__alltraps>

001025c4 <vector155>:
.globl vector155
vector155:
  pushl $0
  1025c4:	6a 00                	push   $0x0
  pushl $155
  1025c6:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  1025cb:	e9 b0 04 00 00       	jmp    102a80 <__alltraps>

001025d0 <vector156>:
.globl vector156
vector156:
  pushl $0
  1025d0:	6a 00                	push   $0x0
  pushl $156
  1025d2:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  1025d7:	e9 a4 04 00 00       	jmp    102a80 <__alltraps>

001025dc <vector157>:
.globl vector157
vector157:
  pushl $0
  1025dc:	6a 00                	push   $0x0
  pushl $157
  1025de:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1025e3:	e9 98 04 00 00       	jmp    102a80 <__alltraps>

001025e8 <vector158>:
.globl vector158
vector158:
  pushl $0
  1025e8:	6a 00                	push   $0x0
  pushl $158
  1025ea:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1025ef:	e9 8c 04 00 00       	jmp    102a80 <__alltraps>

001025f4 <vector159>:
.globl vector159
vector159:
  pushl $0
  1025f4:	6a 00                	push   $0x0
  pushl $159
  1025f6:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1025fb:	e9 80 04 00 00       	jmp    102a80 <__alltraps>

00102600 <vector160>:
.globl vector160
vector160:
  pushl $0
  102600:	6a 00                	push   $0x0
  pushl $160
  102602:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102607:	e9 74 04 00 00       	jmp    102a80 <__alltraps>

0010260c <vector161>:
.globl vector161
vector161:
  pushl $0
  10260c:	6a 00                	push   $0x0
  pushl $161
  10260e:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  102613:	e9 68 04 00 00       	jmp    102a80 <__alltraps>

00102618 <vector162>:
.globl vector162
vector162:
  pushl $0
  102618:	6a 00                	push   $0x0
  pushl $162
  10261a:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  10261f:	e9 5c 04 00 00       	jmp    102a80 <__alltraps>

00102624 <vector163>:
.globl vector163
vector163:
  pushl $0
  102624:	6a 00                	push   $0x0
  pushl $163
  102626:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  10262b:	e9 50 04 00 00       	jmp    102a80 <__alltraps>

00102630 <vector164>:
.globl vector164
vector164:
  pushl $0
  102630:	6a 00                	push   $0x0
  pushl $164
  102632:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  102637:	e9 44 04 00 00       	jmp    102a80 <__alltraps>

0010263c <vector165>:
.globl vector165
vector165:
  pushl $0
  10263c:	6a 00                	push   $0x0
  pushl $165
  10263e:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  102643:	e9 38 04 00 00       	jmp    102a80 <__alltraps>

00102648 <vector166>:
.globl vector166
vector166:
  pushl $0
  102648:	6a 00                	push   $0x0
  pushl $166
  10264a:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  10264f:	e9 2c 04 00 00       	jmp    102a80 <__alltraps>

00102654 <vector167>:
.globl vector167
vector167:
  pushl $0
  102654:	6a 00                	push   $0x0
  pushl $167
  102656:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  10265b:	e9 20 04 00 00       	jmp    102a80 <__alltraps>

00102660 <vector168>:
.globl vector168
vector168:
  pushl $0
  102660:	6a 00                	push   $0x0
  pushl $168
  102662:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  102667:	e9 14 04 00 00       	jmp    102a80 <__alltraps>

0010266c <vector169>:
.globl vector169
vector169:
  pushl $0
  10266c:	6a 00                	push   $0x0
  pushl $169
  10266e:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102673:	e9 08 04 00 00       	jmp    102a80 <__alltraps>

00102678 <vector170>:
.globl vector170
vector170:
  pushl $0
  102678:	6a 00                	push   $0x0
  pushl $170
  10267a:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  10267f:	e9 fc 03 00 00       	jmp    102a80 <__alltraps>

00102684 <vector171>:
.globl vector171
vector171:
  pushl $0
  102684:	6a 00                	push   $0x0
  pushl $171
  102686:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  10268b:	e9 f0 03 00 00       	jmp    102a80 <__alltraps>

00102690 <vector172>:
.globl vector172
vector172:
  pushl $0
  102690:	6a 00                	push   $0x0
  pushl $172
  102692:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102697:	e9 e4 03 00 00       	jmp    102a80 <__alltraps>

0010269c <vector173>:
.globl vector173
vector173:
  pushl $0
  10269c:	6a 00                	push   $0x0
  pushl $173
  10269e:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  1026a3:	e9 d8 03 00 00       	jmp    102a80 <__alltraps>

001026a8 <vector174>:
.globl vector174
vector174:
  pushl $0
  1026a8:	6a 00                	push   $0x0
  pushl $174
  1026aa:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  1026af:	e9 cc 03 00 00       	jmp    102a80 <__alltraps>

001026b4 <vector175>:
.globl vector175
vector175:
  pushl $0
  1026b4:	6a 00                	push   $0x0
  pushl $175
  1026b6:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  1026bb:	e9 c0 03 00 00       	jmp    102a80 <__alltraps>

001026c0 <vector176>:
.globl vector176
vector176:
  pushl $0
  1026c0:	6a 00                	push   $0x0
  pushl $176
  1026c2:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  1026c7:	e9 b4 03 00 00       	jmp    102a80 <__alltraps>

001026cc <vector177>:
.globl vector177
vector177:
  pushl $0
  1026cc:	6a 00                	push   $0x0
  pushl $177
  1026ce:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  1026d3:	e9 a8 03 00 00       	jmp    102a80 <__alltraps>

001026d8 <vector178>:
.globl vector178
vector178:
  pushl $0
  1026d8:	6a 00                	push   $0x0
  pushl $178
  1026da:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1026df:	e9 9c 03 00 00       	jmp    102a80 <__alltraps>

001026e4 <vector179>:
.globl vector179
vector179:
  pushl $0
  1026e4:	6a 00                	push   $0x0
  pushl $179
  1026e6:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1026eb:	e9 90 03 00 00       	jmp    102a80 <__alltraps>

001026f0 <vector180>:
.globl vector180
vector180:
  pushl $0
  1026f0:	6a 00                	push   $0x0
  pushl $180
  1026f2:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1026f7:	e9 84 03 00 00       	jmp    102a80 <__alltraps>

001026fc <vector181>:
.globl vector181
vector181:
  pushl $0
  1026fc:	6a 00                	push   $0x0
  pushl $181
  1026fe:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  102703:	e9 78 03 00 00       	jmp    102a80 <__alltraps>

00102708 <vector182>:
.globl vector182
vector182:
  pushl $0
  102708:	6a 00                	push   $0x0
  pushl $182
  10270a:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  10270f:	e9 6c 03 00 00       	jmp    102a80 <__alltraps>

00102714 <vector183>:
.globl vector183
vector183:
  pushl $0
  102714:	6a 00                	push   $0x0
  pushl $183
  102716:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  10271b:	e9 60 03 00 00       	jmp    102a80 <__alltraps>

00102720 <vector184>:
.globl vector184
vector184:
  pushl $0
  102720:	6a 00                	push   $0x0
  pushl $184
  102722:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  102727:	e9 54 03 00 00       	jmp    102a80 <__alltraps>

0010272c <vector185>:
.globl vector185
vector185:
  pushl $0
  10272c:	6a 00                	push   $0x0
  pushl $185
  10272e:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  102733:	e9 48 03 00 00       	jmp    102a80 <__alltraps>

00102738 <vector186>:
.globl vector186
vector186:
  pushl $0
  102738:	6a 00                	push   $0x0
  pushl $186
  10273a:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  10273f:	e9 3c 03 00 00       	jmp    102a80 <__alltraps>

00102744 <vector187>:
.globl vector187
vector187:
  pushl $0
  102744:	6a 00                	push   $0x0
  pushl $187
  102746:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  10274b:	e9 30 03 00 00       	jmp    102a80 <__alltraps>

00102750 <vector188>:
.globl vector188
vector188:
  pushl $0
  102750:	6a 00                	push   $0x0
  pushl $188
  102752:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  102757:	e9 24 03 00 00       	jmp    102a80 <__alltraps>

0010275c <vector189>:
.globl vector189
vector189:
  pushl $0
  10275c:	6a 00                	push   $0x0
  pushl $189
  10275e:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  102763:	e9 18 03 00 00       	jmp    102a80 <__alltraps>

00102768 <vector190>:
.globl vector190
vector190:
  pushl $0
  102768:	6a 00                	push   $0x0
  pushl $190
  10276a:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  10276f:	e9 0c 03 00 00       	jmp    102a80 <__alltraps>

00102774 <vector191>:
.globl vector191
vector191:
  pushl $0
  102774:	6a 00                	push   $0x0
  pushl $191
  102776:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  10277b:	e9 00 03 00 00       	jmp    102a80 <__alltraps>

00102780 <vector192>:
.globl vector192
vector192:
  pushl $0
  102780:	6a 00                	push   $0x0
  pushl $192
  102782:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102787:	e9 f4 02 00 00       	jmp    102a80 <__alltraps>

0010278c <vector193>:
.globl vector193
vector193:
  pushl $0
  10278c:	6a 00                	push   $0x0
  pushl $193
  10278e:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102793:	e9 e8 02 00 00       	jmp    102a80 <__alltraps>

00102798 <vector194>:
.globl vector194
vector194:
  pushl $0
  102798:	6a 00                	push   $0x0
  pushl $194
  10279a:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  10279f:	e9 dc 02 00 00       	jmp    102a80 <__alltraps>

001027a4 <vector195>:
.globl vector195
vector195:
  pushl $0
  1027a4:	6a 00                	push   $0x0
  pushl $195
  1027a6:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  1027ab:	e9 d0 02 00 00       	jmp    102a80 <__alltraps>

001027b0 <vector196>:
.globl vector196
vector196:
  pushl $0
  1027b0:	6a 00                	push   $0x0
  pushl $196
  1027b2:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  1027b7:	e9 c4 02 00 00       	jmp    102a80 <__alltraps>

001027bc <vector197>:
.globl vector197
vector197:
  pushl $0
  1027bc:	6a 00                	push   $0x0
  pushl $197
  1027be:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  1027c3:	e9 b8 02 00 00       	jmp    102a80 <__alltraps>

001027c8 <vector198>:
.globl vector198
vector198:
  pushl $0
  1027c8:	6a 00                	push   $0x0
  pushl $198
  1027ca:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  1027cf:	e9 ac 02 00 00       	jmp    102a80 <__alltraps>

001027d4 <vector199>:
.globl vector199
vector199:
  pushl $0
  1027d4:	6a 00                	push   $0x0
  pushl $199
  1027d6:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  1027db:	e9 a0 02 00 00       	jmp    102a80 <__alltraps>

001027e0 <vector200>:
.globl vector200
vector200:
  pushl $0
  1027e0:	6a 00                	push   $0x0
  pushl $200
  1027e2:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  1027e7:	e9 94 02 00 00       	jmp    102a80 <__alltraps>

001027ec <vector201>:
.globl vector201
vector201:
  pushl $0
  1027ec:	6a 00                	push   $0x0
  pushl $201
  1027ee:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  1027f3:	e9 88 02 00 00       	jmp    102a80 <__alltraps>

001027f8 <vector202>:
.globl vector202
vector202:
  pushl $0
  1027f8:	6a 00                	push   $0x0
  pushl $202
  1027fa:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1027ff:	e9 7c 02 00 00       	jmp    102a80 <__alltraps>

00102804 <vector203>:
.globl vector203
vector203:
  pushl $0
  102804:	6a 00                	push   $0x0
  pushl $203
  102806:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  10280b:	e9 70 02 00 00       	jmp    102a80 <__alltraps>

00102810 <vector204>:
.globl vector204
vector204:
  pushl $0
  102810:	6a 00                	push   $0x0
  pushl $204
  102812:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102817:	e9 64 02 00 00       	jmp    102a80 <__alltraps>

0010281c <vector205>:
.globl vector205
vector205:
  pushl $0
  10281c:	6a 00                	push   $0x0
  pushl $205
  10281e:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  102823:	e9 58 02 00 00       	jmp    102a80 <__alltraps>

00102828 <vector206>:
.globl vector206
vector206:
  pushl $0
  102828:	6a 00                	push   $0x0
  pushl $206
  10282a:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  10282f:	e9 4c 02 00 00       	jmp    102a80 <__alltraps>

00102834 <vector207>:
.globl vector207
vector207:
  pushl $0
  102834:	6a 00                	push   $0x0
  pushl $207
  102836:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  10283b:	e9 40 02 00 00       	jmp    102a80 <__alltraps>

00102840 <vector208>:
.globl vector208
vector208:
  pushl $0
  102840:	6a 00                	push   $0x0
  pushl $208
  102842:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102847:	e9 34 02 00 00       	jmp    102a80 <__alltraps>

0010284c <vector209>:
.globl vector209
vector209:
  pushl $0
  10284c:	6a 00                	push   $0x0
  pushl $209
  10284e:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  102853:	e9 28 02 00 00       	jmp    102a80 <__alltraps>

00102858 <vector210>:
.globl vector210
vector210:
  pushl $0
  102858:	6a 00                	push   $0x0
  pushl $210
  10285a:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  10285f:	e9 1c 02 00 00       	jmp    102a80 <__alltraps>

00102864 <vector211>:
.globl vector211
vector211:
  pushl $0
  102864:	6a 00                	push   $0x0
  pushl $211
  102866:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  10286b:	e9 10 02 00 00       	jmp    102a80 <__alltraps>

00102870 <vector212>:
.globl vector212
vector212:
  pushl $0
  102870:	6a 00                	push   $0x0
  pushl $212
  102872:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102877:	e9 04 02 00 00       	jmp    102a80 <__alltraps>

0010287c <vector213>:
.globl vector213
vector213:
  pushl $0
  10287c:	6a 00                	push   $0x0
  pushl $213
  10287e:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102883:	e9 f8 01 00 00       	jmp    102a80 <__alltraps>

00102888 <vector214>:
.globl vector214
vector214:
  pushl $0
  102888:	6a 00                	push   $0x0
  pushl $214
  10288a:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  10288f:	e9 ec 01 00 00       	jmp    102a80 <__alltraps>

00102894 <vector215>:
.globl vector215
vector215:
  pushl $0
  102894:	6a 00                	push   $0x0
  pushl $215
  102896:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  10289b:	e9 e0 01 00 00       	jmp    102a80 <__alltraps>

001028a0 <vector216>:
.globl vector216
vector216:
  pushl $0
  1028a0:	6a 00                	push   $0x0
  pushl $216
  1028a2:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  1028a7:	e9 d4 01 00 00       	jmp    102a80 <__alltraps>

001028ac <vector217>:
.globl vector217
vector217:
  pushl $0
  1028ac:	6a 00                	push   $0x0
  pushl $217
  1028ae:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  1028b3:	e9 c8 01 00 00       	jmp    102a80 <__alltraps>

001028b8 <vector218>:
.globl vector218
vector218:
  pushl $0
  1028b8:	6a 00                	push   $0x0
  pushl $218
  1028ba:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  1028bf:	e9 bc 01 00 00       	jmp    102a80 <__alltraps>

001028c4 <vector219>:
.globl vector219
vector219:
  pushl $0
  1028c4:	6a 00                	push   $0x0
  pushl $219
  1028c6:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  1028cb:	e9 b0 01 00 00       	jmp    102a80 <__alltraps>

001028d0 <vector220>:
.globl vector220
vector220:
  pushl $0
  1028d0:	6a 00                	push   $0x0
  pushl $220
  1028d2:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  1028d7:	e9 a4 01 00 00       	jmp    102a80 <__alltraps>

001028dc <vector221>:
.globl vector221
vector221:
  pushl $0
  1028dc:	6a 00                	push   $0x0
  pushl $221
  1028de:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  1028e3:	e9 98 01 00 00       	jmp    102a80 <__alltraps>

001028e8 <vector222>:
.globl vector222
vector222:
  pushl $0
  1028e8:	6a 00                	push   $0x0
  pushl $222
  1028ea:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  1028ef:	e9 8c 01 00 00       	jmp    102a80 <__alltraps>

001028f4 <vector223>:
.globl vector223
vector223:
  pushl $0
  1028f4:	6a 00                	push   $0x0
  pushl $223
  1028f6:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  1028fb:	e9 80 01 00 00       	jmp    102a80 <__alltraps>

00102900 <vector224>:
.globl vector224
vector224:
  pushl $0
  102900:	6a 00                	push   $0x0
  pushl $224
  102902:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102907:	e9 74 01 00 00       	jmp    102a80 <__alltraps>

0010290c <vector225>:
.globl vector225
vector225:
  pushl $0
  10290c:	6a 00                	push   $0x0
  pushl $225
  10290e:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  102913:	e9 68 01 00 00       	jmp    102a80 <__alltraps>

00102918 <vector226>:
.globl vector226
vector226:
  pushl $0
  102918:	6a 00                	push   $0x0
  pushl $226
  10291a:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  10291f:	e9 5c 01 00 00       	jmp    102a80 <__alltraps>

00102924 <vector227>:
.globl vector227
vector227:
  pushl $0
  102924:	6a 00                	push   $0x0
  pushl $227
  102926:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  10292b:	e9 50 01 00 00       	jmp    102a80 <__alltraps>

00102930 <vector228>:
.globl vector228
vector228:
  pushl $0
  102930:	6a 00                	push   $0x0
  pushl $228
  102932:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102937:	e9 44 01 00 00       	jmp    102a80 <__alltraps>

0010293c <vector229>:
.globl vector229
vector229:
  pushl $0
  10293c:	6a 00                	push   $0x0
  pushl $229
  10293e:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102943:	e9 38 01 00 00       	jmp    102a80 <__alltraps>

00102948 <vector230>:
.globl vector230
vector230:
  pushl $0
  102948:	6a 00                	push   $0x0
  pushl $230
  10294a:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  10294f:	e9 2c 01 00 00       	jmp    102a80 <__alltraps>

00102954 <vector231>:
.globl vector231
vector231:
  pushl $0
  102954:	6a 00                	push   $0x0
  pushl $231
  102956:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  10295b:	e9 20 01 00 00       	jmp    102a80 <__alltraps>

00102960 <vector232>:
.globl vector232
vector232:
  pushl $0
  102960:	6a 00                	push   $0x0
  pushl $232
  102962:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102967:	e9 14 01 00 00       	jmp    102a80 <__alltraps>

0010296c <vector233>:
.globl vector233
vector233:
  pushl $0
  10296c:	6a 00                	push   $0x0
  pushl $233
  10296e:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102973:	e9 08 01 00 00       	jmp    102a80 <__alltraps>

00102978 <vector234>:
.globl vector234
vector234:
  pushl $0
  102978:	6a 00                	push   $0x0
  pushl $234
  10297a:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  10297f:	e9 fc 00 00 00       	jmp    102a80 <__alltraps>

00102984 <vector235>:
.globl vector235
vector235:
  pushl $0
  102984:	6a 00                	push   $0x0
  pushl $235
  102986:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  10298b:	e9 f0 00 00 00       	jmp    102a80 <__alltraps>

00102990 <vector236>:
.globl vector236
vector236:
  pushl $0
  102990:	6a 00                	push   $0x0
  pushl $236
  102992:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102997:	e9 e4 00 00 00       	jmp    102a80 <__alltraps>

0010299c <vector237>:
.globl vector237
vector237:
  pushl $0
  10299c:	6a 00                	push   $0x0
  pushl $237
  10299e:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  1029a3:	e9 d8 00 00 00       	jmp    102a80 <__alltraps>

001029a8 <vector238>:
.globl vector238
vector238:
  pushl $0
  1029a8:	6a 00                	push   $0x0
  pushl $238
  1029aa:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  1029af:	e9 cc 00 00 00       	jmp    102a80 <__alltraps>

001029b4 <vector239>:
.globl vector239
vector239:
  pushl $0
  1029b4:	6a 00                	push   $0x0
  pushl $239
  1029b6:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  1029bb:	e9 c0 00 00 00       	jmp    102a80 <__alltraps>

001029c0 <vector240>:
.globl vector240
vector240:
  pushl $0
  1029c0:	6a 00                	push   $0x0
  pushl $240
  1029c2:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  1029c7:	e9 b4 00 00 00       	jmp    102a80 <__alltraps>

001029cc <vector241>:
.globl vector241
vector241:
  pushl $0
  1029cc:	6a 00                	push   $0x0
  pushl $241
  1029ce:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  1029d3:	e9 a8 00 00 00       	jmp    102a80 <__alltraps>

001029d8 <vector242>:
.globl vector242
vector242:
  pushl $0
  1029d8:	6a 00                	push   $0x0
  pushl $242
  1029da:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  1029df:	e9 9c 00 00 00       	jmp    102a80 <__alltraps>

001029e4 <vector243>:
.globl vector243
vector243:
  pushl $0
  1029e4:	6a 00                	push   $0x0
  pushl $243
  1029e6:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  1029eb:	e9 90 00 00 00       	jmp    102a80 <__alltraps>

001029f0 <vector244>:
.globl vector244
vector244:
  pushl $0
  1029f0:	6a 00                	push   $0x0
  pushl $244
  1029f2:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  1029f7:	e9 84 00 00 00       	jmp    102a80 <__alltraps>

001029fc <vector245>:
.globl vector245
vector245:
  pushl $0
  1029fc:	6a 00                	push   $0x0
  pushl $245
  1029fe:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102a03:	e9 78 00 00 00       	jmp    102a80 <__alltraps>

00102a08 <vector246>:
.globl vector246
vector246:
  pushl $0
  102a08:	6a 00                	push   $0x0
  pushl $246
  102a0a:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102a0f:	e9 6c 00 00 00       	jmp    102a80 <__alltraps>

00102a14 <vector247>:
.globl vector247
vector247:
  pushl $0
  102a14:	6a 00                	push   $0x0
  pushl $247
  102a16:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102a1b:	e9 60 00 00 00       	jmp    102a80 <__alltraps>

00102a20 <vector248>:
.globl vector248
vector248:
  pushl $0
  102a20:	6a 00                	push   $0x0
  pushl $248
  102a22:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102a27:	e9 54 00 00 00       	jmp    102a80 <__alltraps>

00102a2c <vector249>:
.globl vector249
vector249:
  pushl $0
  102a2c:	6a 00                	push   $0x0
  pushl $249
  102a2e:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102a33:	e9 48 00 00 00       	jmp    102a80 <__alltraps>

00102a38 <vector250>:
.globl vector250
vector250:
  pushl $0
  102a38:	6a 00                	push   $0x0
  pushl $250
  102a3a:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102a3f:	e9 3c 00 00 00       	jmp    102a80 <__alltraps>

00102a44 <vector251>:
.globl vector251
vector251:
  pushl $0
  102a44:	6a 00                	push   $0x0
  pushl $251
  102a46:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102a4b:	e9 30 00 00 00       	jmp    102a80 <__alltraps>

00102a50 <vector252>:
.globl vector252
vector252:
  pushl $0
  102a50:	6a 00                	push   $0x0
  pushl $252
  102a52:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102a57:	e9 24 00 00 00       	jmp    102a80 <__alltraps>

00102a5c <vector253>:
.globl vector253
vector253:
  pushl $0
  102a5c:	6a 00                	push   $0x0
  pushl $253
  102a5e:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102a63:	e9 18 00 00 00       	jmp    102a80 <__alltraps>

00102a68 <vector254>:
.globl vector254
vector254:
  pushl $0
  102a68:	6a 00                	push   $0x0
  pushl $254
  102a6a:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102a6f:	e9 0c 00 00 00       	jmp    102a80 <__alltraps>

00102a74 <vector255>:
.globl vector255
vector255:
  pushl $0
  102a74:	6a 00                	push   $0x0
  pushl $255
  102a76:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102a7b:	e9 00 00 00 00       	jmp    102a80 <__alltraps>

00102a80 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102a80:	1e                   	push   %ds
    pushl %es
  102a81:	06                   	push   %es
    pushl %fs
  102a82:	0f a0                	push   %fs
    pushl %gs
  102a84:	0f a8                	push   %gs
    pushal
  102a86:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102a87:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102a8c:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102a8e:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102a90:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102a91:	e8 60 f5 ff ff       	call   101ff6 <trap>

    # pop the pushed stack pointer
    popl %esp
  102a96:	5c                   	pop    %esp

00102a97 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102a97:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102a98:	0f a9                	pop    %gs
    popl %fs
  102a9a:	0f a1                	pop    %fs
    popl %es
  102a9c:	07                   	pop    %es
    popl %ds
  102a9d:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102a9e:	83 c4 08             	add    $0x8,%esp
    iret
  102aa1:	cf                   	iret   

00102aa2 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102aa2:	55                   	push   %ebp
  102aa3:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  102aa8:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102aab:	b8 23 00 00 00       	mov    $0x23,%eax
  102ab0:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102ab2:	b8 23 00 00 00       	mov    $0x23,%eax
  102ab7:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102ab9:	b8 10 00 00 00       	mov    $0x10,%eax
  102abe:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102ac0:	b8 10 00 00 00       	mov    $0x10,%eax
  102ac5:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102ac7:	b8 10 00 00 00       	mov    $0x10,%eax
  102acc:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102ace:	ea d5 2a 10 00 08 00 	ljmp   $0x8,$0x102ad5
}
  102ad5:	90                   	nop
  102ad6:	5d                   	pop    %ebp
  102ad7:	c3                   	ret    

00102ad8 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102ad8:	f3 0f 1e fb          	endbr32 
  102adc:	55                   	push   %ebp
  102add:	89 e5                	mov    %esp,%ebp
  102adf:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102ae2:	b8 80 19 11 00       	mov    $0x111980,%eax
  102ae7:	05 00 04 00 00       	add    $0x400,%eax
  102aec:	a3 a4 18 11 00       	mov    %eax,0x1118a4
    ts.ts_ss0 = KERNEL_DS;
  102af1:	66 c7 05 a8 18 11 00 	movw   $0x10,0x1118a8
  102af8:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102afa:	66 c7 05 08 0a 11 00 	movw   $0x68,0x110a08
  102b01:	68 00 
  102b03:	b8 a0 18 11 00       	mov    $0x1118a0,%eax
  102b08:	0f b7 c0             	movzwl %ax,%eax
  102b0b:	66 a3 0a 0a 11 00    	mov    %ax,0x110a0a
  102b11:	b8 a0 18 11 00       	mov    $0x1118a0,%eax
  102b16:	c1 e8 10             	shr    $0x10,%eax
  102b19:	a2 0c 0a 11 00       	mov    %al,0x110a0c
  102b1e:	0f b6 05 0d 0a 11 00 	movzbl 0x110a0d,%eax
  102b25:	24 f0                	and    $0xf0,%al
  102b27:	0c 09                	or     $0x9,%al
  102b29:	a2 0d 0a 11 00       	mov    %al,0x110a0d
  102b2e:	0f b6 05 0d 0a 11 00 	movzbl 0x110a0d,%eax
  102b35:	0c 10                	or     $0x10,%al
  102b37:	a2 0d 0a 11 00       	mov    %al,0x110a0d
  102b3c:	0f b6 05 0d 0a 11 00 	movzbl 0x110a0d,%eax
  102b43:	24 9f                	and    $0x9f,%al
  102b45:	a2 0d 0a 11 00       	mov    %al,0x110a0d
  102b4a:	0f b6 05 0d 0a 11 00 	movzbl 0x110a0d,%eax
  102b51:	0c 80                	or     $0x80,%al
  102b53:	a2 0d 0a 11 00       	mov    %al,0x110a0d
  102b58:	0f b6 05 0e 0a 11 00 	movzbl 0x110a0e,%eax
  102b5f:	24 f0                	and    $0xf0,%al
  102b61:	a2 0e 0a 11 00       	mov    %al,0x110a0e
  102b66:	0f b6 05 0e 0a 11 00 	movzbl 0x110a0e,%eax
  102b6d:	24 ef                	and    $0xef,%al
  102b6f:	a2 0e 0a 11 00       	mov    %al,0x110a0e
  102b74:	0f b6 05 0e 0a 11 00 	movzbl 0x110a0e,%eax
  102b7b:	24 df                	and    $0xdf,%al
  102b7d:	a2 0e 0a 11 00       	mov    %al,0x110a0e
  102b82:	0f b6 05 0e 0a 11 00 	movzbl 0x110a0e,%eax
  102b89:	0c 40                	or     $0x40,%al
  102b8b:	a2 0e 0a 11 00       	mov    %al,0x110a0e
  102b90:	0f b6 05 0e 0a 11 00 	movzbl 0x110a0e,%eax
  102b97:	24 7f                	and    $0x7f,%al
  102b99:	a2 0e 0a 11 00       	mov    %al,0x110a0e
  102b9e:	b8 a0 18 11 00       	mov    $0x1118a0,%eax
  102ba3:	c1 e8 18             	shr    $0x18,%eax
  102ba6:	a2 0f 0a 11 00       	mov    %al,0x110a0f
    gdt[SEG_TSS].sd_s = 0;
  102bab:	0f b6 05 0d 0a 11 00 	movzbl 0x110a0d,%eax
  102bb2:	24 ef                	and    $0xef,%al
  102bb4:	a2 0d 0a 11 00       	mov    %al,0x110a0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102bb9:	c7 04 24 10 0a 11 00 	movl   $0x110a10,(%esp)
  102bc0:	e8 dd fe ff ff       	call   102aa2 <lgdt>
  102bc5:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102bcb:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102bcf:	0f 00 d8             	ltr    %ax
}
  102bd2:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102bd3:	90                   	nop
  102bd4:	c9                   	leave  
  102bd5:	c3                   	ret    

00102bd6 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102bd6:	f3 0f 1e fb          	endbr32 
  102bda:	55                   	push   %ebp
  102bdb:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102bdd:	e8 f6 fe ff ff       	call   102ad8 <gdt_init>
}
  102be2:	90                   	nop
  102be3:	5d                   	pop    %ebp
  102be4:	c3                   	ret    

00102be5 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102be5:	f3 0f 1e fb          	endbr32 
  102be9:	55                   	push   %ebp
  102bea:	89 e5                	mov    %esp,%ebp
  102bec:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102bef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102bf6:	eb 03                	jmp    102bfb <strlen+0x16>
        cnt ++;
  102bf8:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
  102bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  102bfe:	8d 50 01             	lea    0x1(%eax),%edx
  102c01:	89 55 08             	mov    %edx,0x8(%ebp)
  102c04:	0f b6 00             	movzbl (%eax),%eax
  102c07:	84 c0                	test   %al,%al
  102c09:	75 ed                	jne    102bf8 <strlen+0x13>
    }
    return cnt;
  102c0b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102c0e:	c9                   	leave  
  102c0f:	c3                   	ret    

00102c10 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102c10:	f3 0f 1e fb          	endbr32 
  102c14:	55                   	push   %ebp
  102c15:	89 e5                	mov    %esp,%ebp
  102c17:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102c1a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102c21:	eb 03                	jmp    102c26 <strnlen+0x16>
        cnt ++;
  102c23:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102c26:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102c29:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102c2c:	73 10                	jae    102c3e <strnlen+0x2e>
  102c2e:	8b 45 08             	mov    0x8(%ebp),%eax
  102c31:	8d 50 01             	lea    0x1(%eax),%edx
  102c34:	89 55 08             	mov    %edx,0x8(%ebp)
  102c37:	0f b6 00             	movzbl (%eax),%eax
  102c3a:	84 c0                	test   %al,%al
  102c3c:	75 e5                	jne    102c23 <strnlen+0x13>
    }
    return cnt;
  102c3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102c41:	c9                   	leave  
  102c42:	c3                   	ret    

00102c43 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102c43:	f3 0f 1e fb          	endbr32 
  102c47:	55                   	push   %ebp
  102c48:	89 e5                	mov    %esp,%ebp
  102c4a:	57                   	push   %edi
  102c4b:	56                   	push   %esi
  102c4c:	83 ec 20             	sub    $0x20,%esp
  102c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  102c52:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c55:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c58:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102c5b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102c5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102c61:	89 d1                	mov    %edx,%ecx
  102c63:	89 c2                	mov    %eax,%edx
  102c65:	89 ce                	mov    %ecx,%esi
  102c67:	89 d7                	mov    %edx,%edi
  102c69:	ac                   	lods   %ds:(%esi),%al
  102c6a:	aa                   	stos   %al,%es:(%edi)
  102c6b:	84 c0                	test   %al,%al
  102c6d:	75 fa                	jne    102c69 <strcpy+0x26>
  102c6f:	89 fa                	mov    %edi,%edx
  102c71:	89 f1                	mov    %esi,%ecx
  102c73:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102c76:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102c79:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102c7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102c7f:	83 c4 20             	add    $0x20,%esp
  102c82:	5e                   	pop    %esi
  102c83:	5f                   	pop    %edi
  102c84:	5d                   	pop    %ebp
  102c85:	c3                   	ret    

00102c86 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102c86:	f3 0f 1e fb          	endbr32 
  102c8a:	55                   	push   %ebp
  102c8b:	89 e5                	mov    %esp,%ebp
  102c8d:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102c90:	8b 45 08             	mov    0x8(%ebp),%eax
  102c93:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102c96:	eb 1e                	jmp    102cb6 <strncpy+0x30>
        if ((*p = *src) != '\0') {
  102c98:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c9b:	0f b6 10             	movzbl (%eax),%edx
  102c9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102ca1:	88 10                	mov    %dl,(%eax)
  102ca3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102ca6:	0f b6 00             	movzbl (%eax),%eax
  102ca9:	84 c0                	test   %al,%al
  102cab:	74 03                	je     102cb0 <strncpy+0x2a>
            src ++;
  102cad:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
  102cb0:	ff 45 fc             	incl   -0x4(%ebp)
  102cb3:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
  102cb6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102cba:	75 dc                	jne    102c98 <strncpy+0x12>
    }
    return dst;
  102cbc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102cbf:	c9                   	leave  
  102cc0:	c3                   	ret    

00102cc1 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102cc1:	f3 0f 1e fb          	endbr32 
  102cc5:	55                   	push   %ebp
  102cc6:	89 e5                	mov    %esp,%ebp
  102cc8:	57                   	push   %edi
  102cc9:	56                   	push   %esi
  102cca:	83 ec 20             	sub    $0x20,%esp
  102ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  102cd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102cd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cd6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102cd9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102cdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102cdf:	89 d1                	mov    %edx,%ecx
  102ce1:	89 c2                	mov    %eax,%edx
  102ce3:	89 ce                	mov    %ecx,%esi
  102ce5:	89 d7                	mov    %edx,%edi
  102ce7:	ac                   	lods   %ds:(%esi),%al
  102ce8:	ae                   	scas   %es:(%edi),%al
  102ce9:	75 08                	jne    102cf3 <strcmp+0x32>
  102ceb:	84 c0                	test   %al,%al
  102ced:	75 f8                	jne    102ce7 <strcmp+0x26>
  102cef:	31 c0                	xor    %eax,%eax
  102cf1:	eb 04                	jmp    102cf7 <strcmp+0x36>
  102cf3:	19 c0                	sbb    %eax,%eax
  102cf5:	0c 01                	or     $0x1,%al
  102cf7:	89 fa                	mov    %edi,%edx
  102cf9:	89 f1                	mov    %esi,%ecx
  102cfb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102cfe:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102d01:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102d04:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102d07:	83 c4 20             	add    $0x20,%esp
  102d0a:	5e                   	pop    %esi
  102d0b:	5f                   	pop    %edi
  102d0c:	5d                   	pop    %ebp
  102d0d:	c3                   	ret    

00102d0e <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102d0e:	f3 0f 1e fb          	endbr32 
  102d12:	55                   	push   %ebp
  102d13:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102d15:	eb 09                	jmp    102d20 <strncmp+0x12>
        n --, s1 ++, s2 ++;
  102d17:	ff 4d 10             	decl   0x10(%ebp)
  102d1a:	ff 45 08             	incl   0x8(%ebp)
  102d1d:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102d20:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d24:	74 1a                	je     102d40 <strncmp+0x32>
  102d26:	8b 45 08             	mov    0x8(%ebp),%eax
  102d29:	0f b6 00             	movzbl (%eax),%eax
  102d2c:	84 c0                	test   %al,%al
  102d2e:	74 10                	je     102d40 <strncmp+0x32>
  102d30:	8b 45 08             	mov    0x8(%ebp),%eax
  102d33:	0f b6 10             	movzbl (%eax),%edx
  102d36:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d39:	0f b6 00             	movzbl (%eax),%eax
  102d3c:	38 c2                	cmp    %al,%dl
  102d3e:	74 d7                	je     102d17 <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102d40:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d44:	74 18                	je     102d5e <strncmp+0x50>
  102d46:	8b 45 08             	mov    0x8(%ebp),%eax
  102d49:	0f b6 00             	movzbl (%eax),%eax
  102d4c:	0f b6 d0             	movzbl %al,%edx
  102d4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d52:	0f b6 00             	movzbl (%eax),%eax
  102d55:	0f b6 c0             	movzbl %al,%eax
  102d58:	29 c2                	sub    %eax,%edx
  102d5a:	89 d0                	mov    %edx,%eax
  102d5c:	eb 05                	jmp    102d63 <strncmp+0x55>
  102d5e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102d63:	5d                   	pop    %ebp
  102d64:	c3                   	ret    

00102d65 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102d65:	f3 0f 1e fb          	endbr32 
  102d69:	55                   	push   %ebp
  102d6a:	89 e5                	mov    %esp,%ebp
  102d6c:	83 ec 04             	sub    $0x4,%esp
  102d6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d72:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102d75:	eb 13                	jmp    102d8a <strchr+0x25>
        if (*s == c) {
  102d77:	8b 45 08             	mov    0x8(%ebp),%eax
  102d7a:	0f b6 00             	movzbl (%eax),%eax
  102d7d:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102d80:	75 05                	jne    102d87 <strchr+0x22>
            return (char *)s;
  102d82:	8b 45 08             	mov    0x8(%ebp),%eax
  102d85:	eb 12                	jmp    102d99 <strchr+0x34>
        }
        s ++;
  102d87:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102d8a:	8b 45 08             	mov    0x8(%ebp),%eax
  102d8d:	0f b6 00             	movzbl (%eax),%eax
  102d90:	84 c0                	test   %al,%al
  102d92:	75 e3                	jne    102d77 <strchr+0x12>
    }
    return NULL;
  102d94:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102d99:	c9                   	leave  
  102d9a:	c3                   	ret    

00102d9b <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102d9b:	f3 0f 1e fb          	endbr32 
  102d9f:	55                   	push   %ebp
  102da0:	89 e5                	mov    %esp,%ebp
  102da2:	83 ec 04             	sub    $0x4,%esp
  102da5:	8b 45 0c             	mov    0xc(%ebp),%eax
  102da8:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102dab:	eb 0e                	jmp    102dbb <strfind+0x20>
        if (*s == c) {
  102dad:	8b 45 08             	mov    0x8(%ebp),%eax
  102db0:	0f b6 00             	movzbl (%eax),%eax
  102db3:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102db6:	74 0f                	je     102dc7 <strfind+0x2c>
            break;
        }
        s ++;
  102db8:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  102dbe:	0f b6 00             	movzbl (%eax),%eax
  102dc1:	84 c0                	test   %al,%al
  102dc3:	75 e8                	jne    102dad <strfind+0x12>
  102dc5:	eb 01                	jmp    102dc8 <strfind+0x2d>
            break;
  102dc7:	90                   	nop
    }
    return (char *)s;
  102dc8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102dcb:	c9                   	leave  
  102dcc:	c3                   	ret    

00102dcd <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102dcd:	f3 0f 1e fb          	endbr32 
  102dd1:	55                   	push   %ebp
  102dd2:	89 e5                	mov    %esp,%ebp
  102dd4:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102dd7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102dde:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102de5:	eb 03                	jmp    102dea <strtol+0x1d>
        s ++;
  102de7:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102dea:	8b 45 08             	mov    0x8(%ebp),%eax
  102ded:	0f b6 00             	movzbl (%eax),%eax
  102df0:	3c 20                	cmp    $0x20,%al
  102df2:	74 f3                	je     102de7 <strtol+0x1a>
  102df4:	8b 45 08             	mov    0x8(%ebp),%eax
  102df7:	0f b6 00             	movzbl (%eax),%eax
  102dfa:	3c 09                	cmp    $0x9,%al
  102dfc:	74 e9                	je     102de7 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  102dfe:	8b 45 08             	mov    0x8(%ebp),%eax
  102e01:	0f b6 00             	movzbl (%eax),%eax
  102e04:	3c 2b                	cmp    $0x2b,%al
  102e06:	75 05                	jne    102e0d <strtol+0x40>
        s ++;
  102e08:	ff 45 08             	incl   0x8(%ebp)
  102e0b:	eb 14                	jmp    102e21 <strtol+0x54>
    }
    else if (*s == '-') {
  102e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e10:	0f b6 00             	movzbl (%eax),%eax
  102e13:	3c 2d                	cmp    $0x2d,%al
  102e15:	75 0a                	jne    102e21 <strtol+0x54>
        s ++, neg = 1;
  102e17:	ff 45 08             	incl   0x8(%ebp)
  102e1a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102e21:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102e25:	74 06                	je     102e2d <strtol+0x60>
  102e27:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102e2b:	75 22                	jne    102e4f <strtol+0x82>
  102e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e30:	0f b6 00             	movzbl (%eax),%eax
  102e33:	3c 30                	cmp    $0x30,%al
  102e35:	75 18                	jne    102e4f <strtol+0x82>
  102e37:	8b 45 08             	mov    0x8(%ebp),%eax
  102e3a:	40                   	inc    %eax
  102e3b:	0f b6 00             	movzbl (%eax),%eax
  102e3e:	3c 78                	cmp    $0x78,%al
  102e40:	75 0d                	jne    102e4f <strtol+0x82>
        s += 2, base = 16;
  102e42:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102e46:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102e4d:	eb 29                	jmp    102e78 <strtol+0xab>
    }
    else if (base == 0 && s[0] == '0') {
  102e4f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102e53:	75 16                	jne    102e6b <strtol+0x9e>
  102e55:	8b 45 08             	mov    0x8(%ebp),%eax
  102e58:	0f b6 00             	movzbl (%eax),%eax
  102e5b:	3c 30                	cmp    $0x30,%al
  102e5d:	75 0c                	jne    102e6b <strtol+0x9e>
        s ++, base = 8;
  102e5f:	ff 45 08             	incl   0x8(%ebp)
  102e62:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102e69:	eb 0d                	jmp    102e78 <strtol+0xab>
    }
    else if (base == 0) {
  102e6b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102e6f:	75 07                	jne    102e78 <strtol+0xab>
        base = 10;
  102e71:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102e78:	8b 45 08             	mov    0x8(%ebp),%eax
  102e7b:	0f b6 00             	movzbl (%eax),%eax
  102e7e:	3c 2f                	cmp    $0x2f,%al
  102e80:	7e 1b                	jle    102e9d <strtol+0xd0>
  102e82:	8b 45 08             	mov    0x8(%ebp),%eax
  102e85:	0f b6 00             	movzbl (%eax),%eax
  102e88:	3c 39                	cmp    $0x39,%al
  102e8a:	7f 11                	jg     102e9d <strtol+0xd0>
            dig = *s - '0';
  102e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  102e8f:	0f b6 00             	movzbl (%eax),%eax
  102e92:	0f be c0             	movsbl %al,%eax
  102e95:	83 e8 30             	sub    $0x30,%eax
  102e98:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e9b:	eb 48                	jmp    102ee5 <strtol+0x118>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  102ea0:	0f b6 00             	movzbl (%eax),%eax
  102ea3:	3c 60                	cmp    $0x60,%al
  102ea5:	7e 1b                	jle    102ec2 <strtol+0xf5>
  102ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  102eaa:	0f b6 00             	movzbl (%eax),%eax
  102ead:	3c 7a                	cmp    $0x7a,%al
  102eaf:	7f 11                	jg     102ec2 <strtol+0xf5>
            dig = *s - 'a' + 10;
  102eb1:	8b 45 08             	mov    0x8(%ebp),%eax
  102eb4:	0f b6 00             	movzbl (%eax),%eax
  102eb7:	0f be c0             	movsbl %al,%eax
  102eba:	83 e8 57             	sub    $0x57,%eax
  102ebd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ec0:	eb 23                	jmp    102ee5 <strtol+0x118>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  102ec5:	0f b6 00             	movzbl (%eax),%eax
  102ec8:	3c 40                	cmp    $0x40,%al
  102eca:	7e 3b                	jle    102f07 <strtol+0x13a>
  102ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  102ecf:	0f b6 00             	movzbl (%eax),%eax
  102ed2:	3c 5a                	cmp    $0x5a,%al
  102ed4:	7f 31                	jg     102f07 <strtol+0x13a>
            dig = *s - 'A' + 10;
  102ed6:	8b 45 08             	mov    0x8(%ebp),%eax
  102ed9:	0f b6 00             	movzbl (%eax),%eax
  102edc:	0f be c0             	movsbl %al,%eax
  102edf:	83 e8 37             	sub    $0x37,%eax
  102ee2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102ee5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ee8:	3b 45 10             	cmp    0x10(%ebp),%eax
  102eeb:	7d 19                	jge    102f06 <strtol+0x139>
            break;
        }
        s ++, val = (val * base) + dig;
  102eed:	ff 45 08             	incl   0x8(%ebp)
  102ef0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102ef3:	0f af 45 10          	imul   0x10(%ebp),%eax
  102ef7:	89 c2                	mov    %eax,%edx
  102ef9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102efc:	01 d0                	add    %edx,%eax
  102efe:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  102f01:	e9 72 ff ff ff       	jmp    102e78 <strtol+0xab>
            break;
  102f06:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102f07:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102f0b:	74 08                	je     102f15 <strtol+0x148>
        *endptr = (char *) s;
  102f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f10:	8b 55 08             	mov    0x8(%ebp),%edx
  102f13:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102f15:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102f19:	74 07                	je     102f22 <strtol+0x155>
  102f1b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102f1e:	f7 d8                	neg    %eax
  102f20:	eb 03                	jmp    102f25 <strtol+0x158>
  102f22:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102f25:	c9                   	leave  
  102f26:	c3                   	ret    

00102f27 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102f27:	f3 0f 1e fb          	endbr32 
  102f2b:	55                   	push   %ebp
  102f2c:	89 e5                	mov    %esp,%ebp
  102f2e:	57                   	push   %edi
  102f2f:	83 ec 24             	sub    $0x24,%esp
  102f32:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f35:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102f38:	0f be 55 d8          	movsbl -0x28(%ebp),%edx
  102f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  102f3f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  102f42:	88 55 f7             	mov    %dl,-0x9(%ebp)
  102f45:	8b 45 10             	mov    0x10(%ebp),%eax
  102f48:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102f4b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102f4e:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102f52:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102f55:	89 d7                	mov    %edx,%edi
  102f57:	f3 aa                	rep stos %al,%es:(%edi)
  102f59:	89 fa                	mov    %edi,%edx
  102f5b:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102f5e:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102f61:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102f64:	83 c4 24             	add    $0x24,%esp
  102f67:	5f                   	pop    %edi
  102f68:	5d                   	pop    %ebp
  102f69:	c3                   	ret    

00102f6a <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102f6a:	f3 0f 1e fb          	endbr32 
  102f6e:	55                   	push   %ebp
  102f6f:	89 e5                	mov    %esp,%ebp
  102f71:	57                   	push   %edi
  102f72:	56                   	push   %esi
  102f73:	53                   	push   %ebx
  102f74:	83 ec 30             	sub    $0x30,%esp
  102f77:	8b 45 08             	mov    0x8(%ebp),%eax
  102f7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f80:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102f83:	8b 45 10             	mov    0x10(%ebp),%eax
  102f86:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102f89:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f8c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102f8f:	73 42                	jae    102fd3 <memmove+0x69>
  102f91:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f94:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102f97:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f9a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102f9d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102fa0:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102fa3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102fa6:	c1 e8 02             	shr    $0x2,%eax
  102fa9:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102fab:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102fae:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102fb1:	89 d7                	mov    %edx,%edi
  102fb3:	89 c6                	mov    %eax,%esi
  102fb5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102fb7:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102fba:	83 e1 03             	and    $0x3,%ecx
  102fbd:	74 02                	je     102fc1 <memmove+0x57>
  102fbf:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102fc1:	89 f0                	mov    %esi,%eax
  102fc3:	89 fa                	mov    %edi,%edx
  102fc5:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102fc8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102fcb:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102fce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  102fd1:	eb 36                	jmp    103009 <memmove+0x9f>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102fd3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102fd6:	8d 50 ff             	lea    -0x1(%eax),%edx
  102fd9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102fdc:	01 c2                	add    %eax,%edx
  102fde:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102fe1:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102fe4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fe7:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102fea:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102fed:	89 c1                	mov    %eax,%ecx
  102fef:	89 d8                	mov    %ebx,%eax
  102ff1:	89 d6                	mov    %edx,%esi
  102ff3:	89 c7                	mov    %eax,%edi
  102ff5:	fd                   	std    
  102ff6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102ff8:	fc                   	cld    
  102ff9:	89 f8                	mov    %edi,%eax
  102ffb:	89 f2                	mov    %esi,%edx
  102ffd:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  103000:	89 55 c8             	mov    %edx,-0x38(%ebp)
  103003:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  103006:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  103009:	83 c4 30             	add    $0x30,%esp
  10300c:	5b                   	pop    %ebx
  10300d:	5e                   	pop    %esi
  10300e:	5f                   	pop    %edi
  10300f:	5d                   	pop    %ebp
  103010:	c3                   	ret    

00103011 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  103011:	f3 0f 1e fb          	endbr32 
  103015:	55                   	push   %ebp
  103016:	89 e5                	mov    %esp,%ebp
  103018:	57                   	push   %edi
  103019:	56                   	push   %esi
  10301a:	83 ec 20             	sub    $0x20,%esp
  10301d:	8b 45 08             	mov    0x8(%ebp),%eax
  103020:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103023:	8b 45 0c             	mov    0xc(%ebp),%eax
  103026:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103029:	8b 45 10             	mov    0x10(%ebp),%eax
  10302c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  10302f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103032:	c1 e8 02             	shr    $0x2,%eax
  103035:	89 c1                	mov    %eax,%ecx
    asm volatile (
  103037:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10303a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10303d:	89 d7                	mov    %edx,%edi
  10303f:	89 c6                	mov    %eax,%esi
  103041:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103043:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103046:	83 e1 03             	and    $0x3,%ecx
  103049:	74 02                	je     10304d <memcpy+0x3c>
  10304b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  10304d:	89 f0                	mov    %esi,%eax
  10304f:	89 fa                	mov    %edi,%edx
  103051:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  103054:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  103057:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  10305a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  10305d:	83 c4 20             	add    $0x20,%esp
  103060:	5e                   	pop    %esi
  103061:	5f                   	pop    %edi
  103062:	5d                   	pop    %ebp
  103063:	c3                   	ret    

00103064 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  103064:	f3 0f 1e fb          	endbr32 
  103068:	55                   	push   %ebp
  103069:	89 e5                	mov    %esp,%ebp
  10306b:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  10306e:	8b 45 08             	mov    0x8(%ebp),%eax
  103071:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  103074:	8b 45 0c             	mov    0xc(%ebp),%eax
  103077:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  10307a:	eb 2e                	jmp    1030aa <memcmp+0x46>
        if (*s1 != *s2) {
  10307c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10307f:	0f b6 10             	movzbl (%eax),%edx
  103082:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103085:	0f b6 00             	movzbl (%eax),%eax
  103088:	38 c2                	cmp    %al,%dl
  10308a:	74 18                	je     1030a4 <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  10308c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10308f:	0f b6 00             	movzbl (%eax),%eax
  103092:	0f b6 d0             	movzbl %al,%edx
  103095:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103098:	0f b6 00             	movzbl (%eax),%eax
  10309b:	0f b6 c0             	movzbl %al,%eax
  10309e:	29 c2                	sub    %eax,%edx
  1030a0:	89 d0                	mov    %edx,%eax
  1030a2:	eb 18                	jmp    1030bc <memcmp+0x58>
        }
        s1 ++, s2 ++;
  1030a4:	ff 45 fc             	incl   -0x4(%ebp)
  1030a7:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
  1030aa:	8b 45 10             	mov    0x10(%ebp),%eax
  1030ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  1030b0:	89 55 10             	mov    %edx,0x10(%ebp)
  1030b3:	85 c0                	test   %eax,%eax
  1030b5:	75 c5                	jne    10307c <memcmp+0x18>
    }
    return 0;
  1030b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1030bc:	c9                   	leave  
  1030bd:	c3                   	ret    

001030be <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  1030be:	f3 0f 1e fb          	endbr32 
  1030c2:	55                   	push   %ebp
  1030c3:	89 e5                	mov    %esp,%ebp
  1030c5:	83 ec 58             	sub    $0x58,%esp
  1030c8:	8b 45 10             	mov    0x10(%ebp),%eax
  1030cb:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1030ce:	8b 45 14             	mov    0x14(%ebp),%eax
  1030d1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  1030d4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1030d7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1030da:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1030dd:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  1030e0:	8b 45 18             	mov    0x18(%ebp),%eax
  1030e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1030e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1030e9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1030ec:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1030ef:	89 55 f0             	mov    %edx,-0x10(%ebp)
  1030f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1030f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1030f8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1030fc:	74 1c                	je     10311a <printnum+0x5c>
  1030fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103101:	ba 00 00 00 00       	mov    $0x0,%edx
  103106:	f7 75 e4             	divl   -0x1c(%ebp)
  103109:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10310c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10310f:	ba 00 00 00 00       	mov    $0x0,%edx
  103114:	f7 75 e4             	divl   -0x1c(%ebp)
  103117:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10311a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10311d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103120:	f7 75 e4             	divl   -0x1c(%ebp)
  103123:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103126:	89 55 dc             	mov    %edx,-0x24(%ebp)
  103129:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10312c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10312f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103132:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103135:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103138:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  10313b:	8b 45 18             	mov    0x18(%ebp),%eax
  10313e:	ba 00 00 00 00       	mov    $0x0,%edx
  103143:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  103146:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  103149:	19 d1                	sbb    %edx,%ecx
  10314b:	72 4c                	jb     103199 <printnum+0xdb>
        printnum(putch, putdat, result, base, width - 1, padc);
  10314d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  103150:	8d 50 ff             	lea    -0x1(%eax),%edx
  103153:	8b 45 20             	mov    0x20(%ebp),%eax
  103156:	89 44 24 18          	mov    %eax,0x18(%esp)
  10315a:	89 54 24 14          	mov    %edx,0x14(%esp)
  10315e:	8b 45 18             	mov    0x18(%ebp),%eax
  103161:	89 44 24 10          	mov    %eax,0x10(%esp)
  103165:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103168:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10316b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10316f:	89 54 24 0c          	mov    %edx,0xc(%esp)
  103173:	8b 45 0c             	mov    0xc(%ebp),%eax
  103176:	89 44 24 04          	mov    %eax,0x4(%esp)
  10317a:	8b 45 08             	mov    0x8(%ebp),%eax
  10317d:	89 04 24             	mov    %eax,(%esp)
  103180:	e8 39 ff ff ff       	call   1030be <printnum>
  103185:	eb 1b                	jmp    1031a2 <printnum+0xe4>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  103187:	8b 45 0c             	mov    0xc(%ebp),%eax
  10318a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10318e:	8b 45 20             	mov    0x20(%ebp),%eax
  103191:	89 04 24             	mov    %eax,(%esp)
  103194:	8b 45 08             	mov    0x8(%ebp),%eax
  103197:	ff d0                	call   *%eax
        while (-- width > 0)
  103199:	ff 4d 1c             	decl   0x1c(%ebp)
  10319c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  1031a0:	7f e5                	jg     103187 <printnum+0xc9>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  1031a2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1031a5:	05 f0 3e 10 00       	add    $0x103ef0,%eax
  1031aa:	0f b6 00             	movzbl (%eax),%eax
  1031ad:	0f be c0             	movsbl %al,%eax
  1031b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  1031b3:	89 54 24 04          	mov    %edx,0x4(%esp)
  1031b7:	89 04 24             	mov    %eax,(%esp)
  1031ba:	8b 45 08             	mov    0x8(%ebp),%eax
  1031bd:	ff d0                	call   *%eax
}
  1031bf:	90                   	nop
  1031c0:	c9                   	leave  
  1031c1:	c3                   	ret    

001031c2 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  1031c2:	f3 0f 1e fb          	endbr32 
  1031c6:	55                   	push   %ebp
  1031c7:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  1031c9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1031cd:	7e 14                	jle    1031e3 <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  1031cf:	8b 45 08             	mov    0x8(%ebp),%eax
  1031d2:	8b 00                	mov    (%eax),%eax
  1031d4:	8d 48 08             	lea    0x8(%eax),%ecx
  1031d7:	8b 55 08             	mov    0x8(%ebp),%edx
  1031da:	89 0a                	mov    %ecx,(%edx)
  1031dc:	8b 50 04             	mov    0x4(%eax),%edx
  1031df:	8b 00                	mov    (%eax),%eax
  1031e1:	eb 30                	jmp    103213 <getuint+0x51>
    }
    else if (lflag) {
  1031e3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1031e7:	74 16                	je     1031ff <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  1031e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1031ec:	8b 00                	mov    (%eax),%eax
  1031ee:	8d 48 04             	lea    0x4(%eax),%ecx
  1031f1:	8b 55 08             	mov    0x8(%ebp),%edx
  1031f4:	89 0a                	mov    %ecx,(%edx)
  1031f6:	8b 00                	mov    (%eax),%eax
  1031f8:	ba 00 00 00 00       	mov    $0x0,%edx
  1031fd:	eb 14                	jmp    103213 <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  1031ff:	8b 45 08             	mov    0x8(%ebp),%eax
  103202:	8b 00                	mov    (%eax),%eax
  103204:	8d 48 04             	lea    0x4(%eax),%ecx
  103207:	8b 55 08             	mov    0x8(%ebp),%edx
  10320a:	89 0a                	mov    %ecx,(%edx)
  10320c:	8b 00                	mov    (%eax),%eax
  10320e:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  103213:	5d                   	pop    %ebp
  103214:	c3                   	ret    

00103215 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  103215:	f3 0f 1e fb          	endbr32 
  103219:	55                   	push   %ebp
  10321a:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  10321c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103220:	7e 14                	jle    103236 <getint+0x21>
        return va_arg(*ap, long long);
  103222:	8b 45 08             	mov    0x8(%ebp),%eax
  103225:	8b 00                	mov    (%eax),%eax
  103227:	8d 48 08             	lea    0x8(%eax),%ecx
  10322a:	8b 55 08             	mov    0x8(%ebp),%edx
  10322d:	89 0a                	mov    %ecx,(%edx)
  10322f:	8b 50 04             	mov    0x4(%eax),%edx
  103232:	8b 00                	mov    (%eax),%eax
  103234:	eb 28                	jmp    10325e <getint+0x49>
    }
    else if (lflag) {
  103236:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10323a:	74 12                	je     10324e <getint+0x39>
        return va_arg(*ap, long);
  10323c:	8b 45 08             	mov    0x8(%ebp),%eax
  10323f:	8b 00                	mov    (%eax),%eax
  103241:	8d 48 04             	lea    0x4(%eax),%ecx
  103244:	8b 55 08             	mov    0x8(%ebp),%edx
  103247:	89 0a                	mov    %ecx,(%edx)
  103249:	8b 00                	mov    (%eax),%eax
  10324b:	99                   	cltd   
  10324c:	eb 10                	jmp    10325e <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  10324e:	8b 45 08             	mov    0x8(%ebp),%eax
  103251:	8b 00                	mov    (%eax),%eax
  103253:	8d 48 04             	lea    0x4(%eax),%ecx
  103256:	8b 55 08             	mov    0x8(%ebp),%edx
  103259:	89 0a                	mov    %ecx,(%edx)
  10325b:	8b 00                	mov    (%eax),%eax
  10325d:	99                   	cltd   
    }
}
  10325e:	5d                   	pop    %ebp
  10325f:	c3                   	ret    

00103260 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  103260:	f3 0f 1e fb          	endbr32 
  103264:	55                   	push   %ebp
  103265:	89 e5                	mov    %esp,%ebp
  103267:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  10326a:	8d 45 14             	lea    0x14(%ebp),%eax
  10326d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  103270:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103273:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103277:	8b 45 10             	mov    0x10(%ebp),%eax
  10327a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10327e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103281:	89 44 24 04          	mov    %eax,0x4(%esp)
  103285:	8b 45 08             	mov    0x8(%ebp),%eax
  103288:	89 04 24             	mov    %eax,(%esp)
  10328b:	e8 03 00 00 00       	call   103293 <vprintfmt>
    va_end(ap);
}
  103290:	90                   	nop
  103291:	c9                   	leave  
  103292:	c3                   	ret    

00103293 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  103293:	f3 0f 1e fb          	endbr32 
  103297:	55                   	push   %ebp
  103298:	89 e5                	mov    %esp,%ebp
  10329a:	56                   	push   %esi
  10329b:	53                   	push   %ebx
  10329c:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10329f:	eb 17                	jmp    1032b8 <vprintfmt+0x25>
            if (ch == '\0') {
  1032a1:	85 db                	test   %ebx,%ebx
  1032a3:	0f 84 c0 03 00 00    	je     103669 <vprintfmt+0x3d6>
                return;
            }
            putch(ch, putdat);
  1032a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  1032b0:	89 1c 24             	mov    %ebx,(%esp)
  1032b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1032b6:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  1032b8:	8b 45 10             	mov    0x10(%ebp),%eax
  1032bb:	8d 50 01             	lea    0x1(%eax),%edx
  1032be:	89 55 10             	mov    %edx,0x10(%ebp)
  1032c1:	0f b6 00             	movzbl (%eax),%eax
  1032c4:	0f b6 d8             	movzbl %al,%ebx
  1032c7:	83 fb 25             	cmp    $0x25,%ebx
  1032ca:	75 d5                	jne    1032a1 <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  1032cc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  1032d0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  1032d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1032da:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  1032dd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  1032e4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1032e7:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  1032ea:	8b 45 10             	mov    0x10(%ebp),%eax
  1032ed:	8d 50 01             	lea    0x1(%eax),%edx
  1032f0:	89 55 10             	mov    %edx,0x10(%ebp)
  1032f3:	0f b6 00             	movzbl (%eax),%eax
  1032f6:	0f b6 d8             	movzbl %al,%ebx
  1032f9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  1032fc:	83 f8 55             	cmp    $0x55,%eax
  1032ff:	0f 87 38 03 00 00    	ja     10363d <vprintfmt+0x3aa>
  103305:	8b 04 85 14 3f 10 00 	mov    0x103f14(,%eax,4),%eax
  10330c:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  10330f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  103313:	eb d5                	jmp    1032ea <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  103315:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  103319:	eb cf                	jmp    1032ea <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  10331b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  103322:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  103325:	89 d0                	mov    %edx,%eax
  103327:	c1 e0 02             	shl    $0x2,%eax
  10332a:	01 d0                	add    %edx,%eax
  10332c:	01 c0                	add    %eax,%eax
  10332e:	01 d8                	add    %ebx,%eax
  103330:	83 e8 30             	sub    $0x30,%eax
  103333:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  103336:	8b 45 10             	mov    0x10(%ebp),%eax
  103339:	0f b6 00             	movzbl (%eax),%eax
  10333c:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  10333f:	83 fb 2f             	cmp    $0x2f,%ebx
  103342:	7e 38                	jle    10337c <vprintfmt+0xe9>
  103344:	83 fb 39             	cmp    $0x39,%ebx
  103347:	7f 33                	jg     10337c <vprintfmt+0xe9>
            for (precision = 0; ; ++ fmt) {
  103349:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
  10334c:	eb d4                	jmp    103322 <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  10334e:	8b 45 14             	mov    0x14(%ebp),%eax
  103351:	8d 50 04             	lea    0x4(%eax),%edx
  103354:	89 55 14             	mov    %edx,0x14(%ebp)
  103357:	8b 00                	mov    (%eax),%eax
  103359:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  10335c:	eb 1f                	jmp    10337d <vprintfmt+0xea>

        case '.':
            if (width < 0)
  10335e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103362:	79 86                	jns    1032ea <vprintfmt+0x57>
                width = 0;
  103364:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  10336b:	e9 7a ff ff ff       	jmp    1032ea <vprintfmt+0x57>

        case '#':
            altflag = 1;
  103370:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  103377:	e9 6e ff ff ff       	jmp    1032ea <vprintfmt+0x57>
            goto process_precision;
  10337c:	90                   	nop

        process_precision:
            if (width < 0)
  10337d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103381:	0f 89 63 ff ff ff    	jns    1032ea <vprintfmt+0x57>
                width = precision, precision = -1;
  103387:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10338a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10338d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  103394:	e9 51 ff ff ff       	jmp    1032ea <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  103399:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
  10339c:	e9 49 ff ff ff       	jmp    1032ea <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  1033a1:	8b 45 14             	mov    0x14(%ebp),%eax
  1033a4:	8d 50 04             	lea    0x4(%eax),%edx
  1033a7:	89 55 14             	mov    %edx,0x14(%ebp)
  1033aa:	8b 00                	mov    (%eax),%eax
  1033ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  1033af:	89 54 24 04          	mov    %edx,0x4(%esp)
  1033b3:	89 04 24             	mov    %eax,(%esp)
  1033b6:	8b 45 08             	mov    0x8(%ebp),%eax
  1033b9:	ff d0                	call   *%eax
            break;
  1033bb:	e9 a4 02 00 00       	jmp    103664 <vprintfmt+0x3d1>

        // error message
        case 'e':
            err = va_arg(ap, int);
  1033c0:	8b 45 14             	mov    0x14(%ebp),%eax
  1033c3:	8d 50 04             	lea    0x4(%eax),%edx
  1033c6:	89 55 14             	mov    %edx,0x14(%ebp)
  1033c9:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  1033cb:	85 db                	test   %ebx,%ebx
  1033cd:	79 02                	jns    1033d1 <vprintfmt+0x13e>
                err = -err;
  1033cf:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  1033d1:	83 fb 06             	cmp    $0x6,%ebx
  1033d4:	7f 0b                	jg     1033e1 <vprintfmt+0x14e>
  1033d6:	8b 34 9d d4 3e 10 00 	mov    0x103ed4(,%ebx,4),%esi
  1033dd:	85 f6                	test   %esi,%esi
  1033df:	75 23                	jne    103404 <vprintfmt+0x171>
                printfmt(putch, putdat, "error %d", err);
  1033e1:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1033e5:	c7 44 24 08 01 3f 10 	movl   $0x103f01,0x8(%esp)
  1033ec:	00 
  1033ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1033f7:	89 04 24             	mov    %eax,(%esp)
  1033fa:	e8 61 fe ff ff       	call   103260 <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  1033ff:	e9 60 02 00 00       	jmp    103664 <vprintfmt+0x3d1>
                printfmt(putch, putdat, "%s", p);
  103404:	89 74 24 0c          	mov    %esi,0xc(%esp)
  103408:	c7 44 24 08 0a 3f 10 	movl   $0x103f0a,0x8(%esp)
  10340f:	00 
  103410:	8b 45 0c             	mov    0xc(%ebp),%eax
  103413:	89 44 24 04          	mov    %eax,0x4(%esp)
  103417:	8b 45 08             	mov    0x8(%ebp),%eax
  10341a:	89 04 24             	mov    %eax,(%esp)
  10341d:	e8 3e fe ff ff       	call   103260 <printfmt>
            break;
  103422:	e9 3d 02 00 00       	jmp    103664 <vprintfmt+0x3d1>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  103427:	8b 45 14             	mov    0x14(%ebp),%eax
  10342a:	8d 50 04             	lea    0x4(%eax),%edx
  10342d:	89 55 14             	mov    %edx,0x14(%ebp)
  103430:	8b 30                	mov    (%eax),%esi
  103432:	85 f6                	test   %esi,%esi
  103434:	75 05                	jne    10343b <vprintfmt+0x1a8>
                p = "(null)";
  103436:	be 0d 3f 10 00       	mov    $0x103f0d,%esi
            }
            if (width > 0 && padc != '-') {
  10343b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10343f:	7e 76                	jle    1034b7 <vprintfmt+0x224>
  103441:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  103445:	74 70                	je     1034b7 <vprintfmt+0x224>
                for (width -= strnlen(p, precision); width > 0; width --) {
  103447:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10344a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10344e:	89 34 24             	mov    %esi,(%esp)
  103451:	e8 ba f7 ff ff       	call   102c10 <strnlen>
  103456:	8b 55 e8             	mov    -0x18(%ebp),%edx
  103459:	29 c2                	sub    %eax,%edx
  10345b:	89 d0                	mov    %edx,%eax
  10345d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103460:	eb 16                	jmp    103478 <vprintfmt+0x1e5>
                    putch(padc, putdat);
  103462:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  103466:	8b 55 0c             	mov    0xc(%ebp),%edx
  103469:	89 54 24 04          	mov    %edx,0x4(%esp)
  10346d:	89 04 24             	mov    %eax,(%esp)
  103470:	8b 45 08             	mov    0x8(%ebp),%eax
  103473:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  103475:	ff 4d e8             	decl   -0x18(%ebp)
  103478:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10347c:	7f e4                	jg     103462 <vprintfmt+0x1cf>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  10347e:	eb 37                	jmp    1034b7 <vprintfmt+0x224>
                if (altflag && (ch < ' ' || ch > '~')) {
  103480:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  103484:	74 1f                	je     1034a5 <vprintfmt+0x212>
  103486:	83 fb 1f             	cmp    $0x1f,%ebx
  103489:	7e 05                	jle    103490 <vprintfmt+0x1fd>
  10348b:	83 fb 7e             	cmp    $0x7e,%ebx
  10348e:	7e 15                	jle    1034a5 <vprintfmt+0x212>
                    putch('?', putdat);
  103490:	8b 45 0c             	mov    0xc(%ebp),%eax
  103493:	89 44 24 04          	mov    %eax,0x4(%esp)
  103497:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  10349e:	8b 45 08             	mov    0x8(%ebp),%eax
  1034a1:	ff d0                	call   *%eax
  1034a3:	eb 0f                	jmp    1034b4 <vprintfmt+0x221>
                }
                else {
                    putch(ch, putdat);
  1034a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034a8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034ac:	89 1c 24             	mov    %ebx,(%esp)
  1034af:	8b 45 08             	mov    0x8(%ebp),%eax
  1034b2:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1034b4:	ff 4d e8             	decl   -0x18(%ebp)
  1034b7:	89 f0                	mov    %esi,%eax
  1034b9:	8d 70 01             	lea    0x1(%eax),%esi
  1034bc:	0f b6 00             	movzbl (%eax),%eax
  1034bf:	0f be d8             	movsbl %al,%ebx
  1034c2:	85 db                	test   %ebx,%ebx
  1034c4:	74 27                	je     1034ed <vprintfmt+0x25a>
  1034c6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  1034ca:	78 b4                	js     103480 <vprintfmt+0x1ed>
  1034cc:	ff 4d e4             	decl   -0x1c(%ebp)
  1034cf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  1034d3:	79 ab                	jns    103480 <vprintfmt+0x1ed>
                }
            }
            for (; width > 0; width --) {
  1034d5:	eb 16                	jmp    1034ed <vprintfmt+0x25a>
                putch(' ', putdat);
  1034d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034de:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1034e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1034e8:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  1034ea:	ff 4d e8             	decl   -0x18(%ebp)
  1034ed:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1034f1:	7f e4                	jg     1034d7 <vprintfmt+0x244>
            }
            break;
  1034f3:	e9 6c 01 00 00       	jmp    103664 <vprintfmt+0x3d1>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  1034f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034fb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034ff:	8d 45 14             	lea    0x14(%ebp),%eax
  103502:	89 04 24             	mov    %eax,(%esp)
  103505:	e8 0b fd ff ff       	call   103215 <getint>
  10350a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10350d:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  103510:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103513:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103516:	85 d2                	test   %edx,%edx
  103518:	79 26                	jns    103540 <vprintfmt+0x2ad>
                putch('-', putdat);
  10351a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10351d:	89 44 24 04          	mov    %eax,0x4(%esp)
  103521:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  103528:	8b 45 08             	mov    0x8(%ebp),%eax
  10352b:	ff d0                	call   *%eax
                num = -(long long)num;
  10352d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103530:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103533:	f7 d8                	neg    %eax
  103535:	83 d2 00             	adc    $0x0,%edx
  103538:	f7 da                	neg    %edx
  10353a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10353d:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  103540:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  103547:	e9 a8 00 00 00       	jmp    1035f4 <vprintfmt+0x361>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  10354c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10354f:	89 44 24 04          	mov    %eax,0x4(%esp)
  103553:	8d 45 14             	lea    0x14(%ebp),%eax
  103556:	89 04 24             	mov    %eax,(%esp)
  103559:	e8 64 fc ff ff       	call   1031c2 <getuint>
  10355e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103561:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  103564:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  10356b:	e9 84 00 00 00       	jmp    1035f4 <vprintfmt+0x361>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  103570:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103573:	89 44 24 04          	mov    %eax,0x4(%esp)
  103577:	8d 45 14             	lea    0x14(%ebp),%eax
  10357a:	89 04 24             	mov    %eax,(%esp)
  10357d:	e8 40 fc ff ff       	call   1031c2 <getuint>
  103582:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103585:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  103588:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  10358f:	eb 63                	jmp    1035f4 <vprintfmt+0x361>

        // pointer
        case 'p':
            putch('0', putdat);
  103591:	8b 45 0c             	mov    0xc(%ebp),%eax
  103594:	89 44 24 04          	mov    %eax,0x4(%esp)
  103598:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  10359f:	8b 45 08             	mov    0x8(%ebp),%eax
  1035a2:	ff d0                	call   *%eax
            putch('x', putdat);
  1035a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035a7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035ab:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  1035b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1035b5:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  1035b7:	8b 45 14             	mov    0x14(%ebp),%eax
  1035ba:	8d 50 04             	lea    0x4(%eax),%edx
  1035bd:	89 55 14             	mov    %edx,0x14(%ebp)
  1035c0:	8b 00                	mov    (%eax),%eax
  1035c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1035c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  1035cc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  1035d3:	eb 1f                	jmp    1035f4 <vprintfmt+0x361>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  1035d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1035d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035dc:	8d 45 14             	lea    0x14(%ebp),%eax
  1035df:	89 04 24             	mov    %eax,(%esp)
  1035e2:	e8 db fb ff ff       	call   1031c2 <getuint>
  1035e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1035ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  1035ed:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  1035f4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  1035f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1035fb:	89 54 24 18          	mov    %edx,0x18(%esp)
  1035ff:	8b 55 e8             	mov    -0x18(%ebp),%edx
  103602:	89 54 24 14          	mov    %edx,0x14(%esp)
  103606:	89 44 24 10          	mov    %eax,0x10(%esp)
  10360a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10360d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103610:	89 44 24 08          	mov    %eax,0x8(%esp)
  103614:	89 54 24 0c          	mov    %edx,0xc(%esp)
  103618:	8b 45 0c             	mov    0xc(%ebp),%eax
  10361b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10361f:	8b 45 08             	mov    0x8(%ebp),%eax
  103622:	89 04 24             	mov    %eax,(%esp)
  103625:	e8 94 fa ff ff       	call   1030be <printnum>
            break;
  10362a:	eb 38                	jmp    103664 <vprintfmt+0x3d1>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  10362c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10362f:	89 44 24 04          	mov    %eax,0x4(%esp)
  103633:	89 1c 24             	mov    %ebx,(%esp)
  103636:	8b 45 08             	mov    0x8(%ebp),%eax
  103639:	ff d0                	call   *%eax
            break;
  10363b:	eb 27                	jmp    103664 <vprintfmt+0x3d1>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  10363d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103640:	89 44 24 04          	mov    %eax,0x4(%esp)
  103644:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  10364b:	8b 45 08             	mov    0x8(%ebp),%eax
  10364e:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  103650:	ff 4d 10             	decl   0x10(%ebp)
  103653:	eb 03                	jmp    103658 <vprintfmt+0x3c5>
  103655:	ff 4d 10             	decl   0x10(%ebp)
  103658:	8b 45 10             	mov    0x10(%ebp),%eax
  10365b:	48                   	dec    %eax
  10365c:	0f b6 00             	movzbl (%eax),%eax
  10365f:	3c 25                	cmp    $0x25,%al
  103661:	75 f2                	jne    103655 <vprintfmt+0x3c2>
                /* do nothing */;
            break;
  103663:	90                   	nop
    while (1) {
  103664:	e9 36 fc ff ff       	jmp    10329f <vprintfmt+0xc>
                return;
  103669:	90                   	nop
        }
    }
}
  10366a:	83 c4 40             	add    $0x40,%esp
  10366d:	5b                   	pop    %ebx
  10366e:	5e                   	pop    %esi
  10366f:	5d                   	pop    %ebp
  103670:	c3                   	ret    

00103671 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  103671:	f3 0f 1e fb          	endbr32 
  103675:	55                   	push   %ebp
  103676:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  103678:	8b 45 0c             	mov    0xc(%ebp),%eax
  10367b:	8b 40 08             	mov    0x8(%eax),%eax
  10367e:	8d 50 01             	lea    0x1(%eax),%edx
  103681:	8b 45 0c             	mov    0xc(%ebp),%eax
  103684:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  103687:	8b 45 0c             	mov    0xc(%ebp),%eax
  10368a:	8b 10                	mov    (%eax),%edx
  10368c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10368f:	8b 40 04             	mov    0x4(%eax),%eax
  103692:	39 c2                	cmp    %eax,%edx
  103694:	73 12                	jae    1036a8 <sprintputch+0x37>
        *b->buf ++ = ch;
  103696:	8b 45 0c             	mov    0xc(%ebp),%eax
  103699:	8b 00                	mov    (%eax),%eax
  10369b:	8d 48 01             	lea    0x1(%eax),%ecx
  10369e:	8b 55 0c             	mov    0xc(%ebp),%edx
  1036a1:	89 0a                	mov    %ecx,(%edx)
  1036a3:	8b 55 08             	mov    0x8(%ebp),%edx
  1036a6:	88 10                	mov    %dl,(%eax)
    }
}
  1036a8:	90                   	nop
  1036a9:	5d                   	pop    %ebp
  1036aa:	c3                   	ret    

001036ab <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  1036ab:	f3 0f 1e fb          	endbr32 
  1036af:	55                   	push   %ebp
  1036b0:	89 e5                	mov    %esp,%ebp
  1036b2:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  1036b5:	8d 45 14             	lea    0x14(%ebp),%eax
  1036b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  1036bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1036be:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1036c2:	8b 45 10             	mov    0x10(%ebp),%eax
  1036c5:	89 44 24 08          	mov    %eax,0x8(%esp)
  1036c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1036cc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1036d0:	8b 45 08             	mov    0x8(%ebp),%eax
  1036d3:	89 04 24             	mov    %eax,(%esp)
  1036d6:	e8 08 00 00 00       	call   1036e3 <vsnprintf>
  1036db:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1036de:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1036e1:	c9                   	leave  
  1036e2:	c3                   	ret    

001036e3 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  1036e3:	f3 0f 1e fb          	endbr32 
  1036e7:	55                   	push   %ebp
  1036e8:	89 e5                	mov    %esp,%ebp
  1036ea:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  1036ed:	8b 45 08             	mov    0x8(%ebp),%eax
  1036f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1036f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1036f6:	8d 50 ff             	lea    -0x1(%eax),%edx
  1036f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1036fc:	01 d0                	add    %edx,%eax
  1036fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103701:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103708:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10370c:	74 0a                	je     103718 <vsnprintf+0x35>
  10370e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103711:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103714:	39 c2                	cmp    %eax,%edx
  103716:	76 07                	jbe    10371f <vsnprintf+0x3c>
        return -E_INVAL;
  103718:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  10371d:	eb 2a                	jmp    103749 <vsnprintf+0x66>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  10371f:	8b 45 14             	mov    0x14(%ebp),%eax
  103722:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103726:	8b 45 10             	mov    0x10(%ebp),%eax
  103729:	89 44 24 08          	mov    %eax,0x8(%esp)
  10372d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  103730:	89 44 24 04          	mov    %eax,0x4(%esp)
  103734:	c7 04 24 71 36 10 00 	movl   $0x103671,(%esp)
  10373b:	e8 53 fb ff ff       	call   103293 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  103740:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103743:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  103746:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103749:	c9                   	leave  
  10374a:	c3                   	ret    
