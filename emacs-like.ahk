;;
;; An autohotkey script that provides gtk-emacs-key-theme like keybinding on Windows
;; forked from https://github.com/lintaro-jp/gtk-emacs-theme-like.ahk/blob/master/gtk-emacs-theme-like.ahk
;;
#InstallKeybdHook
#UseHook

#InstallKeybdHook
#UseHook

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
SetKeyDelay 0

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
use_default_key()
{
  IfWinActive,ahk_class Vim ; GVIM
    Return 1
  IfWinActive,ahk_exe Code.exe ; GVIM
    Return 1
  IfWinActive,ahk_exe webstorm64.exe
    Return 1
  IfWinActive,ahk_exe WindowsTerminal.exe
    Return 1
  Return 0
}

;
; <ctrl>b
; move cursor backward
;
^b::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send {Left}
  Return

;
; <shift><ctrl>b
; move cursor backward selecting chars
;
+^b::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send +{Left}
  Return

;
; <ctrl>f
; move cursor forward
;
^f::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send {Right}
  Return

;
; <shift><ctrl>f
; move cursor forward selecting chars
;
+^f::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send +{Right}
  Return

;
; <ctrl>p
; move cursor up
;
^p::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send {Up}
  Return

;
; <shift><ctrl>p
; move cursor up selecting chars
;
+^p::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send +{Up}
  Return

;
; <ctrl>n
; move cursor down
;
^n::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send {Down}
  Return

;
; <shift><ctrl>n
; move cursor down selecting chars
;
+^n::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send +{Down}
  Return

;
; <ctrl>d
; delete following char
;
^d::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send {Del}
  Return

;
; <ctrl>h
; delete previous char(Backspace)
;
^h::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send {BS}
  Return

;
; <ctrl>a
; move cursor beginning of current line
;
^a::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send {Home}
  Return

;
; <shift><ctrl>a
; move cursor beginning of current line selecting chars
;
+^a::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send +{Home}
  Return

;
; <ctrl>e
; move cursor end of current line
;
^e::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send {End}
  Return

;
; <shift><ctrl>e
; move cursor end of current line selecting chars
;
+^e::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send +{End}
  Return

;
; <alt>b
; move cursor one word backward
;
!b::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send ^{Left}
  Return

;
; <shift><alt>b
; move cursor one word backward selecting chars
;
+!b::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send +^{Left}
  Return

;
; <alt>f
; move cursor one word forward
;
!f::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send ^{Right}
  Return

;
; <shift><alt>f
; move cursor one word forward selecting chars
;
+!f::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send +^{Right}
  Return

;
; <ctrl>w
; cut
;
^w::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send ^x
  Return

;
; <ctrl>y
; paste
;
^y::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send ^v
  Return

;
; <ctrl>k
; delete chars from cursor to end of line
;
^k::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send {ShiftDown}{END}{SHIFTUP}
    Sleep 50
    ; Send {Del}
    Send ^x
  Return

;
; <ctrl>u
; delete chars from cursor to beginning of line
;
^u::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
  {
    Send {ShiftDown}{HOME}{SHIFTUP}
    Sleep 50
    Send {Del}
    ;Send ^x
  }
  Return

;
; <ctrl>m
; new line(enter)
;
^m::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send {Enter}
  Return

;
; <ctrl>r
; find
;
^r::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send ^f
  Return

;
; <ctrl>\
; select all
;
^\::
  If use_default_key()
    Send %A_ThisHotkey%
  Else
    Send ^a
  Return
