_makePorts(){
  # enter the stage environment.
  cd $MANA_STAGEDIR

  # save ports to $MANA_PKGDIR.
  tar -cv --use-compress-program=pigz -f $MANA_PKGDIR/$name-$version.tar.gz *

  if [ -z $(find $MANA_PKGDIR -name "$name-$version.tar.gz") ]; then
    echo "Failed to save ports to $name-$version.tar.gz"
    exit $?
  fi
    echo "Success: $name-$version.tar.gz"
}

_installPorts(){
  # enter the stage environment.
  cd $MANA_ROOTDIR

  # install saved ports from $MANA_PKGDIR.
  if [ -z $(find $MANA_PKGDIR -name "$name-$version.tar.gz") ]; then
    echo "Failed to load ports from $name-$version.tar.gz"
    exit $?
  fi

  # just extract it.
  tar xvf $MANA_PKGDIR/$name-$version.tar.gz
}
