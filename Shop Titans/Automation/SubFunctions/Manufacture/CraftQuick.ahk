#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#SingleInstance Force
SendMode "Event"
{
    if(PixelSearch(&pX, &pY, 1821, 912, 1838, 929, 0xECF0FD, 2))            ;check if the fusion tab is selected as the main tab
    {
        ClickAtCoord(1804, 827)     ;switch to crafting mode
        Sleep(500)
    }
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

Craft4()
{
    slotX := 727        ;starts in slot 4
    slotChangeCoef := 208
    loop(4)
    {
        if(!PixelSearch(&pX, &pY, (slotX-98), 844, (slotX + 92), 864, 0xB5B0B3, 3))          ;Check if there is an item bookmarked in the current slot(using the white resource letters)
        {
            slotX -= slotChangeCoef
        }
    }
    loop 10
    {
        CraftError := CraftItem(slotX)
        if(CraftError == -1)
        {
            slotX -= slotChangeCoef
            if(slotX < 0)
                break
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
        CraftError := CraftItem(103)         ;craft slot 1
        if(CraftError == -1)
        {
            CraftSlotShift()
        }
    }
    if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 1))          ;check if the crafting menu is still open
    {
        Send("{Escape}")
        sleep(500)
    }
}
CraftItem(x)
{
    info := 0
    if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F))          ;check if the crafting menu is still open
    {
        ClickAtCoord(x, 725)      ;craft item in the given slot
        sleep(500)
        if(PixelSearch(&pX, &pY, 737, 650, 766, 704, 0xFFB729, 2))      ;check if it needs to buy components from the market
        {
            if(CheckConfig("crafting.buycomponents"))       ;check if buying components is enabled
            {
                ClickAtCoord(834, 683)      ;click market button
                sleep(750)
                loop 10
                {
                    if(PixelSearch(&pX, &pY, 740, 722, 803, 747, 0x7E7E7E, 2))         ;checks if there are no components on the market
                    {
                        loop 2
                        {
                            Send("{Escape}")
                            Sleep(500)
                        }
                        info := -1
                        break
                    }
                    else if(PixelSearch(&pX, &pY, 919, 372, 991, 450, 0x9A9991, 2) and PixelSearch(&pX, &pY, 919, 372, 991, 450, 0x898A84, 2))          ;check if its a runestone
                    {
                        loop 2
                        {
                            Send("{Escape}")
                            Sleep(500)
                        }
                        info := -1
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
            else
            {
                Send("{Escape}")
                Sleep(500)
                info := -1
            }
        }
        else if(PixelSearch(&pX, &pY, 1004, 670, 1057, 715, 0x21F75A, 3))   ;scan for "using high quality item"
        {
            ClickAtCoord(1098, 687)     ;click yes
            Sleep(300)
        }
        if(PixelSearch(&pX, &pY, 1209, 355, 1230, 367, 0xFF3F18, 2) or PixelSearch(&pX, &pY, 909, 715, 1031, 756, 0x3F61C0, 2) or PixelSearch(&pX, &pY, 833, 649, 858, 663, 0x18F355))        ;check if recource menu is open or unlock with blueprints button or the buy a summoner button is open
        {
            Send("{Esc}")
            Sleep(300)
            info := -1
        }
        else if(PixelSearch(&pX, &pY, 611, 154, 789, 204, 0xFF2D00, 2))        ;check if the workers level is too low
        {
            info := -1
        }
    }
    return info
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

