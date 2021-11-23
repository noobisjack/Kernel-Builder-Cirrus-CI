#!/bin/bash

# cd To An Absolute Path
cd /tmp/rom

# clone kernel tree
git clone $KT_LINK -b $KT_BRANCH --depth=1 --single-branch
cd *
wget https://withered-wind-7524.marvelmathesh.workers.dev/0:down/build-kernel.sh

# Compile
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 10G
ccache -o compression=true
ccache -z

bash build-kernel.sh

cd AnyKernel3
export kernel=$(ls *.zip)
curl -F document=@$kernel "https://api.telegram.org/bot$TG_TOKEN/sendDocument" \
        -F chat_id=$TG_CHAT_ID\
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html"
