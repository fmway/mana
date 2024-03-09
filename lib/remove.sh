E_NOARGS=75

_remove(){
  # package to delete: $1.
  if [ -z $1 ]; then
    echo "Enter the name of the package to remove"
    exit $E_NOARGS
  fi

  # delete installed package files based on footprint.
  cd $MANA_ROOTDIR

  for i in $(cut -d' ' -f2 $MANA_DBDIR/$1/FOOTPRINT); do
    rm -v $i
  done

  # delete empty directory.
  find $MANA_ROOTDIR/etc $MANA_ROOTDIR/opt $MANA_ROOTDIR/usr -depth -type d -empty -exec rmdir -v {} \;

  # clean up database.
  rm -frv $MANA_DBDIR/$1

  # remove from the wordlist (/var/db/mana/world).
  sed -i "/$1/d" $MANA_DBDIR/world

  exit $?
}
