#Requires AutoHotkey v2.0

#Requires AutoHotkey v2.0
#SingleInstance Force
Delay := 250
{
    MouseGetPos(&mouseX, &mouseY)
    sleep(1000)
    customerBubbleLocation := PixelGetColor(mouseX, mouseY)
    loop 10000
    {
        customerBubbleSpot := PixelGetColor(mouseX, mouseY)
        if(customerBubbleSpot == customerBubbleLocation)
        {
            ClickAtCoord(mouseX, mouseY)
            Sleep(5 * Delay)
            ClickAtCoord(766, 629)
            loop 5
            {
                if(PixelGetColor(766, 629) == 0xF7491E)
                {
                    ClickAtCoord(766, 629)
                }
                Sleep(Delay)
            }
        }
        sleep(1000)
    }
}
ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(200)
    Click(x, y, "Left", "Up")
}
