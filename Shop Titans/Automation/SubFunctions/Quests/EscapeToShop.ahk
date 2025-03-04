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
        Sleep(700)
        attemps++
    }
}