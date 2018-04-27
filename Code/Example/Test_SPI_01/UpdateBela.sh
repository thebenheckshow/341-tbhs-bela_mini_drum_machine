
#! /bin/bash


# dir=`pwd`
# parentdir="$(dirname "$dir")"
#
# echo $parentdir

currentDirName=${PWD##*/}          # to assign to a variable

# printf '%s\n' "${PWD##*/}" # to print to stdout
#                            # ...more robust than echo for unusual names
#                            #    (consider a directory named -e or -n)
#
# printf '%q\n' "${PWD##*/}" # to print to stdout, quoted for use as shell input
#                            # ...useful to make hidden characters readable.

# echo $currentDirName
#echo rsync -avz -e 'ssh' ../${currentDirName} root@192.168.7.2:/root/Bela/projects/${currentDirName}/
rsync -avz -e 'ssh' ../${currentDirName} root@192.168.7.2:/root/Bela/projects

#scp -r ../${currentDirName} root@192.168.7.2:/root/Bela/projects