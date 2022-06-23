/*
  Esercizio 1.35 Giro e Tond, i due maggiori produttori di automobili europei,
  hanno deciso di effettuare una fusione. Ciò comporta una gestione comune degli
  impianti delle due aziende, che dovranno produrre gli stessi modelli.
  Indichiamo con I e J rispettivamente gli insiemi degli impianti della Giro e
  della Tond, con K l’insieme dei mercati in cui dovrà operare la nuova azienda,
  la GiroTond, con b_k, k ∈ K, la domanda del k-esimo mercato e con c_i_k,
  i ∈ I ∪ J, k ∈ K, il costo unitario di trasporto dall’impianto al mercato k.
  Si vuole assegnare ogni mercato ad uno ed uno solo degli impianti, chiudendo
  gli impianti in eccesso. Formulare, come problema di PLI, il problema
  dell’assegnamento degli impianti ai mercati, con l’obiettivo di minimizzare i
  costi di trasporto ed il vincolo che almeno il 50% degli impianti di ciascuno
  dei due produttori rimanga aperto.
*/

param n integer >= 0;
param I{i in 1..n} integer >= 0;
param m integer >= 0;
param J{i in 1..m} integer >= 0;
param l integer >= 0;
param K{i in 1..l} integer >= 0;
param b{k in 1..l} integer >= 0;
param c{i in 1..n + m, k in 1..l} integer >= 0;

var x {i in 1..n + m, k in 1..l};

minimize obj: sum{i in 1..n + m, k in 1..l} b[k] * c[i, k] * x[i, k];

c1 {k in 1..l}: sum{i in 1..n + m} x[i, k] = 1;
c2 {i in 1..n + m}: sum{k in 1..l} x[i, k] <= 1;
c3: sum{k in 1..l} sum{i in 1..n} x[i, k] >= n / 2;
c4: sum{k in 1..l} sum{i in 1..m} x[i, k] >= n / 2;

data;
param n 0;
param m 0;
param l 0;
end;
