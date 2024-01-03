E_NOARGS="75"

# check package is installed or not.
_isInstalled(){
  # check the database, if directory is not exist, means not installed.
  if [ -z $(find $MANA_DBDIR -type d -name "$1") ]; then
    echo 1
    return
  fi

  # directory exist, means installed.
  echo 0
  return
}

# search the packages.
_isFound(){
  # find packages in the repo.
  searchP=$(find $MANA_PORTDIR \! -type d -name "$1.mana")

  # if not found.
  if [ -z $searchP ]; then
    echo "Package not found."
    exit $?
  fi

  # if found.
  echo $searchP
  return
}

# identify if package is binary or source based.
_isBin(){
  if [ $(echo $1 | grep -i "\-bin.mana") ]; then
    echo "$1 is binary based."
    return 0
  fi

  echo "$1 is source based."
  return 1
}

# function to handle source code based package building.
_sourceBuild(){
  # find packages in the repo.
  searchP=$(find $MANA_PORTDIR -name "$1.mana")

  if [ -z $searchP ]; then
    echo "Package not found."
    exit $E_NOARGS
  fi

  # put .mana intruction build.
  source "$searchP"

  # set the source code directory.
  SRC="${MANA_WORKDIR}/${name}-${version}"

  # get the source code from the source URL.
  if [ -z $(find $MANA_DISTDIR -name "$name-$version.tar.gz") ]; then
    echo $(wget -P $MANA_DISTDIR $sourceURL -O $MANA_DISTDIR/$name-$version.tar.gz)
  fi

  # unpack the source code.
  tar xvf $MANA_DISTDIR/$name-$version.tar.gz -C $MANA_WORKDIR 

  # build and install to the stagged environment.
  build

  # save footprints into a database.
  source "$MANA_ROOTDIR/lib/footprint.sh"
  _footprint

  # save ports.
  source "$MANA_ROOTDIR/lib/portutils.sh"
  _makePorts

  # install ports.
  _installPorts

  # save package data.
  echo $version > $MANA_DBDIR/$name/VERSION
  echo $CFLAGS > $MANA_DBDIR/$name/CFLAGS
  echo $CXXFLAGS > $MANA_DBDIR/$name/CXXFLAGS
  echo $LDFLAGS > $MANA_DBDIR/$name/LDFLAGS

  # clean the working directory.
  rm -fr $SRC
  rm -fr $MANA_STAGEDIR/*

  exit $?
}

# function to handle binary package building.
_binBuild(){
  echo "$1 Binary build."
}

_install(){
  searchP=$(find $MANA_PORTDIR -name "$1.mana")

  if [ -z $1 ]; then
    echo "Enter the name of the package to install"
    exit $E_NOARGS
  fi

  # identifies the package to be installed, whether binary or source code based.
  if [ $(echo $searchP | grep -i "\-bin.mana") ]; then
    _binBuild $1
    exit $?
  fi

  _sourceBuild $1

  exit $?
}
