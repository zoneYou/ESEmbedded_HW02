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


