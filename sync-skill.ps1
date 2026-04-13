# sync-skill.ps1
# 同步 excalidraw-skill/SKILL.md 到全域 Antigravity skills 目錄
# 用法：在專案根目錄執行 .\sync-skill.ps1

$source = "$PSScriptRoot\skills\excalidraw-skill\SKILL.md"
$dest   = "$env:USERPROFILE\.gemini\antigravity\plugins\kilocode\skills\excalidraw-skill\SKILL.md"

Write-Host "🔄 同步 SKILL.md ..." -ForegroundColor Cyan

# 1. 複製到全域 skills
Copy-Item -Path $source -Destination $dest -Force
Write-Host "✅ 全域 skill 已更新：$dest" -ForegroundColor Green

# 2. Git add + commit + push
git -C $PSScriptRoot add skills/excalidraw-skill/SKILL.md

$status = git -C $PSScriptRoot status --porcelain
if ($status) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
    git -C $PSScriptRoot commit -m "docs: Update excalidraw-skill SKILL.md ($timestamp)"
    git -C $PSScriptRoot push
    Write-Host "✅ 已推上 GitHub" -ForegroundColor Green
} else {
    Write-Host "ℹ️  無修改，跳過 git commit" -ForegroundColor Yellow
}

Write-Host "`n完成！兩處 SKILL.md 均為最新版本。" -ForegroundColor Cyan
