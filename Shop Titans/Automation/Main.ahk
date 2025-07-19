#Requires AutoHotkey v2.0
#include ../lib/helpers.ahk
#include ../lib/dev_functions.ahk
#Include SubFunctions/GatherInfo/GemTracker/Gem.ahk
#Include SubFunctions/Quests/Quest.ahk
#Include SubFunctions/Customers/ProcessCustomers.ahk
#Include SubFunctions/Bounties/CollectBounty.ahk
#Include SubFunctions/Market/CollectAndRelistMarket.ahk
#Include SubFunctions/General/ConfigManager.ahk
#Include SubFunctions/Crafting/Craft.ahk
#Include SubFunctions/General/UpgradeFurniture.ahk
#SingleInstance Force
delay := 500
energyLevel := 0
restartCounter := 0

heroTokenMode := false
{
    tick := 0
    configs := getConfigs()
    customerZone := [710, 513, 1112, 639]
    if(DevMode() and true)
    {
        tick := 19
    }
    else
    {
        ActivateShopTitans()
        FixWindowFrozen()
        CheckWindowRes(1920, 1009, 10)
        return_to_default_pos()
        MouseMove(customerZone[1], customerZone[2])
        sleep(1000)
        MouseMove(customerZone[3], customerZone[4])
        sleep(1000)
    }
    if(PixelSearch(&pX, &pY, 8, 4, 29, 22, 0xEDC53F, 2))
        subscription := true
    else
        subscription := false
    furnitureUpgrade := Furniture()
    upTime := 0
    questy := Quest()
    counter_upgrade := false
    ExtraInventory := false
    AutomaticRestartTimer := 0
    SellerClogDetecter := 0
    hour := A_Hour
    autoUpdate := false
    piggyBank := true
    lost_city_of_gold := true
    inventory_level := 0.9
    gemCount := Gem()
    mainLoop := true
    while mainLoop == true
    {
        sellingMode := false
        buyingMode := false
        ActivateShopTitans()
        if(PixelSearch(&pX, &pY, 802, 673, 822, 742, 0x21F75A, 2) and PixelSearch(&pX, &pY, 577, 319, 621, 359, 0x381E2D, 2))         ;checks if the game has failed steam identification and needs to restart and top left corner of the box
        {
            if(restartCounter > 20)
            {    
                
                Sleep(30*60*1000)
            }
            else
            {
                restart_shoptitans()
            }
            restartCounter++
        }
        else if(PixelSearch(&pX, &pY, 1090, 669, 1119, 729, 0x21F75D, 2) and PixelSearch(&pX, &pY, 577, 319, 621, 359, 0x381E2D, 2))     ;Check for the reconnect button and top left corner of the box
        {
            if(PixelSearch(&pX, &pY, 795, 673, 831, 748, 0x1EF65A, 2))      ;check if its just a simple lost connection error
            {
                ClickAtCoord(1121, 701)        ;Reconnect
                Sleep(5000)
                if(PixelSearch(&pX, &pY, 795, 673, 831, 748, 0x1EF65A, 2))      ;check if its just a simple lost connection error
                {
                    RestartShopTitans()
                }
            }
            else
            {
                sleep(300000)       ;wait 5 minutes
                sleep(300000)       ;wait 5 minutes
                ClickAtCoord(1121, 701)        ;Reconnect
                Sleep(10000)
                if(PixelSearch(&pX, &pY, 1090, 669, 1119, 729, 0x21F75D, 2) and PixelSearch(&pX, &pY, 577, 319, 621, 359, 0x381E2D, 2))     ;Check for the reconnect button and top left corner of the box
                {
                    ClickAtCoord(1121, 701)        ;Reconnect
                    Sleep(10000)
                }
                if(PixelSearch(&pX, &pY, 1090, 669, 1119, 729, 0x21F75D, 2) and PixelSearch(&pX, &pY, 577, 319, 621, 359, 0x381E2D, 2))     ;Check for the reconnect button and top left corner of the box
                {
                    RestartShopTitans()
                }
            }
        }
        if(A_Hour > hour)
        {
            upTime++
            lost_city_of_gold := true
            gemCount.logGems()
            counter_upgrade := false
            if(WinExist("ahk_exe ShopTitan.exe"))
            {
                WinMaximize("ahk_exe ShopTitan.exe")
            }
            if(configs.general_upgradefurniture)
                furnitureUpgrade.findAndUpgrade()
            Sleep(1000)
            if(configs.crafting_enchantments_autotrash)
            {
                ClickAtCoord(383, 944)          ;open the inventory
                Sleep(1000)
                ClickAtCoord(1611, 966)         ;open enchantment tab
                Sleep(500)
                loop(3)
                {
                    if(PixelSearch(&pX, &pY, 169, 680, 194, 705, 0x5D3148, 2))          ;check if there is an enchant in slot 1
                    {
                        ClickAtCoord(111, 875)          ;click on the enchant in the first slot
                        Sleep(750)
                        ClickAtCoord(733, 706)          ;click the trash button
                        Sleep(750)
                        ClickAtCoord(824, 604)          ;click the minus to switch to the maximum number of enchants
                        Sleep(500)
                        ClickAtCoord(1093, 738)         ;click yes
                        Sleep(500)
                    }
                }
                Send("{Escape}")
            }
            hour := A_Hour
        }
        if(A_Hour == 0)
        {
            autoUpdate := true
        }
        else if(A_Hour == 1 and autoUpdate)
        {
            RunFromTopDir("AutoStart.ahk")
            autoUpdate := false
        }
        if(tickallocator(tick, "closeMenus"))
        {
            loop(5)
            {
                if(PixelSearch(&pX, &pY, 890, 553, 928, 594, 0xCDA151, 2))          ;checks if there is a gift here
                {
                    ClickAtCoord(918, 543)          ;open gift
                    Sleep(1000)
                    if(PixelSearch(&pX, &pY, 865, 937, 895, 969, 0x1FF65A, 2))          ;check for okay button
                    {
                        ClickAtCoord(958, 947)          ;click okay
                    }
                }
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
                if(PixelSearch(&pX, &pY, 861, 708, 884, 723, 0x21F75A, 2))          ;scan for collect button for in shop free chest
                {
                    ClickAtCoord(955, 721)          ;click collect
                }
                if(PixelSearch(&pX, &pY, 1120, 333, 1313, 350, 0xFF481F, 2))            ;scan for red x 
                {
                    ClickAtCoord(pX, pY)            ;click red x
                }
                else if(PixelSearch(&pX, &pY, 1862, 72, 1909, 114, 0xFF3E17, 2), PixelSearch(&pX, &pY, 1862, 72, 1909, 114, 0xFFFFFF, 2))       ;check for red event(daily login) circle and the white of the x
                {
                    Send("{Escape}")
                }
                sleep(400)
            }
            eventPopUpTowerOfTitans()
            FixWindowFrozen()
        }
        sleep(500)
        if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3) and PixelSearch(&pX, &pY, 750, 628, 768, 654, 0xF7461B, 2))        ;check for wait button and refuse button
        {
            inventory_level := Process_Customers(customerZone, inventory_level)
        }
        else if(PixelSearch(&pX, &pY, customerZone[1], (customerZone[2] + 113), customerZone[3], customerZone[4], 0xEFE7D3, 1) and counter_upgrade and !PixelSearch(&pXb, &pYb, 1387, 23, 1413, 48, 0xFFE55C, 2) and tickallocator(tick, "customer"))         ;Look for and click on the customer bubble, if there is a counter upgrade active, and if you cant see guild tokens in the top right(not in city view)
        {
            currentCustomer := Customer(inventory_level)
            ClickAtCoord(pX + 10, pY + 10)
            Sleep(500)
            capriceDailyBonus()
            if(PixelSearch(&pX, &pY, 1235, 258, 1280, 301, 0xFFFFFF, 2) and PixelSearch(&pX, &pY, 1235, 258, 1280, 301, 0xFF3C18, 2))       ;check for white x and red circle(in the case of a counter upgrade for instance)
            {
                counter_upgrade := true
                Send("{Escape}")
            }
            if(PixelSearch(&pX, &pY, 1828, 897, 1877, 949, 0xFFD743, 2) and PixelSearch(&pX, &pY, 1804, 946, 1820, 962, 0x552B44, 2))        ;check for edit furniture button
            {
                Send("{Esc}")
                Sleep(250)
            }
            else if(currentCustomer.scan.WaitButton())        ;check for wait button
            {
                inventory_level := Process_Customers(customerZone, inventory_level)
            }
            else if(PixelSearch(&pX, &pY, 1862, 72, 1909, 114, 0xFF3E17, 2), PixelSearch(&pX, &pY, 1862, 72, 1909, 114, 0xFFFFFF, 2))       ;check for red event(daily login) circle and the white of the x
            {
                Send("{Escape}")
            }
            SellerClogDetecter := 0
        }
        else if(PixelSearch(&pcX, &pcY, customerZone[1], customerZone[2], customerZone[3], customerZone[4], 0xEFEAD6, 1) and !PixelSearch(&pXb, &pYb, 1387, 23, 1413, 48, 0xFFE55C, 2) and tickallocator(tick, "customer"))         ;Look for and click on the customer bubble, if you cant see guild tokens in the top right(not in city view)
        {
            ClickAtCoord(pcX + 10, pcY + 10)
            Sleep(500)
            capriceDailyBonus()
            if(PixelSearch(&pX, &pY, 1235, 258, 1280, 301, 0xFFFFFF, 2) and PixelSearch(&pX, &pY, 1235, 258, 1280, 301, 0xFF3C18, 2))       ;check for white x and red circle(in the case of a counter upgrade for instance)
            {
                counter_upgrade := true
                Send("{Escape}")
                Sleep(500)
                ClickAtCoord(pcX + 10 + 75, pcY + 10)
            }
            if(PixelSearch(&pX, &pY, 1828, 897, 1877, 949, 0xFFD743, 2) and PixelSearch(&pX, &pY, 1804, 946, 1820, 962, 0x552B44, 2))        ;check for edit furniture button
            {
                Send("{Esc}")
                Sleep(250)
            }
            else if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
            {
                inventory_level := Process_Customers(customerZone, inventory_level)
            }
            else if(PixelSearch(&pX, &pY, 1862, 72, 1909, 114, 0xFF3E17, 2), PixelSearch(&pX, &pY, 1862, 72, 1909, 114, 0xFFFFFF, 2))       ;check for red event(daily login) circle and the white of the x
            {
                Send("{Escape}")
            }
            SellerClogDetecter := 0
        }
        else if(PixelSearch(&pX, &pY, customerZone[1], customerZone[2], customerZone[3], customerZone[4], 0xEFE46B, 1) and !PixelSearch(&pXb, &pYb, 1387, 23, 1413, 48, 0xFFE55C, 2) and tickallocator(tick, "customer"))         ;Look for and click on the yellow customer bubble, if you cant see guild tokens in the top right(not in city view)
        { 
            ClickAtCoord(pX, pY)
            Sleep(500)
            capriceDailyBonus()
            if(PixelSearch(&pX, &pY, 1243, 315, 1252, 328, 0xFF481E, 2) and PixelSearch(&pX, &pY, 1262, 315, 1274, 327, 0xFFFFFF, 2))           ;check for red circle and white x for free kings caprice tokens
            {
                if(PixelSearch(&pX, &pY, 706, 463, 732, 491, 0x27E250, 2,) or PixelSearch(&pX, &pY, 898, 460, 926, 486, 0x27E251,2))           ;check for green free tokens from kings caprice event
                {
                    ClickAtCoord(790, 475)          ;collect the free tokens
                    Sleep(500)
                    ClickAtCoord(1267, 322)         ;x out of the menu
                }
            }
            if(PixelSearch(&pX, &pY, 1235, 258, 1280, 301, 0xFFFFFF, 2) and PixelSearch(&pX, &pY, 1235, 258, 1280, 301, 0xFF3C18, 2))       ;check for white x and red circle
            {
                Send("{Escape}")
            }
            else if(SellerClogDetecter > 10)
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
                Process_Customers(customerZone, inventory_level)
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
            Sleep(1000)
            loop(7)
            {
                if(!questy.questCollector.collectQuest(subscription, configs.questing_userepairpacks))      ;collect any finished quests
                    break
                Sleep(500)
            }
            Sleep(500)
            switch(questy.findActiveEvent())
            {
                case "lcog":
                    questy.basic_lcog(0, upTime)
                    Sleep(750)
                case "tot":
                    questy.totAuto()
                    Sleep(750)
                case "nothing":
                    questy.farmEasyChests(0)
                    Sleep(750)
            }
            Quest.EscapeStuckCases(5)
            if(PixelSearch(&pX, &pY, 946, 354, 1034, 468, 0x19CC9D, 2))         ;check if the offer help button is available
            {
                ClickAtCoord(993, 416)      ;click the offer help button
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
                Sleep(2000)
            }
            if(PixelSearch(&pX, &pY, 262, 934, 305, 959, 0xF5BB0D, 2))       ;scan for market tab
            {
                collectAndRelistMarket()
                Sleep(1000)
            }
            if(0 < A_Hour and A_Hour < 2)
                Quest.openAllChests()
            escapeToShop()
            Sleep(3500)
            if(furnitureUpgrade.acknowledgeUpgrade())
            {
                Sleep(1500)
                furnitureUpgrade.upgradeFinishedOk()
                Sleep(1000)
                return_to_default_pos()
                Sleep(1000)
                furnitureUpgrade.findAndUpgrade()
            }
        }
        else if(tickallocator(tick, "resetPos"))     ;reset position
        {
            return_to_default_pos()
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
        else if(PixelSearch(&pX, &pY, 1647, 964, 1719, 997, 0xFFCB19, 3) and GetStoredInfo("InventoryCapacity.txt", "int") < 0.9 and tickallocator(tick, "craft") and configs.crafting == true)       ;check if the item is done crafting
        {
            Craft.CollectItems(10)
            Sleep(500)
            Craft.FigureItOut()
        }
        else if(PixelSearch(&pX, &pY, 1838, 851, 1880, 889, 0xFFB529, 3) and GetStoredInfo("InventoryCapacity.txt", "int") < 0.9 and tickallocator(tick, "craft") and  configs.crafting == true)       ;check if there is an empty crafting slot
        {
            Craft.FigureItOut()     ;launch the crafter
        }
        else if(PixelSearch(&pX, &pY, 246, 918, 284, 956, 0xFFE894, 3) and tickallocator(tick, "bounty"))       ;check on the bounty status
        {
            collect_bounty()
        }
        else if(A_Hour < 22 and 16 < A_Hour and piggyBank)
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
        case 1, 2, 3, 6, 7, 10, 11, 14, 15, 16:
            CurrentEvent := "customer"
        case 4, 12:
            CurrentEvent := "craft"
        case 5:
            CurrentEvent := "bounty"
        case 18:
            CurrentEvent := "closeMenus"
        case 9, 19:
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
            a := true
            while(a)
            {
                Sleep(3000)
                if(WinExist("ahk_exe ShopTitan.exe"))
                {
                    Sleep(5000)
                    WinMaximize("ahk_exe ShopTitan.exe")        ;maximize window
                    a := false
                }
            }
            Sleep(3000)
            ActivateShopTitans()
        }
    }
}

FixWindowFrozen()
{
    if(WinExist("ahk_exe ShopTitan.exe") and PixelSearch(&pX, &pY, 103, -18, 185, -5, 0x000000, 5))       ;check if the game is potentially frozen
    {
        RestartShopTitans()
    }
}

RestartShopTitans()
{
    WinKill("ahk_exe ShopTitan.exe")
    Sleep(10000)
    ActivateShopTitans()
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

CheckWindowRes(x, y, errorMargin)
{
    windowX := SysGet(16)
    windowY := SysGet(17)
    if(windowX < x - errorMargin or x + errorMargin < windowX or y - errorMargin > windowY or windowY > y + errorMargin)
    {
        msgBox("Error: resolution is not set to 1920 X 1080 `nplease set resolution the the appropriate `nsetting before pressing ok")
    }
}

eventPopUpTowerOfTitans()
{
    if(PixelSearch(&pX, &pY, 82, 892, 118, 927, 0xEFE7D3, 2))            ;scan for hero text
    {
        loop(10)
        {
            ClickAtCoord(141, 904)          ;click in the bottom left to get through the hero text
            if(!PixelSearch(&pX, &pY, 82, 892, 118, 927, 0xEFE7D3, 2))            ;scan for a lack of hero text
            {
                break
            }
            Sleep(333)
        }
    }
    Sleep(1000)
    if(PixelSearch(&pX, &pY, 1160, 170, 1243, 230, 0xEFE7D3, 2) and PixelSearch(&pX, &pY, 939, 491, 1003, 615, 0xFFD300, 2))         ;scan for hero indecator in the top middle and mid middle
    {
        ClickAtCoord(960, 544)          ;click on the hero text bubble
    }
    Sleep(750)
    if(PixelSearch(&pX, &pY, 82, 892, 118, 927, 0xEFE7D3, 2))            ;scan for hero text
    {
        loop(10)
        {
            ClickAtCoord(141, 904)          ;click in the bottom left to get through the hero text
            if(!PixelSearch(&pX, &pY, 82, 892, 118, 927, 0xEFE7D3, 2))            ;scan for a lack of hero text
            {
                break
            }
            Sleep(333)
        }
    }
    Sleep(750)
    if(PixelSearch(&pX, &pY, 1208, 274, 1252, 314, 0xFF3C17, 2))        ;scan for x in top left of event menu
    {
        ClickAtCoord(pX, pY)        ;click the x for the event menu
    }
}

giveGift()
{
    if(PixelSearch(&pX, &pY, 719, 503, 758, 524, 0x8FB7DC, 3) or PixelSearch(&pX, &pY, 719, 503, 758, 524, 0xA21D08, 3))       ;scan slot 2 for danial or thomas
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

capriceDailyBonus()
{
    if(PixelSearch(&pX, &pY, 1243, 315, 1252, 328, 0xFF481E, 2) and PixelSearch(&pX, &pY, 1262, 315, 1274, 327, 0xFFFFFF, 2))           ;check for red circle and white x for free kings caprice tokens
    {
        if(PixelSearch(&pX, &pY, 706, 463, 732, 491, 0x27E250, 2,) or PixelSearch(&pX, &pY, 898, 460, 926, 486, 0x27E251,2))           ;check for green free tokens from kings caprice event
        {
            ClickAtCoord(790, 475)          ;collect the free tokens
            Sleep(500)
            ClickAtCoord(1267, 322)         ;x out of the menu
            Sleep(500)
        }
    }
}