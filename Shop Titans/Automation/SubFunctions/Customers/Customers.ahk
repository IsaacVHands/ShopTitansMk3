#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../../../lib/helpers.ahk

class Customer
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
	static Suggest()
	{
		ClickAtCoord(649, 522)      ;suggest
	}
	GetType()
	{
		if(PixelSearch(&pX, &pY, 953, 311, 971, 322, 0xECE168, 1))      ;checks if it is a seller
		{
			this.type := "seller"
		}
		else if(!PixelSearch(&pX, &pY, 1318, 396, 1346, 422, 0x522C44, 2) and PixelSearch(&pX, &pY, 747, 622, 797, 657, 0xF7491E, 2) and !PixelSearch(&pX, &pY, 695, 513, 754, 545, 0x522C44, 3))     ;check if its a hero
		{
			this.type := "hero"
		}
		else if(PixelSearch(&pX, &pY, 952, 312, 968, 321, 0xECE4CE, 3))     ;checks if it is a buyer
		{
			this.type := "buyer"
		}
	}
}
/*
class TestClass {
	__New(temp) 
    {
		this.tempProperty := temp ; "this" works in __New()
	}
	tempProperty 
    {
		set => this.myOthertempProperty := value ; if I use "this" here then it hangs and crashes and hangs
		get => this.myOthertempProperty          ; if I use "this" here then it hangs and crashes and hangs
	}
	test(x,y) 
    {
		return x+y
	}
	refuse()
	{
		ClickAtCoord(684, 633)      ;refuse
	}
}

myclass := TestClass("temp")
;myclass.tempProperty := "change" ; comment this out to get init value
msgbox "test: " myclass.tempProperty
msgbox myclass.test(2,2)
*/