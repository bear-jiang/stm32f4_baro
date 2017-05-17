#include <USART/USART.h>
#include <LED/LED.h>
#include <MPU6050/MPU6050.h>

void Delay()
{
	int i,j;
	for(i=0;i<1000;i++)
	{
		for(j=0;j<10000;j++)
		{

		}
	}
	return;
}

int main()
{
	uint8_t data;
	LED_Init();
	USART1_Init(115200);
	I2C1_Init();
	Delay();
	
	USART1_Send(0x08);
	data=MPU6050Init();
	USART1_Send(data);
	while(1)
	{
		LED_GREEN_ON();
		Delay();
		LED_GREEN_OFF();
		Delay();
		MPU6050GetGyro(&gyro);
		MPU6050GetAcc(&acc);
		// USART1_Send(0xf0);
		// USART1_Send(gyro.x_data>>8);
		// USART1_Send(gyro.x_data&0x08);
		// USART1_Send(0x0f);
		// data = MPU6050Read(MPU_ADDR,0x3b);
		// USART1_Send(data);
		// data = MPU6050Read(MPU_ADDR,0x42);
		// USART1_Send(data);
	}



	return 0;
}