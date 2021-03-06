#!/bin/sh

#  lame_build_arm64.sh
#  LAMEDemo
#
#  Created by 芝麻酱 on 2020/1/15.
#  Copyright © 2020 芝麻酱. All rights reserved.

# configure是符合GUN标准的软件包发布所必备的命令
# 可以通过configure的方式来生成Makefile文件，然后使用make指令编译，使用make install指令来安装整个库
./configure \
--disable-shared \  # 关闭动态链接库
--disable-frontend \ # 不编译出LAME的可执行文件
--host=arm-apple-darwin \  # 指定库最终要运行在哪个平台上
--prefix= "./thin/arm64" \ # 指定将编译好的库放在哪个目录下
CC="xcrun -sdk iphoneos clang -arch armv7" \  # 指定交叉编译工具链的路径  这里是指gcc的路径
CFLAGS="-arch arm64 -fembed-bitcode -miphoneos-version-min=9.0" \ #指定编译时候带的参数  armv64平台 支持bitcode  系统最低版本iOS9.0
LDFLAGS="-archa arm64 -fembed-bitcode -miphoneos-version-min=9.0" # 指定链接过程中的参数
make clean
make -j8
make install
