#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#Include Basic.ahk
#SingleInstance Force

Class Case_Manager
{
    King(customerZone)
    {
        Sleep(1500)
        if(PixelSearch(&pX, &pY, 708, 538, 773, 551, 0x522C44, 2) or PixelSearch(&pX, &pY, 713, 538, 767, 553, 0x453B42, 2))          ;check if the king has a surcharge button
        {
            if(CheckEnergyLevel(0.5))
            {
                Basic.Suggest()
                Sleep(500)
                Basic.Sell()
            }
            else
            {
                Basic.Wait()
                Sleep(500)
                zoneDif := customerZone[3] - customerZone[1]
                sliverQuantity := 4
                zoneSliver := zoneDif/sliverQuantity
                a := 0
                loop(sliverQuantity)
                {
                    if(PixelSearch(&pX, &pY, customerZone[1]+zoneSliver*a, customerZone[2], customerZone[3], customerZone[4], 0xEFEAD6, 1))         ;Look for and click on the customer bubble in the specific sub customer zone
                    {
                        ClickAtCoord(pX, pY)          ;click on the customer in the subzone
                        Sleep(500)
                        if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
                        {
                            if(PixelSearch(&pX, &pY, 829, 130, 855, 150, 0xF1C638, 3))          ;checks for king reinhold
                                ClickAtCoord(968, 756)      ;Wait
                            else
                                break
                        }
                    }
                    Sleep(1500)
                    a++
                }
            }
        }
        else
        {
            Basic.Sell()
        }
    }
    Hero(inventoryLevel, heroTokenMode)
    {
        if(heroTokenMode)
        {
            if(PixelSearch(&pX, &pY, 1288, 614, 1350, 657, 0x21F75D, 3))        ;check if there is enough items for the hero
            {
                Basic.Sell()
                Sleep(750)
                if(PixelSearch(&pX, &pY, 1014, 674, 1065, 711, 0x21F75D, 3))        ;scan for sell warning
                {
                    ClickAtCoord(1103, 698)     ;click yes
                }
            }
            else
            {
                ClickAtCoord(1247, 641)     ;click restock
                Sleep(500)
                ClickAtCoord(840, 675)      ;click market
                sleep(500)
                loop 8
                {
                    if(PixelSearch(&pX, &pY, 734, 698, 776, 714, 0xFFBA29, 3))      ;scan for buy button
                    {
                        ClickAtCoord(851, 724)      ;click buy
                    }
                    else if(PixelSearch(&pX, &pY, 1288, 614, 1350, 657, 0x21F75D, 3))       ;scan for sell button
                    {
                        Basic.Sell()
                        Sleep(750)
                        if(PixelSearch(&pX, &pY, 1014, 674, 1065, 711, 0x21F75D, 3))        ;scan for sell warning
                        {
                            ClickAtCoord(1103, 698)     ;click yes
                        }
                        Sleep(600)
                    }
                    Sleep(333)
                }
                Sleep(1000)
                if(PixelSearch(&pX, &pY, 1288, 614, 1350, 657, 0x21F75D, 3))        ;check for green sell button
                {
                    Basic.Sell()
                    Sleep(750)
                    if(PixelSearch(&pX, &pY, 1014, 674, 1065, 711, 0x21F75D, 3))        ;scan for sell warning
                    {
                        ClickAtCoord(1103, 698)     ;click yes
                    }
                }
                else
                {
                    Basic.Refuse()
                    Sleep(500)
                    ClickAtCoord(1105, 645)     ;confirm
                }
            }
        }
        else
        {
            Sleep(1000)
            Basic.sell()    ;click the sell button
            Sleep(500)
            Send("{Esc}")
            Sleep(500)
            if(PixelSearch(&pX, &pY, 2334, 295, 2382, 325, 0xF7491F, 3))        ;check if escape brought up the quit game menu
            {
                Send("{Esc}")
                Sleep(500)
            }
            Basic.Refuse()
            Sleep(500)
            ClickAtCoord(1105, 645)     ;confirm
        }
    }
   /* Buyer(inventory_level)
    {

    }*/
    Seller(current_customer)
    {
        Sleep(500)
        Customer.SmallTalk()
        Sleep(500 * 2)
        Customer.Buy()
        Sleep(500)
        current_customer.UpdateInventory()
        if(PixelSearch(&pX, &pY, 798, 156, 1115, 198, 0xFF2D00, 2))     ;check for inventory full red letters
        {
            Customer.Refuse()
        }
        /*Sleep(500)
        if(PixelSearch(&pX, &pY, 798, 156, 1115, 198, 0xFF2D00, 2))     ;check for inventory full red letters
        {
            ClickAtCoord()      ;click ok after buying something from a worker
        }*/
        return current_customer
    }
    Buyer(current_customer)
    {
    if(PixelSearch(&pX, &pY, 1335, 518, 1355, 531, 0x522C44, 3) and PixelSearch(&pX2, &pY2, 1295, 617, 1348, 647, 0x21F75D, 3))    ;Check if surcharge is possible and if the item is in stock
        {
            Customer.Surcharge()       ;surcharge
            Sleep(500)
        }
        if(PixelSearch(&pX, &pY, 949, 233, 1173, 289, 0x49FB21, 3) and PixelSearch(&pX2, &pY2, 1295, 617, 1348, 647, 0x21F75D, 3))    ;Check if auto surcharge has accured(or item surcharged) and if the item is in stock
        {
            Customer.SmallTalk()
            Sleep(500 * 2)
            Customer.Sell()
            Sleep(500)
            current_customer.UpdateInventory()
        }
        else if(PixelSearch(&pX, &pY, 1331, 622, 1379, 647, 0xFFB729, 3))           ;check for restock yellow in the sell position
        {
            Customer.Refuse()      ;refuse because the item is out of stock
            Sleep(500)
            if(PixelSearch(&pX, &pY, 996, 620, 1046, 648, 0x23F75D, 3))
            {
                ClickAtCoord(1025, 642)
                Sleep(500)
            }
        }
        else
        {
            if(current_customer.inventory > 0.5 or Random(1, 20) == 20)
            {
                Customer.SmallTalk()
                Sleep(500 * 2)
                if(PixelSearch(&pX, &pY, 1335, 518, 1355, 531, 0x522C44, 3))
                {
                    Customer.Surcharge()
                    sleep(500)
                }
                Customer.Sell()
                Sleep(300)
                current_customer.UpdateInventory()
                Sleep(500)
            }
            else if(PixelSearch(&pX, &pY, 599, 613, 640, 659, 0xF74A21, 3))  ;check for refuse button
            {
                Customer.Refuse()      ;refuse because the surcharge price is to high
                Sleep(750)
            }
        }
    }
}