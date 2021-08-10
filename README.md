# Build script for PostgreSQL on Linux.  

## Compile these dependencies.  
- [Perl](http://www.cpan.org/src/)
- [OpenSSL](https://www.openssl.org/source/)
- [zlib](https://zlib.net)
- [Python](https://www.python.org/downloads/source/)
- [Tcl](https://www.tcl.tk/software/tcltk/download.html)
- [ICU4c](https://github.com/unicode-org/icu/releases)
- [libedit](https://thrysoee.dk/editline/)
- [bison](https://ftp.gnu.org/gnu/bison/)
- [gettext](https://ftp.gnu.org/gnu/gettext/)
- [flex](https://sourceforge.net/projects/flex/files/)
- [Kerberos5](https://web.mit.edu/kerberos/dist/)
- [libiconv](https://ftp.gnu.org/gnu/libiconv/)
- [libxml2](http://xmlsoft.org/sources/)
- [libxslt](http://xmlsoft.org/sources/)

## How to use this?  
1. Copy `build.sh` and `requirements` to the root directory of PostgreSQL source tree.  
```console
$ cp -r build.sh requirements /path/to/postgres/
$ cd /path/to/postgres/
```

2. Perform `./build.sh`.  
```console
$ ./build.sh /path/to/installdir
```

