DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
script1=$DIR/lory.sh
script2=$DIR/monal0304.sh
script3=$DIR/monal0506.sh

cmd="watch -n 300 "
#ssh monal04 -f "watch -n 1 $script1" & ssh monal04 -f "watch -n 1 $script2"

$cmd ssh monal03 -f $script2 &
$cmd ssh monal04 -f $script2 &
$cmd ssh monal05 -f $script3 &
$cmd ssh monal06 -f $script3 &
$cmd ssh lory -f $script1 &

