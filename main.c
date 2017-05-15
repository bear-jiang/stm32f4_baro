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
	MPU6050Init();
	// while(I2C_GetFlagStatus(I2C1, I2C_FLAG_BUSY));
	// USART1_Send(0x07);
	// I2C_GenerateSTART(I2C1,ENABLE);
	// while(!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_MODE_SELECT));
	// USART1_Send(0x06);
	// I2C_Send7bitAddress(I2C1,MPU_ADDR<<1,I2C_Direction_Transmitter);
	// while (!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED));
	USART1_Send(0x05);
	// I2C_SendData(I2C1,(MPU_ADDR<<1)|0);
	// while (!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_BYTE_TRANSMITTED));
	data = MPU6050Read(0x6b);
	USART1_Send(data);
	while(1)
	{
		LED_GREEN_ON();
		Delay();
		LED_GREEN_OFF();
		Delay();
		USART1_Send(0xce);
	}



	return 0;
}