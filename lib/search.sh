E_NOARGS="75"

_search(){
  if [ -z $1 ]; then
    echo "Enter the name of the package to search"
    exit $E_NOARGS
  fi

  # list user search results.
  list=$(find $MANA_PORTDIR -name "*$1*.mana")

  # print user search results.
  for i in $list; do
    echo $i | rev | cut -d'/' -f1 | rev | cut -d'.' -f1
    head -n 1 $i | cut -d':' -f2
    echo
  done
  
  exit $?
}
