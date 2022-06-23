/*
  Un'azienda di trasporti specializzata nei trasporti tra l'Italia e la Polonia
  dispone di k autocarri e deve decidere cosa far loro trasportare in una certa
  settimana. Ogni camion può svolgere nella settimana in questione solo un
  viaggio di andata dall'Italia alla Polonia e il corrispondente viaggio di
  ritorno dalla Polonia verso l'Italia. L'azienda ha ricevuto dai suoi clienti
  n >= k commesse riguardanti il trasporto dall'Italia alla Polonia, ciascuna
  delle quali, chiamiamola i, porterebbe ad un ricavo per l'azienda pari a p_i,
  e richiederebbe un viaggio lungo a_i chilometri. Parimenti, le commesse dalla
  Polonia all'Italia sono pari a m >= k, e ciascuna tale commessa j porterebbe
  ad un ricavo pari a r_j e richiederebbe un viaggio lungo b_j chilometri. Ogni
  autocarro può essere utilizzato per una sola commessa nel viaggio di andata e
  per una sola commessa per il viaggio di ritorno.
  Si formuli, prima di tutto, il problema di determinare quali debbano essere le
  k commesse Italia-Polonia e le k commesse Polonia-Italia da soddisfare in modo
  da massimizzare il ricavo complessivo, allo stesso tempo garantendo che il
  numero di chilometri percorsi da ciascun camion sia al più parti ad un certo
  numero s. Si utilizzi il modello della programmazione lineare intera.
*/

param k integer >= 0; # numero di autocarri
param n integer >= k; # numero di commesse Italia-Polonia
param p {i in 1..n} integer >= 0; # ricavi per le commesse Italia-Polonia
param a {i in 1..n} integer >= 0; # distanze per le commesse Italia-Polonia
param m integer >= k; # numero di commesse Polonia-Italia
param r {j in 1..m} integer >= 0; # ricavi per le commesse Polonia-Italia
param b {j in 1..m} integer >= 0; # distanze per le commesse Polonia-Italia
param s integer >= 0; # distanza totale massima percorribile da un autocarro

var x {h in 1..k, i in 1..n} binary; # h effettua la commessa Italia-Polonia i
var y {h in 1..k, j in 1..m} binary; # h effettua la commessa Polonia-Italia j
var xx {i in 1..n} binary; # la commessa Italia-Polonia i viene effettuata
var yy {j in 1..m} binary; # la commessa Polonia-italia j viene effettuata

/*
  Il testo parla di determinare "k commesse", non "fino a k commesse" per
  massimizzare il ricavo. Assumiamo quindi che questo sia sempre possibile
  rispettando i limiti imposti da s.
*/
c1 {h in 1..k}: sum{i in 1..n} x[h, i] = 1;
c2 {h in 1..k}: sum{j in 1..m} x[h, j] = 1;
c3 {h in 1..k}: (sum{i in 1..n} x[h, i] * a[i]) + (sum{j in 1..m} x[h, j] *
  b[j]) <= s;
c4 {i in 1..n}: xx[i] = sum{h in 1..k} x[h, i];
c5 {i in 1..n}: xx[i] <= 1;
c6 {j in 1..m}: yy[j] = sum{h in 1..k} y[h, j];
c7 {j in 1..m}: yy[j] <= 1;

maximize obj: (sum{i in 1..n} xx[i] * p[i]) + sum{j in 1..m} yy[j] * r[j];

solve;

display x, y, xx, yy;

data;
param k 0;
param n 0;
param m 0;
end;
