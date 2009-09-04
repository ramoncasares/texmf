set TEXMFCNF=c:\tex\texmf.local\web2c;c:\tex\texmf\web2c;d:\texmf\web2c
rem set TEXMFCNF=d:\texmf\web2c
D:\bin\win32\tftopl cmr17.tfm cmr17.pl
D:\bin\win32\tftopl cmr12.tfm cmr12.pl
D:\bin\win32\tftopl cmmi12.tfm cmmi12.pl
D:\bin\win32\tftopl cmr10.tfm cmr10.pl
D:\bin\win32\tftopl cmmi10.tfm cmmi10.pl
D:\bin\win32\tftopl cmr9.tfm cmr9.pl
D:\bin\win32\tftopl cmmi9.tfm cmmi9.pl
D:\bin\win32\tftopl cmr8.tfm cmr8.pl
D:\bin\win32\tftopl cmmi8.tfm cmmi8.pl
D:\bin\win32\tftopl cmr7.tfm cmr7.pl
D:\bin\win32\tftopl cmmi7.tfm cmmi7.pl
D:\bin\win32\tftopl cmr6.tfm cmr6.pl
D:\bin\win32\tftopl cmmi6.tfm cmmi6.pl
D:\bin\win32\tftopl cmr5.tfm cmr5.pl
D:\bin\win32\tftopl cmmi5.tfm cmmi5.pl
D:\bin\win32\tex makecmrj
D:\bin\win32\vptovf cmr17j.vpl cmr17j.vf cmr17j.tfm
D:\bin\win32\vptovf cmr12j.vpl cmr12j.vf cmr12j.tfm
D:\bin\win32\vptovf cmr10j.vpl cmr10j.vf cmr10j.tfm
D:\bin\win32\vptovf cmr9j.vpl cmr9j.vf cmr9j.tfm
D:\bin\win32\vptovf cmr8j.vpl cmr8j.vf cmr8j.tfm
D:\bin\win32\vptovf cmr7j.vpl cmr7j.vf cmr7j.tfm
D:\bin\win32\vptovf cmr6j.vpl cmr6j.vf cmr6j.tfm
D:\bin\win32\vptovf cmr5j.vpl cmr5j.vf cmr5j.tfm
copy *.vf C:\TeX\texmf.local\fonts\vf\public\cmrj
copy *.tfm C:\TeX\texmf.local\fonts\tfm\public\cmrj
rem del *.pl
rem del *.vpl
del *.vf
del *.tfm
del *.fd
rem del cmr*.mtx
rem del cmmi*.mtx
rem del makecmrj.log
