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
        else if(PixelSearch(&pX, &pY, 1721, 923, 1734, 937, 0x37FF5D, 2))         ;check for edit button
        {
            
        }
    }
}