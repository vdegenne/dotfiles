﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;LShift & space::
;  Send, {vk15sc1F2}
;return

GroupAdd, Group1, ahk_exe Emacs.exe
GroupAdd, Group1, ahk_exe netbeans.exe
GroupAdd, Group1, ahk_exe phpstorm64.exe
GroupAdd, Group1, ahk_exe sublime_text.exe
GroupAdd, Group1, ahk_exe atom.exe
GroupAdd, Group1, ahk_exe Illustrator.exe
GroupAdd, Group1, ahk_exe Code.exe
GroupAdd, Group1, ahk_exe cmd.exe
GroupAdd, Group1, ahk_exe idea64.exe
GroupAdd, Group1, ahk_exe webstorm64.exe
return
	
#IfWinNotActive, ahk_group Group1

; NAVIGATIONS
!f::Send, {LAlt Up}{Right}{LAlt Down}{LControl Down}
!b::Send, {LAlt Up}{Left}{LAlt Down}{LControl Down}
^n::Send, {LControl Up}{Down}{LControl Down}
^p::Send, {LControl Up}{Up}{LControl Down}
^f::Send, {LControl Up}{Right}{LControl Down}
^b::Send, {LControl Up}{Left}{LControl Down}
;^a::Send, {LControl Up}{Home}{LControl Down}
^e::Send, {LControl Up}{End}{LControl Down}
LAlt & Backspace::Send, ^{Backspace}
; !+<::Send, {LAlt Up}{Shift Up}{Home}{Shift Down}{LAlt Down}
; !+>::Send, {LAlt Up}{Shift Up}{End}{Shift Down}{LAlt Down}


; COPY & PASTE
^y::^v
^k::Send {LControl Up}+{end}^x{LControl Down}


; FOR KOREAN KEYBOARD, SWITCH TO KOREAN
LCtrl & \::
  Send, {vk15sc1F2}
return


; FOR CHROME
#IfWinActive, ahk_exe chrome.exe
; CANCEL URL BAR
^g::Send, {LControl Up}{Esc}+{Tab}{LControl Down}


#IfWinActive, ahk_exe atom.exe
^n::Send, {LControl Up}{Down}{LControl Down}
^p::Send, {LControl Up}{Up}{LControl Down}
