# Path to Firefox executable
$firefoxPath = "C:\Program Files\Mozilla Firefox\firefox.exe"

# Profile name
$profileName = "Personal"

# Command to open Firefox with the specified profile
Start-Process $firefoxPath -ArgumentList "-P `"$profileName`""