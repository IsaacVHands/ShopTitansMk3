#Requires AutoHotkey v2.0
#SingleInstance Force

{
    tier := 0
    if(ItemTierSearch("T14"))
        tier := 14
    else if(PixelSearch(&pX, &pY, 755, 197, 756, 198, 0x5C2523, 3) and PixelSearch(&pX, &pY, 760, 197, 761, 198, 0x7A2C25, 3) and PixelSearch(&pX, &pY, 765, 197, 766, 198, 0x712924, 3) and PixelSearch(&pX, &pY, 770, 197, 771, 198, 0x3B1411, 3) and PixelSearch(&pX, &pY, 755, 202, 756, 203, 0xCCC9CB, 3) and PixelSearch(&pX, &pY, 760, 202, 761, 203, 0x301B20, 3) and PixelSearch(&pX, &pY, 765, 202, 766, 203, 0x696267, 3) and PixelSearch(&pX, &pY, 770, 202, 771, 203, 0x797377, 3) and PixelSearch(&pX, &pY, 755, 207, 756, 208, 0x979195, 3) and PixelSearch(&pX, &pY, 760, 207, 761, 208, 0x852F26, 3) and PixelSearch(&pX, &pY, 765, 207, 766, 208, 0xF8F8F8, 3) and PixelSearch(&pX, &pY, 770, 207, 771, 208, 0x22171E, 3) and PixelSearch(&pX, &pY, 755, 212, 756, 213, 0x938E91, 3) and PixelSearch(&pX, &pY, 760, 212, 761, 213, 0x822D24, 3) and PixelSearch(&pX, &pY, 765, 212, 766, 213, 0x361C1F, 3) and PixelSearch(&pX, &pY, 770, 212, 771, 213, 0xCDCACC, 3))
        tier := 13
    else if(ItemTierSearch("T12"))
        tier := 12
    else if(ItemTierSearch("T11"))
        tier := 11
    else if(ItemTierSearch("T10"))
        tier := 10
    else if(ItemTierSearch("T9"))
        tier := 9
    else if(ItemTierSearch("T8"))
        tier := 8
    else if(ItemTierSearch("T7"))
        tier := 7
    msgBox(tier)
}

ItemTierSearch(pngName)
{
    PixelSearch(&pX, &pY, 725, 178, 976, 238, 0xFDA571, 3)
    startX := pX - 3
    startY := pY + 6
    endX := pX + 14
    endY := pY + 26
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