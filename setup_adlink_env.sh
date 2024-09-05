#!/bin/sh

# check folder name
path_array=()

while IFS= read -r -d '/' component; do
    path_array+=("$component")
done < <(printf '%s/' "$PWD")

for folder in "${path_array[@]}"; do
    if [[ $folder == M* ]] || [[ $folder == *-I* ]]; then
        echo "Please avoid using folder names that begin with 'M' or contain '-I' in the path, as this may result in compilation errors. Please rename the folders accordingly."
        return
    fi
done



export OPTIND=1 #reset opt index
unset DL_DIR
unset SSTATE_DIR 
usage()
{
    cat << EOF
Usage: `basename $0` [OPTIONS]

Create build environment
e.g.
	source setup_adlink_env.sh -b build_mtk -d /home/adlink/share/downloads -s /home/adlink/share/sstate-cache

 -b <BUILD_NAME>	build folder name
 -d <DOWNLOADS>		pre-downloads folder
 -s <SSTATE>		pre-sstate folder
 -h                     Show help
EOF
}
while getopts "b:d:s:" o; do
    case "${o}" in
    b)
	BUILD_DIR=${OPTARG}
	;;
    d)
        DL_DIR=$(realpath "$OPTARG")
        export DL_DIR=$DL_DIR
        ;;
    s)
        SSTATE_DIR=$(realpath "$OPTARG")
        export SSTATE_DIR=$SSTATE_DIR
        ;;
    *)
        usage
	return
        ;;
    esac
done
export TEMPLATECONF=${PWD}/src/meta-adlink-mtk/conf/templates/
source src/poky/oe-init-build-env $BUILD_DIR
export BUILD_DIR=`pwd`
export DISTRO=rity-demo
export MACHINE=lec-mtk-i1200-ufs
export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS DL_DIR SSTATE_DIR"
grep "NDA" ${BUILD_DIR}/conf/local.conf > /dev/null 2>&1 || echo NDA_BUILD = \"1\" >> ${BUILD_DIR}/conf/local.conf 

