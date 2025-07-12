#Requires AutoHotkey v2.0
#Include ../../../lib/helpers.ahk
#Include ../Customers/Scan.ahk
#Include ../Customers/Customers.ahk
#SingleInstance Force

Class Furniture
{
    __New()
    {
        this.cachedFurnitureCoord := [0, 0]
    }
    clearCache()
    {
        this.cachedFurnitureCoord := [0, 0]
    }
    upgradeFinishedOk()
    {
        if(PixelSearch(&pX, &pY, 897, 931, 913, 956, 0x21F75D, 2))          ;check for okay button
        {
            ClickAtCoord(pX, pY)            ;click okay
        }
    }
    checkSelectedFurniture()
    {
        if(PixelSearch(&pX, &pY, 1810, 940, 1823, 956, 0x552B44, 2))            ;check for edit button
        {
            if(PixelSearch(&pX, &pY, 1596, 914, 1616, 933, 0x37FF5D, 2) or PixelSearch(&pX, &pY, 1718, 915, 1736, 928, 0x37FF5D, 2))       ;check for edit button third or second from the left
            {
                return true
            }
        }
        return false
    }
    findFurniture()
    {
        if(this.cachedFurnitureCoord[1] != 0)
        {
            ClickAtCoord(this.cachedFurnitureCoord[1], this.cachedFurnitureCoord[2])
            Sleep(500)
            if(!this.checkSelectedFurniture())
            {
                this.clearCache()
                this.findFurniture
            }
            else
                return true
        }
        else
        {
            loop(100)
            {
                clickPoint := clickRandomPointNotInDeadZone(118, 83, 1720, 859, 650, 512, 1105, 816)
                Sleep(333)
                if(A_Index > 50)
                    Sleep(127)
                if(A_Index > 75)
                    Sleep(250)
                if(this.checkSelectedFurniture())
                {
                    this.cachedFurnitureCoord := clickPoint
                    return true
                }
            }
            return false
        }
    }
    acknowledgeUpgrade()
    {
        if(PixelSearch(&pX, &pY, 570, 319, 1289, 753, 0x11E85C, 2))         ;scan for furniture finished upgrading
        {
            ClickAtCoord(pX, pY)
            return true
        }
        else if(PixelSearch(&pX, &pY, 570, 319, 1289, 753, 0x35FF5C, 2))         ;scan again for furniture finished upgrading
        {
            ClickAtCoord(pX, pY)
            return true
        }
        else
            return false
    }
    openUpgradeMenu()
    {
        if(PixelSearch(&pX, &pY, 1596, 920, 1619, 940, 0x37FF5D, 2))            ;check if the upgrade button is third from the right
        {
            ClickAtCoord(1605, 925)         ;click third from the right
        }
        else if(PixelSearch(&pX, &pY, 1718, 920, 1740, 940, 0x37FF5D, 2))            ;check if the upgrade button is second from the right
        {
            ClickAtCoord(1730, 922)         ;click second from the right
        }
    }
    attemptUpgrade()
    {
        if(!PixelSearch(&pX, &pY, 1209, 650, 1250, 672, 0xED8551, 4) and !PixelSearch(&pX, &pY, 1127, 704, 1163, 723, 0x26EFF9, 2))            ;check if the upgrade does not take dragon tokens and not an upgrade in progress
        {
            if(!PixelSearch(&pX, &pY, 1163, 702, 1183, 717, 0xAB925D, 2))            ;check if upgrade is affordable
            {
                ClickAtCoord(1107, 723)         ;click upgrade with gold
                Sleep(1000)
                if(PixelSearch(&pX, &pY, 888, 622, 907, 651, 0xF7481E, 2) and PixelSearch(&pX, &pY, 1138, 610, 1157, 627, 0x29EFFA, 2))          ;check if an upgrade is already in progress(i. e. no upgrading slots available)
                {
                    Send("{Escape}")
                    Sleep(500)
                    Send("{Escape}")
                    return true
                }
                Send("{Escape}")
                return true
            }
        }
        return false
    }
    cycleUpgradeAttempts(iterations)
    {
        loop(iterations)
        {
            if(this.attemptUpgrade())
            {
                return true
            }
            else
            {
                Send("{Right}")
                Sleep(100)
            }
        }
        this.clearCache()
        return false
    }
    askForHelp()
    {
        if(PixelSearch(&pX, &pY, 141, 72, 1721, 856, 0x27DCB0, 2))
        {
            ClickAtCoord(pX, pY)
        }
    }
    attemptDeskUpgrade()
    {
        ClickAtCoord(948, 636)          ;attempt to click the front desk
        Sleep(1000)
        if(Scan.WaitButton())
        {
            Customer.Wait()
            Sleep(1000)
            return false
        }
        else
        {
            if(this.checkSelectedFurniture())
            {
                this.openUpgradeMenu()
                Sleep(750)
                if(this.attemptUpgrade())
                {
                    return true
                }
                else
                {
                    Send("{Escape}")
                    Sleep(500)
                    Send("{Escape}")
                    Sleep(500)
                    return false
                }
            }
        }
        return false
    }
    findAndUpgrade()
    {
        if(this.attemptDeskUpgrade())
        {
            this.askForHelp()
        }
        else if(this.findFurniture())
        {
            this.openUpgradeMenu()
            Sleep(750)
            if(this.cycleUpgradeAttempts(100))
                this.askForHelp()
        }
        return_to_default_pos()
    }
}