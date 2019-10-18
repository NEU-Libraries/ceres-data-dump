

# adjust these for where the output should go
# each directory will get its own CSV file of data
# that has to be manually collated into a spreadsheet
# 'cuz library-tech people love them their spreadsheets
pluginsDataDir="/var/www/html/wp-plugins"
usersDataDir="/var/www/html/wp-users/"

# vm is for the different vm boxes that might be relevant to the localhost database settings
# archives sites are on a different vm than other CERES sites, so we need to dump the results into
# different directories based on where we're logged in to run the script
# the appropriate directory(ies) must exist before running the script

# from Karl Yee in slack:

# When using wp-cli to manage a WP site, you have to do the VM where the site’s db lives.  Even though most,  if not all the CERES site files are on a single NFS mount, their respective databases and vhost configs lives on one of two VMs.
# The Archives department have their CERES db and vhost config files on nb9313.neu.edu.  So … you have to log into nb9313.neu.edu and run wp-cli from there to manage Archive’s CERES sites (e.g voices) .

# if it hits a non-WP site, or per above the db connection doesn't work, there will be a 0 byte output to be ignored when collating

# adapted from https://www.golinuxcloud.com/how-to-pass-multiple-parameters-in-shell-script-in-linux/  
while [ ! -z "$1" ]; do
  case "$1" in
     --vm)
         shift
         vm=$1
         ;;
     *)
        echo 'something went wrong, and I should display help info someday' #eventually this will show help info
        vm="nb9313"
        ;;
  esac
shift
done


for d in */ ; do
    echo "$d"
     cd /var/www/html/$d
     wp plugin list --format=csv > $pluginsDataDir/$vm/${d%/}-plugins.csv
     wp user list --format=csv > $usersDataDir/$vm/${d%/}-users.csv
done

