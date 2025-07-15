# save as "Build-ALProject.ps1"
# =============================================================================
# AL Project Build Script --> create .app file from powershell
# =============================================================================

#param
param(
    [string]$ProjectPath = ".",
    [string]$OutputName = "",
    [switch]$Clean
)

#search alc.exe
$alcPath = Get-ChildItem -Path "$env:USERPROFILE\.vscode\extensions" -Recurse -Name "alc.exe" -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $alcPath) {

    Write-Error "AL Compiler not found. Please ensure the AL Language extension is installed in VS Code."
    exit 1
}

$fullAlcPath = "$env:USERPROFILE\.vscode\extensions\$alcPath"
$projectDir = Resolve-Path $ProjectPath
Write-Host "Building AL project from: $projectDir"


#app.json
$appJsonPath = Join-Path $projectDir "app.json"

if (-not (Test-Path $appJsonPath)) {
    Write-Error "app.json not found in project directory."
    exit 1
}

#App config
$appConfig = Get-Content $appJsonPath | ConvertFrom-Json
$projectName = $appConfig.name
$publisher = $appConfig.publisher
$version = $appConfig.version

if (-not $OutputName) {
    $OutputName = "$projectName.app"
}

if ($Clean) {
    Get-ChildItem -Path $projectDir -Name "*.app" | ForEach-Object {
        Remove-Item (Join-Path $projectDir $_) -Force
        Write-Host "Removed: $_"
    }
}

#.al packages
$packageCachePath = Join-Path $projectDir ".alpackages"
$outputPath = Join-Path $projectDir $OutputName

if (-not (Test-Path $packageCachePath)) {
    New-Item -ItemType Directory -Path $packageCachePath -Force | Out-Null
}

#write output
Write-Host "Compiling project: $projectName"
Write-Host "Publisher: $publisher"
Write-Host "Version: $version"
Write-Host "Output: $outputPath"

#try catch - build app
try {
    & $fullAlcPath /project:"$projectDir" /packagecachepath:"$packageCachePath" /out:"$outputPath"    

    if ($LASTEXITCODE -eq 0) {

        Write-Host "`n Build successful!" -ForegroundColor Green
        Write-Host "Generated: $outputPath" -ForegroundColor Green
        $fileSize = (Get-Item $outputPath).Length
        Write-Host "File size: $([math]::Round($fileSize / 1KB, 2)) KB" -ForegroundColor Cyan

    } else {

        Write-Host "`n Build failed with exit code: $LASTEXITCODE" -ForegroundColor Red
        exit $LASTEXITCODE
    }

} 

catch {
    Write-Error "Error during compilation: $_"
    exit 1

}
