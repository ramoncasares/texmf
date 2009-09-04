rem set TEXMFCNF=c:\tex\texmf.local\web2c;c:\tex\texmf\web2c;d:\texmf\web2c
set TEXMFCNF=d:\texmf\web2c
D:\bin\win32\vptovf cmrj10.vpl cmrj10.vf cmrj10.tfm
copy *.vf C:\TeX\texmf.local\fonts\vf\public\cmrj
copy *.tfm C:\TeX\texmf.local\fonts\tfm\public\cmrj
rem del *.vf
rem del *.tfm
