#Requires AutoHotkey v2.0
#SingleInstance Force

sculptMode := false
periboardMode := false
capsUsed := false

; --- CapsLock: tap = Esc, hold = layer ---
*CapsLock:: {
    global capsUsed
    capsUsed := false
    KeyWait "CapsLock"
    if !capsUsed
        Send "{Esc}"
}

CapsNav(key) {
    global capsUsed
    capsUsed := true
    Send "{Blind}" key
}

#HotIf GetKeyState("CapsLock", "P")
*Left::CapsNav("{Home}")
*Right::CapsNav("{End}")
*Up::CapsNav("{PgUp}")
*Down::CapsNav("{PgDn}")
*Delete::CapsNav("{Insert}")

; CapsLock + number = F-number, [ = F11, ] = F12
*1::CapsNav("{F1}")
*2::CapsNav("{F2}")
*3::CapsNav("{F3}")
*4::CapsNav("{F4}")
*5::CapsNav("{F5}")
*6::CapsNav("{F6}")
*7::CapsNav("{F7}")
*8::CapsNav("{F8}")
*9::CapsNav("{F9}")
*0::CapsNav("{F10}")
*[::CapsNav("{F11}")
*]::CapsNav("{F12}")

; CapsLock + Space = Menu key
*Space::CapsNav("{AppsKey}")

; Capslock + Tab actually triggers Capslock
*Tab:: {
    global capsUsed
    capsUsed := true
    SetCapsLockState(!GetKeyState("CapsLock", "T"))
}

; CapsLock+S toggles Sculpt mode
s:: {
    global sculptMode, capsUsed
    capsUsed := true
    sculptMode := !sculptMode
    TrayTip "Sculpt F-keys " (sculptMode ? "ON" : "OFF")
}

; CapsLock+P toggles Periboard mode
p:: {
    global periboardMode, capsUsed
    capsUsed := true
    periboardMode := !periboardMode
    TrayTip "Periboard mode " (periboardMode ? "ON" : "OFF")
}
#HotIf


; --- F5-F12 chords: only the Sculpt sends these, always on ---
+#F21::Send "{F5}"
!#F21::Send "{F6}"
^#F21::Send "{F7}"
#F21::Send "{F8}"
^#BS::Send "{F9}"
^#Tab::Send "{F10}"
!#F22::Send "{F11}"
^#F23::Send "{F12}"

; --- F1-F4 swap: only while Sculpt mode is on ---
#HotIf sculptMode
MEDIA_PLAY_PAUSE::Send "{F1}"
VOLUME_MUTE::Send "{F2}"
VOLUME_DOWN::Send "{F3}"
VOLUME_UP::Send "{F4}"
F1::Send "{Media_Play_Pause}"
F2::Send "{Volume_Mute}"
F3::Send "{Volume_Down}"
F4::Send "{Volume_Up}"
#HotIf

; --- Periboard 805 Ergo: only while Periboard mode is on ---
#HotIf periboardMode
!4::Send "!{F4}"
#HotIf
