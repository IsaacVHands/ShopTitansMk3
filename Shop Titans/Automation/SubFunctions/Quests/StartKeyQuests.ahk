#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Event"
{
    if(PixelSearch(&pX, &pY, 230, 819, 1827, 855, 0x952721, 2))         ;check for key quests(the red part of them)
    {
        loop(10)
        {           
            if(PixelSearch(&pX, &pY, 15, 813, 184, 853, 0x962822, 2))           ;check if the first slot is a key quest
                break
            else
                QuestSlotShiftR()
        }
        loop(10)
        {           
            if(!PixelSearch(&pX, &pY, 15, 813, 184, 853, 0x962822, 2))           ;check if the first slot is not a key quest
                break
            else
                QuestSlotShiftR()
        }
        Loop(10)
        {
            QuestSlotShiftL()
            Sleep(300)
            if(PixelSearch(&pX, &pY, 1845, 854, 1877, 887, 0x21EF4A, 2))           ;check if there are no more crafting slots
            {
                Sleep(500)
                Send("{Escape}")
                Sleep(500)
                break
            }
            else if(PixelSearch(&pX, &pY, 15, 813, 184, 853, 0x962822, 2))           ;check if the first slot is a key quest
            {
                ClickAtCoord(92, 757)       ;click the on first slot(this slot will be the last one of the key quests after all of the scrolling)
                Sleep(500)
                RunWait("SendQuest.ahk")
                Sleep(500)
            }
            else
            {
                Send("{Escape}")
                Sleep(750)
                Send("{Escape}")
                Sleep(500)
                break
            }
        }
    }
}

QuestSlotShiftR()
{
    MouseMove(518, 725)
    Sleep(100)
    Send("{LButton Down}")
    Sleep(100)
    MouseMove(277, 725, 20)
    Sleep(100)
    Send("{LButton Up}")
}

QuestSlotShiftL()
{
    MouseMove(277, 725)
    Sleep(100)
    Send("{LButton Down}")
    Sleep(100)
    MouseMove(518, 725, 20)
    Sleep(100)
    Send("{LButton Up}")
}

ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(50)
    Click(x, y, "Left", "Up")
}