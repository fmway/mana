_makePorts(){
  # set db dir.
  DB=var/db/mana/$name

  # enter the stage environment.
  cd $MANA_STAGEDIR

  # create database structure.
  mkdir -p $DB || (echo "Failed to create \$DB" && exit 1)

  # save package data.
  echo $version > $DB/VERSION
  echo $CFLAGS > $DB/CFLAGS
  echo $CXXFLAGS > $DB/CXXFLAGS
  echo $LDFLAGS > $DB/LDFLAGS

  # save ports to $MANA_PKGDIR.
  tar -cv --use-compress-program=pigz -f $MANA_PKGDIR/$name-$version.tar.gz * || \
    (echo "Failed to save ports to $name-$version.tar.gz" && exit 1)

  echo "Success: $name-$version.tar.gz"
}

_installPorts(){
  # enter the root environment.
  cd $MANA_ROOTDIR

  # just extract it.
  tar xvf $MANA_PKGDIR/$name-$version.tar.gz || \
    (echo "Failed to install ports. Aborting." && exit 1)
}
