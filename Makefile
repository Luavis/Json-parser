CC = gcc
OBJS = json.tab.o lex.yy.o
TARGET = json
LEX = flex
YACC = bison
YFLAGS = -d

.SUFFIXES: .c .o

all: $(TARGET)

json.tab.c: json.y 
	bison -d $<

lex.yy.c: json.l
	flex $<

$(TARGET): $(OBJS)
	$(CC) -o $@ $(OBJS) -ll

test:
	./json < test.json

clean:
	rm -f *.tab.c *.tab.h *.yy.c $(OBJS) $(TARGET)