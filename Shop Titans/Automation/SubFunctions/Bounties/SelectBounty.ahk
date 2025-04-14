#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#SingleInstance Force

{
    if(PixelSearch(&pX, &pY, 257, 906, 281, 919, 0xD51607, 2))      ;check for goals tab
    {
        ClickAtCoord(281, 929)      ;open goals tab
        Sleep(500)
    }
    if(PixelSearch(&pX, &pY, 828, 719, 881, 770, 0xFAD11B, 2))      ;check for go to bounty board button
    {
        ClickAtCoord(978, 750)      ;click go to bounty board
        Sleep(500)
        ClickAtCoord(972, 497)      ;click on the first bounty
        loop 20
        {
            if(PixelSearch(&pX, &pY, 801, 543, 809, 550, 0x65E321, 2) or PixelSearch(&pX, &pY, 792, 527, 817, 563, 0x6EFF2E, 2))      ;check if there is any green on the bounty(I.E. its a surcharge/sell item bounty)
            {
                ClickAtCoord(1088, 698)     ;accept quest
                Sleep(500)
                Send("{Esc}")
                break
            }
            else
            {
                Send("{right}")      ;go to the next bounty
            }
            Sleep(400)
        }
        loop 3
        {
            Send("{Esc}")
            Sleep(333)
        }
    }
    else
    {
        Send("{Esc}")
    }
}