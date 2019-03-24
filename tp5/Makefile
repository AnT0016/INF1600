CXX=gcc
CFLAGS=-g -m32 -Wall
LDFLAGS=-lm
RM=rm -f
EXEC=tp5
OBJECTS=tp5.o

.PHONY: clean

.cpp.o:
	$(CXX) $(CFLAGS) -c -o $@ $<

.s.o:
	$(CXX) $(CFLAGS) -c -o $@ $<

all: tp5

$(EXEC): $(OBJECTS)
	$(CXX) $(CFLAGS) $(LDFLAGS) -o $@ $^

run: $(EXEC)
	./$(EXEC)

clean:
	$(RM) *.o $(EXEC)
