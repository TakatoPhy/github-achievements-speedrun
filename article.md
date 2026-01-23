---
title: "【5分で4つ】GitHubのバッジを最速で取得するワンライナー集"
emoji: "🏃"
type: "tech"
topics: ["GitHub", "ShellScript", "CLI"]
published: false
---

## はじめに

GitHubのプロフィールに表示される「Achievements（バッジ）」、集めてますか？

![GitHub Achievements](https://github.githubassets.com/images/modules/profile/achievements/pull-shark-default.png)

実は **4つのバッジは5分で取得できます**。この記事では、GitHub CLIを使ったワンライナーで効率的にバッジを獲得する方法を紹介します。

## 対象のバッジ

| バッジ | 条件 |
|--------|------|
| ⚡ **Quickdraw** | Issue/PRを5分以内にclose |
| 🦈 **Pull Shark** | 2つのPRをマージ |
| 🤠 **YOLO** | レビューなしで自分のPRをマージ |
| 👥 **Pair Extraordinaire** | Co-author付きPRをマージ |

## 事前準備

[GitHub CLI](https://cli.github.com/)をインストールして認証しておいてください。

```bash
# インストール（Mac）
brew install gh

# 認証
gh auth login
```

## 1. Quickdraw ⚡

**条件**: Issue または PR を開いて5分以内にcloseする

```bash
gh repo create test-quickdraw --public -y && \
gh issue create -R $(gh api user -q .login)/test-quickdraw -t "test" -b "test" | \
xargs -I {} gh issue close {} -R $(gh api user -q .login)/test-quickdraw && \
gh repo delete $(gh api user -q .login)/test-quickdraw --yes
```

これだけ。リポジトリ作成 → Issue作成 → 即close → リポジトリ削除まで自動でやってくれます。

## 2. Pull Shark 🦈

**条件**: 2つのPRをマージする

```bash
REPO="test-pullshark-$(date +%s)"
gh repo create $REPO --public -y && cd /tmp && \
git clone "https://github.com/$(gh api user -q .login)/$REPO" && cd $REPO && \
echo "# PR 1" > file1.txt && git add . && git commit -m "add file1" && git push && \
git checkout -b pr1 && echo "change1" >> file1.txt && git add . && \
git commit -m "change1" && git push -u origin pr1 && \
gh pr create -t "PR1" -b "test" && gh pr merge --merge --yes && \
git checkout main && git pull && \
git checkout -b pr2 && echo "change2" >> file1.txt && git add . && \
git commit -m "change2" && git push -u origin pr2 && \
gh pr create -t "PR2" -b "test" && gh pr merge --merge --yes && \
cd ~ && gh repo delete $(gh api user -q .login)/$REPO --yes
```

2つのPRを作成してマージ。これで Pull Shark 解除です。

:::message
Pull Shark は段階があり、16PRで🥈、128PRで🥇になります
:::

## 3. YOLO 🤠

**条件**: 自分のPRをコードレビューなしでマージする

```bash
REPO="test-yolo-$(date +%s)"
gh repo create $REPO --public -y && cd /tmp && \
git clone "https://github.com/$(gh api user -q .login)/$REPO" && cd $REPO && \
echo "# YOLO" > file.txt && git add . && git commit -m "init" && git push && \
git checkout -b yolo && echo "yolo" >> file.txt && git add . && \
git commit -m "yolo" && git push -u origin yolo && \
gh pr create -t "YOLO" -b "no review needed" && gh pr merge --merge --yes && \
cd ~ && gh repo delete $(gh api user -q .login)/$REPO --yes
```

レビューなしでマージ。名前の通り「You Only Live Once」な精神です。

## 4. Pair Extraordinaire 👥

**条件**: Co-author付きのコミットを含むPRをマージする

```bash
REPO="test-pair-$(date +%s)"
gh repo create $REPO --public -y && cd /tmp && \
git clone "https://github.com/$(gh api user -q .login)/$REPO" && cd $REPO && \
echo "# Pair" > file.txt && git add . && git commit -m "init" && git push && \
git checkout -b feature && echo "collab" >> file.txt && git add . && \
git commit -m "feat: add feature

Co-Authored-By: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>" && \
git push -u origin feature && \
gh pr create -t "Pair PR" -b "test" && gh pr merge --merge --yes && \
cd ~ && gh repo delete $(gh api user -q .login)/$REPO --yes
```

コミットメッセージに `Co-Authored-By:` を入れるのがポイントです。

:::message alert
本来は実際のコラボレーターのメールアドレスを使うべきですが、テスト用にgithub-actions[bot]を使っています
:::

## 全部まとめて取得

4つ全部を一発で取得するスクリプトも用意しました。

```bash
curl -fsSL https://raw.githubusercontent.com/TakatoPhy/github-achievements-speedrun/main/scripts/speedrun.sh | bash
```

実行すると、自動でリポジトリ作成 → バッジ取得 → クリーンアップまでやってくれます。

## その他のバッジ

| バッジ | 取得方法 | 難易度 |
|--------|----------|--------|
| ⭐ **Starstruck** | リポジトリに16スター | ⭐⭐⭐ |
| 🧠 **Galaxy Brain** | Discussionで2回ベストアンサー | ⭐⭐ |
| 💝 **Public Sponsor** | 誰かをスポンサー（$1〜） | ⭐ |

## リポジトリ

スクリプトは全てGitHubで公開しています。

https://github.com/TakatoPhy/github-achievements-speedrun

⭐ スターいただけると励みになります！

## まとめ

- GitHub CLIがあれば4つのバッジは5分で取れる
- 自動化スクリプトで一発取得も可能
- プロフィールを充実させて、GitHubライフを楽しもう

Happy Hacking! 🎉
