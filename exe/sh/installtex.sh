#!/bin/dash

# creates ~/bin if there isn't one
if [ ! -d ~/bin ]
then
 echo 'mkdir ~/bin'
 mkdir ~/bin
fi

# writes links in ~/bin to scripts in ~/texmf/exe/sh
echo "cd ~/texmf/exe/sh/"
      cd ~/texmf/exe/sh/
for f in *.sh
do
 echo "rm -f ~/bin/$(basename $f '.sh')"
       rm -f ~/bin/$(basename $f '.sh')
 echo "ln -s ~/texmf/exe/sh/$f ~/bin/$(basename $f '.sh')"
       ln -s ~/texmf/exe/sh/$f ~/bin/$(basename $f '.sh')
done

# creates ~/texmf/exe/bin if there isn't one
if [ ! -d ~/texmf/exe/bin ]
then
 echo 'mkdir ~/texmf/exe/bin'
 mkdir ~/texmf/exe/bin
fi

# generates c binaries
echo "cd ~/texmf/exe/c/"
      cd ~/texmf/exe/c/
for f in *
do
 echo "gcc -o ../bin/$(basename $f '.c') $f"
       gcc -o ../bin/$(basename $f '.c') $f
done

# writes links in ~/bin to binaries in ~/texmf/exe/bin
echo "cd ~/texmf/exe/bin/"
      cd ~/texmf/exe/bin/
for f in *
do
 echo "rm -f ~/bin/$f"
       rm -f ~/bin/$f
 echo "ln -s ~/texmf/exe/bin/$f ~/bin/$f"
       ln -s ~/texmf/exe/bin/$f ~/bin/$f
done

# builds formats
echo "~/texmf/exe/sh/wmake.sh"
      ~/texmf/exe/sh/wmake.sh

# updates everything
## It did not work with "su -". Never tried with sudo!!
echo "Now I will update everyting"
## su -
echo "sudo update-updmap"
      sudo update-updmap
echo "sudo mktexlsr"
      sudo mktexlsr
echo "sudo updmap-sys"
      sudo updmap-sys
