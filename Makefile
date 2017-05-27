# built-in rules variable ------------------------------------------------------------
CC = arm-none-eabi-gcc
AR = arm-none-eabi-ar
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCP = arm-none-eabi-objcopy
CFLAGS = -g -mtune=cortex-m4 -mthumb -std=c99 -fdata-sections -mfloat-abi=soft \
 -march=armv7-m -mthumb-interwork -mapcs-frame
CPPFLAGS := -DUSE_STDPERIPH_DRIVER -DSTM32F40XX -DSTM32F407xx
TARGET_ARCH = 
ASFLAGS = -c -g -mcpu=cortex-m4 -mthumb-interwork -mthumb -mfloat-abi=soft
ARFLAGS = rcs
export CFLAGS CPPFLAGS
LIBDIR = -L./stm32f4_driver/stm32f4_lib/obj
LIBDIR += -L./stm32f4_driver/obj
LDSCRIPT = $(shell ls *.ld)
LDFLAGS = -T $(LDSCRIPT)
LDFLAGS += -L /home/bear/gcc-arm-none-eabi-5_4-2016q2/arm-none-eabi/lib/thumb/
LDFLAGS += -L /home/bear/gcc-arm-none-eabi-5_4-2016q2/lib/gcc/arm-none-eabi/5.4.1/armv7-m
# ------------------------------------------------------------------------------------

vpath %.a ./stm32f4_driver/stm32f4_lib/obj
vpath %.a ./stm32f4_driver/obj


INCDIR = $(shell find | grep '\>.h')
INCDIR :=$(dir $(INCDIR))
INCDIR :=$(sort $(INCDIR))

CPPFLAGS += $(addprefix -I,$(INCDIR))

all:main.bin 

include main.d

main.bin:main.elf
	$(OBJCP) -Obinary $^ $@

main.elf:main.o startup_stm32f40xx.o driver $(LDSCRIPT)
	$(LD) $(LDFLAGS) main.o startup_stm32f40xx.o $(LIBDIR) -ldriver -lst -lm -lc -lgcc -o $@


driver:
	cd stm32f4_driver&&make&&cd ..
clean_driver:
	@cd stm32f4_driver&&make clean&&cd ..
# clean_driver_all:
# 	@cd stm32f4_driver&&make clean_all&&cd ..

main.o:main.c

startup_stm32f40xx.o:startup_stm32f40xx.s

%.d:%.c 
	$(CC) -M $(CPPFLAGS) $< >> $@

upload:main.bin
	st-flash --reset write main.bin 0x8000000

.PHONY:all driver clean_driver distclean clean

clean:clean_driver
	@-rm *.elf *.bin *.o *.d
	@echo "clean app's files"
distclean:clean
	@cd stm32f4_driver&&make distclean&&cd ..
	@echo "clean all middle files in the hole subject"
