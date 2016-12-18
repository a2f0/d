#https://gist.github.com/darkstalker/2221824
DCC = dmd
DFLAGS = -w
LIBS =
SRC = $(wildcard *.d)
OBJ = $(SRC:.d=.o)
OUT = $(shell basename `pwd`)

.PHONY: all debug release profile clean

all: debug

debug:   DFLAGS += -g -debug
release: DFLAGS += -O -release -inline -noboundscheck
profile: DFLAGS += -g -O -profile

debug release profile: $(OUT)

$(OUT): $(OBJ)
	$(DCC) $(DFLAGS) -of$@ $(OBJ) $(LIBS)

clean:
	rm -f *~ $(OBJ) $(OUT) trace.{def,log}

%.o: %.d
	$(DCC) $(DFLAGS) -c $<

