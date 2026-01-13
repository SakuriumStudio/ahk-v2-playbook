
# AHK v2 Playbook

AutoHotkey v2.x に関するセットアップ手順、動作検証スクリプト、よくある問題とその対処法を収録したプレイブックです。

## 📁 ディレクトリ構成

```
ahk-v2-playbook/
├── setup/
│   ├── AutoHotkey v2.0.x 安定版の環境セットアップガイド.docx
│   └── AutoHotkey v2.0.xでよくある落とし穴.docx
├── tools/
│   └── AutoHotkey v2 実行環境検証ツール.docx
└── README.md
```

## 📌 内容紹介

| カテゴリ | 概要 | ファイル |
|---------|------|---------|
| セットアップ | AHK v2.0.x の導入と推奨設定手順 | `setup/AutoHotkey v2.0.x 安定版の環境セットアップガイド.docx` |
| 落とし穴 | 管理者権限やIME、ゲーム環境などの問題と対処 | `setup/AutoHotkey v2.0.xでよくある落とし穴.docx` |
| 検証ツール | スクリプト環境の正常性チェック用コード | `tools/AutoHotkey v2 実行環境検証ツール.docx` |

## 🔍 今後のディープリサーチ候補

- Send/Hotkey の低レベル干渉の診断方法とログ取得
- AHKHID / RawInput を使った高度な入力制御
- IMEの完全制御と状態復元スクリプトの定式化
- 環境別最適Sendモード診断と切り替えスクリプト
