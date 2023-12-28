E_NOARGS="75"
MANA_VERSION="0.0.1"

# basic usage parameter.
_usage() {
  # exit when script without any argument.
  if [ -z $1 ]; then
    echo -e "Error: Please input specified arguments try \`mana --help\' for details."
    exit $E_NOARGS
  fi

  case "$1" in
    s|search) source "$MANA_ROOTDIR/lib/search.sh"
      _search $2;;
    i|install) source "$MANA_ROOTDIR/lib/install.sh"
      _install $2;;
      # Saya memberikaan opsi -e pada echo Agar nanti dapat memberikan kemudahan membuat dokumentasi untuk option help
    l|list) echo -e "list";;
    u|update) echo -e "update";;
    r|remove) echo -e "remove";;
    h|help ) echo -e "print this massage";;
    v|version) echo -e "version: $MANA_VERSION";;
    * ) echo -e "$(basename $0): options not recognized -$opt";;
    
  esac

  exit $?
}
