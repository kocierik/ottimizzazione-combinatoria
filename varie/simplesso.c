//AUTORE: Libera Longo
//Data: 29 dicembre 2022
//programma che scrive in automatico quello che dovremmo fare noi per risolvere
//l'algoritmo del simplesso
//per ovvi motivi non ragiona in modo grafico quindi è da verificare...
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>  //per i boolean
#include <math.h>			//per +infinito

#define human_num(n) (n+1) //serve pk gli umani contano da 1 gli indici degli array da 0

#define ENGLISH
//#define ITALIAN

int main(int argc, char* argv[]) {
	const int N_VARIABILI = 2; //se cambi questo alcuni printf sono da cambiare...

	//pochi argomenti
	if(argc < 2) {
#ifdef ENGLISH		
		printf("this simpless program work only in R^%d!\n", N_VARIABILI);
		printf("I should know how many constraint there is\n");
#endif
#ifdef ITALIAN
		printf("Questo programma del simplesso lavora solo in R^%d!\n", N_VARIABILI);
		printf("Dovresti dirmi quanti vincoli ci sono\n");
#endif
		return 42;
	}

	//dati
	const int SIZE = atoi(argv[1]);
	
	float C[N_VARIABILI];
	float A[N_VARIABILI][SIZE];
	float Noti[SIZE]; //termine noto
	int Base[N_VARIABILI];

	//inizio
#ifdef ENGLISH
	printf("You want to insert %d constraints\n", SIZE);
	printf("Insert the vector that represent c (the max objective function):\n");
#endif
#ifdef ITALIAN
	printf("Vuoi inserire %d vincoli\n", SIZE);
	printf("Inserisci il vettore che rappresenta c (la funzione obbiettivo da massimizzare):\n");
#endif
	//inserisci c (max c1*x1 + c2 * x2)
	printf("max c_1 * x_1 + c_2 * x_2\n");
	for(int v=0; v<N_VARIABILI; v++) {
		printf("c_%d = ", v); scanf("%f",&C[v]);
	}
	printf("max { (%.2f) * x_1 + (%.2f) * x_2 }\n", C[0], C[1]);

	//inserisci A x <= b
	for(int i = 0; i < SIZE; i++) {
		float b;
#ifdef ENGLISH
		printf("Insert the %d-th constraint\n", human_num(i));
#endif
#ifdef ITALIAN
		printf("Inserisci l'%d-esimo vincolo\n", human_num(i));
#endif
		//inserire vincolo i-esimo
		for(int v=0; v<N_VARIABILI; v++) {
			printf("a_%d = ", v); scanf("%f",&A[v][i]);
		}
		printf("b   = "); scanf("%f",&b); Noti[i] = b;
		printf("\t\t\t(%d)  :  (%.2f) * x_1 + (%.2f) * x_2 <= (%.2f) \n\n",
				human_num(i), A[0][i], A[1][i], b);
	}
	//inserire base B
#ifdef ENGLISH
	printf("wich constraints u want to start with (B)?\n");
#endif
#ifdef ITALIAN
	printf("da quali vincoli vuoi partire (base B)?\n");
#endif
	for(int v=0; v<N_VARIABILI; v++) {
		printf("B_%d = ", v); scanf("%d",&Base[v]);
	}
	printf("Base = { B_1 , B_2 } = { %d, %d }\n\n\n", Base[0], Base[1]);
	//riassunto
#ifdef ENGLISH
	printf("summary:\n");
#endif
#ifdef ITALIAN
	printf("riassumendo:\n");
#endif
	printf("c = [%.2f, %.2f]\n", C[0], C[1]);
	printf("A = [\t\t\tb = [\n");
	for(int i=0; i<SIZE; i++) {
		printf("[ ");
		for(int v=0; v<N_VARIABILI; v++)
			printf(" %.2f ", A[v][i]);
		printf("] \t[ %.2f ]\n", Noti[i]);
	}
	printf("]\t\t\t]\n");
	printf("B = { %d, %d }\n", Base[0], Base[1]);

	//ora decremento di uno gli indici della base così posso utilizzarli negli array...
	for( int v=0; v<N_VARIABILI; v++)
		Base[v]--;
	
	//ora che abbiamo finito di inserire i dati possiamo iniziare con l'algoritmo del simplesso
	//codice fatto nella convinzione che N_VARIABILI == 2 sia vero
	if( N_VARIABILI == 2) {
		int iterazione = 1;
		while(true) {
#ifdef ENGLISH
			printf("\n\n\n( iteration %d-th )\n", iterazione);
#endif
#ifdef ITALIAN
			printf("\n\n\n( iterazione %d-esima )\n", iterazione);
#endif
			//Base
			int vincolo0 = Base[0], vincolo1 = Base[1];
			printf("B = { %d, %d }\n", human_num(vincolo0), human_num(vincolo1));
			//A_B e A_B inversa
			float a = A[0][vincolo0], b = A[1][vincolo0], c = A[0][vincolo1], d = A[1][vincolo1];
			printf("A_B = \t[[ %.2f \t%.2f ]\n\t [ %.2f \t%.2f ]]\n", a, b, c, d);
			float det = a * d - b * c;
			printf("det = (%.2f)(%.2f) - (%.2f)(%.2f) = %.2f\n", a, d, b, c, det);
			float inv_a = d/det, inv_b = -b/det, inv_c = -c/det, inv_d = a/det;
			printf("(A_B)^-1 = [[ %.2f \t%.2f ]\n            [ %.2f \t%.2f ]]\n", inv_a, inv_b, inv_c, inv_d);
			//x
			float noto0 = Noti[vincolo0], noto1 = Noti[vincolo1];
			float x0 = inv_a * noto0 + inv_b * noto1, x1 = inv_c * noto0 + inv_d * noto1;
			printf("x = (A_B)^-1 * b_B = [[ %.2f\t%.2f ]  * [ %.2f   = [ %.2f  \n", inv_a, inv_b, noto0, x0);
			printf("                      [ %.2f\t%.2f ]]     %.2f ]     %.2f ]\n", inv_c, inv_d, noto1, x1);
			//y
			float C0 = C[0], C1 = C[1];
			float y0 = C0 * inv_a + C1 * inv_c, y1 = C0 * inv_b + C1 * inv_d;
			printf("y = c * (A_B)^-1   = [ %.2f\t%.2f] * [[ %.2f  \t%.2f ]  = [ %.2f\t%.2f ] \n", C0, C1, inv_a, inv_b, y0, y1);
			printf("                                    \t [ %.2f \t%.2f ]]\n",                  inv_c, inv_d);
			//successo?
			if (y0 >= 0 && y1 >= 0) {
#ifdef ENGLISH
				printf("If y_B >= 0 , then terminate with success and return x = [%.2f  %.2f] and y\n", x0, x1);
				printf("(to build y we know that y_B = [%.2f  %.2f], y_N = 0, where 0 is a vector)\n", y0, y1);
#endif
#ifdef ITALIAN
				printf("Se y_B >= 0 , allora termina con successo e restituisci x = [%.2f  %.2f] e y\n", x0, x1);
				printf("(per costruire y sappiamo che y_B = [%.2f  %.2f], y_N = 0, dove 0 è un vettore)\n", y0, y1);
#endif
				break; //uscita dal while(true)
			}		
			//h
			int h = ( y0 < 0 ? vincolo0 : vincolo1 );
			printf("h = min { i ∈ B | y_i < 0 } = %d\n", human_num(h));
			//ξ
			float epsilon0 = ( y0 < 0 ? -inv_a : -inv_b ), epsilon1 = ( y0 < 0 ? -inv_c : -inv_d ) ;
			printf("(A_B)^-1 = [[ %.2f \t%.2f ]\n            [ %.2f \t%.2f ]]\n", inv_a, inv_b, inv_c, inv_d);
#ifdef ENGLISH
			printf("ξ column of index h (%d) in -((A_B)^-1). ξ = [ %.2f  \n", human_num(h), epsilon0);
			printf("                                              %.2f ]\n", epsilon1);
#endif
#ifdef ITALIAN
			printf("ξ colonna di indice h (%d) in -((A_B)^-1). ξ = [ %.2f  \n", human_num(h), epsilon0);
			printf("                                                %.2f ]\n", epsilon1);
#endif
			//A_N ξ
#ifdef ENGLISH
			printf("(to calculate A_N ξ we should: for every i ∈ N we calculate A_i ξ as product row by column)\n");
#endif
#ifdef ITALIAN
			printf("(per calcolare A_N ξ dovremo: per ogni i ∈ N calcoliamo A_i ξ come prodotto riga per colonna)\n");
#endif
			bool problema_illimitato = true;
			float last_value = +INFINITY; //serve math.h
			int k;
			for(int i=0; i<SIZE; i++)
				if(i != vincolo0 && i != vincolo1) {
					float a_0 = A[0][i], a_1 = A[1][i];
					float result = a_0 * epsilon0 + a_1 * epsilon1;
#ifdef ENGLISH
					printf("A_%d ξ = row [ %.2f  %.2f ] * column [ %.2f  %.2f ] = %.2f\n", human_num(i), a_0, a_1, epsilon0, epsilon1, result);
#endif
#ifdef ITALIAN
					printf("A_%d ξ = riga [ %.2f  %.2f ] * colonna [ %.2f  %.2f ] = %.2f\n", human_num(i), a_0, a_1, epsilon0, epsilon1, result);
#endif
					if(result > 0) { //stampo le possibili scelte di k
						problema_illimitato = false;
						printf("A_%d ξ > 0\n", human_num(i));
						//scelta di k
						float nominatore = Noti[i] - ( a_0 * x0 + a_1 * x1 ) ;
						float k_value = nominatore / result ;
#ifdef ENGLISH
						printf(" b_%d - A_%d x    %.2f -  row [ %.2f  %.2f ] *  column [ %.2f  %.2f ]   %.2f\n", human_num(i), human_num(i), Noti[i], a_0, a_1, x0, x1, nominatore);
#endif
#ifdef ITALIAN
						printf(" b_%d - A_%d x    %.2f - riga [ %.2f  %.2f ] * colonna [ %.2f  %.2f ]   %.2f\n", human_num(i), human_num(i), Noti[i], a_0, a_1, x0, x1, nominatore);
#endif
						printf("------------- = ---------------------------------------------------- = ---- = %.2f\n", k_value);
						printf("    A_%d ξ                               %.2f                           %.2f\n\n", human_num(i), result, result);
						//choose if k_value is the minimum value until now.
						if(k_value < last_value) {
							last_value = k_value;
							k = i;
						}
					}
				}
			//problema illimitato?
			if(problema_illimitato) {
#ifdef ENGLISH
				printf("If A_N ξ ≤ 0, then terminate and return ξ = [ %.2f  %.2f ] : the problem is unlimited\n", epsilon0, epsilon1);
#endif
#ifdef ITALIAN
				printf("Se A_N ξ ≤ 0, allora termina e restituisci ξ = [ %.2f  %.2f ] : il problema è illimitato\n", epsilon0, epsilon1);
#endif
				break; //uscita dal while(true)
			}
			//k
			printf("k = argmin { ( b_i - A_i x ) / ( A_i ξ ) | A_i ξ > 0 ∧ i ∈ N } = %d\n", human_num(k));
			//nuova base
			int non_refused = ( h == Base[0] ? Base[1] : Base[0] );
			int min_vincolo = ( k < non_refused ? k : non_refused ) , max_vincolo = ( k > non_refused ? k : non_refused ) ;
			printf("B_%d = B_%d ∪ {k} − {h} = {%d, %d} ∪ {%d} − {%d} = {%d, %d}\n", iterazione+1, iterazione, human_num(Base[0]), human_num(Base[1]), human_num(k), human_num(h), human_num(min_vincolo), human_num(max_vincolo));
			Base[0] = min_vincolo; Base[1] = max_vincolo;
			iterazione ++;
		}
	} else
#ifdef ENGLISH
		printf("If u want to CHANGE N_VARIABILI in the code then u should understood how to do A^-1 (INVERSE MATRIX OF A)\n");
#endif
#ifdef ITALIAN
		printf("Se tu volessi cambiare N_VARIABILI nel codice allora dovresti capire come calcolare A^-1 (INVERSA DI A)\n");
#endif
}

