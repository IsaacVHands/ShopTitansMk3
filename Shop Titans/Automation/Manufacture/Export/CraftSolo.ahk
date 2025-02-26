#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Event"
{
    a := true
    while(a)
    {
        if(WinActive("Shop Titans"))
        {
            if(PixelSearch(&pX, &pY, 1647, 964, 1719, 997, 0xFFCB19, 3))         ;check if an item is done crafting
            {
                HarvestItem()
                Sleep(500)
            }
            if(PixelSearch(&pX, &pY, 1838, 851, 1880, 889, 0xFFB529, 3))        ;if there is an empty crafting slot
            {
                ClickAtCoord(1803, 914)     ;open crafting menu
                Sleep(500)

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
        }
        Sleep(1000)
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
                    if(PixelSearch(&pX, &pY, 744, 729, 791, 749, 0x7E7E7E, 2))         ;checks if there are no components on the market
                    {
                        loop 2
                        {
                            Send("{Esc}")
                            Sleep(500)
                        }
                        CraftSlotShift()
                        break
                    }
                    else
                    {
                        ClickAtCoord(835, 731)         ;click buy
                    }
                    Sleep(750)
                }
                if(PixelSearch(&pX, &pY, 732, 724, 770, 745, 0xBA7D1F, 2))       ;check if its still in the components buying menu
                {
                    Send("{Escape}")
                    Sleep(250)
                }
            }
            else if(PixelSearch(&pX, &pY, 1004, 675, 1058, 713, 0x21F45A, 2))   ;scan for "using high quality item"
            {
                ClickAtCoord(2713, 360)     ;click yes
            }
            if(PixelSearch(&pX, &pY, 1209, 355, 1230, 367, 0xFF3F18, 2) or PixelSearch(&pX, &pY, 909, 715, 1031, 756, 0x3F61C0, 2))        ;check if recource menu is open or unlock with blueprints button
            {
                Send("{Esc}")
                Sleep(300)
                CraftSlotShift()
            }
            else if(PixelSearch(&pX, &pY, 611, 154, 789, 204, 0xFF2D00, 2))        ;check if the workers level is too low
            {
                CraftSlotShift()
            }
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
HarvestItem()
{
    ClickAtCoord(1680, 939)     ;collects item
    Sleep(250)
    if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 1))      ;check if it was a quality item thus needing the collect button pushed
    {
        if(PixelSearch(&pX, &pY, 720, 736, 732, 750, 0x522C44, 3) or !PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 3))
        {
            sleep(750)
            ClickAtCoord(808, 747)
            Sleep(500)
        }
    }
}