build:
	./configure
	make python Parser/pgen
	mv python hostpython
	mv Parser/pgen Parser/hostpgen
	make distclean
		
.PHONY: build

