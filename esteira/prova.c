#include <stdlib.h>
#include <stdio.h>
#include "trabalho.h"

int main(int argc, char* argv[]) {
    const int FATOR_X = 10;
    int min, seg;
    float dist, vel;

    int programa;
    while (1) {
        do {
            puts("<<< Selecione o programa >>>");
            puts("1. Manual");
            puts("2. Distancia");
            puts("3. Tempo");
            puts("4. Corrida");
            puts("5. Jogging");
            puts("6. Caminhada");
            puts("0. Sair");
            printf("?-> ");
            scanf("%d", &programa);
        } while (programa < 1 || programa > 6);
        switch (programa) {
            case 0:
                return EXIT_SUCCESS;

            case 1: {
                printf("\nVelocidade [km/h]? ");
                scanf("%f", &vel);
                int hm_h = vel * 10;
                printf("Distancia [km]? ");
                scanf("%f", &dist);
                int hm = dist * 10;
                printf("Tempo [mm:ss]? ");
                scanf("%d:%d", &min, &seg);
                int fator;
                do {
                    printf("Fator de aceleracao? ");
                    scanf("%d", &fator);
                } while (fator < 2 || fator > 20);
                p1_manual(hm, min, seg, hm_h, fator);
                break;
            }
            case 2: {
                printf("\nVelocidade [km/h]? ");
                scanf("%f", &vel);
                int hm_h = vel * 10;
                printf("Distancia [km]? ");
                scanf("%f", &dist);
                int hm = dist * 10;
                int fator;
                do {
                    printf("Fator de aceleracao? ");
                    scanf("%d", &fator);
                } while (fator < 2 || fator > 20);
                p2_distancia(hm, hm_h, fator);
                break;
            }
            default: {
                printf("\nVelocidade [km/h]? ");
                scanf("%f", &vel);
                int hm_h = vel * 10;
                if (programa == 4) {
                    p4_corrida(hm_h, FATOR_X);
                } else if (programa == 5) {
                    p5_jogging(hm_h, FATOR_X);
                } else {
                    p6_caminhada(hm_h, FATOR_X);
                }
            }
        }
    }
    return EXIT_SUCCESS;
}

