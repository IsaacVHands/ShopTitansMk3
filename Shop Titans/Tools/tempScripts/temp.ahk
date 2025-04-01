CraftItem(x, y)
{
    if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F))          ;check if the crafting menu is still open
    {
        ClickAtCoord(x, y)      ;craft item in the given slot
        sleep(500)
        if(PixelSearch(&pX, &pY, 737, 650, 766, 704, 0xFFB729, 2))      ;check if it needs to buy components from the market
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
                    info := "CraftFailed"
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
            ClickAtCoord(1098, 687)     ;click yes
        }
        if(PixelSearch(&pX, &pY, 1209, 355, 1230, 367, 0xFF3F18, 2) or PixelSearch(&pX, &pY, 909, 715, 1031, 756, 0x3F61C0, 2) or PixelSearch(&pX, &pY, 833, 649, 858, 663, 0x18F355))        ;check if recource menu is open or unlock with blueprints button or the buy a summoner button is open
        {
            Send("{Esc}")
            Sleep(300)
            info := "CraftFailed"
        }
        else if(PixelSearch(&pX, &pY, 611, 154, 789, 204, 0xFF2D00, 2))        ;check if the workers level is too low
        {
            info := "CraftFailed"
        }
    }
}