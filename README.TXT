Welcome to the CodeVisionAVR C Compiler V2 and the
CodeWizardAVR Automatic Program Generator

The compiler is designed to be used along with
the Atmel AVR Studio debugger V4.18 SP3 or later.
In case you don't have AVR Studio, then you
must download it from the ATMEL web site:
www.atmel.com

1. Installing CodeVisionAVR

If you will use the Compiler under Windows 2000, XP, Vista or Windows 7
you must first install and run it with Administrator privileges.
On subsequent runs under Windows 2000 or XP you may also have Power User privileges.

For installing under Windows Vista, the following steps should be performed,
having an Administrator account:

- the Windows Vista User Account Control must be disabled using the steps below:

    - press the Windows button and click on the Control Panel link
    - in the Control Panel window, under the User Accounts and Family Safety,
      click on the Add or remove user accounts link
    - a new window will open, click on the Go to the main User Accounts page
      link located at the bottom of the window
    - a new window will open, click on the Turn User Account Control on or off
      link located at the bottom of the window
    - in the new window that will open, uncheck the Use User Account Control (UAC)
      to help protect your computer check box and press the OK button to confirm
    - the computer will have to be restarted for this setting to become effective

- run the CodeVisionAVR setup.exe installer
- after the installation is complete, right click on the CodeVisionAVR icon on the desktop
- select Properties in the popup menu that will open
- a new window called CodeVisionAVR Properties will open
- select the Compatibility tab
- check the Privilege Level|Run this program as an administrator check box and
  press the OK button to confirm.

2. New features/bug fixes in CodeVisionAVR V2.05.0:

- added ADC support for ATxmega chips in the CodeWizardAVR
- added support for the ATmega8U2, ATmega16U2, ATmega32U2, ATmega32A chips in the C Compiler,
  CodeWizardAVR and Programmer
- added support for the USB controller of the AT90USB82, AT90USB162, ATmega16U4 and
  ATmega32U4 chips in the CodeWizardAVR
- added a new alphanumeric LCD library (alcd_ks0073.h) for the Samsung KS0073 controller
- improved configuration settings for ATxmega EBI SDRAM mode
- disabled the possibility to specify the SCK clock rate for SPI slave mode in the
  CodeWizardAVR for non-ATxmega devices
- added code to clean up NVM controller command register after EEPROM write for
  ATxmega chips
- fixed: when the EBI was configured in SDRAM 3P mode, the upper 4 bits of PORTJ
  were not set as outputs for address lines A8..A11
- fixed: functions with __reset attribute were removed by the linker
- fixed: added code to ensure that RAMPX=0 after clearing/initializing more
  than 65535 bytes of RAM in the start-up code for the ATxmega chips
- added the missing definitions of EBI_SDCAS_bm, EBI_SDROW_bm and EBI_CS_SDSREN_bm
  used by the start-up code during EBI initialization for ATxmega chips
- corrected SP initialization for ATxmega chips when calling functions with
  __reset attribute and external RAM enabled
- fixed: the compiler could produce incorrect code (hardware stack unbalance) when
  adressing structure members in complex expressions using pointers, if the
  member's offset is higher than 64-sizeof(member)
- fixed: because the ATxmega registers are not mapped to RAM, like in the rest of
  the AVR chips, the addresses of global variables allocated to registers R2..R14,
  obtained using the & operator, were not correctly passed as function arguments
- fixed: the CodeWizardAVR for ATxmega chips incorrectly set the upper 4 bits
  of the USART BAUDCTRLB register for negative values of BSCALE
- corrected the signature for the ATtiny4313 chip in the programmer
- added new ATxmega ADC examples in the \EXAMPLES ATxmega\ADC directory
- updated the Help topics: CodeVisionAVR C Compiler Reference|Accesing the I/O Registers and
  CodeVisionAVR C Compiler Reference|Bit Level Access to the I/O Registers with ATxmega
  specific examples.
 
3. New features/changes in CodeVisionAVR V2.05.0, not available in old V1.25.x compilers:
a) Compiler:
- ANSI C compatible C front-end
- the bool data type was added
- the @ operator can now be used with variables located in EEPROM too
- the & unary operator can now be applied to I/O registers declared using the sfrb and sfrw keywords.
  It will return a pointer to the RAM address where these registers are mapped.
- there is no need to specify the ‘flash’ or ‘eeprom’ memory attribute during structure or union type definition.
  Therefore the  same structure or union data type can be easily located in any memory area during variable declaration.
- the compiler now makes distinction between the ‘const’ type qualifier and the ‘flash’ memory attribute.
  In order to maintain compatibility with V1.25.x projects, the Project|Configure|C Compiler|Code Generation|Store Global Constants in 
  FLASH Memory must be checked. If this option is not checked, identifiers declared with the ‘const’ type qualifier will be 
  placed in RAM.
- the Code Information tab, present in the Navigator after the first Build, displays detailed information regarding defined data types,
  preprocessor macros, function and variables declarations, included header files, memory and register allocation
- the abs, cabs, labs and fabs functions were moved from the math.h header to the stdlib.h header
- the preprocessor does not use the old ‘funcused’ directive, when it is found it is always evaluated to 1
- added the #message preprocessor directive
- improved error and warning checking
- improved linker: only the modified C source files are compiled when the Project|Build command is executed
- improved COFF object file generator
- improved code optimizer
- enhanced libraries, including MMC/SD/SD HC FLASH Memory Card and FAT support
- I/O registers bits definitions were added to the device header files.
  For projects created with prior versions, these definitions are not enabled by default.
  In order to enable them the Project|Configure|C Compiler|Code Generation|Preprocessor|Include I/O Registers Bits Definitions
  option must be activated.
  For newly created projects, this option is enabled by default. 
- in order to eliminate naming conflicts with I/O registers bits definitions, the names of the
  SPCR0, SPDR0, SPSR0 registers were changed to SPCR, SPDR, SPSR in the following
  header files: mega164.h, mega324.h, mega644.h, mega644p.h.
- in order to eliminate naming conflicts with I/O registers bits definitions, the names of the
  PCINT0, PCINT1, PCINT2, PCINT3 interrupt vectors were changed to
  PC_INT0, PC_INT1, PC_INT2, PC_INT3  in the following header files:
  90usb1286.h, 90usb1287.h, 90usb646.h, 90usb647.h, 90usb162.h, 90usb162.h,
  mega1280.h, mega1281.h, mega2560.h, mega2561.h, mega640.h, mega1284p.h,
  mega162.h, mega164.h, mega165.h, mega168.h, mega168p.h, mega169.h,
  mega324.h, mega325.h, mega325p.h, mega3250.h, mega3250p.h, mega328p.h,
  mega329.h, mega329p.h, mega3290.h, mega3290p.h, mega406.h,
  mega48.h, mega48p.h, mega644.h, mega644p.h, mega645.h, mega6450.h,
  mega649.h, mega6490.h, mega88.h, mega88p.h,
  tiny10.h, tiny13.h, tiny24.h, tiny25.h, tiny44.h, tiny45.h, tiny48.h,
  tiny84.h, tiny 85.h, tiny88.h, tiny261.h, tiny461.h, tiny861.h, tiny2313.h.
  If these interrupt vectors are used in your programs, their names must be updated.
- in order to eliminate naming conflicts with I/O registers bits definitions, the names of the
  INT0...INT7 interrupt vectors were changed to EXT_INT0...EXT_INT7
  in the following header files: mega1280.h, mega1281.h, mega2560.h, mega2561.h,
  mega640.h, mega1284p.h, mega164.h, mega324.h, mega644.h, mega644p.h.
  If these interrupt vectors are used in your programs, their names must be updated.
- removed the limitation: when a literal char string enclosed between quotes,
  is passed as an argument to a function parameter of pointer to char,
  the pointer now can point to any memory type: RAM, EEPROM or FLASH, not only FLASH like in previous versions.
  The CodeVisionAVR C Compiler Reference|Constants Help topic and User Manual chapter were updated to reflect this change.

b) IDE:
- completely redesigned text Editor with improved syntax highlighting for both C and AVR assembly
- added function parameters and global structure/union members auto complete
- improved code folding
- code folding state can be saved and restored
- bookmarks state can be saved and restored
- added automatic matching brace highlighting when the user places the cursor before the brace
- added automatic file saving at specified time interval
- the Code Navigator was redesigned and displays project information in a more logical way
- an additional Code Information tab is present after a project build. It displays detailed information about the included 
  header files, preprocessor macro definitions, type definitions, global/static variable declarations, memory allocation and 
  function definitions.
- added the Functions Call Tree tab in the Navigator
- the new Project|Configure|Files|Output Directories allows to specify in which directories the files generated by the 
  compiler/linker will be placed.
- improved toolbar

It is important to note that in CodeVisionAVR V2 the .asm, .hex, .eep, .cof files created by the compiler have the name of 
the project .prj file.

4. New ATxmega chips support in CodeVisionAVR

- the Standard C I/O Functions use by default the USARTC0. This can be changed by defining the _ATXMEGA_USART_ macro
  as described in the corresponding Help topic.
- the SPI functions use by default the SPIC controller on PORTC. This can be changed by defining the _ATXMEGA_SPI_
  and _ATXMEGA_SPI_PORT_ preprocessor macros as described in the corresponding Help topic.  
- the RTC functions do not yet support the ATxmega chips.

5. Example programs

The Compiler is supplied with the following example
programs:

 - ATxmega chips in \EXAMPLES ATxmega
 - SD FLASH Memory Cards access in \EXAMPLES\SDCARD
 - USB in \EXAMPLES\USB
 - "ATmega8535 ADC on the STK500" in \EXAMPLES\ADC8535
 - "Real Time Clock with ATmega103, Atmel Application Note AVR134" in \EXAMPLES\AVR134
 - "Calling functions written in assembler from C" in \EXAMPLES\C_ASM
 - "Moving LED" in \EXAMPLES\LED
 - "Accessing the EEPROM" in \EXAMPLES\EEPROM
 - "LCD Demo" in \EXAMPLES\LCDDEMO
 - "Definition of user characters in LCDs" in \EXAMPLES\LCDCHAR
 - "LM75 Thermometer" in \EXAMPLES\THERM75
 - "LCD Thermometer" in \EXAMPLES\THERMLCD
 - "DS1820/DS18S20 Multipoint thermometer" in \EXAMPLES\DS1820
 - "DS1990 Serial Number iButton" in \EXAMPLES\DS1990
 - "AD7896 Digital voltmeter" in \EXAMPLES\SPI
 - "MAX1241 Digital voltmeter" in \EXAMPLES\MAX1241
 - "4x4 Keypad" in \EXAMPLES\KEYPAD
 - "Simple multifile project" in \EXAMPLES\MULTFILE
 - "Redirecting the output of standard C I/O functions to USART0, USART1
   and LCD for an ATmega128 chip" in \EXAMPLES\2USART_LCD
 
After starting CodeVisionAVR, execute the File|Open
menu command and load the Project (*.prj) file for the
example you like.
Then execute the Project|Build All menu command to
compile and link the project.

Take some time and carefully read the Help.

***** IMPORTANT NOTE *****

The CodeVisionAVR Evaluation version has the following limitations:
- the compiled code size is restricted to 1kbyte (512words)
  for chips with less then 2kwords of FLASH and 3kbytes (1.5kword) of FLASH for the rest of chips
- the libraries for the ATxmega TWI functions, PCF8583, DS1302, DS1307 REAL TIME CLOCKS,
  DS2430, DS2433 EEPROMs are not available
- interrupt driven serial communication code generation by the CodeWizardAVR is disabled
- ATxmega EBI support is disabled in the compiler
- EBI, TWI, RTC, RTC32 and Battery Backup System code generation is disabled in the CodeWizardAVR
  for the ATxmega devices
- no code is generated by the CodeWizardAVR for reading the ATxmega ADC calibration data from the
  signature row. 

The above mentioned limitations are not present in the commercial versions
of CodeVisionAVR.


