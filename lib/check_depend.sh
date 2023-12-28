function check_dependency {
if ! (builtin command -V "$1" >/dev/null 2>&1); then
echo -e "missing dependency: can\'t find $1"  
return 1            
  fi
}                                          
