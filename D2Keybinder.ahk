#NoEnv
#InstallKeybdHook
VERSION = 1.2.0
SendMode Input
SetWorkingDir %A_ScriptDir%

; --- GENERAL PROGRAM HOTKEYS

^b::Reload()
^g::ShowGui()
pause::Suspend

; --- SKILL REBINDS

#ifWinActive Diablo II

^q::Send q
^w::Send w
^r::Send r
^a::Send a
^t::Transmute()
b::Send i

*xbutton1::CastLeftAttack()
*q::Cast("q","F1")
*w::Cast("w","F2")
*e::Cast("e","F3")
*r::Cast("r","F4")

*a::Cast("a","F5")
*s::Cast("s","F6")
*d::Cast("d","F7")
*f::Cast("f","F8")

*z::Cast("z","F9")
*x::Cast("x","F10")
*c::Cast("c","F11")
*v::Cast("v","F12")

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

~enter::ToggleChatMode()

; --- FUNCTIONS 
Reload()
  {
    MsgBox, , D2 Keybinder Reloading!, D2 Keybinder is reloading in 2 seconds..., 2
    reload
  }

ToggleChatMode()
  {
    global CHAT_MODE
    CHAT_MODE := !CHAT_MODE
  }

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

Cast(inKey,outKey)
    {
        global LAST_SKILL_KEY
        global TOGGLE_SHOW_ITEMS
        global CHAT_MODE
        if(CHAT_MODE)
        {
          Send %inKey%
          return
        }
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
        SetCapsLockState Off
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
       global CHAT_MODE
       if(CHAT_MODE)
          ToggleChatMode()
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
    global CHAT_MODE
    if(TOGGLE_SHOW_ITEMS)
      ToggleShowItems()
    if(!CHAT_MODE)
      Send {ENTER}
    Sleep 100
    Send /players %playerCount%
    Send {ENTER}
    if(CHAT_MODE)
      ToggleChatMode()
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
      Gui, Add, Picture, Center, resources/KeyMap.png
      Gui, Show, x0 y0 AutoSize, D2 Keybinder v%VERSION%
    }
    else 
    {
      Gui, Destroy
    }
  }

Transmute()
  {
    global OLD_MOUSE_POSITION_X
    global OLD_MOUSE_POSITION_Y
    global TRANSMUTE_BUTTON_X
    global TRANSMUTE_BUTTON_Y
    global DROP_LOCATION_X
    global DROP_LOCATION_Y
    global CHECK_LOCATION_X
    global CHECK_LOCATION_Y
    global IS_CHECKING_ITEM
    if (!IS_CHECKING_ITEM && TRANSMUTE_BUTTON_X && TRANSMUTE_BUTTON_Y && DROP_LOCATION_X && DROP_LOCATION_Y && CHECK_LOCATION_X && CHECK_LOCATION_Y)
    {
      MouseGetPos, OLD_MOUSE_POSITION_X, OLD_MOUSE_POSITION_Y, , , 
      SendEvent {Click Left}
      MouseMove, % DROP_LOCATION_X, % DROP_LOCATION_Y, , 
      Sleep 100
      SendEvent {Click Left}
      MouseMove, % TRANSMUTE_BUTTON_X, % TRANSMUTE_BUTTON_Y, ,
      Sleep 100
      SendEvent {Click Left}
      MouseMove, % CHECK_LOCATION_X, % CHECK_LOCATION_Y, ,
      IS_CHECKING_ITEM := true
    }
    else if (IS_CHECKING_ITEM)
    {
      MouseMove, % OLD_MOUSE_POSITION_X, % OLD_MOUSE_POSITION_Y, ,
      IS_CHECKING_ITEM := false
    }
    else 
    {
      if(!TRANSMUTE_BUTTON_X || !TRANSMUTE_BUTTON_Y)
      {
        MsgBox, , Move Mouse Over Transmute Button, 1. Open HORADRIC CUBE`n2. Move Mouse Over TRANSMUTE BUTTON`n3. Press F1
        KeyWait, F1, D T10
        if(ErrorLevel == 0)
        {
          MouseGetPos, TRANSMUTE_BUTTON_X, TRANSMUTE_BUTTON_Y, , , 
          MsgBox, , DONE!, Done!`nTransmute Button Location:`nx=%TRANSMUTE_BUTTON_X% y=%TRANSMUTE_BUTTON_Y%, 10
        }
      }
      if(!DROP_LOCATION_X || !DROP_LOCATION_Y)
      {
        MsgBox, , Move Mouse Over Drop Location, 1. Open HORADRIC CUBE`n2. Move Mouse Over Location In Cube To Drop Item`n3. Press F1
        KeyWait, F1, D T10
        if(ErrorLevel == 0)
        {
          MouseGetPos, DROP_LOCATION_X, DROP_LOCATION_Y, , , 
          MsgBox, , DONE!, Done!`nCube Drop Location:`nx=%DROP_LOCATION_X% y=%DROP_LOCATION_Y%, 10
        }
      }
      if(!CHECK_LOCATION_X || !CHECK_LOCATION_Y)
      {
        MsgBox, , Move Mouse Over Check Location, 1. Open HORADRIC CUBE`n2. Move Mouse Over Location To Hover Mouse To Check Item`n3. Press F1
        KeyWait, F1, D T10
        if(ErrorLevel == 0)
        {
          MouseGetPos, CHECK_LOCATION_X, CHECK_LOCATION_Y, , , 
          MsgBox, , DONE!, Done!`nCube Check Location:`nx=%CHECK_LOCATION_X% y=%CHECK_LOCATION_Y%, 10
        }
      }
    }
  }