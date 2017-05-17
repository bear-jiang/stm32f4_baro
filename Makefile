include makefile.common
LIBDIR = -L./stm32f4_driver/stm32f4_lib/obj
all:main.bin

main.elf:main.o startup_stm32f40xx.o driver
	$(LD) $(LDFLAGS) main.o startup_stm32f40xx.o ./*/obj/*.o $(LIBDIR)  -lst -lm -lc -lgcc -o $@

main.bin:main.elf
	$(OBJCP) -Obinary $^ $@

driver:
	cd stm32f4_driver&&make&&cd ..
clean_driver:
	@cd stm32f4_driver&&make clean&&cd ..
clean_stlib:
	@cd stm32f4_driver&&make clean_st&&cd ..

INCDIR := ./stm32f4_driver
INCDIR += ./stm32f4_driver/stm32f4_lib/STM32F4xx_StdPeriph_Driver/inc
INCDIR += ./stm32f4_driver/stm32f4_lib/CMSIS/Device/ST/STM32F4xx/Include
INCDIR += ./stm32f4_driver/stm32f4_lib/CMSIS/Include
# vpath %.h ./stlib/inc
# vpath %.c ./stlib/src
INCLUDEDIR = $(addprefix -I,$(INCDIR))
vpath %.a ./stm32f4_driver/stm32f4_lib/obj

# vpath %.o ./stm32f4_driver/stm32f4_lib/obj

main.o:main.c
	$(CC)  $(STFLAGS) $< -o ./$@

startup_stm32f40xx.o:startup_stm32f40xx.s
	$(AS) $(ASFLAGS) $< -o ./$@

upload:main.bin
	st-flash --reset write main.bin 0x8000000

.PHONY:all driver clean_driver clean_stlib clean_all

clean:
	@-rm *.elf *.o *.bin
	@echo "clean app's files"
clean_all:clean clean_driver  clean_stlib
	@echo "clean all middle files in the hole subject"
