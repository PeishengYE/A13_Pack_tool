#!/bin/sh
DIR=$(pwd)
PLATFORM=linux
CHIPS=sun5i
BOARD=a13-evb
VERSION=3.0
DATE0=$(date +%w)
DATE1=$(date +%F)
PACKAGE_LOG_DIR="$DIR"/"$DATE0"-"$DATE1"/"$VERSION"_"$CHIPS"
BUILD="$DIR"/work
LICHEEDIR="$BUILD"/"$VERSION"_"$CHIPS"
ANDROIDDIR="$BUILD"/android4.0.1 
IMGDIR="$LICHEEDIR"/tools/pack
#prepare dir
if [ -d $LICHEEDIR ];then
rm -rf $LICHEEDIR

fi
mkdir -pv $LICHEEDIR

if [ -d $PACKAGE_LOG_DIR ];then
rm -rf $PACKAGE_LOG_DIR
fi
mkdir -pv $PACKAGE_LOG_DIR

#donwload source code
cd $LICHEEDIR
#repo init -u git://172.16.1.11/manifest.git -b lichee -m a1x-dev.xml << EOF
repo init -u git://localhost/lichee.git/manifests.git -b a1x-dev << EOF
EOF
cd $LICHEEDIR
repo sync
repo start a1x-dev --all 

read -p " Please enter to continue "

#compile code
./build.sh -p $CHIPS -k $VERSION > $PACKAGE_LOG_DIR/build.log 2> $PACKAGE_LOG_DIR/build_err_warn.log

#pack package
cd $LICHEEDIR/tools/pack
./pack -csun5i -ba13-evb -plinux

#write text
#mv $IMGDIR/*.img  $PACKAGE_LOG_DIR
