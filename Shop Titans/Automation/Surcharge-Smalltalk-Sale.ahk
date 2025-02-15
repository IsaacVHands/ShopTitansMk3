#Requires AutoHotkey v2.0
#SingleInstance Force
Delay := 250
{
    MouseGetPos(&mouseX, &mouseY)
    customerBubbleLocation := PixelGetColor(mouseX, mouseY)
    loop 10000
    {
        customerBubbleSpot := PixelGetColor(mouseX, mouseY)
        EnergyBar := PixelGetColor(1503, 46)
        if(EnergyBar == 0xFE5D36 and customerBubbleSpot == customerBubbleLocation)
        {
            ClickAtCoord(mouseX, mouseY)
            Sleep(5 * Delay)
            ClickAtCoord(1309, 526)
            Sleep(Delay)
            ClickAtCoord(632, 529)
            Sleep(Delay)
            ClickAtCoord(1262, 632)
            Sleep(Delay)
            loop 5
            {
                if(PixelGetColor(1313, 636) == 0x21F65B)
                {
                    ClickAtCoord(1262, 632)
                }
                Sleep(Delay)
            }
        }
        sleep(10000)
    }
}
ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(200)
    Click(x, y, "Left", "Up")
}
