#Requires AutoHotkey v2.0
#SingleInstance Force

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
}

myclass := TestClass("temp")
;myclass.tempProperty := "change" ; comment this out to get init value
msgbox "test: " myclass.tempProperty
msgbox myclass.test(2,2)