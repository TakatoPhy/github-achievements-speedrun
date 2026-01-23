# GitHub Achievements Speedrun 🏃‍♂️

Get 4 GitHub achievements in under 5 minutes.

## Prerequisites

- [GitHub CLI](https://cli.github.com/) installed and authenticated (`gh auth login`)

## Achievements

### ⚡ Quickdraw
> Close an issue/PR within 5 minutes of opening

```bash
gh repo create test-quickdraw --public && \
gh issue create -R $(gh api user -q .login)/test-quickdraw -t "test" -b "test" | xargs -I {} gh issue close {} -R $(gh api user -q .login)/test-quickdraw && \
gh repo delete $(gh api user -q .login)/test-quickdraw --yes
```

### 🦈 Pull Shark
> Merge 2 pull requests

```bash
REPO="test-pullshark-$(date +%s)"
gh repo create $REPO --public && cd /tmp && git clone "https://github.com/$(gh api user -q .login)/$REPO" && cd $REPO && \
echo "# PR 1" > file1.txt && git add . && git commit -m "add file1" && git push && \
git checkout -b pr1 && echo "change1" >> file1.txt && git add . && git commit -m "change1" && git push -u origin pr1 && \
gh pr create -t "PR1" -b "test" && gh pr merge --merge && \
git checkout main && git pull && \
git checkout -b pr2 && echo "change2" >> file1.txt && git add . && git commit -m "change2" && git push -u origin pr2 && \
gh pr create -t "PR2" -b "test" && gh pr merge --merge && \
cd ~ && gh repo delete $(gh api user -q .login)/$REPO --yes
```

### 👥 Pair Extraordinaire
> Co-author a merged pull request

```bash
REPO="test-pair-$(date +%s)"
gh repo create $REPO --public && cd /tmp && git clone "https://github.com/$(gh api user -q .login)/$REPO" && cd $REPO && \
echo "# Pair" > file.txt && git add . && git commit -m "init" && git push && \
git checkout -b feature && echo "collab" >> file.txt && git add . && \
git commit -m "feat: add feature

Co-Authored-By: Your Friend <friend@example.com>" && \
git push -u origin feature && \
gh pr create -t "Pair PR" -b "test" && gh pr merge --merge && \
cd ~ && gh repo delete $(gh api user -q .login)/$REPO --yes
```

> **Note**: Replace `Your Friend <friend@example.com>` with a real GitHub user's name and email for the badge to count.

### 🤠 YOLO
> Merge your own PR without code review

```bash
REPO="test-yolo-$(date +%s)"
gh repo create $REPO --public && cd /tmp && git clone "https://github.com/$(gh api user -q .login)/$REPO" && cd $REPO && \
echo "# YOLO" > file.txt && git add . && git commit -m "init" && git push && \
git checkout -b yolo && echo "yolo" >> file.txt && git add . && git commit -m "yolo" && git push -u origin yolo && \
gh pr create -t "YOLO" -b "no review needed" && gh pr merge --merge && \
cd ~ && gh repo delete $(gh api user -q .login)/$REPO --yes
```

## All-in-One Script

Want all 4 at once? [Download the script](scripts/speedrun.sh):

```bash
curl -fsSL https://raw.githubusercontent.com/TakatoPhy/github-achievements-speedrun/main/scripts/speedrun.sh | bash
```

## Achievement Tiers

| Achievement | Bronze | Silver | Gold |
|-------------|--------|--------|------|
| Pull Shark | 2 PRs | 16 PRs | 128 PRs |
| Pair Extraordinaire | 1 PR | 10 PRs | 24 PRs |

## Other Achievements

| Achievement | How to Get | Difficulty |
|-------------|------------|------------|
| **Starstruck** | Get 16 stars on a repo | ⭐⭐⭐ |
| **Galaxy Brain** | 2 accepted Discussion answers | ⭐⭐ |
| **Public Sponsor** | Sponsor someone ($1+) | ⭐ (costs $) |

## License

MIT
