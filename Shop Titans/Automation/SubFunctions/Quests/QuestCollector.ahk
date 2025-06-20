#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../../../lib/helpers.ahk
#Include ../../../lib/dev_functions.ahk

class QuestCollector
{
    clickReadyQuest()
    {
        if(PixelSearch(&pX, &pY, 1643, 961, 1722, 998, 0x71571B, 3))        ;check if quest is ready
        {
            SendInput("f")            ;click on the ready quest
            return true
        }
    }
    skipCombat()
    {
        if(PixelSearch(&pX, &pY, 150, 946, 210, 986, 0x000000, 2))      ;check if the game is in combat
        {
            loop(80)
            {
                if(PixelSearch(&pX, &pY, 150, 946, 210, 986, 0x000000, 2) and PixelSearch(&pX, &pY, 1804, 953, 1855, 978, 0x6E4F62, 2))       ;scan for skip combat button
                    ClickAtCoord(pX, pY)            ;click skip
                Sleep(500)
                if(!PixelSearch(&pX, &pY, 150, 946, 210, 986, 0x000000, 2))      ;check if the game is not in combat
                {
                    break
                }
            }
        }
    }
    fixBrokenEquipment(subStatus, repairPackSetting)
    {
        if(PixelSearch(&pX, &pY, 983, 659, 1014, 701, 0x20F75C, 2))     ;check for broken equipment
        {
            ClickAtCoord(1102, 685)         ;click show all
            Sleep(500)
            BrokenEquipment := true
            while(BrokenEquipment)
            {
                if(subStatus)
                {
                    if(PixelSearch(&pX, &pY, 1278, 552, 1313, 576, 0xBA7D1F, 2))     ;check for repair with gold button
                    {
                        ClickAtCoord(1391, 546)     ;click repair with gold
                        Sleep(250)
                    }
                    else
                    {
                        BrokenEquipment := false
                    }
                }
                else if(repairPackSetting)
                {
                    if(PixelSearch(&pX, &pY, 1270, 619, 1314, 641, 0x26F863, 2))     ;check for repair button
                    {
                        ClickAtCoord(pX, pY)     ;click repair with repair pack
                        Sleep(250)
                    }
                    else
                    {
                        BrokenEquipment := false
                    }
                }
                else
                {
                    if(DevMode())
                        MsgBox("fix this")
                    if(PixelSearch(&pX, &pY, 1270, 619, 1314, 641, 0x26F863, 2))     ;check for repair button
                    {
                        ClickAtCoord(pX, pY)     ;click repair with repair pack
                        Sleep(250)
                    }
                    else
                    {
                        BrokenEquipment := false
                    }
                }
            }
        }
    }
    clickThroughLootScreen()
    {
        loop(200)
        {
            if(PixelSearch(&pX, &pY, 1097, 740, 1156, 780, 0x21F45A, 2))    ;check for level up
            {
                ClickAtCoord(1211, 758)     ;click continue
                Sleep(300)
            }
            if(PixelSearch(&pX, &pY, 852, 909, 893, 949, 0x21F75D, 2))    ;check for area level up
            {
                ClickAtCoord(958, 931)     ;click continue
                Sleep(300)
            }
            if(PixelSearch(&pX, &pY, 704, 734, 747, 763, 0x522C44, 2) or PixelSearch(&pX, &pY, 839, 726, 895, 772, 0xE3A00D, 2))      ;check for collect button, or gold collect button
            {
                Sleep(500)
                if(DevMode())
                {
                    if(PixelSearch(&pX, &pY, 660, 562, 1297, 718, 0x30EBEF, 2))         ;check if there are gems in the loot
                    {
                        TakeScreenShot(2216, 579, 2953, 725)
                    }
                }
                ClickAtCoord(895, 772)          ;click collect/collect all
                Sleep(1000)
                if(PixelSearch(&pX, &pY, 1861, 73, 1906, 115, 0xFF3E16, 3) and PixelSearch(&pX, &pY, 1861, 73, 1906, 115, 0xFFFFFF, 3))         ;check if event progress screen has popped up
                {
                    Send("{Escape}")
                }
                return true
            }
            else if(PixelSearch(&pX, &pY, 1114, 299, 1121, 323, 0xFFFFFF, 2))       ;if the quest complete words are in the upper middle
            {
                ClickAtCoord(162, 37)       ;click on nothing in the upper left
            }
            Sleep(250)
        }
    }
    collectQuest(subStatus, repairPackSetting)
    {
        if(this.clickReadyQuest())
        {
            Sleep(1000)
            this.skipCombat()
            sleep(1000)
            this.fixBrokenEquipment(subStatus, repairPackSetting)
            Sleep(250)
            this.clickThroughLootScreen()
            return true
        }
        else 
            return false
    }
}