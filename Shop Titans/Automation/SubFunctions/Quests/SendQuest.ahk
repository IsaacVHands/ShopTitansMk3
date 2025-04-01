#Requires AutoHotkey v2.0

{
    overMaxDifficulty := false
    loop(4)         ;pick the difficulty
    {
        if(PixelSearch(&pX, &pY, 580, 708, 604, 729, 0x9200FF, 2))          ;check if a character is bellow the minimum power
        {
            ClickAtCoord(1090, 636)         ;decrease the difficulty
            overMaxDifficulty := true
        }
        else if(overMaxDifficulty == false)
        {
            ClickAtCoord(1497, 634)         ;increase the difficulty
        }
        Sleep(500)
    }
    loop(4)
    {
        if(PixelSearch(&pX, &pY, 501, 335, 895, 399, 0xFFCB31, 2) or PixelSearch(&pX, &pY, 501, 335, 895, 399, 0x3EF865, 2) or PixelSearch(&pX, &pY, 501, 335, 895, 399, 0xF4CB00, 2))         ;checks if there is at least 1 character that has at least a yellow face
        {
            Sleep(1000)
            ClickAtCoord(1299, 763)         ;click explore area
            Sleep(4000)
            break
        }
        else
        {
            ClickAtCoord(1090, 636)         ;decrease the difficulty
        }
        Sleep(300)
    }
    if(PixelSearch(&pX, &pY, 1177, 744, 1219, 786, 0x1EF65A, 2))            ;check if the quest was not started
    {
        Send("{Escape}")
    }
}

ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(50)
    Click(x, y, "Left", "Up")
}