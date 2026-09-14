$ErrorActionPreference = 'Stop'
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$path = Join-Path (Get-Location) 'src\Documents'
$target = Get-ChildItem -LiteralPath $path -Recurse -Filter 'Module.bsl' | Where-Object { $_.Directory.Name -eq [string]::Join('', @([char]0x0424,[char]0x043E,[char]0x0440,[char]0x043C,[char]0x0430,[char]0x0414,[char]0x043E,[char]0x043A,[char]0x0443,[char]0x043C,[char]0x0435,[char]0x043D,[char]0x0442,[char]0x0430)) }
$file = $target | Select-Object -First 1
Write-Output ('FILE: ' + $file.FullName)
Write-Output ('LINES: ' + (Get-Content -LiteralPath $file.FullName -Encoding UTF8).Count)
