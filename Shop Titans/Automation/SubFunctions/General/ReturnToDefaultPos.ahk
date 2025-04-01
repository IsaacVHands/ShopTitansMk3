#Requires AutoHotkey v2.0
#SingleInstance Force

{
    a := true
    attemps := 0
    while(a)
    {
        if(attemps == 30 or PixelSearch(&pX, &pY, 81, 925, 102, 941, 0xFAD11B, 2) and PixelSearch(&pX, &pY, 17, 30, 60, 51, 0x0162FF, 2) and !PixelSearch(&pX, &pY, 1830, 902, 1867, 937, 0xFFD743, 2))   ;checks quests level and furniture edit button
        {
            a := false
        }
        else
        {
            Send("{Esc}")
        }
        Sleep(850)
        attemps++
    }
    SendEvent("{WheelDown 10}")
    Sleep(100)
    Loop 7
    {
        MouseMove(336, 779)
        Send("{LButton Down}")
        Sleep(100)
        SendMode "Event"
        MouseMove(1758, 227)
        Send("{LButton Up}")
        Sleep(100)
    }
    Sleep(500)
    MouseMove(1770, 173)
    Send("{LButton Down}")
    Sleep(100)
    SendMode "Event"
    MouseMove(1251, 379)
    Send("{LButton Up}")
    Sleep(100)
}