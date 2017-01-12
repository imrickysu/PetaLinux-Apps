curdir := $(shell pwd)

build:
	patch -p1 < ../6929380/Python-2.7.3-xcompile.patch
	./configure CC=arm-xilinx-linux-gnueabi-gcc --enable-shared CXX=arm-xilinx-linux-gnueabi-g --host=arm-xilinx-linux-gnueabi --build=x86_64-linux-gnu --prefix=/python AR=arm-xilinx-linux-gnueabi-ar RANLIB=arm-xilinx-linux-gnueabi-ranlib LD=arm-xilinx-linux-gnueabi-ld NM=arm-xilinx-linux-gnueabi-gcc-nm --disable-ipv6
	make HOSTPYTHON=./hostpython HOSTPGEN=./Parser/hostpgen BLDSHARED="arm-xilinx-linux-gnueabi-gcc -shared" CROSS_COMPILE=arm-xilinx-linux-gnueabi- CROSS_COMPILE_TARGET=yes HOSTARCH=arm-xilinx-linux-gnueabi BUILDARCH=x86_64-linux-gnu
	make install HOSTPYTHON=./hostpython BLDSHARED="arm-xilinx-linux-gnueabi-gcc -shared" CROSS_COMPILE=arm-xilinx-linux-gnueabi- CROSS_COMPILE_TARGET=yes prefix=$(curdir)/_install
