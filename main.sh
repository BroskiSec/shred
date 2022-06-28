echo "shredding file: $1 ; overwriting $2 time(s). ; please wait. . ."
x="$(du -k $1)"; x=($(echo -n $x | tr " " "\t"))
for elm in "${x[0]}"; do
    dd if=/dev/zero of=$1 count=$elm iflag=count_bytes &>/dev/null
    for ((y = 0; y < $2; y++)); do
        dd if=/dev/random of=$1 count=$(($elm + $RANDOM % 100)) iflag=count_bytes &>/dev/null
    done;
done; echo "overwritten $2 time(s) ; $1 has been shredded successfully."
