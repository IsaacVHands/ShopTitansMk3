#Requires AutoHotkey v2.0
#SingleInstance Force

{
    Loop 7
    {
        MouseMove(336, 779)
        Send("{LButton Down}")
        Sleep(100)
        SendMode "Event"
        MouseMove(1758, 227)
        Send("{LButton Up}")
        Sleep(100)
    }
}