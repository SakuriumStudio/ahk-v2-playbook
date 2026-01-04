#Requires AutoHotkey v2.0
#SingleInstance Force

; わざと存在しないファイルを読み込んで例外を発生させる
try {
    FileRead(text, "C:\No\file.txt")
    MsgBox "ファイル内容: " text
} catch e {
    MsgBox "エラー発生: " e.Message  ; エラーメッセージを表示
} else {
    MsgBox "ファイル読み込み成功（例外なし）"
} finally {
    MsgBox "処理終了 (Finallyブロック実行)"
}
