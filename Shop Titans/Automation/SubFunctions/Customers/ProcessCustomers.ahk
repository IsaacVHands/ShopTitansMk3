#Requires AutoHotkey v2.0
#include ../../../lib/helpers.ahk
#include Customers.ahk
#SingleInstance Force
craftMode := true
heroTokenMode := false

Process_Customers(customerZone, inventoryLevel)
{
    current_customer := Customer(inventoryLevel)
    energyLevel := 0
    restartCounter := 0
    tick := 0
    loop 15
    {
        sleep(750)
        inventoryLevel := current_customer.inventory
        current_customer.GetType()
        if(current_customer.Type == "dialog")
        {
            Customer.Dialog()
            Sleep(750)
            current_customer.GetType()
        }
        if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
        {
            Sleep(500)
            if(current_customer.Type == "reinhold")          ;checks for king reinhold
            {
                current_customer.case_manager.King(CustomerZone)
            }
            else if(current_customer.Type == "seller")      ;checks if it is a seller
            {
                current_customer := Action_Buy(current_customer)
            }
            else if(current_customer.Type == "hero")     ;check if its a hero
            {
                current_customer.case_manager.Hero(inventoryLevel, heroTokenMode)
            }
            else if(current_customer.Type == "buyer")     ;checks if it is a buyer
            {
                current_customer.inventory := current_customer.case_manager.buyer(current_customer, current_customer.inventory)
                /*if(PixelSearch(&pX, &pY, 1335, 518, 1355, 531, 0x522C44, 3) and PixelSearch(&pX2, &pY2, 1295, 617, 1348, 647, 0x21F75D, 3))    ;Check if surcharge is possible and if the item is in stock
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
                    ;if(current_customer.inventory > 0.5 or Random(1, 20) == 20)
                    if(Random(1, 30) == 20)
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
                }*/
            }
            else if(PixelSearch(&pX, &pY, 1861, 80, 1893, 120, 0xFF3F18, 2))
            {
                ClickAtCoord(1884, 95)      ;Click the x for daily
            }
            else
            {
                Customer.Wait()
                break
            }
        }
        else
        {
            break
        }
        sleep(500)
        Sleep(150)
        if(PixelSearch(&pX, &pY, 798, 156, 1115, 198, 0xFF2D00, 2))     ;check for inventory full red letters
        {
            Send("{Right}")
            Sleep(500)
            current_customer.inventory := 0.9
            if(PixelSearch(&pX, &pY, 713, 296, 1205, 315, 0xEFE368, 2))     ;check if the customer is still selling an item(for the scenario of a worker selling an item)
            {
                Send("{Escape}")
                Sleep(500)
            }
        }
        if(tick >= 20)
        {
            tick := 0
        }
        tick++
        sleep 250
    }
    return current_customer.inventory
}



Action_Buy(current_customer)
{
    Sleep(500)
    Customer.SmallTalk()
    Sleep(500)
    if(PixelSearch(&pX, &pY, 1199, 527, 1220, 545, 0xFF100F, 2))            ;check if you can afoord the discount
    {
        ClickAtCoord(1307, 521)          ;click the discount button
    }
    Sleep(500)
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