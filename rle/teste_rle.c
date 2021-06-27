#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

#include "rle.h"

static void mensagem_erro(const char* nome_programa) {
    fprintf(stderr, "Uso: %s -c|-r -i ARQ-ENTRADA -o ARQ-SAIDA\n",
            nome_programa);
    fputs("Onde: -c para comprimir o arquivo de entrada\n", stderr);
    fputs("      -r para recuperar o conteudo no arquivo de entrada\n", stderr);
    fputs("      -i ARQ-ENTRADA: indica o arquivo de entrada a ser usado na operacao\n",
          stderr);
    fputs("      -o ARQ-SAIDA: indica o arquivo de saida a ser criado pela operacao\n",
          stderr);
}

int main(int argc, char* argv[]) {
    bool compressao = false, operacao_ok = false, entrada_ok = false,
         saida_ok = false;
    const char* nome_arquivo_entrada = NULL;
    const char* nome_arquivo_saida = NULL;

    // Enquanto todos os argumentos da linha de comando nao forem verificados 
    int opcao;
    while ((opcao = getopt(argc, argv, "cri:o:")) != -1) {
        switch (opcao) {
            case 'c': // opcao -c na linha de comando
                compressao = operacao_ok = true;
                break;

            case 'r': // opcao -r na linha de comando
                compressao = false;
                operacao_ok = true;
                break;

            case 'i': // nome do arquivo de entrada deve seguir a opcao -i
                nome_arquivo_entrada = optarg;
                entrada_ok = true;
                break;

            case 'o': // nome do arquivo de saida deve seguir a opcao -o
                nome_arquivo_saida = optarg;
                saida_ok = true;
                break;

            default:
                mensagem_erro(argv[0]);
                return EXIT_FAILURE;
        }
    }
    if (optind > argc || !operacao_ok || !entrada_ok || !saida_ok) {
        mensagem_erro(argv[0]);
        return EXIT_FAILURE;
    }
    // Abre o arquivo de entrada segundo o modelo POSIX/Linux
    int fd_entrada;
    fd_entrada = open(nome_arquivo_entrada, O_RDONLY);
    if (fd_entrada == -1) {
        perror("Nao foi possivel abrir o arquivo de entrada");
        return EXIT_FAILURE;
    }
    // Cria o arquivo de entrada segundo o modelo POSIX/Linux
    int fd_saida;
    mode_t permissoes = S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH;
    int operacoes = O_WRONLY | O_CREAT | O_TRUNC;
    fd_saida = open(nome_arquivo_saida, operacoes, permissoes);
    if (fd_saida == -1) {
        perror("Nao foi possivel criar o arquivo de saida");
        close(fd_entrada);
        return EXIT_FAILURE;
    }
    // Executa a operacao selecionada
    int resultado;
    if (compressao) {
        resultado = rle_compress(fd_entrada, fd_saida);
    } else {
        resultado = rle_recover(fd_entrada, fd_saida);
    }
    if (resultado == -1) {
        fputs("Operacao finalizada com ERRO\n", stderr);
    } else {
        puts("Operacao finalizada com sucesso");
    }

    // Fecha os arquivos
    close(fd_saida);
    close(fd_entrada);

    return EXIT_SUCCESS;
}