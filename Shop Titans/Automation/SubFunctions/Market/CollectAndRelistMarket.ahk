#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#SingleInstance Force

collectAndRelistMarket()
{
    if(PixelSearch(&pX, &pY, 262, 934, 305, 959, 0xF5BB0D, 2))       ;scan for market tab
    {
        SendInput("2")          ;open market tab
        Sleep(500)
        loop(4)
        {
            if(PixelSearch(&pX, &pY, 707, 530, 1214, 561, 0x18F354, 3))       ;Scan top row for collections
            {
                ClickAtCoord(pX, pY)            ;click collect in the top row
                Sleep(250)
            }
            if(PixelSearch(&pX, &pY, 705, 692, 1217, 727, 0x18F354, 2))       ;Scan bottom row for collections
            {
                ClickAtCoord(pX, pY)            ;click collect in the Bottom row
                Sleep(250)
            }
            if(PixelSearch(&pX, &pY, 707, 530, 1214, 561, 0xC44229, 2))       ;Scan for expired trade in the top row
            {
                ClickAtCoord(pX, pY)            ;click on the expired item in the top row
                Sleep(500)
                ClickAtCoord(1091, 704)         ;relist item
                Sleep(250)
                Send("{Escape}")
                Sleep(250)
            }
            if(PixelSearch(&pX, &pY, 705, 692, 1217, 727, 0xC44229, 2))       ;Scan for expired trade in teh bottom row
            {
                ClickAtCoord(pX, pY)            ;click on the expired item in the bottom row
                Sleep(500)
                ClickAtCoord(1091, 704)         ;relist item
                Sleep(250)
                Send("{Escape}")
                Sleep(250)
            }
        }
        Send("{Escape}")
    }
}