name = lir-tutorial

all: $(name).lir
	lir $<
	
.PHONY: clean
clean:
	-rm -r .lir
	-rm $(name).html
