#include <stdbool.h>
#include <stdio.h>
#include <ctype.h>

int comprime(int fd_entrada, int fd_saida) {
    FILE* infile = fdopen(fd_entrada, "r");
    if (infile == NULL) {
        perror("Bad input file descriptor");
        return -1;
    }
    FILE* outfile = fdopen(fd_saida, "wb");
    if (outfile == NULL) {
        perror("Bad output file descriptor");
        return -1;
    }
    unsigned char byte = 0;
    bool msnibble = true;
    while (!feof(infile)) {
        char c = fgetc(infile);
        if (c == EOF) {
            if (ferror(infile)) {
                perror("Could not read from input file");
                return -1;
            } else {
                if (msnibble == false) {
                    byte |= 15;
                    if (fputc(byte, outfile) == EOF) {
                        perror("Could not write to output file");
                        return -1;
                    }
                }
            }
        } else {
            if (isdigit(c)) {
                c -= '0';
            } else {
                switch (c) {
                    case '.':
                        c = 10;
                        break;

                    case '-':
                        c = 11;
                        break;

                    case ' ':
                        c = 12;
                        break;

                    case '\n':
                        c = 13;
                        break;

                    default:
                        printf("Invalid character '%c' (%#hhx) found in input file\n", c, c);
                        return -1;
                }
            }
            if (msnibble == true) {
                byte = c << 4;
            } else {
                byte |= c;
                if (fputc(byte, outfile) == EOF) {
                    perror("Could not write to output file");
                    return -1;
                }
            }
            msnibble = !msnibble;
        }
    }
    fflush(outfile);
    return 0;
}
