#Requires AutoHotkey v2.0
#include ../../../../lib/helpers.ahk
#SingleInstance Force

class Gem
{
    __New() 
    {
        this.gemCount := -1
        this.timeStamp := A_YYYY "," A_MM "," A_DD "," A_Hour
    }
    logGemsHourly()
    {
        if(this.TimeChange())
        {
            this.Get()
            if(this.ErrorLevel() == 0)
            {
                this.SetLog()
                this.gemCount := -1
                this.timeStamp := A_YYYY "," A_MM "," A_DD "," A_Hour
            }
        }
    }
    Get()
    {
        if(FileExist("shop_titans_ml"))
        {
            RunWait("powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File RunmlModel.ps1")
        }
        if(FileExist("mlOutput.txt"))
        {
            mlOutput := FileRead("mlOutput.txt")
            if(mlOutput != "")
            {
                this.gemCount := mlOutput
            }
        }
    }
    SetLog()
    {
        fileAppend(this.timeStamp "," RTrim(this.gemCount, ' `t'), "GemData.txt")
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