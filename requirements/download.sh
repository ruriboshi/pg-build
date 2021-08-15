#!/bin/bash

m4_version='1.4.19'
autoconf_version='2.71'
automake_version='1.16.4'
perl_version='5.34.0'
openssl_version='1.1.1k'
zlib_version='1.2.11'
python_version='3.9.6'
tcl_version='8.6.11'
icu_version='69-1'
libedit_version='20210714-3.1'
bison_version='3.7'
gettext_version='0.21'
flex_version='2.6.0'
krb5_version='1.19.2'
libiconv_version='1.16'
libxml2_version='2.9.12'
libxslt_version='1.1.34'
uuid_version='1.6.2'


function get_version()
{
  local version_str="${1}"
  local version_type="${2^^}"

  case "${version_type}" in
    MAJOR) echo "${version_str}" | awk -F. '{print $1}' ;;
    MINOR) echo "${version_str}" | awk -F. '{print $2}' ;;
    PATCH) echo "${version_str}" | awk -F. '{print $3}' ;;
    *) echo "FATAL: Invalid version type is specified: ${version_type}" >&2
       exit 1
  esac
}

# Download the source code.
if [ ! -f "m4-${m4_version}.tar.gz" ]; then
	wget https://ftp.gnu.org/gnu/m4/m4-${m4_version}.tar.gz
fi

if [ ! -f "autoconf-${autoconf_version}.tar.gz" ]; then
	wget https://ftp.gnu.org/gnu/autoconf/autoconf-${autoconf_version}.tar.gz
fi

if [ ! -f "automake-${automake_version}.tar.gz" ]; then
	https://ftp.gnu.org/gnu/automake/automake-${automake_version}.tar.gz
fi

if [ ! -f "perl-${perl_version}.tar.gz" ]; then
  wget https://www.cpan.org/src/$(get_version ${perl_version} MAJOR).0/perl-5.34.0.tar.gz
fi

if [ ! -f "openssl-${openssl_version}.tar.gz" ]; then
  wget https://www.openssl.org/source/openssl-${openssl_version}.tar.gz
fi

if [ ! -f "zlib-${zlib_version}.tar.gz" ]; then
  wget https://zlib.net/zlib-${zlib_version}.tar.gz
fi

if [ ! -f "Python-${python_version}.tgz" ]; then
  wget https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tgz
fi

if [ ! -f "tcl${tcl_version}.tar.gz" ]; then
  wget -O tcl${tcl_version}.tar.gz https://prdownloads.sourceforge.net/tcl/tcl${tcl_version}-src.tar.gz
fi

if [ ! -f "icu-release-${icu_version}.tar.gz" ]; then
  wget -O icu-release-69-1.tar.gz https://github.com/unicode-org/icu/archive/refs/tags/release-${icu_version}.tar.gz
fi

if [ ! -f "libedit-${libedit_version}.tar.gz" ]; then
  wget https://thrysoee.dk/editline/libedit-${libedit_version}.tar.gz
fi

if [ ! -f "bison-${bison_version}.tar.gz" ]; then
  wget https://ftp.gnu.org/gnu/bison/bison-${bison_version}.tar.gz
fi

if [ ! -f "gettext-${gettext_version}.tar.gz" ]; then
  wget https://ftp.gnu.org/gnu/gettext/gettext-${gettext_version}.tar.gz
fi

if [ ! -f "flex-${flex_version}.tar.gz" ]; then
  wget https://sourceforge.net/projects/flex/files/flex-${flex_version}.tar.gz
fi

if [ ! -f "krb5-${krb5_version}.tar.gz" ]; then
  wget https://web.mit.edu/kerberos/dist/krb5/$(get_version ${krb5_version} MAJOR).$(get_version ${krb5_version} MINOR)/krb5-${krb5_version}.tar.gz
fi

if [ ! -f "libiconv-${libiconv_version}.tar.gz" ]; then
  wget https://ftp.gnu.org/gnu/libiconv/libiconv-${libiconv_version}.tar.gz
fi

if [ ! -f "libxml2-${libxml2_version}.tar.gz" ]; then
  wget http://xmlsoft.org/sources/libxml2-${libxml2_version}.tar.gz
fi

if [ ! -f "libxslt-${libxslt_version}.tar.gz" ]; then
  wget http://xmlsoft.org/sources/libxslt-${libxslt_version}.tar.gz
fi

if [ ! -f "uuid-${uuid_version}.tar.gz" ]; then
  wget ftp://ftp.ossp.org/pkg/lib/uuid/uuid-${uuid_version}.tar.gz
fi
