#Requires AutoHotkey v2.0
#SingleInstance Force
{
    ClickAtCoord(1803, 914)     ;open crafting menu
    Sleep(500)
    ;ClickAtCoord(107, 735)      ;craft item IN SLOT ONE
    ;ClickAtCoord(308, 735)      ;craft item IN SLOT TWO
    ClickAtCoord(526, 735)      ;craft item IN SLOT THREE
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
    if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F))          ;check if the crafting menu is still open
    {
        Send("{Escape}")
        sleep(500)
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
