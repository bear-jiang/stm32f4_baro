#include <USART.h>
#include <LED.h>
#include <MPU6050.h>
#include <AK8975.h>
#include <MS5611.h>
#include <I2C_Soft.h>
#include <Timer.h>
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
	TIM6_Init(0);
	I2c_Soft_Init();
	Delay();
	
	USART1_Send(0xcc);
	data = MPU6050Init();
	USART1_Send(data);
	Delay();
	data = AK8975Init();
	USART1_Send(data);
	MS5611_Init();
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
		GetMag(&mag);

		MS5611_Read_Adc_P();
		// MS5611_Start_P();
		// USART1_Send(0x0f);
		// data = MPU6050Read(MPU_ADDR,0x3b);
		// USART1_Send(data);
		// data = MPU6050Read(MPU_ADDR,0x42);
		// USART1_Send(data);
	}



	return 0;
}