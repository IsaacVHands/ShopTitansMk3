#Requires AutoHotkey v2.0
#SingleInstance Force
{
    ClickAtCoord(1686, 935)
    sleep(750)
    if(PixelSearch(&pX, &pY, 1658, 913, 1712, 961, 0xDF9622, 3))
    {
        ClickAtCoord(1680, 939)     ;collects item
        Sleep(250)
    }
    if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 1))      ;check if it was a quality item thus needing the collect button pushed
    {
        if(PixelSearch(&pX, &pY, 720, 736, 732, 750, 0x522C44, 3) or !PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 3))
        {
            sleep(750)
            ClickAtCoord(808, 747)
            Sleep(500)
        }
    }
    if(PixelSearch(&pX, &pY, 1845, 851, 1875, 887, 0xFFBA29, 3))        ;check if there is a crafting slot available
    {
        ClickAtCoord(1803, 914)     ;open crafting menu
        Sleep(500)
        ClickAtCoord(107, 732)      ;craft item ??
        sleep(500)
        if(PixelSearch(&pX, &pY, 737, 650, 766, 704, 0xFFB729, 2))      ;check if it needs to buy components from the market
        {
            ClickAtCoord(834, 683)      ;click market button
            sleep(750)
            loop 5
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
        sleep(500)
        if(PixelSearch(&pX, &pY, 716, 428, 793, 513, 0x522C44, 3))
        {
            Send("{Escape}")
            Sleep(350)
        }
        if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F))          ;check if the crafting menu is still open
        {
            Send("{Escape}")
            sleep(500)
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
