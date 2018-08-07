#include <stdio.h>

#define NIBBLES 2

int descomprime(int fd_entrada, int fd_saida) {
    FILE* infile = fdopen(fd_entrada, "rb");
    if (infile == NULL) {
        perror("Bad input file descriptor");
        return -1;
    }
    FILE* outfile = fdopen(fd_saida, "w");
    if (outfile == NULL) {
        perror("Bad output file descriptor");
        return -1;
    }
    while (!feof(infile)) {
        char c = fgetc(infile);
        if (c == EOF) {
            if (ferror(infile)) {
                perror("Could not read from input file");
                return -1;
            }
        } else {
            unsigned char v[NIBBLES] = { (c >> 4) & 0xf, c & 0xf };
            int n;
            for (n=0; n<NIBBLES; ++n) {
                if (v[n] < 10) {
                    v[n] += '0';
                } else {
                    switch (v[n]) {
                        case 10:
                            v[n] = '.';
                            break;

                        case 11:
                            v[n] = '-';
                            break;

                        case 12:
                            v[n] = ' ';
                            break;

                        case 13:
                            v[n] = '\n';
                            break;

                        case 15:
                            goto fim;
                            break;

                        default:
                            printf("Invalid code %#hhx found in input file\n", v[n]);
                            return -1;
                    }
                }
                if (fputc(v[n], outfile) == EOF) {
                    perror("Could not write to output file");
                    return -1;
                }
            }
        }
    }
fim:
    fflush(outfile);
    return 0;
}
