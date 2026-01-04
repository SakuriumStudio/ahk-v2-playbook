# 06: 導線（docs と snippets の使い分け）

## 役割
- **docs/**：読む（手順・考え方・判断基準）
- **snippets/**：使う（動く .ahk、コピペ前提）

「Deep Researchの文章を貼るだけ」との差は **検索コスト**。
このリポは “入口（INDEX）” を作って、目的地に一直線で行けるようにします。

## 推奨フロー（迷子にならない版）
1. まず **docs/01_install.md → 02_launch_settings.md** で v2 を固める
2. **snippets/check_version.ahk** で v2 動作確認
3. **snippets/INDEX.md** から目的のコードへ

## 追加する時のルール（ラクさ最優先）
- docs は1ページ短め（後で見返せる長さ）
- snippets は “それ単体で動く” を基本にする
- スニペットは先頭に：
  - `#Requires AutoHotkey v2.0`
  - `#SingleInstance Force`
