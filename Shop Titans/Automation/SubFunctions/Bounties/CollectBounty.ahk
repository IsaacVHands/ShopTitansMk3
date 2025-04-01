#Requires AutoHotkey v2.0
#SingleInstance Force

{
    ClickAtCoord(281, 929)      ;open goals tab
    Sleep(500)
    RunWait("CollectTask.ahk")
    Sleep(500)
    if(PixelSearch(&pX, &pY, 699, 335, 735, 358, 0xFFCF00, 2))        ;check if the tasks tab is selected
    {
        ClickAtCoord(1092, 345)      ;switch to bounty tab
        Sleep(500)
    }
    if(PixelSearch(&pX, &pY, 1067, 592, 1111, 628, 0x2AE74F, 2))      ;check for completed bounty
    {
        ClickAtCoord(975, 606)      ;collect bounty
        Sleep(5000)
        ClickAtCoord(1104, 944)      ;click ok
        Sleep(750)
    }
    RunWait("SelectBounty.ahk")
}

ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(50)
    Click(x, y, "Left", "Up")
    Sleep(10)
}