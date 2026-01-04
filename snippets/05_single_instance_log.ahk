#Requires AutoHotkey v2.0
#SingleInstance Force

OnExit(*) => FileAppend("[" Format("{:T}", A_Now) "] 終了`n", A_ScriptDir "\run.log")

; スクリプト開始処理
OutputDebug("スクリプト開始 - プロセスID: " DllCall("GetCurrentProcessId", "UInt")) 
FileAppend("[" Format("{:T}", A_Now) "] 起動`n", A_ScriptDir "\run.log")

MsgBox "このスクリプトは単一インスタンスで実行されています。(OKで終了)"

ExitApp  ; 終了時にOnExit関数が呼ばれログが残ります
