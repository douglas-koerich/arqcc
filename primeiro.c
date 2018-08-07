//#include <stdio.h>
#include <unistd.h>

const char* msg = "Meu primeiro programa\n";

int main() {
    // printf(msg);
    write(1, msg, 22);  // 1=stdout; 22=numero de caracteres da mensagem
    return 0;
}
