for cmd in 'lsblk --fs' lsblk blkid 'fdisk -l'
do
    echo ""
    echo "$cmd"
    echo ""
    $cmd
done
