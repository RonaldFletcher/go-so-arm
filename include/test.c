#include <stdio.h>
#include "add.h"

int main(int argc, char *argv[])
{
      char* aa = "giter";
      printf("%s\n", Add(aa, 8));
      return 0;
}
// gcc test.c -L lib/ -ladd -o test