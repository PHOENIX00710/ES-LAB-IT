#include <stdio.h>
#include <LPC17xx.h>
#define PRESCALE (25-1) 
#define LED_Pinsel 0xff    // P0.4-0.11
#define RS_CTRL 0x08000000 // P0.27 To inform whether it is command or data
#define EN_CTRL 0x10000000 // P0.28 Enable Pin first goes high then low
#define DT_CTRL 0x07800000 // P0.23 to P0.26 data lines
#define TRIG (1 << 15)     // P0.15
#define ECHO (1 << 16)     // P0.16

char command_init[] = {0x30, 0x30, 0x30, 0x20, 0x28, 0x0c, 0x06, 0x01, 0x80};
int temp, temp1, temp2 = 0;
int flag = 0;
int i, j, k, l, r, echoTime = 5000;
float distance = 0;

void clear_ports(void);
void lcd_write(void);
void port_write(void);
void lcd_display(unsigned char *buf1);
void delay(unsigned int r1);
void clearDisplay(void);

void delay(unsigned int r1)
{
    for (r = 0; r < r1; r++);
}

void clearDisplay(void)
{
    temp = 0x01;
    lcd_write();
    delay(10000);
    return;
}

void clear_ports(void)
{
    /* Clearing the lines at power on */
    LPC_GPIO0->FIOCLR = DT_CTRL; // Clearing data lines
    LPC_GPIO0->FIOCLR = RS_CTRL; // Clearing RS line
    LPC_GPIO0->FIOCLR = EN_CTRL; // Clearing Enable line
    delay(3200);
    return;
}

void port_write(void)
{
    LPC_GPIO0->FIOPIN = temp;
    if (flag)
        LPC_GPIO0->FIOSET = RS_CTRL;
    else
        LPC_GPIO0->FIOCLR = RS_CTRL;
    LPC_GPIO0->FIOSET = EN_CTRL;
    delay(25);
    LPC_GPIO0->FIOCLR = EN_CTRL;
    return;
}

void lcd_write(void)
{
    temp = temp2 & 0xf0;
    temp = temp << 19;
    port_write();
    temp = temp2 & 0x0f;
    temp = temp << 23;
    port_write();
    delay(3200);
    return;
}

void lcd_init() // LCD initialization
{
    /* Ports initialized as GPIO */
    LPC_PINCON->PINSEL1 &= 0xFC003FFF; // P0.23 to P0.28
    /* Setting the directions as output */
    LPC_GPIO0->FIODIR |= DT_CTRL;
    LPC_GPIO0->FIODIR |= RS_CTRL;
    LPC_GPIO0->FIODIR |= EN_CTRL;
    flag = 0;
    clear_ports();
    for (j = 0; j < 4; j++)
    {
        temp = command_init[j] << 19;
        port_write();
        delay(30000);
    }
    for (j = 4; j < 8; j++)
    {
        temp2 = command_init[j];
        lcd_write();
    }
    flag = 1;
    return;
}

void lcd_display(unsigned char *buf1) // Writing data on LCD.
{
    unsigned int i = 0;
    while (buf1[i] != '\0')
    {
        temp2 = buf1[i];
        lcd_write();
        i++;
        if (i == 16) // Moving to second line
        {
            temp2 = 0xc0;
            lcd_write();
        }
    }
    return;
}

void print_dist(float f)
{
    unsigned char msg[11] = {"dist: "};
    unsigned char ans[22] = {""};
    unsigned char space[10] = {""};
    sprintf(space, "%g", f);
    strcpy(ans, msg);
		strcat(ans,space);
    temp = 0x80;
    flag = 0;
    lcd_write();
    delay(40);
    flag = 1;
    lcd_display(&ans[0]);
}

int main()
{
    SystemInit();
    SystemCoreClockUpdate();
    LPC_PINCON->PINSEL0 &= 0xfffff00f;    // Interface LEDs P0.4-P0.11
    LPC_PINCON->PINSEL0 &= 0x3fffffff;    // Interface TRIG P0.15
    LPC_PINCON->PINSEL1 &= 0xfffffffc;    // Interface ECHO P0.16
    LPC_GPIO0->FIODIR |= TRIG;            // Direction for TRIGGER pin
    LPC_GPIO1->FIODIR |= 0 << 16;         // Direction for ECHO PIN
    LPC_GPIO0->FIODIR |= LED_Pinsel << 4; // Direction for LED
    lcd_init();
    temp2 = 0x80;
    flag = 0;
    lcd_write();
    flag = 1;
    while (1)
    {
        flag = 1;
        print_dist(1);
        delay(30);
    }
}