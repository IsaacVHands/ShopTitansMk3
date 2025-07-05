#Requires AutoHotkey v2.0
#include ../../../lib/helpers.ahk
#Include QuestCollector.ahk
#Include OpenChests.ahk
#SingleInstance Force

Class Quest
{
    __New() 
    {
        this.questCollector := QuestCollector()
    }
    static difficulty_up(n)
    {
        loop(n)
        {
            ClickAtCoord(1499, 635)         ;click difficulty up
            Sleep(333)
            if(PixelSearch(&pX, &pY, 1490, 627, 1500, 643, 0x522C44, 2))
            {
                break
            }
        }
    }
    static difficulty_down(n)
    {
        if(PixelSearch(&pX, &pY, 1090, 632, 1097, 641, 0x522C44, 2))
        {
            return true
        }
        loop(n)
        {
            ClickAtCoord(1090, 635)         ;click difficulty down
            Sleep(333)          
            if(PixelSearch(&pX, &pY, 1090, 632, 1097, 641, 0x522C44, 2))            ;check if difficulty is minimized
            {
                break
            }
        }
        return false
    }
    Static get_hero_happiness()
    {
        if(PixelSearch(&pX, &pY, 478, 337, 935, 397, 0x13E533, 3))          ;check if there is green
            return 1
        else if(PixelSearch(&pX, &pY, 478, 337, 935, 382, 0x202020, 3) and PixelSearch(&pX, &pY, 478, 337, 935, 397, 0xF6B614, 3))          ;check if there is black and yellow (super happy)
            return 1
        else
            return 0
    }
    Static launch_quest()
    {
        ClickAtCoord(1297, 760)         ;click explore area
    }
    static fix_overawed_party()
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
    static maximize_party_difficulty()
    {
        loop(11)
        {
            if(this.get_hero_happiness() == 1)
                this.difficulty_up(1)
            else
                break
        }
        loop(11)
        {
            if(this.get_hero_happiness() == 0)
                this.difficulty_down(1)
            else
                break
        }
    }
    /*static get_hero_availability()
    {
        if(PixelSearch(&pX, &pY, 215, 890, 226, 920, 0xFFB629, 3) and PixelSearch(&pX, &pY, 1866, 851, 1879, 877, 0xFFB42A, 3))            ;check for extra heroes and quest slots
        {
            return true
        }
        else if()
    }*/
    static open_quest_menu(tab)
    {
        if(PixelSearch(&pX, &pY, 548, 947, 579, 973, 0x522C44, 2))          ;check if the questing menu is already open
        {
            return true
        }
        else if(PixelSearch(&pX, &pY, 215, 890, 226, 920, 0xFFB629, 3) and PixelSearch(&pX, &pY, 1866, 851, 1879, 877, 0xFFB42A, 3))            ;check for extra heroes and quest slots
        {
            SendInput("{Space}")         ;open quest menu
            Sleep(1000)
            if(PixelSearch(&pX, &pY, 1305, 947, 1344, 979, 0x251921, 3) and tab == "a")         ;check if the all tab is not selected
                ClickAtCoord(1416, 970)     ;open all tab
            else if(PixelSearch(&pX, &pY, 1616, 950, 1662, 985, 0x251921, 3) and tab == "b")         ;check if the bookmarks tab is not selected 
                ClickAtCoord(1757, 973)     ;open bookmark tab
            return true
        }
        else
            return false
    }
    static basic_lcog(numtries)
    {
        if(this.open_quest_menu("a"))
        {
            Sleep(1000)
            if(PixelSearch(&pX, &pY, 19, 873, 809, 896, 0x6D3906, 2))            ;check if the LCOG quest is available
            {
                ClickAtCoord(pX, pY)        ;open the LCOG quest
                sleep(500)
                this.fix_overawed_party()
                Sleep(500)
                if(!PixelSearch(&pX, &pY, 1274, 778, 1303, 788, 0x206032, 3))           ;check if there are any available heros
                {
                    this.maximize_party_difficulty()
                    ClickAtCoord(1301, 761)         ;send quest
                    if(!PixelSearch(&pX, &pY, 27, 930, 39, 943, 0x00FF4F, 3) and numtries < 15)       ;if there are still more questing slots
                    {
                        Sleep(7000)
                        attempt := numtries + 1
                        this.basic_lcog(attempt)
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
    static farmEasyChests(iteration)
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