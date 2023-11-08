#include<stdio.h>
#include<LPC17xx.h>
#define LED_Pinsel 0xff

int main(){
    int i;
    LPC_PINCON->PINSEL0=0;
    LPC_PINCON->PINSEL3=0;
    LPC_GPIO0->FIODIR=LED_Pinsel<<4;
    LPC_GPIO1->FIODIR=0<<23;
    while (1)
    {
        if((LPC_GPIO1->FIOPIN & (0x01<<23))>>23)
            LPC_GPIO0->FIOSET=LED_Pinsel<<4;
        else
            LPC_GPIO0->FIOCLR=LED_Pinsel<<4;
    }
    
}