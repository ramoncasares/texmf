#!/bin/sh
if [ ! -d ~/texmf/web2c ] ; then
 mkdir ~/texmf/web2c
fi
cd ~/texmf/web2c
tex -ini spplain \dump
tex -ini esplain \dump
pdftex -ini spdflain \dump
