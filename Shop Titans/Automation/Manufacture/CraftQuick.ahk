﻿#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Event"
{
    ClickAtCoord(1803, 914)     ;open crafting menu
    Sleep(500)
    ;ClickAtCoord(107, 735)      ;craft item IN SLOT ONE
    ;ClickAtCoord(308, 735)      ;craft item IN SLOT TWO
    ;ClickAtCoord(526, 735)      ;craft item IN SLOT THREE
    /*ClickAtCoord(723, 735)      ;craft item IN SLOT THREE
    sleep(500)
    if(PixelSearch(&pX, &pY, 737, 650, 766, 704, 0xFFB729, 2))      ;check if it needs to buy components from the market
    {
        ClickAtCoord(834, 683)      ;click market button
        sleep(750)
        loop 10
        {
            if(!PixelSearch(&pX, &pY, 732, 724, 770, 745, 0xBA7D1F, 2))       ;check if it gets out of the components buying menu early
            {
                break
            }
            else
            {
                ClickAtCoord(835, 731)         ;click buy
            }
            Sleep(750)
        }
        if(PixelSearch(&pX, &pY, 732, 724, 770, 745, 0xBA7D1F, 2))       ;check if its stil in the components buying menu
        {
            Send("{Escape}")
        }
    }
    if(PixelSearch(&pX, &pY, 716, 428, 793, 513, 0x522C44, 3))
    {
        Send("{Escape}")
        Sleep(350)
    }
    if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 1))          ;check if the crafting menu is still open
    {
        Send("{Escape}")
        sleep(500)
    }*/
    GoToCorrectTab()
    if(PixelSearch(&pX, &pY, 462, 936, 507, 984, 0xCF9712, 3))
    {
        CapriceMode()
    }
    else
    {
        Craft4()
    }
}

ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(50)
    Click(x, y, "Left", "Up")
}
PixelCompareColor(x, y, color)
{
    if(PixelGetColor(x, y) == color)
    {
        return true
    }
    else
        return false
}
Craft4()
{
    slotX := 727        ;starts in slot 4
    slotChangeCoef := 208
    loop 4
    {
        if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F))          ;check if the crafting menu is still open
        {
            ClickAtCoord(slotX, 725)      ;craft item IN SLOT FOUR
            sleep(500)
            if(PixelSearch(&pX, &pY, 737, 650, 766, 704, 0xFFB729, 2))      ;check if it needs to buy components from the market
            {
                ClickAtCoord(834, 683)      ;click market button
                sleep(750)
                loop 10
                {
                    if(!PixelSearch(&pX, &pY, 732, 724, 770, 745, 0xBA7D1F, 2))       ;check if it gets out of the components buying menu early
                    {
                        break
                    }
                    else
                    {
                        ClickAtCoord(835, 731)         ;click buy
                    }
                    Sleep(750)
                }
                if(PixelSearch(&pX, &pY, 732, 724, 770, 745, 0xBA7D1F, 2))       ;check if its stil in the components buying menu
                {
                    Send("{Escape}")
                    Sleep(250)
                }
            }
            if(PixelSearch(&pX, &pY, 1209, 355, 1230, 367, 0xFF3F18, 2))        ;check if recource menu is open
            {
                Send("{Esc}")
                Sleep(300)
            }
            slotX -= slotChangeCoef
            Sleep(500)
        }
    }
    if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 1))          ;check if the crafting menu is still open
    {
        Send("{Escape}")
        sleep(500)
    }
}
GoToCorrectTab()
{
    if(PixelSearch(&pX, &pY, 1515, 955, 1529, 974, 0xFFCF00, 2))        ;check if the misc. tab is not selected
    {
        ClickAtCoord(1522, 969)     ;click the misc. tab
        Sleep(500)
    }
    Sleep(250)
    if(PixelSearch(&pX, &pY, 462, 936, 507, 984, 0xCF9712, 3))        ;check if the caprice tab is available
    {
        if(PixelSearch(&pX, &pY, 521, 930, 556, 951, 0x522C44, 3))      ;check if the caprice tab is not selected
        {
            ClickAtCoord(535, 966)     ;click the caprice tab
        }
        Sleep(500)
    }
    else if(PixelSearch(&pX, &pY, 283, 949, 308, 974, 0x905F7D, 3))        ;check if the bookmarks tab is not selected
    {
        ClickAtCoord(299, 959)     ;click the bookmarks tab
        Sleep(500)
    }
}
CapriceMode()
{
    loop 30
    {
        if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F))          ;check if the crafting menu is still open
        {
            ClickAtCoord(103, 725)      ;craft item in slot 1
            sleep(500)
            if(PixelSearch(&pX, &pY, 737, 650, 766, 704, 0xFFB729, 2))      ;check if it needs to buy components from the market
            {
                ClickAtCoord(834, 683)      ;click market button
                sleep(750)
                loop 10
                {
                    if(!PixelSearch(&pX, &pY, 732, 724, 770, 745, 0xBA7D1F, 2))       ;check if it gets out of the components buying menu early
                    {
                        break
                    }
                    else
                    {
                        ClickAtCoord(835, 731)         ;click buy
                    }
                    Sleep(750)
                }
                if(PixelSearch(&pX, &pY, 732, 724, 770, 745, 0xBA7D1F, 2))       ;check if its stil in the components buying menu
                {
                    Send("{Escape}")
                    Sleep(250)
                }
            }
            if(PixelSearch(&pX, &pY, 1209, 355, 1230, 367, 0xFF3F18, 2) or PixelSearch(&pX, &pY, 909, 715, 1031, 756, 0x3F61C0, 2))        ;check if recource menu is open or unlock with blueprints button
            {
                Send("{Esc}")
                Sleep(300)
            }
            else
            {
                CraftSlotShift()
            }
            Sleep(500)
        }
    }
    if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 1))          ;check if the crafting menu is still open
    {
        Send("{Escape}")
        sleep(500)
    }
}
CraftSlotShift()
{
    MouseMove(518, 725)
    Sleep(100)
    Send("{LButton Down}")
    Sleep(100)
    MouseMove(277, 725, 20)
    Sleep(100)
    Send("{LButton Up}")
}