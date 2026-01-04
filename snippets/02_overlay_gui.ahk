#Requires AutoHotkey v2.0
#SingleInstance Force

; 枠なし・タスクバー非表示の小さなGUIを作成（常に最前面表示）
gui := GuiCreate("+AlwaysOnTop -Caption +ToolWindow") ; 最前面, タイトルバーなし, ツールウィンドウ[22][23]
gui.BackColor := 'Yellow'          ; 背景色
gui.AddText("cBlue", "★Overlay情報★") ; 青色テキスト追加
gui.Show("x400 y200 NoActivate")   ; 位置指定して表示（NoActivateでフォーカスを奪わない）

; 5秒後に自動終了（オーバーレイを消す）
SetTimer(() => ExitApp(), 5000)
