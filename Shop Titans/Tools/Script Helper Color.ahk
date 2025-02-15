#Requires AutoHotkey v2.0

{
    MouseGetPos(&mouseX, &mouseY)
    output := PixelGetColor(mouseX, mouseY)
    A_Clipboard := output
}