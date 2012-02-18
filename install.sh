#!/bin/bash

wd=$(pwd)

ln -sf $wd/vimrc ~/.vimrc
ln -sf $wd/pmsrc ~/.pms/rc
ln -sf $wd/bashrc ~/.bashrc

source ~/.bashrc
