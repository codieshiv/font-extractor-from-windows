# Define the destination folder on the Desktop
$destinationFolder = "$env:USERPROFILE\Desktop\DownloadedFonts"

# Create the destination folder if it doesn't exist
if (-not (Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

# Set the output file path
$outputFile = "$destinationFolder\InstalledFonts.txt"

# Get the fonts directory
$fontsPath = "$env:SystemRoot\Fonts"

# Get all font files in the fonts directory
$fontFiles = Get-ChildItem -Path $fontsPath -Include *.ttf, *.ttc, *.otf, *.fon -Recurse

# Save the font file paths to the output file
$fontFiles | ForEach-Object { $_.FullName } | Out-File -FilePath $outputFile -Encoding UTF8

Write-Output "Font list saved to $outputFile"

# Copy each font to the destination folder
$fontFiles | ForEach-Object {
    $destinationPath = Join-Path -Path $destinationFolder -ChildPath $_.Name
    Copy-Item -Path $_.FullName -Destination $destinationPath
}

Write-Output "Fonts have been copied to $destinationFolder"
