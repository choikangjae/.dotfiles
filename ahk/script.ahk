/*
Alt ! 
Ctrl ^ 
Win # 
Shift + 
Right >
Left <
*/

/*
;백틱과 Esc 스왑 
`::Esc
Esc::`
;\와 백스페이스 스왑
\::BackSpace
BackSpace::\
*/

;Capslock 비활성화
SetCapsLockState, AlwaysOff

;RShift와 Capslock을 누른 경우 Capslock으로 동작.
>+Capslock::Capslock
Capslock::Control
;LShift에 한영키 바인딩. 쉬프트만 단독으로 눌릴 일은 절대 없으므로.
LShift::sendInput, {vk15}{LShift up}

;Left Alt만 입력되었을 경우 비활성화
LAlt:: return
;LAlt::sendInput, {vk15}{LAlt up}
;Right Win만 입력되었을 경우 비활성화
RWin:: return
;왼쪽 Ctrl 비활성화
LCtrl:: return

;Ctrl + Shift + Esc를 눌렀을 경우 Control이 down된 상태로 유지되는 것을 방지. 
LShift & Esc::Send, {Control down}{Shift down}{Esc}{Control up}{Shift up}

;Right Win과 \, ` 키로 음량 조절.
>#\::SoundSet, -8
>#`::SoundSet, +8

;RShift와 Esc를 누르면 백틱으로 동작 (~ 입력)
>+Esc::`
;RShift와 백틱을 누르면 물결표
>+`::~

;LAlt 4를 누르면 Alt + F4로 동작
<!4::F4

;LAlt와 키 조합시 Ctrl을 누른 것처럼 동작. (MacOS)
;<!c::Send ^{c} 처럼 작성해도 아래와 같이 동작한다.
<!w::Send, {LCtrl Down}{w}{LCtrl Up}
<!c::Send, {LCtrl Down}{c}{LCtrl Up}
<!v::Send {LCtrl Down}{v}{LCtrl Up}
<!d::Send {LCtrl Down}{d}{LCtrl Up}
<!s::Send {LCtrl Down}{s}{LCtrl Up}
<!z::Send {LCtrl Down}{z}{LCtrl Up}
<!f::Send {LCtrl Down}{f}{LCtrl Up}
<!x::Send {LCtrl Down}{x}{LCtrl Up}
<!a::Send {LCtrl Down}{a}{LCtrl Up}
<!/::Send {LCtrl Down}{/}{LCtrl Up}
<!t::Send {LCtrl Down}{t}{LCtrl Up}
<!<+t::Send {LCtrl Down}{LShift Down}{t}{LCtrl Up}{LShift Up}

;Alt + hjkl로 방향키.
!h::SendInput, {Left}
!j::SendInput, {Down}
!k::SendInput, {Up}
!l::SendInput, {Right}

;Alt + Shift + h,j,k,l로 하이라이트.
!+h::SendInput, {LShift Down}{Left}{LShift Up}
!+j::SendInput, {LShift Down}{Down}{LShift Up}
!+k::SendInput, {LShift Down}{Up}{LShift Up}
!+l::SendInput, {LShift Down}{Right}{LShift Up}

;RWin . /로 좌우 이동 (유튜브 뒤로가기, 앞으로가기 전용)
RWin & Space::SendInput, {Left}
RWin & vk15::SendInput, {Right}

;마우스 관련 세팅

;마우스휠
#m::
Send {WheelDown}
Sleep, 75
Return

#i::
Send {WheelUp}
Sleep, 75
Return

Speed:=65
;커서 상하좌우
;down
#j::
CoordMode, Mouse, Screen
MouseGetPos, X, Y
Y += 65
DllCall("SetCursorPos", "int", X, "int", Y)
return

;up
#k::
CoordMode, Mouse, Screen
MouseGetPos, X, Y
Y -= 65
DllCall("SetCursorPos", "int", X, "int", Y)
return

;right
#l::
CoordMode, Mouse, Screen
MouseGetPos, X, Y
X += 65
DllCall("SetCursorPos", "int", X, "int", Y)
return

;left
#h::
CoordMode, Mouse, Screen
MouseGetPos, X, Y
X -= 65
DllCall("SetCursorPos", "int", X, "int", Y)
return

;커서 클릭
#enter::MouseClick
#+enter::MouseClick, right

;Esc를 눌렀을때 현재 레이아웃과 상관없이 영어로 전환.
#If WinActive("ahk_exe notepad.exe") OR WinActive("ahk_exe notepad++.exe") OR WinActive("ahk_exe Code.exe") OR WinActive("ahk_exe studio64.exe") OR WinActive("ahk_exe idea64.exe") OR WinActive("ahk_exe webstorm64.exe") OR WinActive("ahk_exe Obsidian.exe") OR WinActive("ahk_exe WindowsTerminal.exe") OR WinActive("ahk_exe clion64.exe")
$`::
    if(IME_CHECK("A"))
        Send, {VK15}
    Send, {Escape}
    return
#If

#If WinActive("ahk_exe notepad.exe") OR WinActive("ahk_exe notepad++.exe") OR WinActive("ahk_exe Code.exe") OR WinActive("ahk_exe studio64.exe") OR WinActive("ahk_exe idea64.exe") OR WinActive("ahk_exe webstorm64.exe") OR WinActive("ahk_exe Obsidian.exe") OR WinActive("ahk_exe WindowsTerminal.exe") OR WinActive("ahk_exe clion64.exe")
$esc::
    if(IME_CHECK("A"))
        Send, {VK15}
    Send, {Escape}
    return
#If

/*
  IME check 
*/
IME_CHECK(WinTitle) {
  WinGet,hWnd,ID,%WinTitle%
  Return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd),0x005,"")
}
Send_ImeControl(DefaultIMEWnd, wParam, lParam) {
  DetectSave := A_DetectHiddenWindows
  DetectHiddenWindows,ON
   SendMessage 0x283, wParam,lParam,,ahk_id %DefaultIMEWnd%
  if (DetectSave <> A_DetectHiddenWindows)
      DetectHiddenWindows,%DetectSave%
  return ErrorLevel
}
ImmGetDefaultIMEWnd(hWnd) {
  return DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
}

/*
;https://gist.github.com/volks73/1e889e01ad0a736159a5d56268a300a8
;https://www.autohotkey.com/boards/viewtopic.php?t=10067
$Capslock::
	KeyWait, Capslock, T0.1
	
	if (ErrorLevel)
		;long press
		Send, {Ctrl Down}

	else {
		KeyWait, Capslock, D T0.1

		;single press
		;Capslock 한번 클릭시 무조건 영어.
		if (ErrorLevel) {
			Send, {Ctrl Up}
			ime_status := % IME_CHECK("A")
			;한글이라면 영어로 전환
			if(ime_status = "1") {
        				Send, {VK15}
			} else {}
		}
		;double press
		;Capslock 2번 클릭시 무조건 한글.
		else {
			Send, {Ctrl Up}
			ime_status := % IME_CHECK("A")
			;영어라면 한글로 전환
			if(ime_status = "0") {
        				Send, {VK15}
			} else {}
		}
	}

	KeyWait, Capslock
	Send, {Ctrl Up}
return

;오른쪽 Ctrl과 그 왼쪽 키를 좌우로 바인딩.
AppsKey::Left
SC11D::Right
SC11D::Send {LCtrl Down}{LShift Down}{F10}{LCtrl Up}{LShift Up}

*/
