/*
  1.2.4.1 Assegnamento di costo minimo
  L'agenzia matrimoniale Cuori Solitari deve organizzare il gran ballo di fine
  anno. L'agenzia ha n clienti maschi e n clienti femmine, ed ha prenotato n
  tavoli da due posti al famoso ristorante Cupido. Dai profili psicologici
  raccolti dai clienti, l'agenzia è in grado di calcolare, per ogni maschio i,
  l'insieme F(i) delle femmine con le quali potrebbe essere interessato ad
  intrecciare una relazione, e che potrebbero essere interessate ad intrecciare
  una relazione con lui; un analogo insieme M(j) può essere ottenuto per ogni
  femmina j. Dai profili dei clienti, l'agenzia è anche in grado di calcolare,
  per ogni coppia (i, j) "compatibile", il costo c_ij della cena da offrire, che
  deve consistere di piatti graditi ad entrambi i commensali. L'agenzia vuole
  quindi decidere come formare le coppie per il gran ballo in modo da evitare
  coppie incompatibili e minimizzare il costo complessivo delle cene.
*/

param n integer >= 0;
param F{i in 1..n, j in 1..n} binary; # F[i, j] = j \in F_i
param c{i in 1..n, j in 1..n} > 0;

var x{i in 1..n, j in 1..n} binary; # il maschio i invita a cena la femmina j

minimize obj: sum{i in 1..n, j in 1..n}c[i, j] * x[i, j];

c1 {i in 1..n}: sum{j in 1..n}x[i, j] = 1;
c2 {j in 1..n}: sum{i in 1..n}x[i, j] = 1;
c3 {i in 1..n, j in 1..n}: x[i, j] <= F[i, j];

data;
param n 0;
end;
