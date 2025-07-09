#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#SingleInstance Force

Class MenuManager
{
    Static clickSlot(slotNumber)
    {
        if(slotNumber > 0 and slotNumber < 10)
        {
            ClickAtCoord(107 + (206 * (slotNumber - 1)), 718)
        }
        else
        {
            MsgBox("Someone codding this messed up because this case has not been added. Click ok to see details")
            MsgBox("Error: function domain exception, clickSlot(slotNumber); {slotNumber|0 < slotNumber < 10}, slotNumber = " slotNumber)
        }
    }
    static SlotNonZero(slotNumber)
    {
        if(PixelSearch(&pX, &pY, 160 + (206 * (slotNumber - 1)), 736, 177 + (206 * (slotNumber - 1)), 746, 0x7B716D, 4))          ;check if capacity is greater than zero by scanning for white numbers
        {
            return true
        }
        else
            return false
    }
}