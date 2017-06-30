#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; ctrl+s (search in the page)
^s::
  send, {ctrl down}f{ctrl up}
Return


; EMACS KEYSTROKES FOR WINDOWS

; ctrl+n (going one step down)
^n::
  send, {down down}{down up}
return

; ctrl+p (going one step up)
^p::
  send, {Up down}{Up up}
Return

; ctrl+e (going to the end of the line)
^e::
  send, {End down}{End up}
Return

; ctrl+a (going to the beginning of the line)
^a::
  send, {Home down}{Home up}
Return

; ctrl+f (one step forward on the line)
^f::
  send, {Right down}
  keywait, f
  send, {Right up}
Return

; ctrl+b (one step backward on the line)
^b::
  send, {Left down}{Left up}
Return

; alt+b (one word backward  on the line)
!b::
  send, {ctrl down}{left down}{left up}{ctrl up}
Return

; ctrl+k (kill and copy the text before cursor)
^k::
  send, {Shift down}{End down}{End up}{Shift up}{ctrl down}c{ctrl up}{del}
Return

; ctrl+y (paste the copied text)
^y::
  send, {Ctrl down}v{ctrl up}
Return




; CHROME SPECIFICS

; alt+a (previous page)
!a::
  send, {alt down}{left down}{left up}{alt up}
Return

; alt+e (next page)
!e::
  send, {alt down}{right down}{right up}{alt up}
Return

^g::
  send, {esc}{shift down}{Tab down}{Tab up}{shift up}
return




; GET THE WINDOW'S CLASS
+#q::
  WinGetClass, class, A
  MsgBox, The active window's class is "%class%".
return