#Requires AutoHotkey v2.0
#SingleInstance Force
{
    slotNumber := 1
    questing := true
    while questing == true
    {
        loop slotNumber
        {
            if(PixelSearch(&pX, &pY, 1694, 119, 1739, 161, 0x2CE84F, 3))        ;chekc if the quest is done
            {
                questing := false
            }
            ClickAtCoord(1686, 935)
            sleep(750)
            if(PixelSearch(&pX, &pY, 1694, 119, 1739, 161, 0x2CE84F, 3))        ;chekc if the quest is done
            {
                questing := false
            }
            if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 1))      ;check if it was a quality item thus needing the collect button pushed
            {
                if(!PixelSearch(&pX, &pY, 2491, 364, 2505, 375, 0x1EF65A, 1))         ;check if a rush is needed
                {
                    ClickAtCoord(849, 701)
                    Sleep(500)
                    if(PixelSearch(&pX, &pY, 1201, 300, 1237, 338, 0xFF3E17, 3))        ;check if the rush failed
                    {
                        ClickAtCoord(1216, 319)     ;x out of the menu
                    }
                }
                sleep(350)
                if(PixelSearch(&pX, &pY, 720, 736, 732, 750, 0x522C44, 3) or !PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 3))
                {
                    sleep(750)
                    ClickAtCoord(808, 747)
                    Sleep(500)
                }
            }
        }
        if(PixelSearch(&pX, &pY, 1694, 119, 1739, 161, 0x2CE84F, 3))        ;chekc if the quest is done
        {
            questing := false
        }
        if(PixelSearch(&pX, &pY, 1845, 851, 1875, 887, 0xFFBA29, 3))        ;check if there is a crafting slot available
        {
            ClickAtCoord(1803, 914)
            Sleep(500)
            loop slotNumber
            {
                ClickAtCoord(107, 732)
                sleep(200)
            }
            sleep(500)
            if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F))          ;check if the crafting menu is still open
            {
                Send("{Escape}")
                sleep(500)
            }
        }
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
