#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#SingleInstance Force

class Basic
{
    static Refuse()
	{
		SendInput("z")      ;refuse
		Sleep(500)
		if(PixelSearch(&pX, &pY, 1003, 622, 1048, 657, 0x21F75D, 2))			;check if it is checking if you are sure
		{
			ClickAtCoord(1080, 643)			;click yes
		}
	}
	static SmallTalk()
	{
		SendInput("s")      ;smalltalk
	}
	static Surcharge()
	{
		SendInput("f")        ;surcharge
	}
	static Sell()
	{
		ClickAtCoord(1260, 633)     ;sell
	}
	static Buy()
	{
		this.Sell()     ;Buy
	}
	static Suggest()
	{
		SendInput("q")      ;suggest
	}
	static Wait()
	{
		SendInput("x")      ;Wait
	}
	static Dialog()
	{
		loop(10)
		{
			if(PixelSearch(&pX, &pY, 74, 883, 174, 932, 0xEFE7D3, 1) and PixelSearch(&pX, &pY,898, 836, 984, 906, 0xEFE7D3, 1) and PixelSearch(&pX, &pY, 1689, 860, 1804, 930, 0xEFE7D3, 1))
			{
				ClickAtCoord(930, 889)      ;click through the dialog
				Sleep(500)
			}
			else
				break
		}
	}
}