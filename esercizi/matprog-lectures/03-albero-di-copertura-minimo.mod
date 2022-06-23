/*
  Albero di copertura minimo
*/

param n integer >= 0; # numero dei nodi
param m integer >= 0; # numero degli archi
param E{i in 1..m, j in 1..2} integer >= 0 <= n; # estremi degli archi
param p{i in 1..m} > 0; # pesi degli archi

var x{i in 1..m} binary; # l'i-esimo arco appartiene all'albero di copertura?

minimize obj: sum{i in 1..m} p[i] * x[i];

/*
  Per ogni taglio T del grafo,
    sum{i in 1..m} (l'arco i-esimo attraversa T) * x[i] > 0;
*/

data;
param n 0;
param m 0;
end;
