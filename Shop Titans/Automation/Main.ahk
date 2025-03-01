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
    tabTimer := 0
    AutomaticRestartTimer := 0
    a := true
    while a == true
    {
        sellingMode := false
        buyingMode := false
        if(!WinActive("Shop Titans"))      ;checks if shop titans is selected
        {
            Send("{Alt Down}{Tab}{Alt Up}")
            Sleep(500)
        }
        else if(PixelSearch(&pX, &pY, 1090, 669, 1119, 729, 0x21F75D, 2) and PixelSearch(&pX, &pY, 577, 319, 621, 359, 0x381E2D, 2))     ;Check for the reconnect button and top left corner of the box
        {
            sleep(300000)       ;wait 5 minutes
            sleep(300000)       ;wait 5 minutes
            ClickAtCoord(1121, 701)        ;Reconnect
        }
        else if(PixelSearch(&pX, &pY, 74, 883, 174, 932, 0xEFE7D3, 1) and PixelSearch(&pX, &pY,898, 836, 984, 906, 0xEFE7D3, 1) and PixelSearch(&pX, &pY, 1689, 860, 1804, 930, 0xEFE7D3, 1))
        {
            ClickAtCoord(930, 889)      ;click through the diolog
        }
        else if(PixelSearch(&pX, &pY, 997, 923, 1045, 950, 0x21F75D, 3))
        {
            ClickAtCoord(996, 936)      ;click the okay button
        }
        else if(PixelSearch(&pX, &pY, 75, 883, 100, 905, 0x14C3B2, 3))   ;check for the return to shop button in the bottom left corner
        {
            ClickAtCoord(100, 912)      ;click the shop button
            Sleep(500)
        }
        else if(PixelSearch(&pX, &pY, 903, 614, 931, 655, 0xF7491F, 3))
        {
            ClickAtCoord(893, 644)      ;click the no button
        }
        else if(PixelSearch(&pX, &pY, 1848, 99, 1891, 141, 0xFF3E16, 3))       ;check for the red x for the crafting menu
        {
            ClickAtCoord(1870, 127)     ;click the red x
        }
        else if(PixelSearch(&pX, &pY, 1478, 269, 1523, 311, 0xFF3D17, 3))       ;check for the red x for the workers
        {
            ClickAtCoord(1504, 289)     ;click the red x
        }
        else if(PixelSearch(&pX, &pY, 1225, 229, 1275, 281, 0xFF4820, 3))       ;check for the red x from the welcome back popup
        {
            ClickAtCoord(1250, 255)     ;click the red x
        }
        else if(PixelSearch(&pX, &pY, 1076, 734, 1125, 777, 0x21F75D, 3))       ;check for a worker level up
        {
            ClickAtCoord(1185, 760)     ;click continue
        }
        else if(AutomaticRestartTimer > 10000)
        {
            RunWait("SubFunctions\General\RestartShopTitans.ahk")
            AutomaticRestartTimer := 0
        }
        else if(PixelSearch(&pX, &pY, 812, 135, 846, 157, 0x1D2129, 1) and PixelSearch(&pX, &pY, 971, 751, 1082, 799, 0x95B407, 2))     ;checks if the game is stuck in the steam shop
        {
            if(restartCounter > 5)
            {
                
                RunWait("SubFunctions\General\KillAllScripts.ahk")
            }
            else
            {
                RunWait("SubFunctions\General\RestartShopTitans.ahk")
            }
            restartCounter++
        }
        else if(PixelSearch(&pX, &pY, 1248, 300, 1289, 345, 0xFF3F18, 2))        ;checks for red x button on offers
        {
            ClickAtCoord(1270, 319)     ;click the x
            sleep(500)
        }
        else if(PixelSearch(&pX, &pY, 978, 778, 1098, 886, 0x000000, 2) and PixelSearch(&pX, &pY, 1706, 786, 1745, 833, 0xA5A6A5, 3))       ;check for infinite loading screen
        {
            RunWait("SubFunctions\General\TrappedInLoading.ahk")
        }
        else if(PixelSearch(&pX, &pY, 834, 484, 980, 623, 0xB57923, 3) and PixelSearch(&pX, &pY, 834, 484, 980, 623, 0xA21308, 3))        ;checks for recieving a gift
        {
            ClickAtCoord(912, 533)     ;click the present
            sleep(500)
        }
        else if(PixelSearch(&pX, &pY, 947, 283, 969, 313, 0xFECE23, 3) and PixelSearch(&pX, &pY, 924, 684, 993, 701, 0x29F863, 3))  ;scan for gold gift ribbon and scan for green confirm button
        {
            if(PixelSearch(&pX, &pY, 724, 424, 758, 442,  0x8FB7DC, 3) or PixelSearch(&pX, &pY, 724, 424, 758, 442,  0xA21D08, 3))      ;scan slot 1 for danial or thomas
            {
                ClickAtCoord(945, 445)
            }
            else if(PixelSearch(&pX, &pY, 719, 503, 758, 524, 0x8FB7DC, 3) or PixelSearch(&pX, &pY, 719, 503, 758, 524, 0xA21D08, 3))       ;scan slot 2 for danial or thomas
            {
                ClickAtCoord(945, 528)
            }
            else if(PixelSearch(&pX, &pY, 728, 594, 752, 608, 0x8FB7DC, 3) or PixelSearch(&pX, &pY, 728, 594, 752, 608, 0xA21D08, 3))       ;scan slot 3 for danial or thomas
            {             
                ClickAtCoord(945, 619)
            }
            Sleep(500)
            ClickAtCoord(958, 715)      ;click confirm
            Sleep(500)
            ClickAtCoord(958, 715)      ;click finish
        }
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
        else if(PixelSearch(&pX, &pY, customerZone[1], customerZone[2], customerZone[3], customerZone[4], 0xEFEAD6, 1) and !PixelSearch(&pXb, &pYb, 1387, 23, 1413, 48, 0xFFE55C, 2) and tick <= 17)         ;Look for and click on the customer bubble, if you cant see guild tokens in the top right(not in city view)
        { 
            ClickAtCoord(pX, pY)
            Sleep(500)
            if(PixelSearch(&pX, &pY, 1828, 897, 1877, 949, 0xFFD743, 3))        ;check for edit furniture button
            {
                Send("{Esc}")
                Sleep(250)
            }
        }
        else if(tabTimer >= 15)         ;check if enough time has passed to go to town for a few seconds
        {
            Send("{Tab}")
            Sleep(2500)
            if(PixelSearch(&pX, &pY, 803, 236, 1179, 574, 0x0677B8, 2))         ;scan for cleaning hearts
            {
                ClickAtCoord(pX, pY)
                Sleep(3000)
                ClickAtCoord(1078, 128)     ;click the grean help around the shop button
                loop 3
                {
                    sleep(500)
                    ClickAtCoord(1078, 128)     ;click the grean help around the shop button
                    Sleep(1500)         ;click the first furnature
                    loop 3
                    {
                        Sleep(500)
                        ClickAtCoord(965, 457)
                    }
                }
                sleep(500)
                ClickAtCoord(1078, 128)         ;click the claim reward button
                sleep(750)
                ClickAtCoord(951, 941)          ;click the continue button
                Sleep(500)
                ClickAtCoord(1133, 938)          ;click the continue button
            }
            if(subscription)
            {
                RunWait("SubFunctions\Quests\CollectQuests.ahk")       ;collect any finished quests
                Sleep(500)
                RunWait("SubFunctions\General\EscapeToShop.ahk")
                Sleep(500)
                RunWait("SubFunctions\Quests\TOTSendQuest.ahk")         ;try to launch a tot mission
                Sleep(2500)
                RunWait("SubFunctions\General\EscapeToShop.ahk")
            }
            tabTimer := 0
        }
        else if(tick == 20)     ;reset position
        {
            RunWait("SubFunctions\General\ReturnToDefaultPos.ahk")
        }
        else if(PixelSearch(&pX, &pY, 1647, 964, 1719, 997, 0xFFCB19, 3) and craftMode == true)       ;check if the item is done crafting
        {
            RunWait("Manufacture\CraftExacutable.ahk")     ;launch the crafter
        }
        else if(PixelSearch(&pX, &pY, 1838, 851, 1880, 889, 0xFFB529, 3) and tick > 17 and craftMode == true)       ;check if there is an empty crafting slot
        {
            RunWait("Manufacture\CraftQuick.ahk")     ;launch the quick crafter
        }
        else if(PixelSearch(&pX, &pY, 246, 918, 284, 956, 0xFFE894, 3) and tick > 17)       ;check on the bounty status
        {
            RunWait("SubFunctions\Bounties\CollectBounty.ahk")
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
            else if(tierScan() == 13 and PixelSearch(&pX, &pY, 1295, 617, 1348, 647, 0x21F75D, 3))      ;check if the tier is 13 and if the item is in stock
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
        tabTimer++
        tick++
        regModTimer++
        AutomaticRestartTimer++
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
PixelCompareColor(x, y, color)
{
    if(PixelGetColor(x, y) == color)
    {
        return true
    }
    else
        return false
}
ScanForPixel(firstX, firstY, secondX, secondY, color, scanCoef)
{
    scanX := firstX
    scanY := firstY
    areaX := (secondX - firstX + 1)/scanCoef
    areaY := (secondY - firstY + 1)/scanCoef
    loop areaY
    {
        loop areaX
        {
            MouseMove(scanX, scanY)
            if(PixelCompareColor(scanX, scanY, color) == true)
            {
                return true
            }
            scanX += scanCoef
        }
        scanX := firstX
        scanY += scanCoef
    }
}

CheckEnergyLevel(fillPercent)       ;Note, scan maxes out at 96%
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

tierScan()
{
    ;if(PixelCompareColor() and PixelCompareColor() and PixelCompareColor() and PixelCompareColor() and PixelCompareColor() and PixelCompareColor())
    if(PixelCompareColor(757, 196, 0x291F26) and PixelCompareColor(756, 200, 0xCCCACC) and PixelCompareColor(757, 207, 0x392F36) and PixelCompareColor(765, 194, 0xFFFFFF) and PixelCompareColor(769, 201, 0x22171E) and PixelCompareColor(764, 209, 0xFFFFFF))
    {
        return 13
    }
    else return 0
}

CreateErrorMessage(errorTitle, ErrorDetails)
{

    ;FileAppend(, errorTitle, "Errors")
}