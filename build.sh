#!/bin/bash
#set -eux
_top_="${PWD}"

_prefix_="${1:-"/usr/local/pgsql"}"
_build_="${_top_}/_build"
_src_="${_top_}/requirements"

if [ ! -f README ]; then
  echo "Is the current directory the root of PostgreSQL source tree?"
  exit 1
else
  if [[ "$(head -n 1 README)" != 'PostgreSQL Database Management System' ]]; then
    echo "This build script must be performed on the root directory of PostgreSQL source tree."
    exit 1
  fi
fi

# Create a working directory for compiling.
if [ -d "${_build_}" ]; then
  rm -rf "${_build_}"
fi
mkdir -p "${_build_}"

# Download the source codes of the dependencies.
cd "${_src_}"
./download.sh

#------------------------------------------------------------#
# Compile requirements.                                      #
#------------------------------------------------------------#
export PATH=${_prefix_}/bin:${PATH}
export LD_LIBRARY_PATH=${_prefix_}/lib64:${_prefix_}/lib:${LD_LIBRARY_PATH}

# 1. Compile Perl
cd "${_build_}"
if [ ! -f "${_prefix_}/bin/perl" ]; then
  tar -xf ${_src_}/perl-*.*.*.tar.gz || exit 1
  cd perl-*.*.*/
  ./Configure -des -Dprefix=${_prefix_} -Duseshrplib || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 2. Compile OpenSSL
cd "${_build_}"
if [ ! -f "${_prefix_}/bin/openssl" ]; then
  tar -xf ${_src_}/openssl-*.*.*.tar.gz
  cd openssl-*.*.*/
  ./config --prefix=${_prefix_} --openssldir=${_prefix_} || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 3. Compile zlib
cd "${_build_}"
if [ ! -f "${_prefix_}/lib/libz.so" ]; then
  tar -xf ${_src_}/zlib-*.*.*.tar.gz || exit 1
  cd zlib-*.*.*/
  ./configure --prefix=${_prefix_} || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 4. Compile Python
cd "${_build_}"
if [ ! -f "${_prefix_}/lib/libpython3.so" ]; then
  tar -xf ${_src_}/Python-*.*.*.tgz || exit 1
  cd Python-*.*.*/
  ./configure --prefix=${_prefix_} \
              --with-openssl=${_prefix_} \
              --with-ensurepip \
              --enable-shared \
              --enable-optimizations \
              --enable-loadable-sqlite-extensions || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 5. Compile Tcl
cd "${_build_}"
if [ ! -f "${_prefix_}/lib/tclConfig.sh" ]; then
  tar -xf ${_src_}/tcl*.*.*.tar.gz || exit 1
  cd tcl*.*.*/unix/
  ./configure --prefix=${_prefix_} \
              --enable-threads \
              --enable-shared \
              --enable-64bit || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 6. Compile ICU4c
cd "${_build_}"
if [ ! -f "${_prefix_}/bin/icu-config" ]; then
  tar -xf ${_src_}/icu-release-*-*.tar.gz || exit 1
  cd icu-release-*-*/icu4c/source/
  ./runConfigureICU Linux --prefix=${_prefix_} \
                          --enable-icu-config || exit 1
  make -j 5 || exit 1
  sudo make install
fi

# 7. Compile libedit
cd "${_build_}"
if [ ! -f "${_prefix_}/lib/libedit.so" ]; then
  tar -xf ${_src_}/libedit-*-*.*.tar.gz || exit 1
  cd libedit-*-*.*/
  ./configure --prefix=${_prefix_} || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 8. Compile bison
cd "${_build_}"
if [ ! -f "${_prefix_}/bin/bison" ]; then
  tar -xf ${_src_}/bison-*.*.tar.gz || exit 1
  cd bison-*.*/
  ./configure --prefix=${_prefix_} || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 9. Compile gettext
cd "${_build_}"
if [ ! -f "${_prefix_}/bin/gettext" ]; then
  tar -xf ${_src_}/gettext-*.*.tar.gz || exit 1
  cd gettext-*.*/
  ./configure --prefix=${_prefix_} \
              --with-libiconv-prefix=${_prefix_} \
              --enable-shared || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 10. Compile flex
cd "${_build_}"
if [ ! -f "${_prefix_}/bin/flex" ]; then
  tar -xf ${_src_}/flex-*.*.*.tar.gz || exit 1
  cd flex-*.*.*/
  ./autogen.sh || exit 1
  ./configure --prefix=${_prefix_} || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 11. Compile Kerberos5
cd "${_build_}"
if [ ! -f "${_prefix_}/lib/libgssapi_krb5.so" ]; then
  tar -xf ${_src_}/krb5-*.*.*.tar.gz || exit 1
  cd krb5-*.*.*/src/
  ./configure --prefix=${_prefix_} || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 12. Compile libiconv
cd "${_build_}"
if [ ! -f "${_prefix_}/lib/libiconv.so" ]; then
  tar -xf ${_src_}/libiconv-*.*.tar.gz || exit 1
  cd libiconv-*.*/
  ./configure --prefix=${_prefix_} || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 13. Compile libxml2
cd "${_build_}"
if [ ! -f "${_prefix_}/bin/xml2-config" ]; then
  tar -xf ${_src_}/libxml2-*.*.*.tar.gz || exit 1
  cd libxml2-*.*.*/
  ./configure --prefix=${_prefix_} \
              --with-icu \
              --with-iconv=${_prefix_} \
              --with-python-install-dir=${_prefix_} \
              --with-zlib=${_prefix_} || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 14. Compile libxslt
cd "${_build_}"
if [ ! -f "${_prefix_}/lib/libxslt.so" ]; then
  tar -xf ${_src_}/libxslt-*.*.*.tar.gz || exit 1
  cd libxslt-*.*.*/
  ./configure --prefix=${_prefix_} \
              --with-python=${_prefix_} \
              --with-libxml-prefix=${_prefix_}/bin \
              --with-libxml-include-prefix=${_prefix_}/include/libxml2 \
              --with-libxml-libs-prefix=${_prefix_}/lib \
              CPPFLAGS="$(xml2-config --cflags)" \
              LDFLAGS="-L${_prefix_}/lib" \
              LIBS="-lxml2 -lz -liconv -licui18n -licuuc -licudata -lm -ldl" || exit 1
  make -j 5 || exit 1
  sudo make install || exit 1
fi

# 15. Compile OSSP-UUID
cd "${_build_}"
if [ ! -f "${_prefix_}/lib/libuuid.so" ]; then
    tar -xf ${_src_}/uuid-*.*.*.tar.gz || exit 1
    cd uuid-*.*.*/
    ./configure --prefix=${_prefix_} \
                --with-perl=${_prefix_} || exit 1
    make -j 5 || exit 1
    sudo make install || exit 1
fi

#---------------------------#
# Finally, build PostgreSQL #
#---------------------------#
cd ${_top_}

make clean > /dev/null 2>&1

./configure \
  --prefix=${_prefix_} \
  --with-includes=${_prefix_}/include \
  --with-libraries=${_prefix_}/lib \
  --enable-nls='ja' \
  --with-perl \
  --with-python \
  --with-tcl \
  --with-tclconfig=${_prefix_}/lib \
  --with-gssapi \
  --with-icu \
  --with-openssl \
  --with-libedit-preferred \
  --with-uuid=ossp \
  --with-libxml \
  --with-libxslt \
  ICU_CFLAGS="$(icu-config --cppflags)" \
  ICU_LIBS="$(icu-config --ldflags)" \
  CPPFLAGS="$(xml2-config --cflags)" || exit 1
make world -j 5 || exit 1
#sudo make install-world || exit 1
sudo make install || exit 1

exit 0
