E_NOARGS="75"

# function to handle source code based package building.
_sourceBuild(){

}

# function to handle binary package building.
_binBuild(){

}

_install(){
  if [ -z $1 ]; then
    echo "Enter the name of the package to install"
    exit $E_NOARGS
  fi

  # find packages in the repo.
  searchP=$(find ../templates -name "$1.mana")

  # if the package is found, download the source code and build the package.
  if [ -z $searchP ]; then
    echo "installing $1"
    source "../templates/bash.mana"
    
    SRC="${MANA_WORKDIR}/${name}-${version}"
    #echo $(wget -P $MANA_DISTDIR $sourceURL)
    build

  fi
}
