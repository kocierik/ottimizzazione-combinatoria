/*
  Esempio 1.2
  Il direttore di un canale televisivo per le informazioni locali deve
  organizzare il lavoro delle squadre di giornalisti e operatori per coprire n
  diversi servizi fuori sede. Il capo-redattore ha predisposto m possibili
  attività che una singola squadra può svolgere, dove una attività è l'insieme
  dei servizi che possono essere svolti e comporta un determinato costo di
  retribuzione della squadra, comprensivo dei costi per la trasferta e eventuali
  ore di straordinario. Il direttore deve decidere quali delle attività far
  svolgere in modo da pagare il meno possibile con la garanzia che ciascuno dei
  servizi sia "coperto" da almeno una squadra. Il problema è chiaramente un
  problema di copertura.
*/

param n integer >= 0;
param m integer >= 0;
param a{i in 1..n, j in 1..m} binary; # il servizio i appartiene all'attività j?
param c{j in 1..m} >= 0; # costo per l'attività j

var x{j in 1..m} binary; # l'attività j viene svolta?

minimize obj: sum{j in 1..m} c[j] * x[j];

c {i in 1..n}: sum{j in 1..m} a[i, j] * x[j] > 0;

data;
param n 0;
param m 0;
end;
