_footprint(){
  # enter the stage environment.
  cd $MANA_STAGEDIR

  # create directory if it does not exist.
  if [ -z $(find $MANA_DBDIR -type d -name "$name") ]; then
    mkdir $MANA_DBDIR/$name
  fi

  # save footprints into a database.
  for i in $(find * \! -type d); do
    permission=$(stat -c "%a" $i)
    echo "$permission $i" >> $MANA_DBDIR/$name/FOOTPRINT
  done

  exit $?
}
