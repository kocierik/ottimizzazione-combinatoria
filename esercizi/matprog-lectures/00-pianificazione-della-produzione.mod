/*
  1.2.1.1 Pianificazione della produzione
  La società Pintel deve pianificare la produzione della sua fabbrica di
  microprocessori. La Pintel possiede due diverse linee di prodotti: i
  processori Pintium, più potenti e destinati al mercato “server”, ed i Coloron,
  meno potenti e destinati al mercato “consumer”. L’impianto è in grado di
  realizzare 3.000 “wafer” alla settimana: su ogni wafer trovano posto o 500
  Coloron oppure 300 Pintium. La resa di un wafer dipende anch’essa dal tipo di
  processore: i Coloron, di minori dimensioni, hanno una resa media del 60%,
  mentre i Pintium, più grandi e quindi maggiormente sottoposti a difetti,
  solamente del 50%. I processori Pintium si vendono a 500$ al pezzo, mentre i
  Coloron si vendono a 200$ al pezzo. La divisione commerciale della Pintel ha
  anche stabilito che la massima quantità di processori che possono essere messi
  sul mercato ogni settimana senza causare un calo dei prezzi è di 400.000 unità
  per i Pintium e di 700.000 unità per i Coloron. Si vuole determinare le
  quantità di ciascun tipo di processore da produrre settimanalmente in modo da
  massimizzare il ricavo totale.
*/

param wmax integer >= 0; # massimo numero di wafer
param cc integer >= 0; # capienza di un wafer in Coloron
param cp integer >= 0; # capienza di un wafer in Pintium
param rc >= 0 <= 1; # resa di un wafer per Coloron
param rp >= 0 <= 1; # resa di un wafer per Pintium
param vc >= 0; # prezzo di un Coloron
param vp >= 0; # prezzo di un Pintium
param mc integer >= 0; # massimo numero di Coloron
param mp integer >= 0; # massimo numero di Pintium

var wc integer >= 0 <= wmax; # numer di Wafer per Coloron
var wp integer >= 0 <= wmax; # numer di Wafer per Pintium
var xc <= mc; # numero di Coloron prodotti e funzionanti
var xp <= mp; # numero di Pintium prodotti e funzionanti

c1: wc + wp <= wmax;
c2: xc = wc * cc * rc;
c3: xp = wp * cp * rp;

maximize obj: vc * xc + vp * xp;

solve;

display wc, wp, xc, xp;

data;
param wmax 3000;
param cc 500;
param cp 300;
param rc 0.6;
param rp 0.5;
param vc 200;
param vp 500;
param mc 700000;
param mp 400000;
end;
