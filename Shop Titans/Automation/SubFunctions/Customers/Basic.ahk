#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#SingleInstance Force

class Basic
{
    static Refuse()
	{
		ClickAtCoord(684, 633)      ;refuse
	}
	static SmallTalk()
	{
		ClickAtCoord(632, 523)      ;smalltalk
	}
	static Surcharge()
	{
		ClickAtCoord(1279, 518)        ;surcharge
	}
	static Sell()
	{
		ClickAtCoord(1303, 630)     ;sell
	}
	static Buy()
	{
		ClickAtCoord(1303, 630)     ;Buy
	}
	static Suggest()
	{
		ClickAtCoord(649, 522)      ;suggest
	}
	static Wait()
	{
		ClickAtCoord(968, 756)      ;Wait
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