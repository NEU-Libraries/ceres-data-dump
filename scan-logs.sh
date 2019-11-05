

# topDir="/var/www/html/library" # the parent directory of all the glorious CERES sites

topDir="/var/www/html" # the parent directory of all the glorious CERES sites

for d in $topDir/*/ ; do
     cd $d;
     echo $d;     
     ls -l wp-content/debug.log;
done

