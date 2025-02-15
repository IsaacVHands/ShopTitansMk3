#Requires AutoHotkey v2.0

{
    MouseGetPos(&mouseX, &mouseY)
    output := A_Clipboard ", " mouseX ", " MouseY
    A_Clipboard := output
}