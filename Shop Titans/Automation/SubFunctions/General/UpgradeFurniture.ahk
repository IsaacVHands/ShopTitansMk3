#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#Include ../Customers/Scan.ahk
#SingleInstance Force

Class Furniture
{
    static findFurniture()
    {
        ClickAtCoord(1009, 682)
        Sleep(1000)
        if(Scan.WaitButton())
        {
            return false
        }
        else if(PixelSearch(&pX, &pY, 1807, 945, 1824, 970, 0x552B44, 2))         ;check for edit button
        {
            ;
        }
    }
}