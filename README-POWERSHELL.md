# PowerShell Scripts - Usage Guide

## Quick Start

Download all the scripts and run this from your project root:

```powershell
.\deploy-fixes.ps1
```

This interactive script will guide you through fixing everything!

---

## Individual Scripts

### 1. check-missing-images.ps1
**What it does:** Scans your project for missing image files

```powershell
.\check-missing-images.ps1
```

**Looks for:**
- jason-plus-mlc-2021.png
- stage-duo.png
- band-camp-north-end.png
- choir-performance.png
- group-selfie.png
- piano-performance.png
- merch-hoodie.png
- merch-mug.png
- merch-tote.png
- merch-sticker.png

**Output:** Shows you which images are missing and where to put them

---

### 2. fix-csp-youtube.ps1
**What it does:** Creates the config file to fix YouTube embed blocking

```powershell
.\fix-csp-youtube.ps1
```

**Interactive prompts:**
- Asks if you're using Vercel or Netlify
- Creates the appropriate config file (vercel.json or _headers)
- Checks your HTML for conflicting CSP tags

---

### 3. deploy-fixes.ps1 (RECOMMENDED)
**What it does:** All-in-one script that checks status, applies fixes, and deploys

```powershell
# Check status only (no changes)
.\deploy-fixes.ps1 -CheckOnly

# Interactive fix and deploy
.\deploy-fixes.ps1
```

**Features:**
- Checks git status
- Runs other scripts as needed
- Commits changes with custom message
- Pushes to remote
- Shows deployment status

---

## Step-by-Step Workflow

### From PowerShell in your project directory:

```powershell
# 1. Check current status
.\deploy-fixes.ps1 -CheckOnly

# 2. Run the main fix script
.\deploy-fixes.ps1

# 3. Follow the prompts:
#    - Choose what to fix (images, YouTube, or both)
#    - Confirm deployment
#    - Enter commit message (or use default)

# 4. Wait for automatic deployment on Vercel/Netlify
```

---

## Manual Git Commands (if needed)

If you prefer to do it manually:

```powershell
# After fixing images and CSP config:
git add .
git commit -m "Fix images and YouTube embed issues"
git push
```

---

## Troubleshooting

**"git is not recognized"**
- Install Git: https://git-scm.com/download/win
- Or run from Git Bash instead of PowerShell

**"Execution Policy Error"**
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

**"Not a git repository"**
- Make sure you're in your project root directory
- Check if .git folder exists

---

## What Each Fix Does

### YouTube Fix:
- Creates vercel.json or _headers file
- Adds Content-Security-Policy allowing YouTube embeds
- Automatically includes on next deployment

### Image Fix:
- Identifies missing images
- Shows you where to copy them
- You still need to manually copy the actual image files before committing

---

## Questions?

After running the scripts, your site should be fixed after the next deployment (usually 1-2 minutes on Vercel/Netlify).
