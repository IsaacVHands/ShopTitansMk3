#Requires AutoHotkey v2.0
#include ../../../lib/helpers.ahk
#SingleInstance Force

Class Quest
{
    static difficulty_up(n)
    {
        loop(n)
        {
            ClickAtCoord(1499, 635)         ;click difficulty up
            Sleep(333)
            if(PixelSearch(&pX, &pY, 1490, 627, 1500, 643, 0x522C44, 2))
            {
                break
            }
        }
    }
    static difficulty_down(n)
    {
        loop(n)
        {
            ClickAtCoord(1090, 635)         ;click difficulty down
            Sleep(333)          
            if(PixelSearch(&pX, &pY, 1090, 632, 1097, 641, 0x522C44, 2))
            {
                break
            }
        }
    }
    Static get_hero_happiness()
    {
        if(PixelSearch(&pX, &pY, 478, 337, 935, 397, 0x13E533, 3))
            return 1
        else
            return 0
    }
    static maximize_party_difficulty()
    {
        loop(11)
        {
            if(this.get_hero_happiness() == 1)
                this.difficulty_up(1)
            else
                break
        }
        loop(11)
        {
            if(this.get_hero_happiness() == 0)
                this.difficulty_down(1)
            else
                break
        }
    }
    static basic_lcog()
    {
        if(PixelSearch(&pX, &pY, 215, 890, 226, 920, 0xFFB629, 3) and PixelSearch(&pX, &pY, 1866, 851, 1879, 877, 0xFFB42A, 3))            ;check for extra heroes and quest slots
        {
            ClickAtCoord(1810, 923)         ;open quest menu
            Sleep(1000)
        }
        if(PixelSearch(&pX, &pY, 26, 825, 54, 854, 0xECB859, 3) and PixelSearch(&pX, &pY, 759, 949, 769, 955, 0x522C44, 2))            ;check if the LCOG quest is available
        {
            ClickAtCoord(102, 728)        ;open the LCOG quest
            sleep(500)
            if(!PixelSearch(&pX, &pY, 1274, 778, 1303, 788, 0x206032, 3))           ;check if there are any available heros
            {
                this.maximize_party_difficulty()
                MsgBox("send quest")
                ; ClickAtCoord(1301, 761)         ;send quest
                if(!PixelSearch(&pX, &pY, 27, 930, 39, 943, 0x00FF4F, 3))       ;if there are still more questing slots
                {
                    Sleep(7000)
                    this.basic_lcog()
                }
            }
        }
    }
}