/*
  Problema dello zaino
*/

param n integer >= 0; # numero di oggetti
param p{i in 1..n} > 0; # pesi degli oggetti
param v{i in 1..n} > 0; # valori degli oggetti
param k > 0; # capacità dello zaino

var x {i in 1..n} binary; # prendo l'oggetto i?

maximize obj: sum{i in 1..n} v[i] * x[i];

c1: sum{i in 1..n} p[i] * x[i] <= k;

data;
param n 0;
end;
