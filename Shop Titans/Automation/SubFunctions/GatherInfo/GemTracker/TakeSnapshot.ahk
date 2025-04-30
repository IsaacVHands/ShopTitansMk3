#Requires AutoHotkey v2.0
#SingleInstance Force

{
    FileGetShortcut("imagesShortcut.lnk", &OutTarget)
    if(InStr(OutTarget, "C:\Users\isaac\"))
    {
        if(!FileExist("TimeStamp.txt"))
        {
            FileAppend(0, "TimeStamp.txt")
        }
        timeStamp := FileRead("TimeStamp.txt")
        currentTime := A_YYYY A_MM A_DD A_Hour
        if(currentTime > timeStamp)
        {
            FileDelete("TimeStamp.txt")
            FileAppend(currentTime, "TimeStamp.txt")
            SendMode "Event"
            TakeScreenShot(3326, 41, 3385, 76)
            Sleep(500)
            MoveScreenShot()
        }
    }
}

TakeScreenShot(x1, y1, x2, y2)
{
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