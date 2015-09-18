#include <stdio.h>

int main(void){
    char nextChar;
    const char sbox[] = {8, 6, 7, 9, 3, 12, 10, 15, 13, 1, 14, 4, 0, 11, 5, 2}; //S2
    
    while(scanf("%c", &nextChar)){
        //Convert ascii to integer
        switch(nextChar){
            case '0':
            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
                nextChar -= 48;
                break;
            case 'a':
            case 'A':
                nextChar = 10;
                break;
            case 'b':
            case 'B':
                nextChar = 11;
                break;
            case 'c':
            case 'C':
                nextChar = 12;
                break;
            case 'd':
            case 'D':
                nextChar = 13;
                break;
            case 'e':
            case 'E':
                nextChar = 14;
                break;
            case 'f':
            case 'F':
                nextChar = 15;
                break;
            default:
                while(1); //If error on input, loop here.
        }
        //Substitute using sbox
        nextChar = sbox[nextChar];
        //Convert integer to ascii
        switch(nextChar){
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
                nextChar += 48;
                break;
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
                nextChar += 87;
                break;
            default:
                while(1); //If error while processing, loop here.
        }
        //Output
        printf("%c", nextChar);
    }
    return 0;
}
