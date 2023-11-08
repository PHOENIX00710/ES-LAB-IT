#include <LPC17xx.h>
#include <stdio.h>
#include <string.h>
#define _OPEN_SYS_ITOA_EXT
#include <stdlib.h>
#define SPEED_OF_SOUND 34300

char msg1, msg[] = "dist: 1";
int temp;
int flag1 = 0, i;
unsigned long j, k;
unsigned int x;
unsigned int flag, key, col, row;

void delay()
{

    for (k = 0; k < 300; k++);
}

void lcd_port()
{
    LPC_GPIO0->FIOPIN = msg1 << 23;
    if (flag1 == 0)
        LPC_GPIO0->FIOCLR = 1 << 27;
    else
				LPC_GPIO0->FIOSET = 1 << 27;
    LPC_GPIO0->FIOSET = 1 << 28;
    for (j = 0; j < 25; j++);
    LPC_GPIO0->FIOCLR = 1 << 28;
    delay();
}

void lcd_wr()

{
    msg1 = temp & 0xF0;
    msg1 = msg1 >> 4;
    lcd_port();
    msg1 = temp & 0x0F;
    lcd_port();
}

void lcd_display()
{

    unsigned char init_comd[] = {0, 3, 3, 3, 2, 0x28, 0x0C, 0x01, 0x06, 0x80};
		// SystemInit();
    //SystemCoreClockUpdate();
    LPC_PINCON->PINSEL1 &= 0xFC003FFF;
    LPC_GPIO0->FIODIR = 0x3F << 23;
    flag1 = 0;
    for (i = 0; i < 10; i++)
    {
        temp = init_comd[i];
        lcd_wr();
    }
    flag1 = 1;
    i = 0;
		while (msg[i] != '\0')
    {
        temp = msg[i];
				lcd_wr();
        i++;
    }
}

void main()
{
    int dist;
    while (1)
    {
        lcd_display();
        delay(500);
    }
}