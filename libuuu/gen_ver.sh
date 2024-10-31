#!/bin/sh

# Input parameters
file_to_write="$1"

set -e

if [ -f ../.tarball-version ]
then
	echo "#define GIT_VERSION \"lib$(cat ../.tarball-version)\"" > "$file_to_write"
	exit 0
fi

if [ "${APPVEYOR_BUILD_VERSION}" != "" ];
then
<<<<<<< HEAD
	git tag uuu_${APPVEYOR_BUILD_VERSION}
=======
	echo build not in appveyor
else
	git tag -m"uuu ${APPVEYOR_BUILD_VERSION}" uuu_${APPVEYOR_BUILD_VERSION}
>>>>>>> origin/master
fi

# Test if we are in a repo
if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ];
then
	#echo "In a repo"
	# Get the version of the last commit of the repo
<<<<<<< HEAD
	version=$(git describe --tags --long)
	if [ "$(cat "$file_to_write" 2>/dev/null)" != "#define GIT_VERSION \"lib$version\"" ];
	then
	  echo "#define GIT_VERSION \"lib$version\"" > "$file_to_write"
  fi
=======
	version=`git describe --long`
	echo "#define GIT_VERSION \"lib$version\"" > $file_to_write
>>>>>>> origin/master
fi
