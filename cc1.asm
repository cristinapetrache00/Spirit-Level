
;CodeVisionAVR C Compiler V2.05.0 Professional
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega164A
;Program type             : Application
;Clock frequency          : 20,000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 256 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : No
;'char' is unsigned       : No
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega164A
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1279
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E
	.EQU GPIOR1=0x2A
	.EQU GPIOR2=0x2B

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x04FF
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _rx_wr_index0=R3
	.DEF _rx_rd_index0=R2
	.DEF _rx_counter0=R5
	.DEF _tx_wr_index0=R4
	.DEF _tx_rd_index0=R7
	.DEF _tx_counter0=R6

;GPIOR0-GPIOR2 INITIALIZATION VALUES
	.EQU __GPIOR0_INIT=0x00
	.EQU __GPIOR1_INIT=0x00
	.EQU __GPIOR2_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer1_compa_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart0_rx_isr
	JMP  0x00
	JMP  _usart0_tx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x2040060:
	.DB  0x1
_0x2040000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  __seed_G102
	.DW  _0x2040060*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	;__GPIOR1_INIT = __GPIOR0_INIT
	OUT  GPIOR1,R30
	;__GPIOR2_INIT = __GPIOR0_INIT
	OUT  GPIOR2,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0
	.DB  0 ; FIRST EEPROM LOCATION NOT USED, SEE ATMEL ERRATA SHEETS

	.DSEG
	.ORG 0x200

	.CSEG
;/*********************************************
;Project : Test software
;**********************************************
;Chip type: ATmega164A
;Clock frequency: 20 MHz
;Compilers:  CVAVR 2.x
;*********************************************/
;
;#include <mega164a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;
;#include <stdio.h>
;#include <delay.h>
;#include <string.h>
;#include <stdlib.h>
;#include <stdint.h>
;#include "defs.h"
;
;//*************************************************************************************************
;//*********** BEGIN SERIAL STUFF (interrupt-driven, generated by Code Wizard) *********************
;//*************************************************************************************************
;
;#ifndef RXB8
;#define RXB8 1
;#endif
;
;#ifndef TXB8
;#define TXB8 0
;#endif
;
;#ifndef UPE
;#define UPE 2
;#endif
;
;#ifndef DOR
;#define DOR 3
;#endif
;
;#ifndef FE
;#define FE 4
;#endif
;
;#ifndef UDRE
;#define UDRE 5
;#endif
;
;#ifndef RXC
;#define RXC 7
;#endif
;
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;
;// USART0 Receiver buffer
;#define RX_BUFFER_SIZE0 8
;char rx_buffer0[RX_BUFFER_SIZE0];
;
;#if RX_BUFFER_SIZE0 <= 256
;unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
;#else
;unsigned int rx_wr_index0,rx_rd_index0,rx_counter0;
;#endif
;
;// This flag is set on USART0 Receiver buffer overflow
;bit rx_buffer_overflow0;
;
;// USART0 Receiver interrupt service routine
;interrupt [USART0_RXC] void usart0_rx_isr(void)
; 0000 0047 {

	.CSEG
_usart0_rx_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0048 char status,data;
; 0000 0049 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	LDS  R17,192
; 0000 004A data=UDR0;
	LDS  R16,198
; 0000 004B if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x3
; 0000 004C    {
; 0000 004D    rx_buffer0[rx_wr_index0++]=data;
	MOV  R30,R3
	INC  R3
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	ST   Z,R16
; 0000 004E #if RX_BUFFER_SIZE0 == 256
; 0000 004F    // special case for receiver buffer size=256
; 0000 0050    if (++rx_counter0 == 0) rx_buffer_overflow0=1;
; 0000 0051 #else
; 0000 0052    if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
	LDI  R30,LOW(8)
	CP   R30,R3
	BRNE _0x4
	CLR  R3
; 0000 0053    if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x4:
	INC  R5
	LDI  R30,LOW(8)
	CP   R30,R5
	BRNE _0x5
; 0000 0054       {
; 0000 0055       rx_counter0=0;
	CLR  R5
; 0000 0056       rx_buffer_overflow0=1;
	SBI  0x1E,0
; 0000 0057       }
; 0000 0058 #endif
; 0000 0059    }
_0x5:
; 0000 005A }
_0x3:
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0xFC
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART0 Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0000 0061 {
; 0000 0062 char data;
; 0000 0063 while (rx_counter0==0);
;	data -> R17
; 0000 0064 data=rx_buffer0[rx_rd_index0++];
; 0000 0065 #if RX_BUFFER_SIZE0 != 256
; 0000 0066 if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
; 0000 0067 #endif
; 0000 0068 #asm("cli")
; 0000 0069 --rx_counter0;
; 0000 006A #asm("sei")
; 0000 006B return data;
; 0000 006C }
;#pragma used-
;#endif
;
;// USART0 Transmitter buffer
;#define TX_BUFFER_SIZE0 8
;char tx_buffer0[TX_BUFFER_SIZE0];
;
;#if TX_BUFFER_SIZE0 <= 256
;unsigned char tx_wr_index0,tx_rd_index0,tx_counter0;
;#else
;unsigned int tx_wr_index0,tx_rd_index0,tx_counter0;
;#endif
;
;// USART0 Transmitter interrupt service routine
;interrupt [USART0_TXC] void usart0_tx_isr(void)
; 0000 007C {
_usart0_tx_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 007D if (tx_counter0)
	TST  R6
	BREQ _0xC
; 0000 007E    {
; 0000 007F    --tx_counter0;
	DEC  R6
; 0000 0080    UDR0=tx_buffer0[tx_rd_index0++];
	MOV  R30,R7
	INC  R7
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer0)
	SBCI R31,HIGH(-_tx_buffer0)
	LD   R30,Z
	STS  198,R30
; 0000 0081 #if TX_BUFFER_SIZE0 != 256
; 0000 0082    if (tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
	LDI  R30,LOW(8)
	CP   R30,R7
	BRNE _0xD
	CLR  R7
; 0000 0083 #endif
; 0000 0084    }
_0xD:
; 0000 0085 }
_0xC:
_0xFC:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Write a character to the USART0 Transmitter buffer
;#define _ALTERNATE_PUTCHAR_
;#pragma used+
;void putchar(char c)
; 0000 008C {
; 0000 008D while (tx_counter0 == TX_BUFFER_SIZE0);
;	c -> Y+0
; 0000 008E #asm("cli")
; 0000 008F if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
; 0000 0090    {
; 0000 0091    tx_buffer0[tx_wr_index0++]=c;
; 0000 0092 #if TX_BUFFER_SIZE0 != 256
; 0000 0093    if (tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
; 0000 0094 #endif
; 0000 0095    ++tx_counter0;
; 0000 0096    }
; 0000 0097 else
; 0000 0098    UDR0=c;
; 0000 0099 #asm("sei")
; 0000 009A }
;#pragma used-
;#endif
;//*************************************************************************************************
;//********************END SERIAL STUFF (USART0)  **************************************************
;//*************************************************************************************************
;//*******   if you need USART1, enable it in Code Wizard and copy coresponding code here  *********
;//*************************************************************************************************
;
;/*
; * Timer 1 Output Compare A interrupt is used to blink LED
; */
;interrupt [TIM1_COMPA] void timer1_compa_isr(void)
; 0000 00A7 {
_timer1_compa_isr:
; 0000 00A8 LED1 = ~LED1; // invert LED
	SBIS 0xB,6
	RJMP _0x16
	CBI  0xB,6
	RJMP _0x17
_0x16:
	SBI  0xB,6
_0x17:
; 0000 00A9 }
	RETI
;
;// Read the 8 most significant bits
;// of the AD conversion result
;unsigned char read_adc(unsigned char adc_input)
; 0000 00AE {
_read_adc:
; 0000 00AF ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
;	adc_input -> Y+0
	LD   R30,Y
	ORI  R30,LOW(0x60)
	STS  124,R30
; 0000 00B0 // Delay needed for the stabilization of the ADC input voltage
; 0000 00B1 delay_us(10);
	__DELAY_USB 67
; 0000 00B2 // Start the AD conversion
; 0000 00B3 ADCSRA|=0x40;
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
; 0000 00B4 // Wait for the AD conversion to complete
; 0000 00B5 while ((ADCSRA & 0x10)==0);
_0x18:
	LDS  R30,122
	ANDI R30,LOW(0x10)
	BREQ _0x18
; 0000 00B6 ADCSRA|=0x10;
	LDS  R30,122
	ORI  R30,0x10
	STS  122,R30
; 0000 00B7 return ADCH;
	LDS  R30,121
	ADIW R28,1
	RET
; 0000 00B8 }
;
;/*
; * main function of program
; */
;
;void main (void)
; 0000 00BF {
_main:
; 0000 00C0 int Axa_X;
; 0000 00C1 int Axa_Y;
; 0000 00C2 int axa = 1;
; 0000 00C3 
; 0000 00C4 	Init_initController();  // this must be the first "init" action/call!
;	Axa_X -> R16,R17
;	Axa_Y -> R18,R19
;	axa -> R20,R21
	__GETWRN 20,21,1
	RCALL _Init_initController
; 0000 00C5 	#asm("sei")             // enable interrupts
	sei
; 0000 00C6 	LED1 = 1;           	// initial state, will be changed by timer 1
	SBI  0xB,6
; 0000 00C7 
; 0000 00C8     //Wake pentru accelerometru
; 0000 00C9     PORTB.7 = 1;
	SBI  0x5,7
; 0000 00CA 
; 0000 00CB 	while(TRUE)
_0x1F:
; 0000 00CC 	{
; 0000 00CD         switch(axa)
	MOVW R30,R20
; 0000 00CE         {
; 0000 00CF          case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x25
; 0000 00D0          Axa_Y = read_adc(0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _read_adc
	MOV  R18,R30
	CLR  R19
; 0000 00D1          delay_ms(10);
	CALL SUBOPT_0x0
; 0000 00D2 
; 0000 00D3          //Cazul in care bolobocul este centrat pe axa Y
; 0000 00D4           if (Axa_Y > 100 && Axa_Y < 110) {
	__CPWRN 18,19,101
	BRLT _0x27
	__CPWRN 18,19,110
	BRLT _0x28
_0x27:
	RJMP _0x26
_0x28:
; 0000 00D5             //Aprind ledul alb din centru
; 0000 00D6             PORTC.7 = 1;
	SBI  0x8,7
; 0000 00D7 
; 0000 00D8             //Sting ledurile de pe axa Y
; 0000 00D9             PORTC.0 = 0;
	CBI  0x8,0
; 0000 00DA             PORTC.1 = 0;
	CBI  0x8,1
; 0000 00DB             PORTC.2 = 0;
	CBI  0x8,2
; 0000 00DC             PORTC.4 = 0;
	CBI  0x8,4
; 0000 00DD             PORTC.3 = 0;
	CBI  0x8,3
; 0000 00DE             PORTC.5 = 0;
	CBI  0x8,5
; 0000 00DF           }
; 0000 00E0           else PORTC.7 = 0;
	RJMP _0x37
_0x26:
	CBI  0x8,7
; 0000 00E1 
; 0000 00E2          //Cazul in care bolobocul este inclinat sub 30 de grade pe axa Y
; 0000 00E3          if (Axa_Y >= 110 && Axa_Y < 125) {
_0x37:
	__CPWRN 18,19,110
	BRLT _0x3B
	__CPWRN 18,19,125
	BRLT _0x3C
_0x3B:
	RJMP _0x3A
_0x3C:
; 0000 00E4             //Aprind ledul verde
; 0000 00E5             PORTC.2 = 1;
	SBI  0x8,2
; 0000 00E6 
; 0000 00E7             //Sting restul ledurilor de pe axa Y
; 0000 00E8             PORTC.0 = 0;
	CBI  0x8,0
; 0000 00E9             PORTC.1 = 0;
	CBI  0x8,1
; 0000 00EA             PORTC.3 = 0;
	CBI  0x8,3
; 0000 00EB             PORTC.4 = 0;
	CBI  0x8,4
; 0000 00EC             PORTC.5 = 0;
	CBI  0x8,5
; 0000 00ED          }
; 0000 00EE 
; 0000 00EF          if (Axa_Y >85 && Axa_Y <= 100) {
_0x3A:
	__CPWRN 18,19,86
	BRLT _0x4A
	__CPWRN 18,19,101
	BRLT _0x4B
_0x4A:
	RJMP _0x49
_0x4B:
; 0000 00F0             //Aprind ledul verde
; 0000 00F1             PORTC.3 = 1;
	SBI  0x8,3
; 0000 00F2 
; 0000 00F3             //Sting restul ledurilor de pe axa Y
; 0000 00F4             PORTC.0 = 0;
	CBI  0x8,0
; 0000 00F5             PORTC.1 = 0;
	CBI  0x8,1
; 0000 00F6             PORTC.2 = 0;
	CBI  0x8,2
; 0000 00F7             PORTC.4 = 0;
	CBI  0x8,4
; 0000 00F8             PORTC.5 = 0;
	CBI  0x8,5
; 0000 00F9          }
; 0000 00FA 
; 0000 00FB          //Cazul in care bolobocul este inclinat intre 30-45 de grade pe axa Y
; 0000 00FC          if (Axa_Y >= 125 && Axa_Y < 140) {
_0x49:
	__CPWRN 18,19,125
	BRLT _0x59
	__CPWRN 18,19,140
	BRLT _0x5A
_0x59:
	RJMP _0x58
_0x5A:
; 0000 00FD             //Aprind ledul galben
; 0000 00FE             PORTC.1 = 1;
	SBI  0x8,1
; 0000 00FF 
; 0000 0100             //Sting restul ledurilor de pe axa Y
; 0000 0101             PORTC.0 = 0;
	CBI  0x8,0
; 0000 0102             PORTC.2 = 0;
	CBI  0x8,2
; 0000 0103             PORTC.3 = 0;
	CBI  0x8,3
; 0000 0104             PORTC.4 = 0;
	CBI  0x8,4
; 0000 0105             PORTC.5 = 0;
	CBI  0x8,5
; 0000 0106          }
; 0000 0107 
; 0000 0108          if (Axa_Y > 70 && Axa_Y <= 85) {
_0x58:
	__CPWRN 18,19,71
	BRLT _0x68
	__CPWRN 18,19,86
	BRLT _0x69
_0x68:
	RJMP _0x67
_0x69:
; 0000 0109             //Aprind ledul galben
; 0000 010A             PORTC.4 = 1;
	SBI  0x8,4
; 0000 010B 
; 0000 010C             //Sting restul ledurilor de pe axa Y
; 0000 010D             PORTC.0 = 0;
	CBI  0x8,0
; 0000 010E             PORTC.1 = 0;
	CBI  0x8,1
; 0000 010F             PORTC.2 = 0;
	CBI  0x8,2
; 0000 0110             PORTC.3 = 0;
	CBI  0x8,3
; 0000 0111             PORTC.5 = 0;
	CBI  0x8,5
; 0000 0112          }
; 0000 0113 
; 0000 0114          //Cazul in care bolobocul este inclinat la peste 45 de grade pe axa Y
; 0000 0115          if (Axa_Y >= 140) {
_0x67:
	__CPWRN 18,19,140
	BRLT _0x76
; 0000 0116             //Aprind ledul rosu
; 0000 0117             PORTC.0 = 1;
	SBI  0x8,0
; 0000 0118 
; 0000 0119             //Sting restul ledurilor de pe axa Y
; 0000 011A             PORTC.1 = 0;
	CBI  0x8,1
; 0000 011B             PORTC.2 = 0;
	CBI  0x8,2
; 0000 011C             PORTC.3 = 0;
	CBI  0x8,3
; 0000 011D             PORTC.4 = 0;
	CBI  0x8,4
; 0000 011E             PORTC.5 = 0;
	CBI  0x8,5
; 0000 011F          }
; 0000 0120 
; 0000 0121          if (Axa_Y <= 70) {
_0x76:
	__CPWRN 18,19,71
	BRGE _0x83
; 0000 0122             //Aprind ledul rosu
; 0000 0123             PORTC.5 = 1;
	SBI  0x8,5
; 0000 0124 
; 0000 0125             //Sting restul ledurilor de pe axa Y
; 0000 0126             PORTC.0 = 0;
	CBI  0x8,0
; 0000 0127             PORTC.1 = 0;
	CBI  0x8,1
; 0000 0128             PORTC.2 = 0;
	CBI  0x8,2
; 0000 0129             PORTC.3 = 0;
	CBI  0x8,3
; 0000 012A             PORTC.4 = 0;
	CBI  0x8,4
; 0000 012B          }
; 0000 012C 
; 0000 012D          delay_ms(200);
_0x83:
	CALL SUBOPT_0x1
; 0000 012E          axa = 2;
	__GETWRN 20,21,2
; 0000 012F          break;
	RJMP _0x24
; 0000 0130 
; 0000 0131          case 2:
_0x25:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x24
; 0000 0132          Axa_X = read_adc(1);
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _read_adc
	MOV  R16,R30
	CLR  R17
; 0000 0133          delay_ms(10);
	CALL SUBOPT_0x0
; 0000 0134 
; 0000 0135          //Cazul in care bolobocul este centrat pe axa X
; 0000 0136 	    if (Axa_X > 90 && Axa_X < 100) {
	__CPWRN 16,17,91
	BRLT _0x92
	__CPWRN 16,17,100
	BRLT _0x93
_0x92:
	RJMP _0x91
_0x93:
; 0000 0137 	        //Aprind ledul alb din centru
; 0000 0138 	    	PORTC.7 = 1;
	SBI  0x8,7
; 0000 0139 
; 0000 013A 	    	//Sting ledurile de pe axa X
; 0000 013B 	    	PORTB.0 = 0;
	CALL SUBOPT_0x2
; 0000 013C 	    	PORTB.1 = 0;
; 0000 013D 	    	PORTB.2 = 0;
; 0000 013E 	    	PORTB.3 = 0;
; 0000 013F 	    	PORTB.4 = 0;
	CBI  0x5,4
; 0000 0140 	    	PORTB.5 = 0;
	CBI  0x5,5
; 0000 0141 	    }
; 0000 0142         else PORTC.7 = 0;
	RJMP _0xA2
_0x91:
	CBI  0x8,7
; 0000 0143 
; 0000 0144         //Cazul in care bolobocul este inclinat sub 30 grade pe axa X
; 0000 0145         if (Axa_X >= 100 && Axa_X < 115) {
_0xA2:
	__CPWRN 16,17,100
	BRLT _0xA6
	__CPWRN 16,17,115
	BRLT _0xA7
_0xA6:
	RJMP _0xA5
_0xA7:
; 0000 0146             //Aprind ledul verde
; 0000 0147             PORTB.2 = 1;
	SBI  0x5,2
; 0000 0148 
; 0000 0149             //Sting restul ledurilor de pe axa X
; 0000 014A             PORTB.0 = 0;
	CBI  0x5,0
; 0000 014B             PORTB.1 = 0;
	CBI  0x5,1
; 0000 014C             PORTB.3 = 0;
	CBI  0x5,3
; 0000 014D             PORTB.4 = 0;
	CBI  0x5,4
; 0000 014E             PORTB.5 = 0;
	CBI  0x5,5
; 0000 014F         }
; 0000 0150 
; 0000 0151         if (Axa_X > 75 && Axa_X <= 90) {
_0xA5:
	__CPWRN 16,17,76
	BRLT _0xB5
	__CPWRN 16,17,91
	BRLT _0xB6
_0xB5:
	RJMP _0xB4
_0xB6:
; 0000 0152             //Aprind ledul verde
; 0000 0153             PORTB.3 = 1;
	SBI  0x5,3
; 0000 0154 
; 0000 0155             //Sting restul ledurilor de pe axa X
; 0000 0156             PORTB.0 = 0;
	CBI  0x5,0
; 0000 0157             PORTB.1 = 0;
	CBI  0x5,1
; 0000 0158             PORTB.2 = 0;
	CBI  0x5,2
; 0000 0159             PORTB.4 = 0;
	CBI  0x5,4
; 0000 015A             PORTB.5 = 0;
	CBI  0x5,5
; 0000 015B         }
; 0000 015C 
; 0000 015D         //Cazul in care bolobocul este inclinat intre 30-45 grade pe axa X
; 0000 015E         if (Axa_X >= 115 && Axa_X < 130) {
_0xB4:
	__CPWRN 16,17,115
	BRLT _0xC4
	__CPWRN 16,17,130
	BRLT _0xC5
_0xC4:
	RJMP _0xC3
_0xC5:
; 0000 015F             //Aprind ledul galben
; 0000 0160             PORTB.1 = 1;
	SBI  0x5,1
; 0000 0161 
; 0000 0162             //Sting restul ledurilor de pe axa X
; 0000 0163             PORTB.0 = 0;
	CBI  0x5,0
; 0000 0164             PORTB.2 = 0;
	CBI  0x5,2
; 0000 0165             PORTB.3 = 0;
	CBI  0x5,3
; 0000 0166             PORTB.4 = 0;
	CBI  0x5,4
; 0000 0167             PORTB.5 = 0;
	CBI  0x5,5
; 0000 0168         }
; 0000 0169 
; 0000 016A         if (Axa_X > 60 && Axa_X <= 75) {
_0xC3:
	__CPWRN 16,17,61
	BRLT _0xD3
	__CPWRN 16,17,76
	BRLT _0xD4
_0xD3:
	RJMP _0xD2
_0xD4:
; 0000 016B             //Aprind ledul galben
; 0000 016C             PORTB.4 = 1;
	SBI  0x5,4
; 0000 016D 
; 0000 016E             //Sting restul ledurilor de pe axa X
; 0000 016F             PORTB.0 = 0;
	CALL SUBOPT_0x2
; 0000 0170             PORTB.1 = 0;
; 0000 0171             PORTB.2 = 0;
; 0000 0172             PORTB.3 = 0;
; 0000 0173             PORTB.5 = 0;
	CBI  0x5,5
; 0000 0174         }
; 0000 0175 
; 0000 0176         //Cazul in care bolobocul este inclinat la peste 45 de grade pe axa X
; 0000 0177         if (Axa_X >= 130) {
_0xD2:
	__CPWRN 16,17,130
	BRLT _0xE1
; 0000 0178             //Aprind ledul rosu
; 0000 0179             PORTB.0 = 1;
	SBI  0x5,0
; 0000 017A 
; 0000 017B             //Sting restul ledurilor de pe axa X
; 0000 017C             PORTB.1 = 0;
	CBI  0x5,1
; 0000 017D             PORTB.2 = 0;
	CBI  0x5,2
; 0000 017E             PORTB.3 = 0;
	CBI  0x5,3
; 0000 017F             PORTB.4 = 0;
	CBI  0x5,4
; 0000 0180             PORTB.5 = 0;
	CBI  0x5,5
; 0000 0181         }
; 0000 0182 
; 0000 0183         if (Axa_X <= 60) {
_0xE1:
	__CPWRN 16,17,61
	BRGE _0xEE
; 0000 0184             //Aprind ledul rosu
; 0000 0185             PORTB.5 = 1;
	SBI  0x5,5
; 0000 0186 
; 0000 0187             //Sting restul ledurilor de pe axa X
; 0000 0188             PORTB.0 = 0;
	CALL SUBOPT_0x2
; 0000 0189             PORTB.1 = 0;
; 0000 018A             PORTB.2 = 0;
; 0000 018B             PORTB.3 = 0;
; 0000 018C             PORTB.4 = 0;
	CBI  0x5,4
; 0000 018D         }
; 0000 018E         delay_ms(200);
_0xEE:
	CALL SUBOPT_0x1
; 0000 018F         axa = 1;
	__GETWRN 20,21,1
; 0000 0190         break;
; 0000 0191         }// end switch
_0x24:
; 0000 0192     }// end while
	RJMP _0x1F
; 0000 0193 }// end main loop
_0xFB:
	RJMP _0xFB
;
;
;/* initialization file */
;
;#include <mega164a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;#include "defs.h"
;
;
;/*
; * most intialization values are generated using Code Wizard and depend on clock value
; */
;void Init_initController(void)
; 0001 000B {

	.CSEG
_Init_initController:
; 0001 000C // Crystal Oscillator division factor: 1
; 0001 000D #pragma optsize-
; 0001 000E CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0001 000F CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0001 0010 #ifdef _OPTIMIZE_SIZE_
; 0001 0011 #pragma optsize+
; 0001 0012 #endif
; 0001 0013 
; 0001 0014 // Input/Output Ports initialization
; 0001 0015 // Port A initialization
; 0001 0016 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0001 0017 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0001 0018 PORTA=0x00;
	OUT  0x2,R30
; 0001 0019 DDRA=0x00;
	OUT  0x1,R30
; 0001 001A 
; 0001 001B // Port B initialization
; 0001 001C PORTB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x5,R30
; 0001 001D DDRB=0xFF;
	OUT  0x4,R30
; 0001 001E 
; 0001 001F // Port C initialization
; 0001 0020 PORTC=0xFF;
	OUT  0x8,R30
; 0001 0021 DDRC=0xFF;
	OUT  0x7,R30
; 0001 0022 
; 0001 0023 // Port D initialization
; 0001 0024 PORTD=0b00100000; // D.5 needs pull-up resistor
	LDI  R30,LOW(32)
	OUT  0xB,R30
; 0001 0025 DDRD= 0b01010000; // D.6 is LED, D.4 is test output
	LDI  R30,LOW(80)
	OUT  0xA,R30
; 0001 0026 
; 0001 0027 // Timer/Counter 0 initialization
; 0001 0028 // Clock source: System Clock
; 0001 0029 // Clock value: Timer 0 Stopped
; 0001 002A // Mode: Normal top=FFh
; 0001 002B // OC0 output: Disconnected
; 0001 002C TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0001 002D TCCR0B=0x00;
	OUT  0x25,R30
; 0001 002E TCNT0=0x00;
	OUT  0x26,R30
; 0001 002F OCR0A=0x00;
	OUT  0x27,R30
; 0001 0030 OCR0B=0x00;
	OUT  0x28,R30
; 0001 0031 
; 0001 0032 // Timer/Counter 1 initialization
; 0001 0033 // Clock source: System Clock
; 0001 0034 // Clock value: 19.531 kHz = CLOCK/256
; 0001 0035 // Mode: CTC top=OCR1A
; 0001 0036 // OC1A output: Discon.
; 0001 0037 // OC1B output: Discon.
; 0001 0038 // Noise Canceler: Off
; 0001 0039 // Input Capture on Falling Edge
; 0001 003A // Timer 1 Overflow Interrupt: Off
; 0001 003B // Input Capture Interrupt: Off
; 0001 003C // Compare A Match Interrupt: On
; 0001 003D // Compare B Match Interrupt: Off
; 0001 003E 
; 0001 003F TCCR1A=0x00;
	STS  128,R30
; 0001 0040 TCCR1B=0x0D;
	LDI  R30,LOW(13)
	STS  129,R30
; 0001 0041 TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  133,R30
; 0001 0042 TCNT1L=0x00;
	STS  132,R30
; 0001 0043 ICR1H=0x00;
	STS  135,R30
; 0001 0044 ICR1L=0x00;
	STS  134,R30
; 0001 0045 
; 0001 0046 // 1 sec = 19531 counts = 4C41H counts, from 0 to 4C40
; 0001 0047 // 4C40H = 4CH (MSB) and 40H (LSB)
; 0001 0048 OCR1AH=0x4C;
	LDI  R30,LOW(76)
	STS  137,R30
; 0001 0049 OCR1AL=0x40;
	LDI  R30,LOW(64)
	STS  136,R30
; 0001 004A 
; 0001 004B OCR1BH=0x00;
	LDI  R30,LOW(0)
	STS  139,R30
; 0001 004C OCR1BL=0x00;
	STS  138,R30
; 0001 004D 
; 0001 004E // Timer/Counter 2 initialization
; 0001 004F // Clock source: System Clock
; 0001 0050 // Clock value: Timer2 Stopped
; 0001 0051 // Mode: Normal top=0xFF
; 0001 0052 // OC2A output: Disconnected
; 0001 0053 // OC2B output: Disconnected
; 0001 0054 ASSR=0x00;
	STS  182,R30
; 0001 0055 TCCR2A=0x00;
	STS  176,R30
; 0001 0056 TCCR2B=0x00;
	STS  177,R30
; 0001 0057 TCNT2=0x00;
	STS  178,R30
; 0001 0058 OCR2A=0x00;
	STS  179,R30
; 0001 0059 OCR2B=0x00;
	STS  180,R30
; 0001 005A 
; 0001 005B // External Interrupt(s) initialization
; 0001 005C // INT0: Off
; 0001 005D // INT1: Off
; 0001 005E // INT2: Off
; 0001 005F // Interrupt on any change on pins PCINT0-7: Off
; 0001 0060 // Interrupt on any change on pins PCINT8-15: Off
; 0001 0061 // Interrupt on any change on pins PCINT16-23: Off
; 0001 0062 // Interrupt on any change on pins PCINT24-31: Off
; 0001 0063 EICRA=0x00;
	STS  105,R30
; 0001 0064 EIMSK=0x00;
	OUT  0x1D,R30
; 0001 0065 PCICR=0x00;
	STS  104,R30
; 0001 0066 
; 0001 0067 // Timer/Counter 0,1,2 Interrupt(s) initialization
; 0001 0068 TIMSK0=0x00;
	STS  110,R30
; 0001 0069 TIMSK1=0x02;
	LDI  R30,LOW(2)
	STS  111,R30
; 0001 006A TIMSK2=0x00;
	LDI  R30,LOW(0)
	STS  112,R30
; 0001 006B 
; 0001 006C // USART0 initialization
; 0001 006D // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0001 006E // USART0 Receiver: On
; 0001 006F // USART0 Transmitter: On
; 0001 0070 // USART0 Mode: Asynchronous
; 0001 0071 // USART0 Baud rate: 9600
; 0001 0072 UCSR0A=0x00;
	STS  192,R30
; 0001 0073 UCSR0B=0xD8;
	LDI  R30,LOW(216)
	STS  193,R30
; 0001 0074 UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  194,R30
; 0001 0075 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  197,R30
; 0001 0076 UBRR0L=0x81;
	LDI  R30,LOW(129)
	STS  196,R30
; 0001 0077 
; 0001 0078 // USART1 initialization
; 0001 0079 // USART1 disabled
; 0001 007A UCSR1B=0x00;
	LDI  R30,LOW(0)
	STS  201,R30
; 0001 007B 
; 0001 007C 
; 0001 007D // Analog Comparator initialization
; 0001 007E // Analog Comparator: Off
; 0001 007F // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0001 0080 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0001 0081 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0001 0082 DIDR1=0x00;
	STS  127,R30
; 0001 0083 
; 0001 0084 // ADC initialization
; 0001 0085 // ADC Clock frequency: 156,250 kHz
; 0001 0086 // ADC Voltage Reference: AVCC pin
; 0001 0087 // ADC Auto Trigger Source: Free Running
; 0001 0088 // Only the 8 most significant bits of
; 0001 0089 // the AD conversion result are used
; 0001 008A // Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On
; 0001 008B // ADC4: On, ADC5: On, ADC6: On, ADC7: On
; 0001 008C DIDR0=0x00;
	STS  126,R30
; 0001 008D ADMUX=ADC_VREF_TYPE & 0xff;
	LDI  R30,LOW(96)
	STS  124,R30
; 0001 008E ADCSRA=0xA7;
	LDI  R30,LOW(167)
	STS  122,R30
; 0001 008F ADCSRB&=0xF8;
	LDS  R30,123
	ANDI R30,LOW(0xF8)
	STS  123,R30
; 0001 0090 
; 0001 0091 // SPI initialization
; 0001 0092 // SPI disabled
; 0001 0093 SPCR=0x00;
	LDI  R30,LOW(0)
	OUT  0x2C,R30
; 0001 0094 
; 0001 0095 // TWI initialization
; 0001 0096 // TWI disabled
; 0001 0097 
; 0001 0098 
; 0001 0099 // Watchdog Timer initialization
; 0001 009A // Watchdog Timer Prescaler: OSC/2048
; 0001 009B #pragma optsize-
; 0001 009C #asm("wdr")
	wdr
; 0001 009D // Write 2 consecutive values to enable watchdog
; 0001 009E // this is NOT a mistake !
; 0001 009F WDTCSR=0x18;
	LDI  R30,LOW(24)
	STS  96,R30
; 0001 00A0 WDTCSR=0x08;
	LDI  R30,LOW(8)
	STS  96,R30
; 0001 00A1 #ifdef _OPTIMIZE_SIZE_
; 0001 00A2 #pragma optsize+
; 0001 00A3 #endif
; 0001 00A4 
; 0001 00A5 }
	RET
;
;
;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_rx_buffer0:
	.BYTE 0x8
_tx_buffer0:
	.BYTE 0x8
__seed_G102:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	CBI  0x5,0
	CBI  0x5,1
	CBI  0x5,2
	CBI  0x5,3
	RET


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x1388
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
