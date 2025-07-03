#Requires AutoHotkey v2.0
#Include ../../../../lib/helpers.ahk
#Include ../Customers.ahk
#Include ../Scan.ahk
#SingleInstance Force

Class CustomerFinder
{
    static customerZoneClick(customerZone, xStartOffset, yStartOffset, colour)
    {
        if(PixelSearch(&pcX, &pcY, customerZone[1] + yStartOffset, customerZone[2] + xStartOffset, customerZone[3], customerZone[4], 0xEFEAD6, 1))         ;Look for and click on the customer bubble, if you cant see guild tokens in the top right(not in city view)
        {
            ClickAtCoord(pcX, pcY)
            return true
        }
        else
            return false
    }
    static checkActiveIntity()
    {
        if(Scan.WaitButton())
            return "customer"
        else if(PixelSearch(&pX, &pY, 1828, 897, 1877, 949, 0xFFD743, 2) and PixelSearch(&pX, &pY, 1804, 946, 1820, 962, 0x552B44, 2))        ;check for edit furniture button
            return "regular furniture"
        else 
    }
    static ClickCustomer(inventory_level, customerZone)
    {
        if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
        {
            return true
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
                return true
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
                return true
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
    }
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