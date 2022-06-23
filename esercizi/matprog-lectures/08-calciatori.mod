/*
  Esercizio 1.32 Il C.T. Tramattoni, dopo la clamorosa esclusione dell’Itaglia
  dalla Coppa del Tondo, decide di rivolgersi ad un esperto di Ricerca Operativa
  per le prossime partite per i Campionati della Moneta Unica. Per le partite di
  qualificazione ha già deciso di avvalersi di una rosa di n giocatori; di
  ciascun giocatore i, i = 1, . . . , n, si conosce la bravura bi e il ruolo che
  può ricoprire in campo (uno e uno solo per giocatore). Gli n giocatori sono
  partizionati negli insiemi P dei portieri, D dei difensori, C dei
  centrocampisti e A degli attaccanti. Si dovrà far giocare almeno un giocatore
  per ciascun ruolo ma non piu` di 1 portiere, 6 difensori, 5 centrocampisti e 4
  attaccanti. Tramattoni fornisce all’esperto anche la lista L, |L| = m, delle
  coppie di giocatori che non potranno giocare assieme per incompatibilità
  tattiche e/o caratteriali. Egli richiede all’esperto di aiutarlo a definire
  una formazione di 11 giocatori che rispetti sia le limitazioni sui ruoli sia
  le incompatibilità e che massimizzi la bravura complessiva, data dalla somma
  delle bravure dei singoli giocatori. Svolgere il ruolo dell’esperto di Ricerca
  Operativa formulando come PLI il problema per Tramattoni.
*/

param n integer >= 0;
param nn integer >= 0;
param b {i in 1..n} integer;
param min integer >= 0;

param np integer >= 0;
param P{i in 1..np} integer >= 0 <= n;
param pmax integer >= min;

param nd integer >= 0;
param D{i in 1..nd} integer >= 0 <= n;
param dmax integer >= min;

param nc integer >= 0;
param C{i in 1..nc} integer >= 0 <= n;
param cmax integer >= min;

param na integer >= 0;
param A{i in 1..na} integer >= 0 <= n;
param amax integer >= min;

param m integer >= 0;
param LL{i in 1..n, j in 1..n} binary;

var x {i in 1..n} binary; # il giocatore i viene scelto

c1: sum{i in 1..n} x[i] = nn;
c2: sum{i in 1..np} x[i] >= min;
c3: sum{i in 1..np} x[i] <= pmax;
c4: sum{i in 1..nd} x[i] >= min;
c5: sum{i in 1..nd} x[i] <= dmax;
c6: sum{i in 1..nc} x[i] >= min;
c7: sum{i in 1..nc} x[i] <= cmax;
c8: sum{i in 1..na} x[i] >= min;
c9: sum{i in 1..na} x[i] <= amax;
c0 {i in 1..n, j in 1..n}: !x[i] || !x[j] || !LL[i, j];

maximize obj: sum{i in 1..n} x[i] * b[i];

data;
param n 0;
param nn 0;
param min 0;
param np 0;
param pmax 0;
param nd 0;
param dmax 0;
param nc 0;
param cmax 0;
param na 0;
param amax 0;
param m 0;
end;
