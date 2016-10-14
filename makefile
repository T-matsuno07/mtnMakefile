# Most Simple Makefile

# Compile Option
CXX = gcc -g

TOP_DIR=$(HOME)git/myGitMakefile

CUR_DIR=$(PWD)
OBJ_DIR=$(CUR_DIR)/OBJ
DEP_DIR=$(CUR_DIR)/DEP
HEAD_DIR=$(TOP_DIR)/head


CUR_SRCS=$(wildcard *.c)
CUR_TGTS=$(basename $(CUR_SRCS))
CUR_OBJS=$(addprefix $(OBJ_DIR)/, $(CUR_SRCS:.c=.o))
CUR_DEPS=$(addprefix $(DEP_DIR)/, $(CUR_SRCS:.c=.d))

all: $(CUR_TGTS)

-include $(CUR_DEPS)

$(CUR_TGTS) : $(CUR_OBJS)
	$(CXX) -o $@ $^ 

$(OBJ_DIR)/%.o : %.c
#	@if [ ! -d $(OBJ_DIR) ]; then \
#	  echo mkdidr $(OBJ_DIR); mkdir $(OBJ_DIR); \
#	fi
#	@if [ ! -d $(DEP_DIR) ]; then \
#	  echo mkdidr $(DEP_DIR); mkdir $(DEP_DIR); \
#	fi
	@[ -d $(OBJ_DIR) ] || echo "mkdir -p  $(OBJ_DIR)"; mkdir -p  $(OBJ_DIR)
	@[ -d $(DEP_DIR) ] || echo "mkdir -p  $(DEP_DIR)"; mkdir -p  $(DEP_DIR)
	$(CXX) -MMD -MF dep.tmp -c $< -I$(HEAD_DIR)
	sed "s@$(<:%.c=%.o)@$(OBJ_DIR)/$(<:%.c=%.o)@g"  dep.tmp | sed "s@$<@$(CUR_DIR)/$<@g" > $(<:%.c=%.d) 
	rm -fr dep.tmp
	mv $(<:%.c=%.o) $(OBJ_DIR)
	mv $(<:%.c=%.d) $(DEP_DIR)




test :
	@echo $(CUR_DEPS)

clean :
	rm -rf *.a *.o *.d $(OBJ_DIR) $(DEP_DIR) $(CUR_TGTS) 


