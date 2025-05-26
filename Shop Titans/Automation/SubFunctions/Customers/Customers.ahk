﻿#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#Include Case_Manager.ahk
#SingleInstance Force


class Customer
{
	__New(inventory) 
	{
		this.inventory := inventory
		this.Type := ""
		this.case_manager := Case_Manager()
	}
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
	GetType()
	{
		if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
		{
			if(PixelSearch(&pX, &pY, 829, 130, 855, 150, 0xF1C638, 3))		;check if its king reinhold
				this.Type := "reinhold"
			if(PixelSearch(&pX, &pY, 953, 311, 971, 322, 0xECE168, 1))      ;checks if it is a seller
				this.Type := "seller"
			else if(!PixelSearch(&pX, &pY, 1318, 396, 1346, 422, 0x522C44, 2) and PixelSearch(&pX, &pY, 747, 622, 797, 657, 0xF7491E, 2) and !PixelSearch(&pX, &pY, 695, 513, 754, 545, 0x522C44, 3))     ;check if its a hero
				this.Type := "hero"
			else if(PixelSearch(&pX, &pY, 952, 312, 968, 321, 0xECE4CE, 3))     ;checks if it is a buyer
				this.Type := "buyer"
		}
		else if(PixelSearch(&pX, &pY, 74, 883, 174, 932, 0xEFE7D3, 1) and PixelSearch(&pX, &pY,898, 836, 984, 906, 0xEFE7D3, 1) and PixelSearch(&pX, &pY, 1689, 860, 1804, 930, 0xEFE7D3, 1))		;checks for dialog
            this.Type := "dialog"
		else
			this.Type := "nothing"
	}
	UpdateInventory()
	{
		if(PixelSearch(&pX, &pY, 1901, 114, 1916, 138, 0xCF9318, 3))        ;check(~90%)
		{
			WriteToInfoStorage("InventoryCapacity.txt", 0.9)
			this.inventory := 0.9
		}
		else if(PixelSearch(&pX, &pY, (1893 - 20), 109, 1916, 138, 0xCF9318, 3))          ;check for full inventory brown bar on the right (true of > 75% full)
		{
			WriteToInfoStorage("InventoryCapacity.txt", 0.75)
			this.inventory := 0.75
		}
		else if(PixelSearch(&pX, &pY, 1745, 104, 1790, 145, 0x402F1F, 3) and PixelSearch(&pX, &pY, 1745, 104, 1790, 145, 0xE1B658, 3))		;check for the inventory crate in the upper right
		{
			WriteToInfoStorage("InventoryCapacity.txt", 0.5)
			this.inventory := 0.5
		}
		else if(PixelSearch(&pX, &pY, 1890, 110, 1906, 133, 0x61360F, 3))
		{
			WriteToInfoStorage("InventoryCapacity.txt", 0.5)
			this.inventory := 0.5
		}
	}
	AutoCustomer()
	{
		if(this.inventory >= 0.75)
		{
			this.surcharge()
			Sleep(500)
			this.SmallTalk()
			Sleep(500)
			this.Sell()
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