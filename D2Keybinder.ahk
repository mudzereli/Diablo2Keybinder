#NoEnv
#InstallKeybdHook
VERSION = 1.2.0
SendMode Input
SetWorkingDir %A_ScriptDir%

; --- GENERAL PROGRAM HOTKEYS

^t::reload
^g::ShowGui()
pause::Suspend

; --- SKILL REBINDS

#ifWinActive Diablo II

^q::Send q
^w::Send w
^r::Send r
^a::Send a
b::Send i

*xbutton1::CastLeftAttack()
*q::Cast("F1")
*w::Cast("F2")
*e::Cast("F3")
*r::Cast("F4")

*a::Cast("F5")
*s::Cast("F6")
*d::Cast("F7")
*f::Cast("F8")

*z::Cast("F9")
*x::Cast("F10")
*c::Cast("F11")
*v::Cast("F12")

lalt::ToggleShowItems()
*tab::FixxedTab()
*esc::FixxedEsc()

numpad0::FixWindowSize()
numpad1::SetPlayers(1)
numpad2::SetPlayers(2)
numpad3::SetPlayers(3)
numpad4::SetPlayers(4)
numpad5::SetPlayers(5)
numpad6::SetPlayers(6)
numpad7::SetPlayers(7)
numpad8::SetPlayers(8)

^1::SetPlayers(1)
^2::SetPlayers(2)
^3::SetPlayers(3)
^4::SetPlayers(4)
^5::SetPlayers(5)
^6::SetPlayers(6)
^7::SetPlayers(7)
^8::SetPlayers(8)

; --- FUNCTIONS 

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
        toggledOn := TOGGLE_SHOW_ITEMS
        toggleAlt := GetKeyState("LAlt","P")
        if(toggledOn) 
          ToggleShowItems()
        if(toggleAlt)
        {
          Send {Alt Down}{Tab}
          Sleep 100
          KeyWait, Alt
          Send {Alt Up}
        }
        else
          Send {Tab}
        if(toggledOn && !toggleAlt) 
          ToggleShowItems()
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

FixWindowSize()
  {
    WinActivate Borderless Gaming
    Sleep 100
    Send {ALT DOWN}
    Send t
    Sleep 100
    Send f
    Send {ALT UP}
    WinActivate Diablo II
  }

SetPlayers(playerCount)
  {
    global TOGGLE_SHOW_ITEMS
    if(TOGGLE_SHOW_ITEMS)
      ToggleShowItems()
    Send {ENTER}
    Sleep 100
    Send /players %playerCount%
    Send {ENTER}
  }

ShowGui()
  {
    global VERSION
    global SHOW_GUI
    SHOW_GUI := !SHOW_GUI
    if (SHOW_GUI)
    {
      Gui, Destroy
      Gui, font, w1000 cBlack s15
      Gui, Add, Text, ,D2 Keybinder v%VERSION%
      Gui, Add, Picture, Center, KeyMap.png
      Gui, Show, Center AutoSize, D2 Keybinder v%VERSION%
    }
    else 
    {
      Gui, Destroy
    }
  }
