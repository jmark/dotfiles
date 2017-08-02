# mkdir -p /run/user/$UID/scratch ~/scratch
# if ! mountpoint -q ~/scratch
# then
#     echo "Mouting: ~/scratch" 
#     sudo mount /run/user/$UID/scratch ~/scratch -o bind
# fi
# 
# mkdir -p  /run/user/$UID/cache ~/.cache
# if ! mountpoint -q ~/.cache
# then
#     echo "Mouting: ~/.cache" 
#     sudo mount /run/user/$UID/cache ~/.cache -o bind
# fi
# 
# mkdir -p /run/user/$UID/data
# if ! mountpoint -q /run/user/$UID/data
# then
#     echo "Mouting: /run/user/$UID/data"
#     sudo mount /dev/mapper/onboard /run/user/$UID/data -o subvol=/data/@$UID
# fi
# 
# for dir in $(ls /run/user/$UID/data)
# do
#     mkdir -p ~/$dir
# 
#     if ! mountpoint -q ~/$dir
#     then
#         echo "Mouting: $dir" 
#         sudo mount /run/user/$UID/data/$dir ~/$dir -o bind
#     fi
# done

function tmpmount()
{
    DIR="$1"
    mkdir -p $DIR
    if ! mountpoint -q $DIR
    then
        echo "Mouting: $DIR" 
        sudo mount -t tmpfs -o size=4G -o uid=$USER -o gid=$USER tmpfs $DIR
    fi
}

tmpmount ~/tmp
#tmpmount ~/.cache

# Load profiles from profile.d
if test -d ~/data/config/bash/profile.d/
then
	for profile in ~/data/config/bash/profile.d/*.sh
    do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

export PYTHONDONTWRITEBYTECODE=True

# some magic so that mpi for intel-fortran works
echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope

source ~/.bashrc
