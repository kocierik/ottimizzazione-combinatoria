/*
  Un’azienda alimentare deve decidere gli ingredienti del suo prossimo prodotto,
  che sarà una barretta multicereali. Ogni chilogrammo di tale prodotto conterrà
  in percentuali variabili m cereali diversi, mentre gli altri ingredienti
  avranno un peso trascurabile. Ciascun chilogrammo del cereale j contiene g_j
  grammi di grasso e costa c_j euro. Inoltre, ciascun cereale j non è
  disponibile per più di k_j tonnellate all’anno. Si formuli in PL il problema
  di determinare la composizione della barretta multicereali, sapendo che
  l’azienda intende mantenere la percentuale di grassi al di sotto di una certa
  soglia r, che intende produrre q chilogrammi di questo prodotto ogni anno, e
  che il suo scopo è quello di minimizzare i costi di produzione.
*/

param m integer >= 0;
param gg{j in 1..m} >= 0; # preprocessing: g gets converted to kgs
param c{j in 1..m} >= 0;
param kk{j in 1..m} >= 0; # preprocessing: k gets converted to kgs
param rr >= 0; # preprocessing: r's representation as fraction in [0, 1]
param q >= 0;

var x{j in 1..m} >= 0 <= 1;

minimize obj: sum{j in 1..m} c[j] * x[j];

c0 {j in 1..m}: q * x[j] <= kk[j];
c1: sum{j in 1..m} gg[j] < rr;
c2: sum{j in 1..m} x[j] = 1;
