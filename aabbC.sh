_jail="/httpd.java.jail_2"
printf "The java jail is located at %s\nStarting chroot()...\n" $_jail

NOW=$(date)
echo $NOW

die(){
  local error=${1:-Undefined error}
  echo "$0: $LINE $error" 
}
# call die() with an argument 
die "File not found"
 
 
# call die() without an argument 
die

declare -r LEN=10
echo "len=$LEN"
#LEN=20  #variable.sh: line 20: LEN: readonly variable
#cannot unset: readonly variable
#unset LEN

readonly NUM=20
#NUM=30
