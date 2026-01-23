#!/bin/bash
set -e

# GitHub Achievements Speedrun
# Get 4 achievements in minutes

echo "🏃 GitHub Achievements Speedrun"
echo "================================"
echo ""

# Check gh CLI
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) not found. Install: https://cli.github.com/"
    exit 1
fi

# Check auth
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated. Run: gh auth login"
    exit 1
fi

USERNAME=$(gh api user -q .login)
echo "👤 Logged in as: $USERNAME"
echo ""

# Create temp repo
REPO="achievements-speedrun-$(date +%s)"
echo "📦 Creating temporary repo: $REPO"
gh repo create "$REPO" --public -y > /dev/null 2>&1

cd /tmp
rm -rf "$REPO"
git clone "https://github.com/$USERNAME/$REPO" > /dev/null 2>&1
cd "$REPO"

# Initialize
echo "# Speedrun" > README.md
git add .
git commit -m "init" > /dev/null 2>&1
git push > /dev/null 2>&1

# ⚡ Quickdraw
echo ""
echo "⚡ Getting Quickdraw..."
gh issue create -t "Quickdraw test" -b "Closing quickly" > /dev/null 2>&1
gh issue close 1 > /dev/null 2>&1
echo "   ✅ Quickdraw - Issue opened and closed"

# 🦈 Pull Shark (2 PRs)
echo ""
echo "🦈 Getting Pull Shark..."

git checkout -b pr1
echo "PR1" >> README.md
git add . && git commit -m "PR 1" > /dev/null 2>&1
git push -u origin pr1 > /dev/null 2>&1
gh pr create -t "PR 1" -b "First PR" > /dev/null 2>&1
gh pr merge --merge --yes > /dev/null 2>&1
echo "   ✅ PR 1 merged"

git checkout main && git pull > /dev/null 2>&1
git checkout -b pr2
echo "PR2" >> README.md
git add . && git commit -m "PR 2" > /dev/null 2>&1
git push -u origin pr2 > /dev/null 2>&1
gh pr create -t "PR 2" -b "Second PR" > /dev/null 2>&1
gh pr merge --merge --yes > /dev/null 2>&1
echo "   ✅ PR 2 merged"
echo "   ✅ Pull Shark unlocked!"

# 🤠 YOLO
echo ""
echo "🤠 Getting YOLO..."
git checkout main && git pull > /dev/null 2>&1
git checkout -b yolo
echo "YOLO" >> README.md
git add . && git commit -m "YOLO commit" > /dev/null 2>&1
git push -u origin yolo > /dev/null 2>&1
gh pr create -t "YOLO" -b "No review needed" > /dev/null 2>&1
gh pr merge --merge --yes > /dev/null 2>&1
echo "   ✅ YOLO - PR merged without review"

# 👥 Pair Extraordinaire
echo ""
echo "👥 Getting Pair Extraordinaire..."
git checkout main && git pull > /dev/null 2>&1
git checkout -b pair
echo "Pair" >> README.md
git add .
git commit -m "feat: pair programming

Co-Authored-By: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>" > /dev/null 2>&1
git push -u origin pair > /dev/null 2>&1
gh pr create -t "Pair PR" -b "Co-authored commit" > /dev/null 2>&1
gh pr merge --merge --yes > /dev/null 2>&1
echo "   ✅ Pair Extraordinaire - Co-authored PR merged"

# Cleanup
echo ""
echo "🧹 Cleaning up..."
cd ~
gh repo delete "$USERNAME/$REPO" --yes > /dev/null 2>&1
rm -rf "/tmp/$REPO"

echo ""
echo "================================"
echo "🎉 Done! Check your profile:"
echo "   https://github.com/$USERNAME?tab=achievements"
echo ""
echo "Note: Achievements may take a few minutes to appear."
