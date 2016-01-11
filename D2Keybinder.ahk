#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

^+!r::reload

#ifWinActive Diablo II

*xbutton1::CastLeftAttack()

*q::Cast("F1")
*w::Cast("F2")
*e::Cast("F3")
*r::Cast("F4")
*t::Cast("F5")
*f::Cast("F6")
*g::Cast("F7")

z::q
x::a
c::t
v::i

a::Cast("F8")
s::w
d::r
b::ToggleShowItems()
*tab::FixxedTab()
*esc::FixxedEsc()

CastLeftAttack()
    {
        while(GetKeyState("XButton1","P")) {
            mod := ""
            if(GetKeyState("Shift","P"))
                mod := "+"
            Send, %mod%{Click}
            Sleep, 25
        }
    }

Cast(outKey)
    {
       global LAST_SKILL_KEY
       global TOGGLE_SHOW_ITEMS
       if(TOGGLE_SHOW_ITEMS)
           Send, {Alt Up}
       if (LAST_SKILL_KEY != outKey)
           Send, {%outKey%}
        mod := ""
        if(GetKeyState("Shift","P"))
            mod := "+"
       Send, %mod%{Click Right}
       LAST_SKILL_KEY := outKey
       if(TOGGLE_SHOW_ITEMS)
           Send, {Alt Down}
    }

ToggleShowItems()
    {
        global TOGGLE_SHOW_ITEMS
        TOGGLE_SHOW_ITEMS := !TOGGLE_SHOW_ITEMS
        if(TOGGLE_SHOW_ITEMS)
            Send, {Alt Down}
        else
            Send, {Alt Up}
    }

FixxedTab()
    {
        global TOGGLE_SHOW_ITEMS
        if(TOGGLE_SHOW_ITEMS)
            Send, {Alt Up}
        if(GetKeyState("Alt","P")) {
            if(TOGGLE_SHOW_ITEMS)
                ToggleShowItems()
            Send, {Blind} !{Tab}
        } else
            Send, {Tab}
        if(TOGGLE_SHOW_ITEMS)
            Send, {Alt Down}
    }

FixxedEsc()
    {
       global TOGGLE_SHOW_ITEMS
       if(TOGGLE_SHOW_ITEMS)
           Send, {Alt Up}
       Send, {Escape}
       if(TOGGLE_SHOW_ITEMS)
           Send, {Alt Down}
    }