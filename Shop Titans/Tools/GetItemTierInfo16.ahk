#Requires AutoHotkey v2.0
#SingleInstance Force

{
    PixelSearch(&pX, &pY, 725, 178, 976, 238, 0xFDA571, 3)
    startX := pX - 3
    startY := pY + 6
    endX := pX + 14
    endY := pY + 26
    scanX := startX
    scanY := startY
    output := "if("
    loop 4
    {
        loop 4
        {
            ;MouseMove(scanX, scanY)
            ;Sleep(250)
            color := PixelGetColor(scanX, scanY)
            output := output "PixelSearch(&pX, &pY, " scanX ", " scanY ", " (scanX + 1) ", " (scanY + 1) ", " color ", 3) and "
            scanX += 5
        }
        scanX := startX
        scanY += 5
    }
    output := RTrim(output, "and ")
    output := output ")"
    A_Clipboard := output
    ;ItemTierSearch("T10")
}
ItemTierSearch(pngName)
{
    PixelSearch(&pX, &pY, 725, 178, 976, 238, 0xFDA571, 3)
    startX := pX - 3
    startY := pY + 6
    endX := pX + 14
    endY := pY + 26
    output := startX " " startY " " endX " " endY
    A_Clipboard := output
    MouseMove(startX, startY)
    Sleep(300)
    MouseMove(endX, endY)
    Sleep(300)
    path := "*3 *trans0x7B2C24 C:\Users\isaac\OneDrive\Desktop\AutoHotKey V2 Scripts\Shop Titans\Automation\SubFunctions\Check Item Tier\Ref-Images\" pngName ".png"
    if(ImageSearch(&pX, &pY, startX, startY, endX, endY, path))
    {
        msgBox("true!!")
        return true
    }
    else
    {
        return false
    }
}