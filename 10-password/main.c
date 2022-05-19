#include <stdlib.h>
#include <stdio.h>

const char* correct_password = "pippo";


void login_valid()
{
    printf("Login effettuato!\n Ecco le tue informazioni personali:\n");
    printf(".....\n");
    exit(0);
}


int checkpassword()
{
    int valid=0;
    char user_password[16];


    printf("Enter password: ");
    scanf("%s", user_password );

    const char* pPass = correct_password;
    char* pUserPass = user_password;

    while( *pPass != 0 && *pUserPass != 0 && *pPass == *pUserPass )
    {
        ++pPass;
        ++pUserPass;
    }
    
    if( *pPass==0 && *pUserPass==0 )
        valid = 1;

    return valid;
}


int main()
{
    if( checkpassword() )
    {
        login_valid();
        return 0;
    }

    printf("Password errata.\n");
    return 3;
}   
