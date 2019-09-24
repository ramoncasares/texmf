% firma.mp (RMCG20190920)

% run: mpost firma.mp

% uncomment and set to get the signature of any day
% commented you get today signature
% year := 2015; month := 10; day := 16;

def firma(expr charcode) =
 % parameters
 w := 4cm; h := 2cm; d := 2mm;
 save val, i, j, k, par, alfa, beta, gamma,
  exceso, grosor, base, altura, pos_acento, long_acento;
 val0uno := 60;   val0cero := 45;    % alfa
 val1uno := 60;   val1cero := 45;    % beta
 val2uno := 1;    val2cero := 5;     % exceso
 val3uno := 1pt;  val3cero := 3pt;   % grosor
 val4uno := 3/4;  val4cero := 1;     % base
 val5uno := 3/4;  val5cero := 1;     % altura
 val6uno := 0.3;  val6cero := 0.7;   % pos_acento
 val7uno := 1;    val7cero := 2;     % long_acento
 % choose values from charcode (0 <= charcode <= 255)
 i := charcode;
 for k := 0 upto 7:
  j := i mod 2; i := i div 2;
  par[k] := if odd j: val[k]uno else: val[k]cero fi;
 endfor;
 alfa := par0;       beta := par1;
 exceso := par2 * d; grosor := par3;
 base := par4 * w;   altura := par5 * h;
 pos_acento := par6; long_acento := par7 * d;
 % draw signature
 y2 = y4 = y6 = 0; x2 = 0; x4 = base/2; x6 = w;
 z2 - z1 = (exceso,0) rotated alfa;
 gamma := 1/2 * (alfa + beta);
 z3 = 1/2*(z4-z2) + (altura,0) rotated gamma;
 z51 - z4 = (d,0) rotated (180+beta);
 z52 - z4 = (d,0);
 z7 = (base/2 + pos_acento * (w - base/2), h/10);
 z8 = z7 + (long_acento,0) rotated gamma;
 pickup pencircle xscaled grosor rotated 30;
 draw z1..z2{dir alfa}..z3{right}..z4{dir(180+beta)}
  ..z51{dir(180+beta)}; draw z51..z52..z6{right};
 draw z7{dir alfa}..z8{dir beta};
 % labels(1,2,3,4,51,52,6,7,8);
enddef;

string datestring;
datestring := decimal year
  if month < 10: & "0" fi & decimal month
  if day < 10: & "0" fi & decimal day;

datenumber := (epsilon * year * 100 * 100) +
              (epsilon * month * 100) +
              (epsilon * day);
signnumber := ( datenumber - ( ( (datenumber + epsilon * 128 ) / 256) - epsilon ) * 256 ) / epsilon ;

message "date: "; show datestring; message"signature: "; show decimal signnumber; message "";

prologues := 0;
outputtemplate := "firma-" & datestring & "-%c.svg";
outputformat := "svg";

beginfig(signnumber);
 firma(signnumber);
 % hack to avoid mpost clipping
   pickup pencircle scaled epsilon;
   erase draw bbox(currentpicture);
endfig;

end.
