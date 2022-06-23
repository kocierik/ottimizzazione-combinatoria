/*
  1.2.1.2 Il problema della Fonderia
  Una fonderia deve produrre 1000 pezzi del peso ciascuno di un chilogrammo. Il
  ferro con cui tali pezzi sono fatti dovrà contenere manganese e silicio nelle
  seguenti quantità:
  0.45% ≤ manganese
  3.25% ≤ silicio ≤ 5.5%
  Sono disponibili tre tipi di materiale ferroso con le seguenti
  caratteristiche:
  Materiale ferroso    A     B     C
  Silicio (%)        4.00  1.00  0.60
  Manganese (%)      0.45  0.50  0.40
  Costo (Euro / kg.) 0.025 0.030 0.018
  Inoltre si può aggiungere direttamente manganese al costo di 10 Euro al kg. Il
  problema che si vuole modellare `e quello di determinare il piano di
  produzione che minimizza il costo del materiale utilizzato. Si vuole cioè
  individuare le quantità di materiale per ciascuno dei tre tipi A, B, o C e di
  manganese puro da acquistare per produrre i 1000 pezzi richiesti, spendendo il
  meno possibile.
*/

param q >= 0; # numero di kg da produrre
param mnmin >= 0 <= 1; # manganese minimo
param simin >= 0 <= 1; # silicio minimo
param simax >= simin <= 1; # silicio massimo
param sia >= 0 <= 1; # silicio in a
param sib >= 0 <= 1; # silicio in b
param sic >= 0 <= 1; # silicio in c
param mna >= 0 <= 1; # manganese in a
param mnb >= 0 <= 1; # manganese in b
param mnc >= 0 <= 1; # manganese in c
param ca >= 0; # costo di a
param cb >= 0; # costo di b
param cc >= 0; # costo di c
param cm >= 0; # costo del manganese puro

var xa >= 0 <= q; # quantità di a da acquistare
var xb >= 0 <= q; # quantità di b da acquistare
var xc >= 0 <= q; # quantità di c da acquistare
var xm >= 0 <= q; # quantità di m da acquistare

c1: xa + xb + xc + xm = q;
c2: mna * xa + mnb * xb + mnc * xc + xm >= mnmin * q;
c3: sia * xa + sib * xb + sic * xc >= simin * q;
c4: sia * xa + sib * xb + sic * xc <= simax * q;

minimize obj: ca * xa + cb * xb + cc * xc + cm * xm;

solve;

display xa, xb, xb, xm;

data;
param q 1000;
param mnmin 0.0045;
param simin 0.0325;
param simax 0.055;
param sia 0.04;
param sib 0.01;
param sic 0.006;
param mna 0.0045;
param mnb 0.005;
param mnc 0.004;
param ca 0.025;
param cb 0.03;
param cc 0.018;
param cm 10;
end;
