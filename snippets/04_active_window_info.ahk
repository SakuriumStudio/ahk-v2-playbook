#Requires AutoHotkey v2.0
#SingleInstance Force

; F2キーで現在アクティブなウィンドウ情報を表示
F2:: {
    hwnd := WinActive("A")                ; アクティブウィンドウのハンドル取得（無ければ0）[25]
    if !hwnd {
        MsgBox "現在アクティブなウィンドウはありません。"
        return
    }
    title := WinGetTitle(hwnd)            ; ウィンドウタイトル取得
    proc := WinGetProcessName(hwnd)       ; プロセス名取得
    MsgBox "Active Window:\nTitle: " title "\nProcess: " proc
}
