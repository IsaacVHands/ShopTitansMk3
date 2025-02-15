#Requires AutoHotkey v2.0
#SingleInstance Force
Delay := 250
{
    MouseGetPos(&mouseX, &mouseY)
    customerBubbleLocation := PixelGetColor(mouseX, mouseY)
    ScanPixelsClick(mouseX, mouseY, customerBubbleLocation)
    loop 0
    {
        customerBubbleSpot := PixelGetColor(mouseX, mouseY)
        if(customerBubbleSpot == customerBubbleLocation)
        {
            ClickAtCoord(mouseX, mouseY)
            Sleep(5 * Delay)
            ClickAtCoord(632, 529)
            Sleep(4 * Delay)
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
    Sleep(80)
    Click(x, y, "Left", "Up")
}
PixelCompareColor(x, y, color)
{
    if(PixelGetColor(x, y) == color)
    {
        return true
    }
    else
        return false
}
ScanPixelsClick(x, y, color)
{
    X := x
    Y := y
    loop 50
    {
        loop 50
        {
            if(PixelCompareColor(X, Y, color) == true)
            {
                ClickAtCoord(X, Y)
                sleep 500
                MsgBox "it worked!"
            }
            X++ 
        }
        Y++
        X := x
    }
}