#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../../../lib/helpers.ahk

collect_task()
{
    if(PixelSearch(&pX, &pY, 716, 333, 737, 360, 0x261B21, 3))      ;check if the tasks tab is active
    {
        ClickAtCoord(832, 346)
        Sleep(400)
    }
    loop 3
    {
        if(PixelSearch(&pX, &pY, 1095, 411, 1164, 663, 0x2BE84F, 3))        ;check if any tasks are fnished
        {
            ClickAtCoord(pX, pY)
        }
        Sleep(500)
    }
    ClickAtCoord(1197, 451)         ;click the reset button for the top task
    Sleep(750)
    if(PixelSearch(&pX, &pY, 1002, 628, 1028, 655, 0x20F75A, 2))            ;scan for green yes button
    {
        ClickAtCoord(pX, pY)         ;click yes
        Sleep(500)
    }

}