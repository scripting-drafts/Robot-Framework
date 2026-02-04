# Installs Appium v2 and Android UIAutomator2 driver
Write-Host "Installing Appium..."
npm install -g appium
Write-Host "Installing Android UIAutomator2 driver..."
appium driver install uiautomator2
Write-Host "Done. Start Appium with 'scripts/start-appium.ps1' or 'appium'"
