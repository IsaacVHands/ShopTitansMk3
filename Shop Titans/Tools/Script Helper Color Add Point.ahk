#Requires AutoHotkey v2.0

{
    MouseGetPos(&mouseX, &mouseY)
    output := A_Clipboard ", " PixelGetColor(mouseX, mouseY)
    A_Clipboard := output
}