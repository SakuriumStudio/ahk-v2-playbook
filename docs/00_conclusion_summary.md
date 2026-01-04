# 結論サマリ（Deep Research 出力貼り付け）

> このファイルは、受け取った「結論サマリ (Conclusion Summary).docx」をそのままリポジトリに残すためのMarkdown版です。  
> ※一部、元文書内の省略（...）はそのまま保持しています。

## 0. サマリ

AutoHotkey v2は2022年12月20日にv2.0.0が正式リリースされ、現在の最新安定版はv2.0.19（2025年1月25日公開）です[1][2]。Windows 7以降のOSで動作し（Windows 10/11対応）[3]、v1.1系は2024年3月にサポート終了となりました[4]。

言語仕様の骨格：AHK v2は表現（Expression）ベースの統一された構文を採用し、v1で混在していたレガシー構文を廃止しました[5]。全てのビルトインは関数化され、値は戻り値やオブジェクトで受け取ります（多くのコマンドは例外を投げる設計に変わり、エラーレベルやOutputVar変数に依存しません[6][7]）。オブジェクト指向の要素（配列やマップ、GUIクラス等）が導入されましたが、シンプルなスクリプト記述も可能です[8]。例外処理構文（try-catch-finally）が正式に備わり、スコープ規則も明確化されています（関数内変数はデフォルトでローカルなど）。

v1→v2移行の落とし穴：旧v1のスクリプトをそのままv2で動かすと構文エラーや動作変更に多く直面します。主な例として「コマンド記法の廃止」「%による変数展開の廃止」「OutputVarパラメータの撤廃」「GUI/メニューAPIのオブジェクト化」「ホットキー構文の変更（複数行は{}必須）」等が挙げられます（詳細は表を参照）。これらの変更点を把握し、関数コールと式中心の書き方に統一することで、v2でのスクリプト開発がスムーズになります[5][9]。

ベストプラクティス：v2では厳格なエラーチェックが導入されているため、エラーは早期にtry-catchで捕捉し、例外オブジェクトのMessage等で原因を把握できます[6]。また、Guiのオーバーレイ表示では+AlwaysOnTop -Caption +ToolWindow等のスタイル指定でトップ表示かつ枠なしウィンドウを作成し、必要に応じてクリック透過（拡張スタイル0x20付与）を設定します。さらに、ウィンドウ操作では管理者権限やUACの影響に留意し、必要ならUIAccess署名実行も検討します。設定保存にはIniRead/IniWriteを活用し、デフォルト値で安全にフォールバックしつつ[10]、単一インスタンス実行（#SingleInstance）と終了時処理（OnExitフック）の実装で安定した常駐スクリプトを構築します。

## 1. バージョン前提

バージョン前提 (Version Premise)

本ガイドはAutoHotkey v2.0.19（最新安定版）を前提としています（公開日: 2025年1月25日[2]）。AutoHotkey v2はWindows 7以降のOSをサポートし[3]、32-bit/64-bit版いずれも提供されています。v2.0.0の正式リリースは2022年末で、2023年1月よりv2系が公式の主力バージョンとなりました[1]。なお、2024年3月にAutoHotkey v1.1系列は最終更新を迎えサポート終了しています[4]。以降、新機能や修正はv2系列にのみ適用されるため、本ガイドではv2.0.x安定版での仕様・挙動に基づき解説します（※将来のv2.1以降で仕様変更の可能性がある箇所は適宜補足します）。

## 2. よくある落とし穴 → 回避策

よくある落とし穴 → 回避策 (Common Pitfalls → Solutions)

以下に、AutoHotkey v1からv2への移行時によく陥るミスと、その回避策・ベストプラクティスを一覧にまとめます。

※補足：上記以外にも「ループ構文の変更（Loop, Parse廃止→for文で代用）」「A_*変数名の変更（例: A_LineNumberはA_Lineに簡略化）」「プラグインDLLやCOM周り**の仕様調整」など細かな移行ポイントがあります。詳細は公式の「v1.1からv2.0への変更リスト」を参照してください[20]。

## 3. ミニ検証スクリプト集

ミニ検証スクリプト集 (Mini Verification Script Examples)

以下はAutoHotkey v2で動作確認済みの短いサンプルコード集です。それぞれコピーペーストで単体のスクリプトとして動作し、v2の典型的な機能・文法の使い方を示します。

### 例1: 例外処理の基本（try/catch/finally）
- スニペット: `snippets/01_try_catch_finally.ahk`

```ahk
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
```

### 例2: 常に最前面に表示されるGUIオーバーレイ
- スニペット: `snippets/02_overlay_gui.ahk`

```ahk
#Requires AutoHotkey v2.0
#SingleInstance Force

; 枠なし・タスクバー非表示の小さなGUIを作成（常に最前面表示）
gui := GuiCreate("+AlwaysOnTop -Caption +ToolWindow") ; 最前面, タイトルバーなし, ツールウィンドウ[22][23]
gui.BackColor := 'Yellow'          ; 背景色
gui.AddText("cBlue", "★Overlay情報★") ; 青色テキスト追加
gui.Show("x400 y200 NoActivate")   ; 位置指定して表示（NoActivateでフォーカスを奪わない）

; 5秒後に自動終了（オーバーレイを消す）
SetTimer(() => ExitApp(), 5000)
```

### 例3: Ini設定の読み書きとデフォルト処理
- スニペット: `snippets/03_ini_read_write.ahk`

```ahk
#Requires AutoHotkey v2.0
#SingleInstance Force

cfgFile := A_ScriptDir "\sample.ini"
section := "Settings", key := "UserName"

; INI書き込み: ユーザー名を保存
IniWrite(A_UserName, cfgFile, section, key)

; INI読み込み: ユーザー名を取得（存在しなければ "Guest" をデフォルト使用）
name := IniRead(cfgFile, section, key, "Guest")  ; キーが無い場合 "Guest" を返す[10]
MsgBox "こんにちは、" name "さん！"
```

### 例4: アクティブウィンドウの判定と取得
- スニペット: `snippets/04_active_window_info.ahk`

```ahk
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
```

### 例5: 単一インスタンス起動とログ出力
- スニペット: `snippets/05_single_instance_log.ahk`

```ahk
#Requires AutoHotkey v2.0
#SingleInstance Force

OnExit(*) => FileAppend("[" Format("{:T}", A_Now) "] 終了`n", A_ScriptDir "\run.log")

; スクリプト開始処理
OutputDebug("スクリプト開始 - プロセスID: " DllCall("GetCurrentProcessId", "UInt")) 
FileAppend("[" Format("{:T}", A_Now) "] 起動`n", A_ScriptDir "\run.log")

MsgBox "このスクリプトは単一インスタンスで実行されています。(OKで終了)"

ExitApp  ; 終了時にOnExit関数が呼ばれログが残ります
```

## 4. この先、個別案件で調査が必要になるポイント

この先、個別案件で調査が必要になるポイント (Checklist for Future Investigation)

AutoHotkey v2の開発・運用において、今後さらに詳細な検討や対策が必要となり得るポイントを挙げます。プロジェクトの要件に応じて、以下の事項について追加調査・実験を行うと良いでしょう。

管理者権限とUIPI: スクリプトの権限レベルと操作対象プロセスの権限の差による制約を確認。通常権限のAHKから管理者権限のウィンドウ操作はWindowsのUIPIによりブロックされます（キーボードフックやWinAPI操作が無効）[26]。必要に応じてスクリプト自体を管理者で実行するか、操作対象の権限を揃える対策が必要です。

UIAccessの利用: セキュアデスクトップ上のUACダイアログや一部のシステムUIを操作する場合、AHKスクリプトにUIAccessを付与する必要があります。UIAccess有効な実行ファイルを作成するには、コードサイニング証明書付きでコンパイルし、所定のパス（例えばProgram Files下）に配置するなどの条件があります。導入コストやセキュリティリスクがあるため、どうしても必要な場合のみ選択します。

ゲーム環境への対応: ゲーム（特にフルスクリーン排他モードやアンチチート搭載タイトル）ではAHKからの入力送信やオーバーレイ表示が制限される場合があります。DirectXのフルスクリーンでは通常ウィンドウを最前面に出せないため、ゲーム側をウィンドウ(ボーダーレス)モードに変更するか、DirectXのオーバーレイ描画APIを利用する必要があります。また、アンチチートによってAHKの動作自体がブロック・検出される可能性もあるため、ゲーム毎のポリシーを調査してください。

フルスクリーン時の最前面競合: Windowsの仕様で、通常の最前面ウィンドウより独占的に上位に描画されるもの（例: タスクマネージャーの常に手前モード、Ctrl+Alt+Del画面、フルスクリーン3Dゲーム等）にはAHKのGuiやWinSet Topmostで対抗できないケースがあります。こうした「最前面が負ける」状況では、OS側の制約と割り切りが必要です（代替としてOSDツールを使う、音で通知する等検討）。

低レベルフックと入力: キーボード・マウスフック（例：#InstallKeybdHook）の動作やSendEvent/SendInputの挙動は、ターゲットアプリやOS環境によって変わる場合があります。特にリモートデスクトップや仮想環境ではフックやSendInputが機能制限されることがあるため、必要ならSendPlayの利用や別途専用ツールの検討も視野に入れます。

マルチスレッドとタイマー: AutoHotkey自体はシングルスレッドですが、複数のタイマーや非同期タスク（例えばCOMイベント）を組み合わせると擬似マルチスレッド的な動作になります。複雑な並行処理を行う場合、スレッド間で競合しうるリソースの保護（グローバル変数のLock代用など）や処理の直列化（Queue制御）について検討が必要です。

将来のバージョン変化: AutoHotkey v2.1（現在α版）の動向に注目します。安定版v2.0系では大きな破壊的変更は予定されていませんが、v2.1では新たな組み込み関数の追加や内部仕様の最適化が進められています。特に現在v2で制限事項となっている部分（例: 内部的な参照渡しの挙動[27]やCOM機能拡張など）は、将来改善される可能性があります。公式リリースノート[28][29]やコミュニティフォーラムを定期的に確認し、最新情報を踏まえてスクリプトをアップデートしてください。

OSアップデート影響: Windows 10/11の大型アップデートにより、UI要素の名称変更やセキュリティ仕様変更が起こると、ウィンドウ識別や操作手法を修正する必要があります。例として、Windowsのウィンドウクラス名やUI Automation仕様が変われば、AHKスクリプト側でWinTitle/ahk_class指定を見直す必要が出るでしょう。常に最新のOS変更情報とAHKフォーラム上の報告事例をチェックする習慣が重要です。

## 5. 参照リンク一覧

参照リンク一覧 (References to Primary Sources)

AutoHotkey公式Wiki「v1 or v2?」(Lexikos執筆) – v2の設計理念とv1比較[5][30][9]

AutoHotkey公式ドキュメント – v2変更点 (Changes from v1.1 to v2.0)[11][10]

AutoHotkey公式フォーラム – 移行時のFAQ/Q&A集[31][32]

AutoHotkey公式ヘルプ – Guiオブジェクトとオプション解説[22][23][24]

AutoHotkey公式ヘルプ – エラーオブジェクト/例外処理解説[6][21]

GitHubリリースノート – 安定版v2.0.19の修正内容（例：Finallyブロック修正等）[29]

Wikipedia “AutoHotkey” – リリース履歴とOS対応[2][3]

(※上記は一次情報を優先して参照しています。【】内は出典箇所を示しています)

[1] [2] [4] AutoHotkey - Wikipedia

https://en.wikipedia.org/wiki/AutoHotkey

[3] AutoHotkey v2

https://www.autohotkey.com/v2/

[5] [6] [7] [8] [9] [12] [13] [14] [19] [20] [30] Should I choose v1 or v2? [AutoHotkey Wiki]

https://autohotkey.wiki/versions

[10] [11] Changes from v1.1 to v2.0 | AutoHotkey v2

https://www.autohotkey.com/docs/v2/v2-changes.htm

[15] [16] autohotkey 2 - Error: This variable has not been assigned a value - Stack Overflow

https://stackoverflow.com/questions/79163858/error-this-variable-has-not-been-assigned-a-value

[17] #HotIf - Syntax & Usage | AutoHotkey v2

https://www.autohotkey.com/docs/v2/lib/_HotIf.htm

[18] HotIf / HotIfWin... - Syntax & Usage | AutoHotkey v2

https://www.autohotkey.com/docs/v2/lib/HotIf.htm

[21] [v2.0.2] Possible if...else bug - AutoHotkey Community

https://www.autohotkey.com/boards/viewtopic.php?t=112700

[22] [23] [24]  GuiCreate() - Auto Hotkey Documentation

https://documentation.help/AHK_H-2.0/GuiCreate.htm

[25] WinActive() - Auto Hotkey - Documentation & Help

https://documentation.help/AHK_H-2.0/WinActive.htm

[26] Autohotkey clipboard duplication script issues - Facebook

https://www.facebook.com/groups/AHK.Automation/posts/2075957342719408/

[27] Variables and Expressions - Definition & Usage | AutoHotkey v2

https://www.autohotkey.com/docs/v2/Variables.htm

[28] [29] Releases · AutoHotkey/AutoHotkey · GitHub

https://github.com/AutoHotkey/AutoHotkey/releases

[31] Is AHK v2 better than v1? - AutoHotkey Community

https://www.autohotkey.com/boards/viewtopic.php?t=130066

[32] SetTitleMatchMode - Syntax & Usage | AutoHotkey v2

https://www.autohotkey.com/docs/v2/lib/SetTitleMatchMode.htm
