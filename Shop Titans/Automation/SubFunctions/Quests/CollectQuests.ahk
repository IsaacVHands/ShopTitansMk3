#Requires AutoHotkey v2.0
#SingleInstance Force

{
    loop 7
    {
        if(PixelSearch(&pX, &pY, 1643, 961, 1722, 998, 0x71571B, 3))        ;check if quest is ready
        {
            ClickAtCoord(1678, 933)         ;collect quest
            Sleep(1000)
            if(PixelSearch(&pX, &pY, 983, 659, 1014, 701, 0x20F75C, 2))     ;check for broken equipment
            {
                ClickAtCoord(1102, 685)         ;click show all
                Sleep(500)
                BrokenEquipment := true
                while(BrokenEquipment)
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
            }
            loop(20)
            {
                if(PixelSearch(&pX, &pY, 1097, 740, 1156, 780, 0x21F45A, 2))    ;check for level up
                {
                    ClickAtCoord(1211, 758)     ;click continue
                    Sleep(300)
                }
                Sleep(2000)
                if(PixelSearch(&pX, &pY, 852, 909, 893, 949, 0x21F75D, 2))    ;check for area level up
                {
                    ClickAtCoord(958, 931)     ;click continue
                    Sleep(300)
                }
                if(PixelSearch(&pX, &pY, 839, 726, 895, 772, 0xE3A00D, 2))      ;check for collect button
                {
                    ClickAtCoord(895, 772)
                    Sleep(500)
                    break
                }
                else if(PixelSearch(&pX, &pY, 1114, 299, 1121, 323, 0xFFFFFF, 2))       ;if the quest complete words are in the upper middle
                {
                    ClickAtCoord(162, 37)       ;click on nothing in the upper left
                }
                Sleep(1000)
            }
                Sleep(500)
                RunWait("EscapeToShop.ahk")
                Sleep(2000)
                if(PixelSearch(&pX, &pY, 25, 112, 94, 183, 0x645693, 2))            ;check if the tower of titans is active
                {
                    RunWait("TOTSendQuest.ahk")         ;try to launch a tot mission
                }
        }
        Sleep(250)
    }
}

ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(50)
    Click(x, y, "Left", "Up")
    Sleep(10)
}