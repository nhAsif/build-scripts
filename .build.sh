#!/bin/bash

export PATH=~/bin/:$PATH

sudo apt update && sudo apt install -y bc bison build-essential curl \
flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev \
lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev \
libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool \
squashfs-tools xsltproc zip zlib1g-dev iputils-ping &&\

cd ~/ &&\
git clone https://github.com/akhilnarang/scripts &&\
cd scripts &&\
bash setup/android_build_env.sh &&\

mkdir -p ~/bin &&\
mkdir -p ~/android/lineage &&\
mkdir -p ~/android/lineage/.repo/local_manifests &&\

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo &&\
chmod a+x ~/bin/repo &&\

git config --global user.email "najmulhasan3609@gmail.com" &&\
git config --global user.name "nhAsif" &&\

cd ~/android/lineage &&\
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest.git -b arrow-11.0 &&\
git clone https://github.com/nhAsif/local_manifest.git --depth 1 -b arrow .repo/local_manifests &&\
repo sync -j$(nproc --all) -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune &&\
cd ~/android/lineage &&\
source build/envsetup.sh &&\
lunch arrow_rosy-userdebug &&\
croot &&\
m bacon | tee logs.txt

cd ~/android/lineage &&\
curl --upload-file ./out/target/product/rosy/*.zip https://transfer.sh/nhalos.zip
