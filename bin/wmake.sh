#!/bin/sh
if [ ! -d /home/papa/texmf/web2c ] ; then
 mkdir /home/papa/texmf/web2c
fi
cd /home/papa/texmf/web2c
tex -ini spplain \dump
pdftex -ini spdflain \dump

