#Requires AutoHotkey v2.0
#include ../../../lib/helpers.ahk
#SingleInstance Force
delay := 500
energyLevel := 0
restartCounter := 0
tick := 0
regModTimer := 0
craftMode := true
heroTokenMode := false
{
    mode := "reg"
    inventoryLevel := 0
    customerZone := [695, 539, 1131, 663]
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
                        ClickAtCoord(649, 522)      ;suggest
                        Sleep(500)
                        ClickAtCoord(1303, 630)     ;sell
                    }
                    else
                    {
                        ClickAtCoord(968, 756)      ;Wait
                    }
                }
                else
                {
                    ClickAtCoord(1303, 630)     ;sell
                    FileAppend("No Suggest Button | Month:" A_MM " Day:" A_DD " Hour:" A_Hour, "KingMessage.txt")
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
                        ClickAtCoord(1241, 643)     ;sell
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
                                ClickAtCoord(1241, 643)     ;sell
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
                            ClickAtCoord(1241, 643)     ;sell
                            Sleep(750)
                            if(PixelSearch(&pX, &pY, 1014, 674, 1065, 711, 0x21F75D, 3))        ;scan for sell warning
                            {
                                ClickAtCoord(1103, 698)     ;click yes
                            }
                        }
                        else
                        {
                            ClickAtCoord(684, 633)      ;refuse
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
                    ClickAtCoord(684, 633)      ;refuse
                    Sleep(500)
                    ClickAtCoord(1105, 645)     ;confirm
                }
            }
            else if(PixelSearch(&pX, &pY, 952, 312, 968, 321, 0xECE4CE, 3))     ;checks if it is a buyer
            {
                sellingMode := true
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
                ClickAtCoord(632, 523)      ;smalltalk
                Sleep(delay * 2)
                ClickAtCoord(1303, 630)     ;sell
                Sleep(delay)
            }
            else if(PixelSearch(&pX, &pY, 949, 233, 1173, 289, 0x49FB21, 3) and PixelSearch(&pX2, &pY2, 1295, 617, 1348, 647, 0x21F75D, 3))    ;Check if auto surcharge has accured and if the item is in stock
            {
                ClickAtCoord(632, 523)      ;smalltalk
                Sleep(delay * 2)
                ClickAtCoord(1303, 630)     ;sell
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
                if(mode == "reg" or regModTimer > 9600)
                {
                    if(PixelSearch(&pX, &pY, 599, 613, 640, 659, 0xF74A21, 3))  ;check for refuse button
                    {
                        ClickAtCoord(692, 633)      ;refuse because the surcharge price is to high
                    }
                }
                else if(mode == "MANreg")
                {
                    Send("{Esc}")
                    Sleep(500)
                    ;for manual selling
                }
                else
                {
                    ClickAtCoord(632, 523)      ;smalltalk
                    Sleep(delay * 2)
                    if(PixelSearch(&pX, &pY, 1335, 518, 1355, 531, 0x522C44, 3))
                    {
                        ClickAtCoord(1279, 518)        ;surcharge
                        sleep(delay)
                    }
                    ClickAtCoord(1303, 630)     ;sell
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
                Customer("refuse")
            }
            Sleep(delay)
            ClickAtCoord(632, 523)      ;smalltalk
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

CheckEnergyLevel(fillPercent)       ;Note, scan maxes out at 96% and has a margin of error of around 5 percent
{
    barStart := 1388
    barEnd := 1511
    barLength := barEnd - barStart
    scan := barStart
    counter := 0
    global energyLevel

    loop barLength
    {
        MouseMove(scan, 25)
        if(PixelCompareColor(scan, 25, 0xFE5D36))
        {
            energyLevel := ((3 + counter)/barLength)
        }
        scan++
        counter++
    }
    if(energyLevel >= fillPercent)
        return true
    ;else
    ;    MsgBox(energyLevel)
}

Customer(Action)
{
    Switch(Action)
    {
    case "refuse":
        ClickAtCoord(684, 633)      ;refuse
    }
}