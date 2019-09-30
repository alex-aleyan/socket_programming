#include <stdio.h>

void hi_func(void)
{
printf("TYPE: \t\t\tValue:\t Units: \n");
printf("char is: \t\t%d \t byte(s)\n",sizeof(char));
printf("signed char is: \t%d \t byte(s)\n",sizeof(signed char));
printf("unsigned char is: \t%d \t byte(s)\n",sizeof(unsigned char));
printf("short is: \t\t%d \t byte(s)\n",sizeof(short));
printf("unsigned short is: \t%d \t byte(s)\n",sizeof(unsigned short));
printf("short int is: \t\t%d \t byte(s)\n",sizeof(short int));
printf("int is: \t\t%d \t byte(s)\n",sizeof(int));
printf("long int is: \t\t%d \t byte(s)\n",sizeof(long int));
printf("long is: \t\t%d \t byte(s)\n",sizeof(long));
printf("unsigned long is: \t%d \t byte(s)\n",sizeof(unsigned long));
printf("unsigned is: \t\t%d \t byte(s)\n",sizeof(unsigned));
printf("double is: \t\t%d \t byte(s)\n",sizeof(double));
printf("long double is: \t%d \t byte(s)\n",sizeof(long double));
printf("float is: \t\t%d \t byte(s)\n",sizeof(float));
}

int main(int argc, char **argv)
{
    hi_func();

return 0;
}
