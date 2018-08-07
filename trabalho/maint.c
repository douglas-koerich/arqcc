#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

// Prototipos das subrotinas
int comprime(int fd_entrada, int fd_saida);
int descomprime(int fd_entrada, int fd_saida);

int main(int argc, char* argv[]) {
    if (argc < 4) {
        puts("Invalid parameter(s)");
        goto failed;
    }
    int opt, oper = 1;
    while ((opt = getopt(argc, argv, "cd")) != -1) {
        switch (opt) {
            case 'c':
                oper = 0;
                break;

            case 'd':
                oper = 1;
                break;

            default:
                puts("Invalid option");
                goto failed;
        }
    }
    if (optind >= argc) {
        puts("Missing parameter(s)");
        goto failed;
    }
    int fd_in = open(argv[optind], O_RDONLY);
    if (fd_in == -1) {
        perror("Could not open input file for reading");
        return EXIT_FAILURE;
    }
    int fd_out = creat(argv[optind+1], S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
    if (fd_out == -1) {
        perror("Could not create output file for writing");
        if (close(fd_in) == -1) {
            perror("Could not close input file (opened before)");
        }
        return EXIT_FAILURE;
    }
    int ret = -1;
    if (oper == 0) {
        ret = comprime(fd_in, fd_out);
    } else {
        ret = descomprime(fd_in, fd_out);
    }
    if (ret == -1) {
        printf("Failed %scompression\n", oper==0? "": "de");
    } else {
        printf("Successful %scompression\n", oper==0? "": "de");
    }

    if (close(fd_in) == -1) {
        perror("Could not close input file");
    }
    if (close(fd_out) == -1) {
        perror("Could not close output file");
    }

    return EXIT_SUCCESS;

failed:
    printf("Use: %s <-c|-d> <input-file> <output-file>, where\n", argv[0]);
    puts("     -c: Compress <input-file> into <output-file>");
    puts("     -d: Decompress <input-file> into <output-file>");
    return EXIT_FAILURE;
}
