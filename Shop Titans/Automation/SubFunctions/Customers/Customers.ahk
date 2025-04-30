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