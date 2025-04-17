#Requires AutoHotkey v2.0
#include ../lib/helpers.ahk
#SingleInstance Force
delay := 500
energyLevel := 0
surchargeCost := 0.1
restartCounter := 0
tick := 0

craftMode := true
heroTokenMode := false
{
    ActivateShopTitans()
    RunFromTopDir("Shop Titans/Automation/SubFunctions/General/ReturnToDefaultPos.ahk")
    customerZone := [710, 513, 1112, 639]
    MouseMove(customerZone[1], customerZone[2])
    sleep(1000)
    MouseMove(customerZone[3], customerZone[4])
    sleep(1000)
    if(PixelSearch(&pX, &pY, 8, 4, 29, 22, 0xEDC53F, 2))
        subscription := true
    else
        subscription := false
    global surchargeCost
    ExtraInventory := false
    AutomaticRestartTimer := 0
    SellerClogDetecter := 0
    autoUpdate := false
    piggyBank := true
    a := true
    while a == true
    {
        sellingMode := false
        buyingMode := false
        ActivateShopTitans()
        if(PixelSearch(&pX, &pY, 802, 673, 822, 742, 0x21F75A, 2) and PixelSearch(&pX, &pY, 577, 319, 621, 359, 0x381E2D, 2))         ;checks if the game has failed steam identification and needs to restart and top left corner of the box
        {
            if(restartCounter > 20)
            {    
                
                Sleep(900000)
            }
            else
            {
                RunWait("SubFunctions\General\RestartShopTitans.ahk")
            }
            restartCounter++
        }
        else if(PixelSearch(&pX, &pY, 1090, 669, 1119, 729, 0x21F75D, 2) and PixelSearch(&pX, &pY, 577, 319, 621, 359, 0x381E2D, 2))     ;Check for the reconnect button and top left corner of the box
        {
            sleep(300000)       ;wait 5 minutes
            sleep(300000)       ;wait 5 minutes
            ClickAtCoord(1121, 701)        ;Reconnect
        }
        if(A_Hour == 0)
        {
            autoUpdate := true
        }
        else if(A_Hour == 1)
        {
            RunFromTopDir("AutoStart.ahk")
        }
        if(tickallocator(tick, "closeMenus"))
        {
            loop(5)
            {
                if(PixelSearch(&pX, &pY, 74, 883, 174, 932, 0xEFE7D3, 1) and PixelSearch(&pX, &pY,898, 836, 984, 906, 0xEFE7D3, 1) and PixelSearch(&pX, &pY, 1689, 860, 1804, 930, 0xEFE7D3, 1))
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
                else if(PixelSearch(&pX, &pY, 1248, 300, 1289, 345, 0xFF3F18, 2))        ;checks for red x button on offers
                {
                    ClickAtCoord(1270, 319)     ;click the x
                    sleep(500)
                }
                else if(PixelSearch(&pX, &pY, 1076, 734, 1125, 777, 0x21F75D, 3))       ;check for a worker level up
                {
                    ClickAtCoord(1185, 760)     ;click continue
                }
                else if(PixelSearch(&pX, &pY, 1169, 267, 1183, 276, 0xFF5129, 3))
                {
                    ClickAtCoord(1176, 287)
                }
                sleep(400)
            }
            EventChampionAtDoor()
        }
        else if(AutomaticRestartTimer > 10000)
        {
            RunWait("SubFunctions\General\RestartShopTitans.ahk")
            AutomaticRestartTimer := 0
        }
        else if(PixelSearch(&pX, &pY, 812, 135, 846, 157, 0x1D2129, 1) and PixelSearch(&pX, &pY, 971, 751, 1082, 799, 0x95B407, 2))     ;checks if the game is stuck in the steam shop
        {
            if(restartCounter > 20)
            {
                
                Sleep(15*60*1000)
            }
            else
            {
                RunWait("SubFunctions\General\RestartShopTitans.ahk")
            }
            restartCounter++
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
        RunWait("SubFunctions\GatherInfo\GemTracker\TakeSnapshot.ahk")
        if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
        {
            RunWait("SubFunctions\Customers\ProcessCustomers.ahk")
        }
        else if(PixelSearch(&pX, &pY, customerZone[1], customerZone[2], customerZone[3], customerZone[4], 0xEFEAD6, 1) and !PixelSearch(&pXb, &pYb, 1387, 23, 1413, 48, 0xFFE55C, 2) and tickallocator(tick, "customer"))         ;Look for and click on the customer bubble, if you cant see guild tokens in the top right(not in city view)
        {
            ClickAtCoord(pX, pY)
            Sleep(500)
            if(PixelSearch(&pX, &pY, 1828, 897, 1877, 949, 0xFFD743, 3))        ;check for edit furniture button
            {
                Send("{Esc}")
                Sleep(250)
            }
            else if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
            {
                RunWait("SubFunctions\Customers\ProcessCustomers.ahk")
            }
            SellerClogDetecter := 0
        }
         else if(PixelSearch(&pX, &pY, customerZone[1], customerZone[2], customerZone[3], customerZone[4], 0xEFE46B, 1) and !PixelSearch(&pXb, &pYb, 1387, 23, 1413, 48, 0xFFE55C, 2) and tickallocator(tick, "customer"))         ;Look for and click on the yellow customer bubble, if you cant see guild tokens in the top right(not in city view)
        { 
            ClickAtCoord(pX, pY)
            Sleep(500)
            if(SellerClogDetecter > 10)
            {
                FileAppend("refuse", "SubFunctions\Customers\Mode.txt")
            }
            else
                SellerClogDetecter++
            if(PixelSearch(&pX, &pY, 1828, 897, 1877, 949, 0xFFD743, 3))        ;check for edit furniture button
            {
                Send("{Esc}")
                Sleep(250)
            }
            else if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
            {
                RunWait("SubFunctions\Customers\ProcessCustomers.ahk")
            }
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
        else if(tickallocator(tick, "tabCity"))         ;check if enough time has passed to go to town for a few seconds
        {
            Send("{Tab}")
            Sleep(2000)
            SendEvent("{WheelDown 10}")         ;scroll all the way out
            Sleep(500)
            if(PixelSearch(&pX, &pY, 946, 354, 1034, 468, 0x19CC9D, 2))         ;check if the offer help button is available
            {
                ClickAtCoord(995, 410)      ;click the offer help button
                Sleep(1000)
                ClickAtCoord(960, 728)      ;click help all
                Sleep(500)
                Send("{Escape}")
                Sleep(500)
            }
            if(PixelSearch(&pX, &pY, 803, 227, 1171, 556, 0x01D5E6, 2))         ;scan for cleaning hearts
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
            if(PixelSearch(&pX, &pY, 262, 934, 305, 959, 0xF5BB0D, 2))       ;scan for market tab
            {
                RunWait("SubFunctions\Market\CollectAndRelistMarket.ahk")
            }
            if(subscription)
            {
                RunWait("SubFunctions\Quests\CollectQuests.ahk")       ;collect any finished quests
                Sleep(2500)
            }
            else
            {
                RunWait("SubFunctions\Quests\CollectQuestsSubFree.ahk")       ;collect any finished quests
                Sleep(2500)
            }
            Sleep(3000)
            if(PixelSearch(&pX, &pY, 654, 164, 1362, 748, 0x11E85C, 2))         ;scan for upgraded furniture
            {
                ClickAtCoord(pX, pY)        ;click upgraded furniture
                Sleep(1000)
                
            }
            RunWait("SubFunctions\General\EscapeToShop.ahk")
            Sleep(1000)
        }
        else if(tickallocator(tick, "resetPos"))     ;reset position
        {
            RunWait("SubFunctions\General\ReturnToDefaultPos.ahk")
        }
        else if(PixelSearch(&pX, &pY, 1838, 851, 1880, 889, 0xEF3214, 2))          ;check for a new recipe notification on the craft button
        {
            ClickAtCoord(1804, 919)     ;click on the crafting menu
            Sleep(500)
            if(PixelSearch(&pX, &pY, 1192, 335, 1243, 389, 0xFF3D17, 2))         ;check for the red x button in the unlock crafting slot menu
            {
                ClickAtCoord(1195, 446)         ;click the crafting menu button
                Sleep(500)
            }
            if(PixelSearch(&pX, &pY, 1594, 918, 1919, 949, 0xEF3214, 2))           ;check which tab the notification is in
            {
                ClickAtCoord(pX, pY)        ;click the tab with the notification
                Sleep(500)
                if(PixelSearch(&pX, &pY, 4, 936, 922, 1001, 0xF03315, 2))
                {
                    ClickAtCoord(pX, pY)        ;click the tab with the notification
                    Sleep(250)
                    Send("{Escape}")
                }
            }
        }
        else if(PixelSearch(&pX, &pY, 1647, 964, 1719, 997, 0xFFCB19, 3) and GetStoredInfo("InventoryCapacity.txt", "int") < 0.9 and tickallocator(tick, "craft") and craftMode == true)       ;check if the item is done crafting
        {
            RunWait("Manufacture\CraftExacutable.ahk")     ;launch the crafter
        }
        else if(PixelSearch(&pX, &pY, 1838, 851, 1880, 889, 0xFFB529, 3) and GetStoredInfo("InventoryCapacity.txt", "int") < 0.9 and tickallocator(tick, "craft") and  craftMode == true)       ;check if there is an empty crafting slot
        {
            RunWait("Manufacture\CraftQuick.ahk")     ;launch the quick crafter
        }
        else if(PixelSearch(&pX, &pY, 246, 918, 284, 956, 0xFFE894, 3) and tickallocator(tick, "bounty"))       ;check on the bounty status
        {
            RunWait("SubFunctions\Bounties\CollectBounty.ahk")
        }
        else if(A_Hour < 19 and 16 < A_Hour and piggyBank)
        {
            ClickAtCoord(1881, 37)          ;click the white bars in the top right
            Sleep(500)
            if(PixelSearch(&pX, &pY, 1472, 591, 1527, 643, 0xFD8EAA, 2))            ;scan for the piggy bank icon
            {
                ClickAtCoord(1498, 616)         ;click on the piggy bank
                Sleep(500)
                if(PixelSearch(&pX, &pY, 1269, 742, 1304, 769, 0x21F459, 2))            ;scan for claim button
                {
                    ClickAtCoord(1397, 745)         ;click the claim button
                    Sleep(500)
                    loop(12)
                    {
                        ClickAtCoord(964, 526)          ;click through the piggy bank animation
                        Sleep(333)
                    }
                    ClickAtCoord(956, 956)      ;click ok
                    Sleep(1000)
                    Send("{Escape}")
                }
                else
                {
                    Send("{Escape}")
                }
                piggyBank := false
            }
        }
        else if(A_Hour >= 19 and !piggyBank)
        {
            piggyBank := true
        }
        sleep(500)
        if(tick >= 20)
        {
            tick := 0
        }
        tick++
        AutomaticRestartTimer++
        sleep 250
    }
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

AltTab(TabQuantity)
{
    Send("{Alt Down}")
    Sleep(100)
    loop TabQuantity
    {
        Send("{Tab}")
        Sleep(200)
    }
    Send("{Alt Up}")
}

tickallocator(tickN, event)
{
    CurrentEvent := ""
    switch(tickN)
    {
        case 1, 2, 3, 10, 11, 12:
            CurrentEvent := "customer"
        case 4, 5, 6:
            CurrentEvent := "craft"
        case 7:
            CurrentEvent := "bounty"
        case 18:
            CurrentEvent := "closeMenus"
        case 19:
            CurrentEvent := "tabCity"       
        case 20:
            CurrentEvent := "resetPos"
    }
    if(event == CurrentEvent)
        return true
    else
        return false
}

ActivateShopTitans()
{
    if(!WinActive("ahk_exe ShopTitan.exe"))      ;checks if shop titans is selected
    {
        if(WinExist("ahk_exe ShopTitan.exe"))
        {
            WinActivate("ahk_exe ShopTitan.exe")         ;activate the shop titans window
            Sleep(500)
            WinMaximize("ahk_exe ShopTitan.exe")        ;maximize window
        }
        else
        {
            RunWait("steam://rungameid/1258080")
            Sleep(15000)
            WinMaximize("ahk_exe ShopTitan.exe")        ;maximize window
            ActivateShopTitans()
        }
    }
}

CheckInventoryLevel(fillPercent)       ;Note, scan maxes out at 96%
{
    barStart := 1800
    barEnd := 1904
    barLength := barEnd - barStart
    scan := barStart
    counter := 0
    global energyLevel

    loop barLength
    {
        MouseMove(scan, 25)
        if(PixelCompareColor(scan, 111, 0xFE5D36))
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