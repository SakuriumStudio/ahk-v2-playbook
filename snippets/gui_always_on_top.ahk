#Requires AutoHotkey v2.0
#SingleInstance Force

; ============================================================
; gui_always_on_top.ahk
; 目的：常に前面の“小さな状態表示”を作る（ドラッグ移動＋位置保存）
; 右クリック：終了 / Ctrl+Alt+O：表示文言を切替
; ============================================================

ini := A_ScriptDir "\osd_overlay.ini"

x := IniRead(ini, "pos", "x", 30)
y := IniRead(ini, "pos", "y", 30)

osd := Gui("+AlwaysOnTop -Caption +ToolWindow +LastFound")
osd.BackColor := "000000"
osd.SetFont("s10 cFFFFFF", "Segoe UI")
lbl := osd.AddText("vLbl BackgroundTrans", "OSD: READY")

; ドラッグ移動（左クリック）
OnMessage(0x201, WM_LBUTTONDOWN) ; WM_LBUTTONDOWN
OnMessage(0x202, WM_LBUTTONUP)   ; WM_LBUTTONUP

; 右クリックで終了
osd.OnEvent("ContextMenu", (*) => ExitApp())

; 保険：たまに最前面が負ける環境向け（軽い）
SetTimer(EnsureTopMost, 750)

osd.Show(Format("x{1} y{2} NoActivate", x, y))

; Ctrl+Alt+O で表示を切替（ここは好きに編集OK）
state := 0
^!o::{
    global state, lbl
    state := Mod(state + 1, 3)
    if (state = 0)
        lbl.Text := "OSD: DESKTOP"
    else if (state = 1)
        lbl.Text := "OSD: GAME-1"
    else
        lbl.Text := "OSD: GAME-2"
}

EnsureTopMost() {
    global osd
    try WinSetAlwaysOnTop(true, "ahk_id " osd.Hwnd)
}

WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
    global osd
    if (hwnd != osd.Hwnd)
        return
    ; 0xA1 = WM_NCLBUTTONDOWN, 2 = HTCAPTION
    PostMessage(0xA1, 2, , , "ahk_id " osd.Hwnd)
}

WM_LBUTTONUP(wParam, lParam, msg, hwnd) {
    global osd, ini
    if (hwnd != osd.Hwnd)
        return
    try {
        WinGetPos(&x, &y, , , "ahk_id " osd.Hwnd)
        IniWrite(x, ini, "pos", "x")
        IniWrite(y, ini, "pos", "y")
    }
}
