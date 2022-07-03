# Soluzione dello scritto di Ottimizzazione combinatoria del 2022/06/06

## Esercizio 1

### Parametri

- $n$ è il numero (naturale) di clienti;
- $m$ è il numero (naturale) di incompatibilità;
- $i_k$ e $j_k$, con $1 \leq k \leq m$, sono la k-esima incompatibilità.

### Variabili

- $x_l$, con $1 \leq l \leq n$, è una variabile intera e logica che vale 1 se
  si invita l'l-esimo cliente, e 0 altrimenti.

### Obiettivo

$$ \max \sum\_{l=1}^{n} x_l $$

### Vincoli

$$ \forall l \in \{1, \dots n\}\ 0 \leq x_l \leq 1 $$

$$ \forall k \in \{1, \dots, m\}\ x*{i_k} + x*{j_k} \leq 1 $$

## Esercizio 4

### Parametri

- $n$ è il numero (naturale) dei nodi;
- $A$ è l'insieme degli archi.

### Variabili

- $x_k$, con $1 \leq k \leq n$, è una variabile intera e logica che vale 1 se
  il k-esimo nodo appartiene alla copertura, e 0 altrimenti.

### Obiettivo

$$ \min \sum\_{k=1}^{n} x_k $$

### Vincoli

$$ \forall k \in \{1, \dots n\}\ 0 \leq x_k \leq 1 $$

$$ \forall (i, j) \in A. x_i + x_j \geq 1 $$
