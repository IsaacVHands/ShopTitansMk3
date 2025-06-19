#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#SingleInstance Force

class Basic
{
    static Refuse()
	{
		SendInput("z")      ;refuse
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
		SendInput("c")     ;sell
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