#Requires AutoHotkey v2.0
#SingleInstance Force

sculptMode := false
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
