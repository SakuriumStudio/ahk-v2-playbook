#Requires AutoHotkey v2.0
#SingleInstance Force

; Ctrl + Alt + P：アクティブウィンドウの exe パスをコピー
^!p::{
    try {
        hwnd := WinGetID("A")
        path := WinGetProcessPath("ahk_id " hwnd)
        title := WinGetTitle("ahk_id " hwnd)
        A_Clipboard := path
        ToolTip("Copied:`n" path "`n`n(" title ")", 10, 10)
        SetTimer(() => ToolTip(), -1500)
    } catch as e {
        MsgBox("取得できんかった…`n" e.Message)
    }
}
