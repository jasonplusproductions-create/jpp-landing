# Complete Fix and Deploy Script for Jason Plus Productions
# Run this from your project root directory

param(
    [switch]$CheckOnly
)

Write-Host @"
╔════════════════════════════════════════════════════╗
║  Jason Plus Productions - Fix & Deploy Script     ║
╚════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

# Function to check git status
function Check-GitStatus {
    $gitStatus = git status --porcelain 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "⚠ Not a git repository or git not found" -ForegroundColor Yellow
        return $false
    }
    return $true
}

# Function to check for uncommitted changes
function Get-UncommittedChanges {
    $changes = git status --porcelain
    return ($changes -ne $null -and $changes -ne "")
}

# Check if we're in a git repo
if (-not (Check-GitStatus)) {
    Write-Host "This doesn't appear to be a git repository." -ForegroundColor Red
    Write-Host "Make sure you're in your project root directory." -ForegroundColor Yellow
    exit
}

Write-Host "`n📊 PROJECT STATUS CHECK" -ForegroundColor Cyan
Write-Host ("=" * 50)

# Check current branch
$currentBranch = git branch --show-current
Write-Host "Current branch: $currentBranch" -ForegroundColor Yellow

# Check for uncommitted changes
if (Get-UncommittedChanges) {
    Write-Host "⚠ You have uncommitted changes" -ForegroundColor Yellow
    git status --short
} else {
    Write-Host "✓ Working directory clean" -ForegroundColor Green
}

# Check remote
$remote = git remote get-url origin 2>$null
if ($remote) {
    Write-Host "Remote: $remote" -ForegroundColor Gray
}

Write-Host "`n" -ForegroundColor White

# If CheckOnly flag, stop here
if ($CheckOnly) {
    Write-Host "Check complete. Run without -CheckOnly to make fixes." -ForegroundColor Cyan
    exit
}

# Ask what to fix
Write-Host "What would you like to fix?" -ForegroundColor Yellow
Write-Host "1. Add missing images"
Write-Host "2. Fix YouTube embed (CSP)"
Write-Host "3. Both"
Write-Host "4. Just commit & push existing changes"
$fixChoice = Read-Host "Enter 1, 2, 3, or 4"

$needsCommit = $false

switch ($fixChoice) {
    "1" {
        Write-Host "`nRunning image check script..." -ForegroundColor Cyan
        & "$PSScriptRoot/check-missing-images.ps1"
        $needsCommit = $true
    }
    
    "2" {
        Write-Host "`nRunning CSP fix script..." -ForegroundColor Cyan
        & "$PSScriptRoot/fix-csp-youtube.ps1"
        $needsCommit = $true
    }
    
    "3" {
        Write-Host "`nRunning image check script..." -ForegroundColor Cyan
        & "$PSScriptRoot/check-missing-images.ps1"
        Write-Host "`nRunning CSP fix script..." -ForegroundColor Cyan
        & "$PSScriptRoot/fix-csp-youtube.ps1"
        $needsCommit = $true
    }
    
    "4" {
        $needsCommit = $true
    }
}

if ($needsCommit) {
    Write-Host "`n📦 DEPLOYMENT" -ForegroundColor Cyan
    Write-Host ("=" * 50)
    
    # Show what will be committed
    Write-Host "`nFiles to commit:" -ForegroundColor Yellow
    git status --short
    
    Write-Host "`nReady to commit and deploy?" -ForegroundColor Yellow
    $confirm = Read-Host "Type 'yes' to continue"
    
    if ($confirm -eq "yes") {
        # Add all changes
        Write-Host "`nStaging changes..." -ForegroundColor Cyan
        git add .
        
        # Commit
        $commitMsg = Read-Host "Commit message (or press Enter for default)"
        if ([string]::IsNullOrWhiteSpace($commitMsg)) {
            $commitMsg = "Fix images and YouTube embed issues"
        }
        
        Write-Host "Committing: $commitMsg" -ForegroundColor Cyan
        git commit -m $commitMsg
        
        # Push
        Write-Host "Pushing to remote..." -ForegroundColor Cyan
        git push
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "`n✓ Successfully deployed!" -ForegroundColor Green
            Write-Host "Your hosting platform should automatically deploy the changes." -ForegroundColor Yellow
            Write-Host "Check your deployment status on your hosting dashboard." -ForegroundColor Yellow
        } else {
            Write-Host "`n✗ Push failed!" -ForegroundColor Red
            Write-Host "Check your git credentials and network connection." -ForegroundColor Yellow
        }
    } else {
        Write-Host "Deployment cancelled." -ForegroundColor Yellow
    }
}

Write-Host "`n✅ Script complete!`n" -ForegroundColor Green
