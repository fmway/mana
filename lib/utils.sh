E_NOARGS="75"
MANA_VERSION="0.0.1"

# basic usage parameter.
_usage() {
  # exit when script without any argument.
  if [ -z $1 ]; then
    echo "Error, try with --help parameter"
    exit $E_NOARGS
  fi

  case "$1" in
    s|search) source "$MANA_ROOTDIR/lib/search.sh"
      _search $2;;
    i|install) source "$MANA_ROOTDIR/lib/install.sh"
      _install $2;;
    l|list) echo "list";;
    u|update) echo "update";;
    r|remove) echo "remove";;
    h|help ) echo "print this massage";;
    v|version) echo "version: $MANA_VERSION";;
    * ) echo "$(basename $0): options not recognized -$opt";;
    
  esac

  exit $?
}
