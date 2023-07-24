read n

x=0
for i in $(seq $n)
do
read c
x=$((x + c))
done

printf "%.3f" $(echo "$x / $n" | bc -l)
