#Requires AutoHotkey v2.0

{
    MouseGetPos(&mouseX, &mouseY)
    output := mouseX ", " MouseY
    A_Clipboard := output
}