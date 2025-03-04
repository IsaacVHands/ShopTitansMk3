#Requires AutoHotkey v2.0
#SingleInstance Force
delay := 500
energyLevel := 0
surchargeCost := 0.1
restartCounter := 0
tick := 0
mode := "reg"      ;reg for only surcharge. Nreg for burn mode. and MANreg for manual selling

regModTimer := 0
craftMode := true
heroTokenMode := false
{
    subscription := true
    RunWait("SubFunctions\General\ReturnToDefaultPos.ahk")
    customerZone := [695, 539, 1131, 663]
    MouseMove(customerZone[1], customerZone[2])
    sleep(1000)
    MouseMove(customerZone[3], customerZone[4])
    sleep(1000)
    global surchargeCost
    a := true
    while a == true
    {
        sellingMode := false
        buyingMode := false
        sleep(500)
        if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
        {
            if(PixelSearch(&pX, &pY, 829, 130, 855, 150, 0xF1C638, 3))          ;checks if for king reinhold
            {
                Sleep(delay * 3)
                ;ClickAtCoord(1303, 630)     ;sell
                ClickAtCoord(968, 756)      ;Wait
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
                }
            }
        }
        else if(buyingMode)
        {
            Sleep(delay)
            ClickAtCoord(632, 523)      ;smalltalk
            Sleep(delay * 2)
            ClickAtCoord(1255, 634)         ;buy
        }
        if(tick >= 20)
        {
            tick := 0
        }
        tick++
        sleep 250
    }
}


ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(50)
    Click(x, y, "Left", "Up")
    Sleep(10)
}