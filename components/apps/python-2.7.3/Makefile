ifndef PETALINUX
$(error "Error: PETALINUX environment variable not set.  Change to the root of your PetaLinux install, and source the settings.sh file")
endif

include apps.common.mk


# Source should be tar.bz2 type because extrace command is hard coded
SOURCE_URL = https://www.python.org/ftp/python/2.7.3/Python-2.7.3.tar.bz2
SOURCE = $(notdir $(SOURCE_URL))
# remove two levels of suffix
SOURCE_DIR = $(basename $(basename $(SOURCE)))
PATCH_URL = http://randomsplat.com/wp-content/uploads/2012/10/Python-2.7.3-xcompile.patch
PATCH = $(notdir $(PATCH_URL))


TARGET_APP = $(SOURCE_DIR)/_install/bin/python
HOST_APP = $(SOURCE_DIR)/hostpython

all: build install

build: $(TARGET_APP)

$(SOURCE):
	@echo "Downloading Python from web"
	wget $(SOURCE_URL)

$(SOURCE_DIR): $(SOURCE)
	@echo "Extracting Python source code"
	tar -xjf $(SOURCE)

$(PATCH):
	@echo "Downloading cross-compile patch"
	wget $(PATCH_URL)

# Host Python compilation
# depends on extracted sources
# use env -i to remove all the environment variable PetaLinux set
# only use the very pure PATH env to generate host Python
$(HOST_APP): $(SOURCE_DIR)
	@echo "Compiling Python for host PC"
	cp hostpython.mk $(SOURCE_DIR)/hostpython.mk
	cd $(SOURCE_DIR); env -i PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make -f hostpython.mk 



# Cross Compile python for ARM
$(TARGET_APP): $(HOST_APP) $(PATCH)
	@echo "Cross-compiling Python for target platform"
	cp targetpython.mk $(SOURCE_DIR)/targetpython.mk
	cd $(SOURCE_DIR); make -f targetpython.mk

clean:
	-rm -rf $(SOURCE_DIR)

.PHONY: build install clean help all

install: 
	$(TARGETINST) -d $(SOURCE_DIR)/_install/bin/ /usr/local/bin/
	$(TARGETINST) -d $(SOURCE_DIR)/_install/include /usr/local/include
	$(TARGETINST) -d $(SOURCE_DIR)/_install/lib/ /usr/local/lib/

help:
	@echo ""
	@echo "Quick reference for various supported build targets for $(INSTANCE)."
	@echo "----------------------------------------------------"
	@echo "  clean                  clean out build objects"
	@echo "  all                    build $(INSTANCE) and install to rootfs host copy"
	@echo "  build                  build subsystem"
	@echo "  install                install built objects to rootfs host copy"

# The compilation process is referred to these sites:
# - http://randomsplat.com/id5-cross-compiling-python-for-embedded-linux.html
# - http://www.csce.uark.edu/~yfrancku/cross-python.html
