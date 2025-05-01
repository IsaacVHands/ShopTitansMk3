#Requires AutoHotkey v2.0
#include ../../../../lib/helpers.ahk
#SingleInstance Force

class Gem
{
    __New() 
    {
        this.path := getMainDir() "Shop Titans/Automation/SubFunctions/GatherInfo/GemTracker/"
        this.gemCount := -1
        this.timeStamp := A_YYYY "," A_MM "," A_DD "," A_Hour
    }
    logGems()
    {
        this.Get()
        if(this.ErrorLevel() == 0)
        {
            this.SetLog()
            this.ResetObj()
        }
    }
    Get()
    {
        if(FileExist(this.path "shop_titans_ml"))
        {
            RunWait(this.path "psLauncher.ahk")
        }
        if(FileExist(this.path "mlOutput.txt"))
        {
            mlOutput := FileRead(this.path "mlOutput.txt")
            if(mlOutput != "")
            {
                this.gemCount := mlOutput
            }
        }
    }
    SetLog()
    {
        fileAppend(this.timeStamp "," RTrim(this.gemCount, ' `t'), this.path "GemData.txt")
    }
    TimeChange()
    {
        time := A_YYYY "," A_MM "," A_DD "," A_Hour
        if(time != this.timeStamp)
            return true
        else
            return false
    }
    ErrorLevel()
    {
        if(this.gemCount == -1)
            return 1
        else
            return 0
    }
    ResetObj()
    {
        this.gemCount := -1
        this.timeStamp := A_YYYY "," A_MM "," A_DD "," A_Hour
    }
}