#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../../../lib/helpers.ahk

Class ConfigManager
{
    __New() 
    {
        this.crafting := true
        this.crafting_buycomponents := true
        this.crafting_buycomponents_maxbuyprice := false
        this.crafting_mastery := false
        this.crafting_bookmarkpriority := false
        this.crafting_enchantments_autotrash := false
        this.questing := true
        this.questing_regularquests := false
        this.questing_keyquests := false
        this.questing_userepairpacks := false
        this.questing_events := false
        this.questing_toweroftitans := false
        this.questing_lostcityofgold := false
        this.market := true
        this.market_collect := true
        this.market_offer := false
        this.market_request := false
        general := true
        this.general_upgradefurniture := true
        configFile := getMainDir() "/Shop Titans/Config.txt"
        loop read configFile
        {
            if(A_LoopReadLine != "")
            {
                mode := this.GetConfigStatus(A_LoopReadLine)
                switch(this.GetConfigName(A_LoopReadLine))
                {
                    Case "crafting":
                        this.crafting := mode
                    Case "crafting.buycomponents":
                        this.crafting_buycomponents := mode
                    Case "crafting.buycomponents.maxbuyprice":
                        this.crafting_buycomponents_maxbuyprice := mode
                    Case "crafting.mastery":
                        this.crafting_mastery := mode
                    Case "crafting.bookmarkpriority":
                        this.crafting_bookmarkpriority := mode
                    Case "crafting.enchantments.autotrash":
                        this.crafting_enchantments_autotrash := mode
                    Case "questing":
                        this.questing := mode
                    Case "questing.regularquests":
                        this.questing_regularquests := mode
                    Case "questing.keyquests":
                        this.questing_keyquests := mode
                    Case "questing.userepairpacks":
                        this.questing_userepairpacks := mode
                    Case "questing.events":
                        this.questing_events := mode
                    Case "questing.toweroftitans":
                        this.questing_toweroftitans := mode
                    Case "questing.lostcityofgold":
                        this.questing_lostcityofgold := mode
                    Case "market":
                        this.market := mode
                    Case "market.collect":
                        this.market_collect := mode
                    Case "market.offer":
                        this.market_offer := mode
                    Case "market.request":
                        this.market_request := mode
                    Case "general.upgradefurniture":
                        this.general_upgradefurniture := mode
                    Case "general":
                        this.general := mode
                    default:
                        MsgBox("ERROR: config found in config file that does not exist in code: " this.GetConfigName(A_LoopReadLine))
                }
            }
        }
    }
    GetConfigStatus(configInQuestion)
    {
        mode := LTrim(RTrim(StrLower(configInQuestion), " "), ' `t' "abcdefghijklmnopqrstuvwxyz.:")
        switch(mode)
        {
            case "= true":
                return true
            case "= false":
                return false
            default:
                MsgBox("Error: config status not found")
        }
        MsgBox("Error: config does not exist: " configInQuestion)             ;uncomment this line for debbuging 
    }
    GetConfigName(configInQuestion)
    {
        name := LTrim(RTrim(RTrim(StrLower(configInQuestion), "= true" "= false"), ' :'), ' `t')
        return name
    }
}

global configs := ""
getConfigs()
{
    global configs
    if(configs == "")
    {
        configs := ConfigManager()
    }
    return configs
}