HW02
===
This is the hw02 sample. Please follow the steps below.

# Build the Sample Program

1. Fork this repo to your own github account.

2. Clone the repo that you just forked.

3. Under the hw02 dir, use:

	* `make` to build.

	* `make clean` to clean the ouput files.

4. Extract `gnu-mcu-eclipse-qemu.zip` into hw02 dir. Under the path of hw02, start emulation with `make qemu`.

	See [Lecture 02 ─ Emulation with QEMU] for more details.

5. The sample is designed to help you to distinguish the main difference between the `b` and the `bl` instructions.  

	See [ESEmbedded_HW02_Example] for knowing how to do the observation and how to use markdown for taking notes.

# Build Your Own Program

1. Edit main.s.

2. Make and run like the steps above.

# HW02 Requirements

1. Please modify main.s to observe the `push` and the `pop` instructions:  

	Does the order of the registers in the `push` and the `pop` instructions affect the excution results?  

	For example, will `push {r0, r1, r2}` and `push {r2, r0, r1}` act in the same way?  

	Which register will be pushed into the stack first?

2. You have to state how you designed the observation (code), and how you performed it.  

	Just like how [ESEmbedded_HW02_Example] did.

3. If there are any official data that define the rules, you can also use them as references.

4. Push your repo to your github. (Use .gitignore to exclude the output files like object files or executable files and the qemu bin folder)

[Lecture 02 ─ Emulation with QEMU]: http://www.nc.es.ncku.edu.tw/course/embedded/02/#Emulation-with-QEMU
[ESEmbedded_HW02_Example]: https://github.com/vwxyzjimmy/ESEmbedded_HW02_Example

--------------------

- [ ] **If you volunteer to give the presentation next week, check this.**

--------------------

Please take your note here.


HW02
===
## 1.實驗題目
觀察`push{r0,r1,r2}`,`pop{r0,r1,r2}`指令差異。
## 2.實驗步驟
1. 設計測試程式main.s，從`_start`開始,往`r0``r1``r2`丟值，在執行指令，並在最後回去`_start`，多次執行觀察記憶體堆疊狀態，如下面程式所示。

main.s:

```assembly
.syntax unified

.word 0x20000100
.word _start

.global _start
.type _start, %function
_start:

	mov r0,#0
	mov r1,#1
	mov r2,#2
	//
	push 	{r2}
	push	{r1}
	push	{r0}
	push	{r0,r1,r2}
	push	{r2,r0,r1}
	//
	pop	{r0}
	pop	{r2}
	pop	{r1}
	
	pop	{r0,r1,r2}
	pop 	{r2,r0,r1}
	//
	nop

	//
	//branch w/o link
	//
	b	label01

label01:
	nop

	//
	//branch w/ link
	//
	bl	sleep

sleep:
	nop
	b	_start
```

2. 將 main.s 編譯並以 qemu 模擬， `$ make clean`, `$ make`, `$ make qemu`
開啟另一 Terminal 連線 `$ arm-none-eabi-gdb` ，再輸入 `target remote localhost:1234` 連接，輸入兩次的 `ctrl + x` 再輸入 `2`, 開啟 Register 以及指令，並且輸入 `si` 單步執行觀察。
在使用qemu模擬時發現,程式輸入`r0``r1``r2`順序,在模擬內都會被按照順序排列。

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/1.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/2.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/3.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/4.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/5.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/6.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/7.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/8.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/9.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/10.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/11.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/12.jpg)

![](https://github.com/zoneYou/ESEmbedded_HW02/img_HW02/13.jpg)


## 3. 結果與討論
1. 使用`push`指令會發現每次記憶體單元位址會按照順序遞減,也就是說使用此指令會按照順序根據記憶體位置堆疊寫資料。
2. 使用`pop`指令與`push`指令相反,會根據每次使用記憶體單元按照順序遞增,也就表示會從堆疊中讀取數據。
3. github的圖檔如顯示不出會放在img_HW02,遇到了一點使用障礙。 


