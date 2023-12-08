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
    s|search) echo "search";;
    i|install) echo "install";;
    l|list) echo "list";;
    u|update) echo "update";;
    r|remove) echo "remove";;
    h|help ) echo "print this massage";;
    v|version) echo "version: $MANA_VERSION";;
    * ) echo "Relax yourself!";;
  esac

  exit $?
}
