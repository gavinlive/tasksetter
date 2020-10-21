DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
script1=$DIR/tasksetter.sh
script2=$DIR/tasksetterv2.sh

cmd="watch -n 300 "
#ssh monal04 -f "watch -n 1 $script1" & ssh monal04 -f "watch -n 1 $script2"

$cmd ssh monal03 -f $script1 &
$cmd ssh monal04 -f $script1 &
$cmd ssh monal05 -f $script1 &
$cmd ssh monal06 -f $script1 &
$cmd ssh lory -f $script2 &

