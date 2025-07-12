#Requires AutoHotkey v2.0
#SingleInstance Force

Class Scan
{
    WaitButton()
    {
        if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
            return true
        else
            return false
    }
    static WaitButton()
    {
        if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))        ;check for wait button
            return true
        else
            return false
    }
}