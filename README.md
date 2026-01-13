# 📘 AutoHotkey v2 Playbook

AutoHotkey v2.0.x Stable 向けの環境構築・デバッグ・確認・回避策までを体系的に整理した実践ガイドです。

## 📂 セットアップ手順と落とし穴
- [環境構築ガイド](setup/environment_setup.md)  
  └ Windows 10/11 対応。インストール手順、併存対応、エディタ・デバッグ連携など。
- [よくある落とし穴とその対策](setup/pitfalls_and_fixes.md)  
  └ 管理者権限/UAC、ゲーム環境、IME干渉、Sendモードなど詳細な再現条件・対策付き。

## ✅ 動作確認チェックリスト
- [検証用チェックリスト](checklist/verify_checklist.md)  
  └ スクリプトの最短動作確認、ログ出力、アクティブウィンドウ取得のポイント付き。

## 🛠 デバッグと調査のヒント
- [詰まり解消フローチャート](debug/debug_flowchart.md)  
  └ ホットキーが効かない、Sendが通らない… その原因を順に潰すための判断手順。
- [デバッグヒント集](debug/debug_tips.md)  
  └ WindowSpy, DBGView, メッセージログなど活用の長所・短所。

## 🔧 ツール・スニペット
- [`runtime_verifier.ahk`](tools/runtime_verifier.ahk)  
  └ AHK v2動作判定、キー入力検知、アクティブウィンドウログ出力など単体で動作するスクリプト。
