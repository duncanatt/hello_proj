# Project name configuration.
PROJ_NAME=test.o

# Project structure configuration - source and output directory.
SRC_DIR=src
OUT_DIR=out

# GCC command configuration.
# -g: adds debugging information to the executable file.
# -Wall: turns on most, but not all, compiler warnings.
# -I: adds .h include files.
CC=gcc
CFLAGS=-g -Wall

# Get the list of .c source files.
SRC=$(wildcard $(SRC_DIR)/*.c)$

# Converts the list of source files (.c files) contained in $(SRC) to a list of object
# files, bearing the same name but with a .o extension. 
OUT = $(SRC:$(SRC_DIR)/%.c=$(OUT_DIR)/%.o)

# The things after the : are the dependencies on which this target (i.e. all) depends.
# In this case, this is a list of all *.o files, contained withing $(OUT). This links
# to the $(OUT_DIR)/%.o: $(SRC_DIR)/%.c target.
#
# Note that the 'all' task is the default task run by make, if no task name is
# specified in the command line.
all: $(OUT)
	@echo "List of object files produced [$(OUT)]"
	$(CC) -o $(OUT_DIR)/$(PROJ_NAME) $^ $(FLAGS) $(LIBS)
	@echo "Linked object files in [$(PROJ_NAME)]"

# Shorthand for target *.o and dependencies *.c files. This loops on the a list of
# required object files. This list is the $(OUT) list. The $(OUT_DIR)/%.o: $(SRC_DIR)/%.c 
# syntax means grab each .c file and generate the .o file, as required by $(OBJ).
#
# This is a suffix replacement rule for building .o's from .c's
# it uses automatic variables 
# - $<: the name of the prerequisite/dependency of the rule (a .c file) and 
# - $@: the name of the target of the rule (a .o file) 
# (see the gnu make manual section about automatic variables)
$(OUT_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "Compiling source file: $< to $@"
	@mkdir -p $(OUT_DIR)
	$(CC) -c -o $@ $< $(FLAGS)

# Removes the object files containes in the $(OBJ) list and $(PROJ_NAME). Note that since 
# there are no items after the :, this means that the clean task has no
# dependencies.
clean:
	@echo "Cleaning object files [$(OUT)]"
	@rm -fd $(OUT)
	@echo "Cleaning main project file [$(OUT_DIR)/$(PROJ_NAME)]"
	@rm -fd $(OUT_DIR)/$(PROJ_NAME) $(OUT_DIR)
