#!/bin/sh
if [ ! -d ~/texmf/web2c ] ; then
 mkdir ~/texmf/web2c
fi
cd ~/texmf/web2c
tex -ini -translate-file=cp8bit.tcx spplain \dump
pdftex -ini -translate-file=cp8bit.tcx spdflain \dump
