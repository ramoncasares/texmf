set TEXMFCNF=c:\tex\texmf.local\web2c;c:\tex\texmf\web2c;d:\texmf\web2c
D:\bin\win32\tftopl cmr17.tfm cmr17.pl
D:\bin\win32\tftopl cmr12.tfm cmr12.pl
D:\bin\win32\tftopl cmr10.tfm cmr10.pl
D:\bin\win32\tftopl cmr9.tfm cmr9.pl
D:\bin\win32\tftopl cmr8.tfm cmr8.pl
D:\bin\win32\tftopl cmr7.tfm cmr7.pl
D:\bin\win32\tftopl cmr6.tfm cmr6.pl
D:\bin\win32\tftopl cmr5.tfm cmr5.pl
c:\tex\bin\win32\tex &spplain makeecr
D:\bin\win32\vptovf ecr17.vpl ecr17.vf ecr17.tfm
D:\bin\win32\vptovf ecr12.vpl ecr12.vf ecr12.tfm
D:\bin\win32\vptovf ecr10.vpl ecr10.vf ecr10.tfm
D:\bin\win32\vptovf ecr9.vpl ecr9.vf ecr9.tfm
D:\bin\win32\vptovf ecr8.vpl ecr8.vf ecr8.tfm
D:\bin\win32\vptovf ecr7.vpl ecr7.vf ecr7.tfm
D:\bin\win32\vptovf ecr6.vpl ecr6.vf ecr6.tfm
D:\bin\win32\vptovf ecr5.vpl ecr5.vf ecr5.tfm
copy *.vf C:\TeX\texmf.local\fonts\vf\public\ecr
copy *.tfm C:\TeX\texmf.local\fonts\tfm\public\ecr
del *.pl
del *.vpl
del *.vf
del *.tfm
del *.fd
del cmr*.mtx
del makeecr.log
