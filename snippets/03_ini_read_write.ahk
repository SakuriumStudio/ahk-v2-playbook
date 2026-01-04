#Requires AutoHotkey v2.0
#SingleInstance Force

cfgFile := A_ScriptDir "\sample.ini"
section := "Settings", key := "UserName"

; INI書き込み: ユーザー名を保存
IniWrite(A_UserName, cfgFile, section, key)

; INI読み込み: ユーザー名を取得（存在しなければ "Guest" をデフォルト使用）
name := IniRead(cfgFile, section, key, "Guest")  ; キーが無い場合 "Guest" を返す[10]
MsgBox "こんにちは、" name "さん！"
