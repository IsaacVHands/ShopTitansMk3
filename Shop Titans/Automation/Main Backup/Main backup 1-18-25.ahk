#Requires AutoHotkey v2.0
#SingleInstance Force
delay := 500
energyLevel := 0
surchargeCost := 0.1

{
    global surchargeCost
    loop 1000
    {
        if(CheckEnergyLevel(surchargeCost))
        {
            if(PixelSearch(&pX, &pY, 593, 223, 1110, 771, 0xEFEAD6, 3))         ;Look for and click on the customer bubble.
            { 
                ClickAtCoord(pX, pY)
                Sleep(1500)

                if(PixelSearch(&pX, &pY, 1335, 518, 1355, 531, 0x522C44, 3))    ;Check if surcharge is possible
                {
                    ClickAtCoord(pX, pY)        ;surcharge
                    Sleep(delay)
                    ClickAtCoord(632, 523)      ;smalltalk
                    Sleep(delay)
                    ClickAtCoord(1303, 630)     ;sell
                    Sleep(delay)
                    loop 5
                    {
                        if(PixelSearch(&pX, &pY, 1304, 625, 1337, 650, 0x21F75D, 3))
                            ClickAtCoord(1303, 630)     ;sell
                        sleep 200
                    }
                    surchargeCost := 0.1
                }
                else
                {  
                    if(surchargeCost > 0.94)
                    {
                        ClickAtCoord(692, 633)      ;refuse because the surcharge price is to high
                        surchargeCost := 0.1
                    }
                    else
                    {
                        surchargeCost += 0.1
                        if(surchargeCost > 0.93)
                            surchargeCost := 0.93
                    }
                    if(PixelSearch(&pX, &pY, 1023, 737, 1053, 768, 0x522C44, 3))
                    {
                        Sleep(delay)
                        ClickAtCoord(974, 750)
                        Sleep(delay)
                    }
                }
            }
        }
        if(PixelSearch(&pX, &pY, 593, 223, 1110, 771, 0xEFE46B, 1))         ;Look for and click on the yellow customer bubble
        {
            ClickAtCoord(pX, pY)
            Sleep(1500)
            if(PixelSearch(&pX, &pY, 1296, 619, 1354, 644, 0xFFB729, 3))         ;Scan for buy button
            {
                ClickAtCoord(pX, pY)    ;Buy
                Sleep(1500)
                if(PixelSearch(&pX, &pY, 994, 922, 1048, 955, 0x21F75D, 3))         ;Scan for okay button
                    Clickatcoord(pX, pY)        ; okay
            }
        }
        if(PixelSearch(&pX, &pY, 68, 838, 219, 948, 0xEFE7D3, 3) and PixelSearch(&pX, &pY, 766, 834, 978, 948, 0xEFE7D3, 3) and PixelSearch(&pX, &pY, 1628, 835, 1797, 944, 0xEFE7D3, 3))
        {
            ClickAtCoord(956, 866)
        }
        Sleep(1000)
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
ScanForPixel(firstX, firstY, secondX, secondY, color, scanCoef)
{
    scanX := firstX
    scanY := firstY
    areaX := (secondX - firstX + 1)/scanCoef
    areaY := (secondY - firstY + 1)/scanCoef
    loop areaY
    {
        loop areaX
        {
            MouseMove(scanX, scanY)
            if(PixelCompareColor(scanX, scanY, color) == true)
            {
                return true
            }
            scanX += scanCoef
        }
        scanX := firstX
        scanY += scanCoef
    }
}

CheckEnergyLevel(fillPercent)       ;Note, scan maxes out at 96%
{
    barStart := 1388
    barEnd := 1511
    barLength := barEnd - barStart
    scan := barStart
    counter := 0
    global energyLevel

    loop barLength
    {
        MouseMove(scan, 25)
        if(PixelCompareColor(scan, 25, 0xFE5D36))
        {
            energyLevel := ((3 + counter)/barLength)
        }
        scan++
        counter++
    }
    if(energyLevel >= fillPercent)
        return true
    ;else
    ;    MsgBox(energyLevel)
}