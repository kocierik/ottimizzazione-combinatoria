/*
  1.2.4.2 Ordinamento di lavori su macchine: minimizzazione del numero di
  macchine
  Questo problema appare frequentemente in diversi ambiti, ad esempio in quello
  manufatturiero, nella gestione di sistemi informatici e nella gestione di
  progetti. Siano dati n lavori e m macchine uguali, su cui far eseguire i
  lavori. il lavoro i-esimo, i = 1, ..., n, può essere svolto su ciascuna
  macchina e richiede un tempo di esecuzione d, indipendente dalla macchina su
  cui viene eseguito. Il lavoro i-esimo viene consegnato al tempo t_i, e deve
  essere immediatamente eseguito; essendo d_i la sua durata, l'esecuzione
  terminerà al tempo t_i + d_i. Il numero m di macchine è a priori illimitato
  (ovviamente, è sufficiente che sia m = n; se fosse m > n, alcune delle
  macchine sarebbero comunque inutilizzate). L'obiettivo è utilizzare il minimo
  numero possibile di macchine per eseguire tutti i lavori, assegnando alla
  stessa macchina lavori i cui tempi di esecuzione non si sovrappongano.
*/

param n integer >= 0;
param t{i in 1..n};
param d{i in 1..n} >= 0;
param C{i in 1..n, j in 1..n} binary; # C[i, j] = "i e j non sono compatibili"

var x{i in 1..n, j in 1..n} binary; # il lavoro i è eseguito dalla macchina j

c1 {i in 1..n}: sum{j in 1..n}x[i, j] = 1;
c2 {i in 1..n, j in 1..i - 1, k in 1..n}: x[i, k] + x[j, k] <= C[i, j] + 1;

data;
param n 0;
end;
