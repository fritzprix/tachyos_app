#Makefile
# Created on: 2015. 2. 1.
#     Author: innocentevil

include appCfg.mk

ifeq ($(MAJ_NUM),)
	MAJ_NUM = 0
endif

ifeq ($(MIN_NUM),)
	MIN_NUM = 0
endif

ifeq ($(BUILD), )
	BUILD = Debug
endif

ifeq ($(APP_NAME), )
	APP_NAME = tachy_app
endif
ifeq ($(MK),)
	MK=mkdir
endif

ifeq ($(LDSCRIPT),)
	LDSCRIPT=$(PRJ_ROOT_DIR)/tool/$(TOOL)/app.ld
endif

PRJ_ROOT_DIR = $(CURDIR)
APP_ENTRY_DIR = $(PRJ_ROOT_DIR)/source/app
MODULE_ROOT_DIR = $(PRJ_ROOT_DIR)/source/module

TACHY_HDR_ROOT_DIR = $(PRJ_ROOT_DIR)/include
TACHY_HAL_HDR_DIR = $(TACHY_HDR_ROOT_DIR)/hal

BUILD_DIR = $(PRJ_ROOT_DIR)/$(BUILD)
BUILD_SUB_DIR =
TARGET = $(BUILD_DIR)/$(APP_NAME)_VER$(MAJ_NUM).$(MIN_NUM).elf

INC += 	-I$(TACHY_HDR_ROOT_DIR)\
    	-I$(TACHY_HAL_HDR_DIR)
    	
include $(PRJ_ROOT_DIR)/tool/$(TOOL)/tool.mk


include $(APP_ENTRY_DIR)/app.mk


TARGET_SIZE = $(TARGET:%.elf=%.siz)
TARGET_FLASH = $(TARGET:%.elf=%.hex) 
TARGET_BINARY = $(TARGET:%.elf=%.bin)


all : $(BUILD_DIR) $(BUILD_SUB_DIR) $(TARGET) $(TARGET_FLASH) $(TARGET_BINARY) $(TARGET_SIZE)

$(BUILD_DIR):
	$(MK) $@ 

$(TARGET) : $(OBJS)
	@echo "Generating ELF"
	$(CPP) -o $@ $(CFLAG) $(LDFLAG) $(MMAP_FLAG) $(LIB_DIR) $(LIBS) $(INC) $(OBJS)
	@echo ' '

$(TARGET_FLASH): $(TARGET)
	@echo 'Invoking: Cross ARM GNU Create Flash Image'
	$(OBJCP) -O ihex $<  $@
	@echo 'Finished building: $@'
	@echo ' '
	
$(TARGET_BINARY): $(TARGET)
	@echo 'Invoking: Cross ARM GNU Create Flash Image'
	$(OBJCP) -O binary -S $<  $@
	@echo 'Finished building: $@'
	@echo ' '

$(TARGET_SIZE): $(TARGET)
	@echo 'Invoking: Cross ARM GNU Print Size'
	$(SIZEPRINT) --format=berkeley $<
	@echo 'Finished building: $@'
	@echo ' '

clean : 
	rm -rf $(TARGET) $(TARGET_FLASH) $(TARGET_BINARY) $(TARGET_SIZE)  $(OBJS)




	