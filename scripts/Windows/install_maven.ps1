﻿Write-Host "Installing Apache Maven 3.6.0 ..." -ForegroundColor Cyan

$apachePath = 'C:\Program Files (x86)\Apache'
$mavenPath = "$apachePath\Maven"

if(Test-Path $mavenPath) {
    Remove-Item $mavenPath -Recurse -Force
}

if(-not (Test-Path $apachePath)) {
    New-Item $apachePath -ItemType directory -Force
}

Write-Host "Downloading..."
$zipPath = "$env:TEMP\apache-maven-3.6.0-bin.zip"
(New-Object Net.WebClient).DownloadFile('http://mirror.csclub.uwaterloo.ca/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.zip', $zipPath)

Write-Host "Unpacking..."
7z x $zipPath -oC:\apache-maven | Out-Null
[IO.Directory]::Move('C:\apache-maven\apache-maven-3.6.0', $mavenPath)
Remove-Item 'C:\apache-maven' -Recurse -Force
del $zipPath

[Environment]::SetEnvironmentVariable("M2_HOME", $mavenPath, "Machine")
[Environment]::SetEnvironmentVariable("MAVEN_HOME", $mavenPath, "Machine")

add-path "$mavenPath\bin"

mvn --version

Write-Host "Apache Maven 3.6.0 installed" -ForegroundColor Green