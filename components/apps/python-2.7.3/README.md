# Python 2.7.3

This app will fetch source file of python 2.7.3 from web, cross compile it and install it to target rootfs.

## Hardware Dependency
This app doesn't depend on any specific hardware in PL.

## Prerequests
- Internet connection, otherwise put the required source files to this app's directory
- PetaLinux environment
- Host machine should have installed gcc

## Usage
- Create app: `petalinux-create -t apps -n python-2.7.3 --enable`
- Copy all files in this directory to `components/apps/python-2.7.3`
- Build the whole image: `petalinux-build`
- If the image has been built before, use these two commands to only build this app and repackage the image
  ```
  petalinux-build -c rootfs/python-2.7.3
  petalinux-build -x package
  ```
- If any errors occur during the build process, the log of the build process can be checked in `build/build.log`

## Known Issues
Some feature of python is not included. Python build reports:
```
Python build finished, but the necessary bits to build these modules were not fo
und:
_bsddb             _curses            _curses_panel   
_sqlite3           _ssl               _tkinter        
bsddb185           bz2                dbm             
dl                 gdbm               imageop         
nis                readline           sunaudiodev     
zlib                                                  
To find the necessary bits, look in setup.py in detect_modules() for the module'
s name.

```
