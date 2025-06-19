#Requires AutoHotkey v2.0
#SingleInstance Force
#Include helpers.ahk
#Include ../Automation/SubFunctions/Quests/Quest.ahk

Farm_Wood_Chests()
{
    ; if(A_Hour >= 0 and A_Hour < 7 or A_Hour >= 9 and A_Hour < 12)
    ; {
    Quest.open_quest_menu("b")
    Sleep(500)
    if(PixelSearch(&pX, &pY, 898, 953, 934, 994, 0x522C44, 2))          ;check if the quest menu is open
    {
        ClickAtCoord(106, 736)          ;open first bookmarked quest
        Sleep(750)
        Quest.difficulty_down(3)
        Sleep(250)
        Quest.launch_quest()
        Sleep(1000)
        if(PixelSearch(&pX, &pY, 898, 953, 934, 994, 0x522C44, 2))          ;check if the quest menu is still open, i.e. there are more heroes to send out and more quest slots to fill
        {
            Farm_Wood_Chests()
        }
    }
    ; }
}

TakeScreenShot(x1, y1, x2, y2)
{
    SendMode("Event")
    Send("{Ctrl Down}")
    Sleep(100)
    Send("{PrintScreen}")
    Sleep(100)
    Send("{Ctrl Up}")
    Sleep(200)
    MouseClickDrag("Left", x1, y1, x2, y2)
    Sleep(200)
}

MoveScreenShot()
{
    YearMonth := A_YYYY "-" A_MM
    PullAddress := "C:\Users\isaac\OneDrive\Documents\ShareX\Screenshots\" YearMonth "\ShopTitan_*.png"
    FileCopy(PullAddress, "C:\Users\isaac\OneDrive\Desktop\AutoHotKey V2 Scripts\ShopTitansMk3\Shop Titans\Automation\SubFunctions\GatherInfo\GemTracker\images")
    FileDelete(PullAddress)
}