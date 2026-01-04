# AutoHotkey v2 Playbook

AutoHotkey v2（主に **Stable v2.0.x**）の「判断基準＋すぐ動く断片」をまとめる実用メモ集。  
*docs = 読み物（方針/罠/設計）*、*snippets = コピペで動く最小スクリプト*。

---

## 最初の3ステップ（迷ったらここから）

1. **セットアップを終わらせる**  
   → `docs/01_setup.md`

2. **動作確認を一発でやる（v2判定＋入力確認）**  
   → `docs/02_quick_test.md`  
   → `snippets/check_version.ahk`

3. **詰まりやすい罠を先に潰す（管理者/競合/表示/フック周り）**  
   → `docs/03_pitfalls.md`

---

## 入口（まずここを開く）

- **Docs 入口**：`docs/README.md`（読む順番・目的別導線）
- **Snippets 入口**：`snippets/README.md`（用途別にコピペで使う）

---

## 目的

- v2の「定石」「破壊的変更」「やりがちなミス」を、あとで自分が助かる形で残す
- “その場しのぎ”のスクリプトを、再利用しやすい **最小スニペット** に分解して蓄積する
- **ゲーム/常駐/管理者権限** など「現場で揉める条件」を前提に、再現性ある手順にする

---

## Docs（読み物）

- `docs/00_scope.md`：このリポの範囲・前提（何をやって/やらないか）
- `docs/01_setup.md`：導入（v2の入れ方・関連設定・推奨）
- `docs/02_quick_test.md`：最短テスト（v2判定・キー確認・ログ）
- `docs/03_pitfalls.md`：罠まとめ（管理者/IME/フック/ウィンドウ/ゲーム）
- `docs/04_patterns.md`：よく使う設計パターン（関数分割/設定/ホットキー）
- `docs/05_gui_overlay.md`：常に前面の小窓（オーバーレイ）作り方

---

## Snippets（コピペで動く）

- `snippets/check_version.ahk`：v2で動いてるか確認（ワンショット）
- `snippets/always_on_top_overlay.ahk`：前面小窓（ドラッグ移動/最前面）
- `snippets/debug_key_viewer.ahk`：押してるキー確認（トラブル時）
- `snippets/process_exe_finder.ahk`：アクティブアプリのexe名を出す（Synapse登録用）

---

## 運用のコツ（おすすめ）

- まず **docs/README.md** から入って、該当するページへ飛ぶ
- 使ったスクリプトは「完成品のまま置く」より、**snippets化** して再利用しやすくする
- “管理者が絡む/ゲームが絡む/常駐させる” は罠が増えるので、該当ページに手順を追記していく
