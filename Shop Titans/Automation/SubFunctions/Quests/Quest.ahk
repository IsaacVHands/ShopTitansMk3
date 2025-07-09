#Requires AutoHotkey v2.0
#include ../../../lib/helpers.ahk
#Include ../General/MenuManager.ahk
#Include QuestCollector.ahk
#Include OpenChests.ahk
#SingleInstance Force

Class Quest
{
    __New() 
    {
        this.questCollector := QuestCollector()
        this.highestDifficulty := -1
        this.upTime := 0
    }
    difficulty_up(n)
    {
        loop(n)
        {
            ClickAtCoord(1499, 635)         ;click difficulty up
            Sleep(200)
            if(PixelSearch(&pX, &pY, 1490, 627, 1500, 643, 0x522C44, 2))
            {
                return true
            }
            return false
        }
    }
    difficulty_down(n)
    {
        if(PixelSearch(&pX, &pY, 1090, 632, 1097, 641, 0x522C44, 2))
        {
            return true
        }
        loop(n)
        {
            ClickAtCoord(1090, 635)         ;click difficulty down
            Sleep(200)          
            if(PixelSearch(&pX, &pY, 1090, 632, 1097, 641, 0x522C44, 2))            ;check if difficulty is minimized
            {
                return true
            }
        }
        return false
    }
    get_party_size_current(maxPartySize)
    {
        if(maxPartySize == 5)
        {
            currentPartySize := 0
            Coords := [513, 354, 611, 324, 701, 357, 789, 324, 877, 353]
            loop(maxPartySize)
            {
                if(PixelSearch(&pX, &pY, Coords[(A_Index * 2) - 1] - 10, Coords[((A_Index * 2))] - 10, Coords[(A_Index * 2) - 1], Coords[((A_Index * 2))], 0xF8F4E6, 4))           ;check if the white part of the bubble exists(to decrease false posatives)
                    currentPartySize++                      
            }
            return currentPartySize
        }
    }
    get_hero_happiness(topLeftFaceX, topLeftFaceY, attempt)
    {
        if(PixelSearch(&pX, &pY, topLeftFaceX - 10, topLeftFaceY - 10, topLeftFaceX, topLeftFaceY, 0xF8F4E6, 4) and attempt < 3)           ;check if the white part of the bubble exists(to decrease false posatives)
        {
            topLeftFaceX2 := topLeftFaceX + 20
            topLeftFaceY2 := topLeftFaceY + 20
            if(PixelSearch(&pX, &pY, topLeftFaceX, topLeftFaceY, topLeftFaceX2, topLeftFaceY2, 0x8C00FE, 3))           ;check if the face is purple
                return 0
            else if(PixelSearch(&pX, &pY, topLeftFaceX, topLeftFaceY, topLeftFaceX2, topLeftFaceY2, 0xFF1E00, 3))           ;check if the face is red
                return 1
            else if(PixelSearch(&pX, &pY, topLeftFaceX, topLeftFaceY, topLeftFaceX2, topLeftFaceY2, 0xFF8300, 3))           ;check if the face is orange
                return 2
            else if(PixelSearch(&pX, &pY, topLeftFaceX, topLeftFaceY, topLeftFaceX2, topLeftFaceY2, 0xF4CA00, 3))           ;check if the face is yellow
                return 3
            else if(PixelSearch(&pX, &pY, topLeftFaceX, topLeftFaceY, (topLeftFaceX + 20), (topLeftFaceY + 20), 0x64F88C, 3))           ;check if the face is green
                return 4
            else if(PixelSearch(&pX, &pY, topLeftFaceX, topLeftFaceY, topLeftFaceX2, topLeftFaceY2, 0xFEBC15, 3))           ;check if the face has black
                return 5
            else if(PixelSearch(&pX, &pY, topLeftFaceX - 10, topLeftFaceY - 10, topLeftFaceX, topLeftFaceY, 0xF8F4E6, 3))            ;check for the white part of the charcter bubble
            {
                attempt++
                additionalTry := this.get_hero_happiness(topLeftFaceX, topLeftFaceY, attempt)
                return additionalTry
            }
        }
        return -1
    }
    get_party_happiness(maxPartySize)
    {
        if(maxPartySize == 5)
        {
            a := 0
            b := 0
            partyCount := maxPartySize
            Coords := [513, 354, 611, 324, 701, 357, 789, 324, 877, 353]
            loop(5)
            {
                ; MsgBox(A_Index ", " Coords[A_Index * 2])
                currentHero := this.get_hero_happiness(Coords[(A_Index * 2) - 1], Coords[((A_Index * 2))], 0)
                if(currentHero == 5)
                {
                    a++
                    b++
                }
                else if(currentHero >= 3)
                    b++
                else if(currentHero == -1)
                    partyCount--
            }
            if(partyCount == 1 and a > 0 or b > 0 and partyCount == 1)
                return true
            else if(a > 0 or b > 0 or b > 2)
                return true
            else
                return false
        }
        else
        {
            if(PixelSearch(&pX, &pY, 478, 337, 935, 397, 0x13E533, 3))          ;check if there is green
                return true
            else if(PixelSearch(&pX, &pY, 478, 337, 935, 382, 0x202020, 3) and PixelSearch(&pX, &pY, 478, 337, 935, 397, 0xF6B614, 3))          ;check if there is black and yellow (super happy)
                return true
            else
                return false
        }
    }
    launch_quest()
    {
        ClickAtCoord(1297, 760)         ;click explore area
    }
    fix_overawed_party()
    {
        if(PixelSearch(&pX, &pY, 1222, 726, 1238, 739, 0x29653A, 2))            ;check if send quest button is slitely grayed out
        {
            this.difficulty_down(11)
            Sleep(500)
            ClickAtCoord(711, 623)          ;open the add heros menu
            Sleep(500)
            loop(6)
            {
                if(PixelSearch(&pX, &pY, 1227, 399, 1242, 415, 0x5B3047, 2) and !PixelSearch(&pX, &pY, 1228, 472, 1247, 491, 0x81DFFF, 2))            ;check if hero is ready, and if hero is not sleeping
                {
                    ClickAtCoord(1295, 404)         ;add hero
                }
                else
                {
                    if(!PixelSearch(&pX, &pY, 1220, 726, 1232, 741, 0x29F863, 2))            ;check for green launch quest button not being there
                    {
                        ClickAtCoord(1524, 206)
                        Sleep(500)
                    }
                    break
                }
                Sleep(333)
            }
        }
    }
    maximize_party_difficulty(maxPartySize, maxDifficulty, upTime)
    {
        if(upTime > 6)
        {
            maxDif := false
            loop(maxDifficulty)
            {
                if(this.get_party_happiness(maxPartySize) and !maxDif)
                    maxDif := this.difficulty_up(1)
                else
                    break
            }
            minDif := false
            loop(maxDifficulty)
            {
                if(!this.get_party_happiness(maxPartySize) and !minDif)
                    minDif := this.difficulty_down(1)
                else
                    break
            }
            return -1
        }
        else
        {
            this.difficulty_up(maxDifficulty)
            currentDifficulty := maxDifficulty
            minDif := false
            loop(maxDifficulty)
            {
                if(!this.get_party_happiness(maxPartySize) and !minDif)
                {
                    minDif := this.difficulty_down(1)
                    currentDifficulty--
                }
                else
                    break
            }
            return currentDifficulty
        }
    }
    get_hero_availability()
    {
        if(PixelSearch(&pX, &pY, 1866, 851, 1879, 877, 0xFFB42A, 3))            ;check for available questing slots
        {
            if(PixelSearch(&pX, &pY, 215, 890, 226, 920, 0xFFB629, 3))            ;check for extra heroes and quest slots
            {
                return true
            }
            else if(PixelSearch(&pX, &pY, 215, 890, 226, 920, 0xF53516, 2))         ;check if there is a red exclamtion mark on the hero number slot
            {
                Send("1")
                Sleep(1000)
                ClickAtCoord(1374, 967)      ;open the hero line
                Sleep(500)
                if(PixelSearch(&pX, &pY, 282, 893, 286, 898, 0x6EFF2E, 2))          ;check for ready hero
                {
                    send("{Escape}")
                    Sleep(500)
                    return true
                }
                ClickAtCoord(1581, 964)
                sleep(500)
                if(PixelSearch(&pX, &pY, 282, 893, 286, 898, 0x6EFF2E, 2))          ;check for ready champion
                {
                    send("{Escape}")
                    Sleep(500)
                    return true
                }
            }
        }
        return false
    }
    open_quest_menu(tab)
    {
        if(PixelSearch(&pX, &pY, 548, 947, 579, 973, 0x522C44, 2))          ;check if the questing menu is already open
        {
            return true
        }
        else if(this.get_hero_availability())            ;check for extra heroes and quest slots
        {
            SendInput("{Space}")         ;open quest menu
            Sleep(1000)
            if(PixelSearch(&pX, &pY, 1305, 947, 1344, 979, 0x251921, 3) and tab == "a")         ;check if the all tab is not selected
                ClickAtCoord(1416, 970)     ;open all tab
            else if(PixelSearch(&pX, &pY, 1616, 950, 1662, 985, 0x251921, 3) and tab == "b")         ;check if the bookmarks tab is not selected 
                ClickAtCoord(1757, 973)     ;open bookmark tab
            Sleep(1000)
            return true
        }
        else
            return false
    }
    useBooster(booster, maxTier)
    {
        if(PixelSearch(&pX, &pY, 1488, 745, 1495, 753, 0xA74C80, 2))            ;check for booster button
        {
            ClickAtCoord(1492, 751)         ;open booster menu
            Sleep(200)
            if(waitForEvent(58, 988, 69, 999, 0xB36D20, 100, 5000))             ;check to see if the menu was open
            {
                boosterList := ["power", "loot", "compass"]
                startingSlot := 0
                loop(boosterList.Length)
                {
                    if(booster == boosterList[A_Index])
                        startingSlot := ((A_Index - 1) * 3) + 1 
                }
                loop(maxTier)
                {
                    if(MenuManager.SlotNonZero(startingSlot + A_Index - 1))
                    {
                        MenuManager.clickSlot(startingSlot + A_Index - 1)
                        return true
                    }
                }
                Send("{Escape}")
            }
            return false
        }
    }
    basic_lcog(numtries, upTime)
    {
        maxEventDifficulty := 12
        this.upTime := upTime
        if(this.open_quest_menu("a"))
        {
            if(PixelSearch(&pX, &pY, 19, 873, 809, 896, 0x6D3906, 2))            ;check if the LCOG quest is available
            {
                ClickAtCoord(pX, pY)        ;open the LCOG quest
                sleep(500)
                this.fix_overawed_party()
                Sleep(500)
                if(this.get_party_size_current(5) < 5)
                {
                    loop(2)
                    {
                        send("{Escape}")
                        Sleep(500)
                    }
                    return true
                }
                if(!PixelSearch(&pX, &pY, 1274, 778, 1303, 788, 0x206032, 3))           ;check if there are any available heros
                {
                    currentDifficulty := this.maximize_party_difficulty(5, maxEventDifficulty, upTime)
                    if(currentDifficulty > this.highestDifficulty)
                        this.highestDifficulty := currentDifficulty
                    if(currentDifficulty == maxEventDifficulty or this.upTime > 5 and currentDifficulty == this.highestDifficulty)          ;checks if either the quest has the global or local(after at least 5 hours) maxium
                    {
                        this.useBooster("loot", 2)
                        Sleep(500)
                    }
                    ClickAtCoord(1301, 761)         ;send quest
                    if(!PixelSearch(&pX, &pY, 27, 930, 39, 943, 0x00FF4F, 3) and numtries < 15)       ;if there are still more questing slots
                    {
                        Sleep(7000)
                        attempt := numtries + 1
                        this.basic_lcog(attempt, upTime)
                    }
                }
                return true
            }
            else
            {
                send("{Escape}")
                return false
            }
        }
        else
            return true
    }
    farmEasyChests(iteration)
    {
        ; if(A_Hour >= 0 and A_Hour < 7 or A_Hour >= 9 and A_Hour < 12)
        ; {
        this.open_quest_menu("b")
        Sleep(500)
        if(PixelSearch(&pX, &pY, 898, 953, 934, 994, 0x522C44, 2))          ;check if the quest menu is open
        {
            ClickAtCoord(106, 736)          ;open first bookmarked quest
            Sleep(750)
            if(this.difficulty_down(3))
                Sleep(250)
            this.launch_quest()
            Sleep(1500)
            if(PixelSearch(&pX, &pY, 898, 953, 934, 994, 0x522C44, 2) and iteration < 15)          ;check if the quest menu is still open, i.e. there are more heroes to send out and more quest slots to fill
            {
                iteration++
                this.farmEasyChests(iteration)
            }
        }
        ; }
    }
    static EscapeStuckCases(checkIterations)
    {
        loop(checkIterations)
        {
            if(PixelSearch(&pX, &pY, 704, 734, 747, 763, 0x522C44, 2) or PixelSearch(&pX, &pY, 839, 726, 895, 772, 0xE3A00D, 2))      ;check for collect button, or gold collect button
            {
                ClickAtCoord(895, 772)          ;click collect/collect all
            }
            Sleep(100)
        }
    }
    static openAllChests()
    {
        if(OpenChests.openChestMenu())
        {
            OpenChests.unlockChests()
            Sleep(500)
            OpenChests.closeChestMenu()
        }
    }
}