i=0
while [ $i -ne 256 ]
do
        printf '%08X\n' $i
        i=$(($i+1))
done