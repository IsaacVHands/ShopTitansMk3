#Requires AutoHotkey v2.0
#include ../../../lib/helpers.ahk
#include Customers.ahk
#SingleInstance Force
delay := 500
energyLevel := 0
restartCounter := 0
tick := 0
regModTimer := 0
craftMode := true
heroTokenMode := false
{
    customerZone := [710, 513, 1112, 639]
    mode := "reg"
    inventoryLevel := 0
    loop 15
    {
        sellingMode := false
        buyingMode := false
        sleep(250)
        if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
        {
            Sleep(500)
            if(PixelSearch(&pX, &pY, 829, 130, 855, 150, 0xF1C638, 3))          ;checks for king reinhold
            {
                Sleep(delay * 3)
                if(PixelSearch(&pX, &pY, 708, 538, 773, 551, 0x522C44, 2) or PixelSearch(&pX, &pY, 713, 538, 767, 553, 0x453B42, 2))          ;check if the king has a surcharge button
                {
                    if(CheckEnergyLevel(0.5))
                    {
                        Customer.Suggest()
                        Sleep(500)
                        Customer.Sell()
                    }
                    else
                    {
                        ClickAtCoord(968, 756)      ;Wait
                        Sleep(500)
                        zoneDif := customerZone[3] - customerZone[1]
                        zoneSliver := zoneDif/4
                        a := 0
                        loop(4)
                        {
                            if(PixelSearch(&pX, &pY, customerZone[1]+zoneSliver*a, customerZone[2], customerZone[3], customerZone[4], 0xEFEAD6, 1))         ;Look for and click on the customer bubble in the specific sub customer zone
                            {
                                ClickAtCoord(pX, pY)          ;click on the customer in the subzone
                                Sleep(500)
                                if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
                                {
                                    if(PixelSearch(&pX, &pY, 829, 130, 855, 150, 0xF1C638, 3))          ;checks for king reinhold
                                    {
                                        ClickAtCoord(968, 756)      ;Wait
                                    }
                                    else
                                    {
                                        break
                                    }
                                }
                            }
                            Sleep(1500)
                            a++
                        }
                    }
                }
                else
                {
                    Customer.Sell()
                }
            }
            else if(PixelSearch(&pX, &pY, 953, 311, 971, 322, 0xECE168, 1))      ;checks if it is a seller
            {
                buyingMode := true
            }
            else if(!PixelSearch(&pX, &pY, 1318, 396, 1346, 422, 0x522C44, 2) and PixelSearch(&pX, &pY, 747, 622, 797, 657, 0xF7491E, 2) and !PixelSearch(&pX, &pY, 695, 513, 754, 545, 0x522C44, 3))     ;check if its a hero
            {
                if(heroTokenMode)
                {
                    if(PixelSearch(&pX, &pY, 1288, 614, 1350, 657, 0x21F75D, 3))        ;check if there is enough items for the hero
                    {
                        Customer.Sell()
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
                                Customer.Sell()
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
                            Customer.Sell()
                            Sleep(750)
                            if(PixelSearch(&pX, &pY, 1014, 674, 1065, 711, 0x21F75D, 3))        ;scan for sell warning
                            {
                                ClickAtCoord(1103, 698)     ;click yes
                            }
                        }
                        else
                        {
                            Customer.Refuse()
                            Sleep(500)
                            ClickAtCoord(1105, 645)     ;confirm
                        }
                    }
                }
                else
                {
                    Sleep(1000)
                    ClickAtCoord(1266, 637)      ;click the sell button
                    Sleep(500)
                    Send("{Esc}")
                    Sleep(500)
                    if(PixelSearch(&pX, &pY, 2334, 295, 2382, 325, 0xF7491F, 3))        ;check if escape brought up the quit game menu
                    {
                        ClickAtCoord(827, 644)      ;click no
                    }
                    Customer.Refuse()
                    Sleep(500)
                    ClickAtCoord(1105, 645)     ;confirm
                }
            }
            else if(PixelSearch(&pX, &pY, 952, 312, 968, 321, 0xECE4CE, 3))     ;checks if it is a buyer
            {
                sellingMode := true
                currentCustomer := Customer()
            }
            else if(PixelSearch(&pX, &pY, 1861, 80, 1893, 120, 0xFF3F18, 2))
            {
                ClickAtCoord(1884, 95)      ;Click the x for daily
            }
            else
            {
                ClickAtCoord(968, 756)      ;Wait
            }
        }
        else if(PixelSearch(&pX, &pY, 74, 883, 174, 932, 0xEFE7D3, 1) and PixelSearch(&pX, &pY,898, 836, 984, 906, 0xEFE7D3, 1) and PixelSearch(&pX, &pY, 1689, 860, 1804, 930, 0xEFE7D3, 1))
        {
            loop(5)
            {
                if(PixelSearch(&pX, &pY, 74, 883, 174, 932, 0xEFE7D3, 1) and PixelSearch(&pX, &pY,898, 836, 984, 906, 0xEFE7D3, 1) and PixelSearch(&pX, &pY, 1689, 860, 1804, 930, 0xEFE7D3, 1))
                {
                    ClickAtCoord(930, 889)      ;click through the diolog
                    Sleep(450)
                }
                Sleep(50)
            }
        }
        else
        {
            break
        }

        sleep(500)
        if(sellingMode)
        {
            if(PixelSearch(&pX, &pY, 1335, 518, 1355, 531, 0x522C44, 3) and PixelSearch(&pX2, &pY2, 1295, 617, 1348, 647, 0x21F75D, 3))    ;Check if surcharge is possible and if the item is in stock
            {
                ClickAtCoord(1279, 518)        ;surcharge
                Sleep(delay)
                Customer.SmallTalk()
                Sleep(delay * 2)
                Customer.Sell()
                Sleep(delay)
            }
            else if(PixelSearch(&pX, &pY, 949, 233, 1173, 289, 0x49FB21, 3) and PixelSearch(&pX2, &pY2, 1295, 617, 1348, 647, 0x21F75D, 3))    ;Check if auto surcharge has accured and if the item is in stock
            {
                Customer.SmallTalk()
                Sleep(delay * 2)
                Customer.Sell()
                Sleep(delay)
            }
            else if(PixelSearch(&pX, &pY, 1331, 622, 1379, 647, 0xFFB729, 3))
            {
                ClickAtCoord(692, 633)      ;refuse because the item is out of stock
                Sleep(500)
                if(PixelSearch(&pX, &pY, 996, 620, 1046, 648, 0x23F75D, 3))
                {
                    ClickAtCoord(1025, 642)
                    Sleep(500)
                }
            }
            else
            {
                if(GetStoredInfo("InventoryCapacity.txt", "int") >= 0.75)
                {
                    Customer.SmallTalk()
                    Sleep(delay * 2)
                    if(PixelSearch(&pX, &pY, 1335, 518, 1355, 531, 0x522C44, 3))
                    {
                        Customer.Surcharge()
                        sleep(delay)
                    }
                    Customer.Sell()
                    Sleep(delay)
                }
                else if(mode == "reg" and Random(1, 20) < 20)
                {
                    if(PixelSearch(&pX, &pY, 599, 613, 640, 659, 0xF74A21, 3))  ;check for refuse button
                    {
                        ClickAtCoord(692, 633)      ;refuse because the surcharge price is to high
                    }
                }
                else
                {
                    Customer.SmallTalk()
                    Sleep(delay * 2)
                    if(PixelSearch(&pX, &pY, 1335, 518, 1355, 531, 0x522C44, 3))
                    {
                        ClickAtCoord(1279, 518)        ;surcharge
                        sleep(delay)
                    }
                    Customer.Sell()
                    Sleep(delay)
                    mode := "reg"
                }
            }
        }
        else if(buyingMode)
        {
            if(FileRead("Mode.txt") == "refuse")
            {
                Sleep(delay)
                Customer.Refuse()
            }
            Sleep(delay)
            Customer.SmallTalk()
            Sleep(delay * 2)
            ClickAtCoord(1255, 634)         ;buy
        }
        Sleep(150)
        if(PixelSearch(&pX, &pY, 798, 156, 1115, 198, 0xFF2D00, 2))     ;check for inventory full red letters
        {
            Send("{Right}")
            Sleep(500)
            mode := "Nreg"
            if(PixelSearch(&pX, &pY, 713, 296, 1205, 315, 0xEFE368, 2))     ;check if the customer is still selling an item(for the scenario of a worker selling an item)
            {
                Send("{Escape}")
                Sleep(500)
            }
        }
        if(PixelSearch(&pX, &pY, 1901, 114, 1916, 138, 0xCF9318, 3))        ;check if inventory is basically full(~90%)
        {
            if(inventoryLevel != 0.9)
            {
                WriteToInfoStorage("InventoryCapacity.txt", 0.9)
                inventoryLevel := 0.9
            }
            mode := "Nreg"
        }
        else if(PixelSearch(&pX, &pY, (1893 - 20), 109, 1916, 138, 0xCF9318, 3))          ;check for full inventory brown bar on the right (true of > 75% full)
        {
            if(inventoryLevel != 0.75)
            {
                WriteToInfoStorage("InventoryCapacity.txt", 0.75)
                inventoryLevel := 0.75
            }
            mode := "Nreg"
        }
        else
        {
            if(inventoryLevel != 0.5)
            {
                WriteToInfoStorage("InventoryCapacity.txt", 0.5)
                inventoryLevel := 0.5
            }
            mode := "reg"
        }
        if(tick >= 20)
        {
            tick := 0
        }
        tick++
        sleep 250
    }
    if(!FileExist("Mode.txt"))
    {
        FileAppend("", "Mode.txt")
        Sleep(250)
    }
    if(FileRead("Mode.txt") != "")
    {
        FileErase("Mode.txt")
    }
}