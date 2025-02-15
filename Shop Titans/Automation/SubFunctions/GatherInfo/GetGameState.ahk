#Requires AutoHotkey v2.0

{
    gameState := "unknown"
    levelDisplay := false
    goToCityButton := false
    editFurnitureButton := false
    subMenuBar := false
    if(PixelSearch(&pX, &pY, 20, 38, 48, 59, 0x0266FF, 3))       ;check if the level is in the top left 
    {
        levelDisplay := true
    }
    if(PixelSearch(&pX, &pY, 51, 892, 88, 924, 0xFAD11B, 3))     ;check if the go to city button is in the bottom left
    {
        goToCityButton := true
    }


    if(PixelSearch(&pX, &pY, 20, 38, 48, 59, 0x0266FF, 3) and PixelSearch(&pX, &pY, 1807, 937, 1827, 960, 0x552B44, 3))       ;check if the Edit button is in the bottom right
    {
        editFurnitureButton := true
    }
    if(PixelSearch(&pX, &pY, 619, 951, 655, 985, 0x522C44, 3))     ;check if there is a dark purple menu bar at the bottom of the screen
    {
        subMenuBar := true
    }



    if(levelDisplay and goToCityButton)
        gameState := "shopDefault"
    if(editFurnitureButton and !subMenuBar)
    {
        if(gameState == "unknown")
        {
            gameState := "furniture selected"
        }
        else
            gameState := "Error: double Positive at edit button"
    }
    MsgBox(gameState)
}