_footprint(){
  # enter the stage environment.
  cd $1

  # create directory if it does not exist.
  if [ -z $(find $2 -type d -name "$name") ]; then
    mkdir -p $2 || (echo "Cannot create database. Aborting." && exit 1)
  fi

  # save footprints into a database.
  for i in $(find * \! -type d); do
    permission=$(stat -c "%a" $i)
    echo "$permission $i" >> $2/FOOTPRINT || (echo "Cannot write database. Aborting." && exit 1)
  done
}
