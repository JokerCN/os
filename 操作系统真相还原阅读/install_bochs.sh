#!/bin/bash
tar zxvf bochs-2.6.11.tar.gz
ln -s bochs-2.6.11 bochs
cd bochs
./configure \
		--prefix=$PWD \
		--enable-debugger \
		--enable-disasm  \
		--enable-iodebug \
		--enable-x86-debugger \
		--with-x \
		--with-x11 \
		--enable-x86-64

make
make install
sed -i'.bak' 's/^sound: /#&/' .bochsrc
sed -i 's/^floppya: /#&/' .bochsrc
bin/bximage -hd=60M -mode=create -imgmode=flat -q hd60M.img
sed -i 's/^ata1: enabled=1/ata1: enabled=0/' .bochsrc
sed -i '/^ata0: /a ata0-master: type=disk, path="hd60M.img", mode=flat' .bochsrc

