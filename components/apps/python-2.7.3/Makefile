ifndef PETALINUX
$(error "Error: PETALINUX environment variable not set.  Change to the root of your PetaLinux install, and source the settings.sh file")
endif

include apps.common.mk

APP = Python-2.7.3/_install/bin/python

SOURCE_DIR = Python-2.7.3
SOURCE = Python-2.7.3.tar.bz2
PATCH = Python-2.7.3-xcompile.patch
SOURCE_URL = https://www.python.org/ftp/python/2.7.3/Python-2.7.3.tar.bz2
PATCH_URL = http://randomsplat.com/wp-content/uploads/2012/10/Python-2.7.3-xcompile.patch


all: build_target install

# fetch source
$(SOURCE):
	wget $(SOURCE_URL)

$(SOURCE_DIR): $(SOURCE)
	tar -xjf Python-2.7.3.tar.bz2 

$(PATCH):
	wget $(PATCH_URL)

Python-2.7.3/hostpython: $(SOURCE_DIR)
	cp hostpython.mk Python-2.7.3/hostpython.mk
	cd Python-2.7.3; env -i PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make -f hostpython.mk 

build_target: $(APP)

$(APP): Python-2.7.3/hostpython $(PATCH)
	cp targetpython.mk Python-2.7.3/targetpython.mk
	cd Python-2.7.3; make -f targetpython.mk

clean:
	-rm -rf Python-2.7.3

.PHONY: build_target install

install: $(APP)
	$(TARGETINST) -d Python-2.7.3/_install/bin/python2.7 /usr/local/bin/python2.7
	$(TARGETINST) -d Python-2.7.3/_install/include /usr/local/include
	$(TARGETINST) -d Python-2.7.3/_install/lib/ /usr/local/lib/

help:
	@echo ""
	@echo "Quick reference for various supported build targets for $(INSTANCE)."
	@echo "----------------------------------------------------"
	@echo "  clean                  clean out build objects"
	@echo "  all                    build $(INSTANCE) and install to rootfs host copy"
	@echo "  build                  build subsystem"
	@echo "  install                install built objects to rootfs host copy"
