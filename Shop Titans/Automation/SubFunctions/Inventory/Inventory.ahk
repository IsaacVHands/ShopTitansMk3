#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#SingleInstance Force

class Inventory
{
    __New()
    {
        current_inventory := -1
        max_inventory := -1
    }
    
    update_inventory()
    {
        if(PixelSearch(&pX, &pY, 374, 923, 397, 945, 0xD5A649, 2))          ;check for inventory tab button
        {
            ClickAtCoord(pX, pY)        ;open inventory
            Sleep(500)
            check
        }
    }
}