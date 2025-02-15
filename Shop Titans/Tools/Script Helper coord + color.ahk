#Requires AutoHotkey v2.0

{
    MouseGetPos(&mouseX, &mouseY)
    pixelColor := PixelGetColor(mouseX, mouseY)
    output := mouseX ", " MouseY ", " pixelColor
    A_Clipboard := output
}