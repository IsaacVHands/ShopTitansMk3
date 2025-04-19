#Requires AutoHotkey v2.0
#Include ../../lib/helpers.ahk
{
    CompareConfig()
}
CompareConfig()
{
    configFile := getMainDir() "/Shop Titans/Config.txt"
    configFileExample := getMainDir() "/Shop Titans/Config.example.txt"
    b := 0
    loop read configFile
    {
        if(GetFileLine(configFileExample, b) == LTrim(RTrim(A_LoopReadLine, "= true" "= false"), ' `t'))
        {
            /*mode := LTrim(RTrim(A_LoopReadLine, " "), GetFileLine(configFileExample, b) " :")
            switch(mode)
            {
                case "= true":
                    return true
                case "= false":
                    return false
                default:
                    MsgBox("Error: config status not found")
            }*/
        }
        else
        {
            MsgBox(GetFileLine(configFileExample, b) "  " LTrim(RTrim(A_LoopReadLine, "= true" "= false"), ' `t'))
        }
        b++
    }
    ;MsgBox("Error: config does not exist: " configInquiry)             ;uncomment this line for debbuging 
    return false
}
GetFileLine(fileAddress, lineNum)
{
    a := 0
    loop read fileAddress
    {
        if(a == lineNum)
            return LTrim(RTrim(A_LoopReadLine, "= true" "= false"), ' `t')
        a++
    }
}