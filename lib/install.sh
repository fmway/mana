E_NOARGS="75"

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
  echo $(wget -P $MANA_DISTDIR $sourceURL)

  # unpack the source code.
  tar xvf $MANA_DISTDIR/$name-$version.tar.gz -C $MANA_WORKDIR 

  # build and install to the stagged environment.
  build

  return $?
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
    return $?
  fi

  _sourceBuild $1

  return $?
}
