#include <unistd.h>

const char* const MSG = "Hello\n";
#define STDOUT 1

int main(int argc, char* argv[]) {
    write(STDOUT, MSG, 6);
    return 0;
}

