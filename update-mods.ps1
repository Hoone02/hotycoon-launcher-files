# 호타이쿤 런처 모드 배포
#   1) servers/hobaektycoon-26.2/fabricmods/required/ 에 jar 를 넣거나 빼거나 바꾼다
#   2) 이 스크립트를 실행한다:  powershell -ExecutionPolicy Bypass -File update-mods.ps1 "메모"
# → Nebula 로 distribution.json 을 다시 만들고 GitHub 에 올린다.
#   런처는 실행할 때마다 distribution.json 을 받아 파일 해시를 비교하므로,
#   이미 설치한 사람도 다음 실행 때 바뀐 모드만 새로 받는다(목록에서 빠진 모드는 더 이상 불러오지 않는다).
param([string]$Message = "모드 갱신")

$ErrorActionPreference = "Stop"
$files = $PSScriptRoot
$nebula = Join-Path $files "..\nebula"

Push-Location $nebula
try {
    if (-not (Test-Path "dist\index.js")) { npm run build }
    node dist/index.js g distro
    if ($LASTEXITCODE -ne 0) { throw "Nebula 실패" }
    node (Join-Path $files "add-extra-modules.js")
    if ($LASTEXITCODE -ne 0) { throw "추가 모듈 붙이기 실패" }
} finally { Pop-Location }

Push-Location $files
try {
    git add -A
    git diff --cached --quiet
    if ($LASTEXITCODE -eq 0) { Write-Host "바뀐 파일이 없어요."; return }
    git commit -m $Message
    git push origin main
    Write-Host "올림 완료. raw.githubusercontent.com 캐시 때문에 최대 5분 뒤부터 런처에 반영돼요."
} finally { Pop-Location }
