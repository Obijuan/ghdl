#! /bin/sh
# This script is executed in the travis-ci environment.

# Stop in case of error
set -e

CDIR=$PWD

if [ $# -ne 0 ]; then BLD=$1; fi

# Display environment
echo "Environment:"
env

# Prepare
prefix="$CDIR/install-$BLD"
mkdir "$prefix"
mkdir build-$BLD
cd build-$BLD

# Configure
case "$BLD" in
  mcode)
      ../configure --prefix="$prefix"
      MAKEOPTS=""
      ;;

  llvm-3.5)
      ../configure --prefix="$prefix" --with-llvm-config=llvm-config-3.5
      MAKEOPTS="CXX=clang++"
      ;;

  llvm-3.8)
      ../configure --prefix="$prefix" --with-llvm-config=llvm-config-3.8
      MAKEOPTS="CXX=clang++-3.8"
      ;;

  *)
      echo "unknown build $BLD"
      exit 1
      ;;
esac

# Build
make $MAKEOPTS
make install
cd ..

# Package
PKG_VER=`grep Ghdl_Ver src/version.in | sed -e 's/.*"\(.*\)";/\1/'`

if [ "$TRAVIS_TAG" = "" ]; then
    PKG_TAG=`date -u +%Y%m%d`
else
    PKG_TAG=$TRAVIS_TAG
fi
PKG_FILE=ghdl-$PKG_VER-$BLD-$PKG_TAG.tgz
echo "creating $PKG_FILE"
tar -zcvf $PKG_FILE -C $prefix .

# Test
export GHDL="$CDIR/install-$BLD/bin/ghdl"
cd testsuite
gnatmake get_entities
./testsuite.sh
cd ..
