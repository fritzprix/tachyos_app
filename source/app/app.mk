#app.mk
# Created on: 2015. 2. 1.
#     Author: innocentevil


APP_CSRCS = main.c
APP_CPPSRCS =
APP_ASMSRCS =

APP_BUILD_DIR=$(BUILD_DIR)/app
BUILD_SUB_DIR+= $(APP_BUILD_DIR)

APP_OBJS = $(APP_CSRCS:%.c=$(APP_BUILD_DIR)/%.o)
APP_ASMOBJS = $(APP_ASMSRCS:%.S=$(APP_BUILD_DIR)/%.o)\

OBJS += $(APP_OBJS)\
		$(APP_ASMOBJS)

$(APP_BUILD_DIR):
	$(MK) $@

$(APP_BUILD_DIR)/%.o : $(APP_ENTRY_DIR)/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	$(CC) $< -c $(CFLAG) $(LDFLAG) $(INC) -o $@
	@echo 'Finished building: $<'
	@echo ' '
	
$(APP_BUILD_DIR)/%.o : $(APP_ENTRY_DIR)/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM g++'
	$(CPP) $< -c $(CPFLAG) $(LDFLAG) $(INC) -o $@
	@echo 'Finishing building: $<'
	@echo ' '

$(APP_BUILD_DIR)/%.o: $(APP_ENTRY_DIR)/%.S 
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM GNU Assembler'
	$(CC) $< -c $(CFLAG) $(INC) $(ASM_OPT) -o $@
	@echo 'Finished building: $<'
	@echo ' '