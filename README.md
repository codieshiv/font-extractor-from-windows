# font-extractor-from-windows
# Export and Download Installed Fonts

This PowerShell script lists all the fonts installed on your Windows system, saves their paths to a text file, and copies the font files to a specified folder on your Desktop.

## Prerequisites

- Windows operating system
- PowerShell (run as an Administrator)

## Script Description

- Creates a folder named `DownloadedFonts` on your Desktop if it doesn't already exist.
- Saves the list of installed font paths to a file named `InstalledFonts.txt` within the `DownloadedFonts` folder.
- Copies all the font files from the system fonts directory to the `DownloadedFonts` folder.

## How to Use

1. **Download the Script**
   - Save the provided script as `ExportAndDownloadFonts.ps1`.

2. **Open PowerShell with Administrative Privileges**
   - Press `Windows + X` and select "Windows PowerShell (Admin)".
   - Alternatively, search for "PowerShell" in the Start menu, right-click it, and choose "Run as administrator".

3. **Run the Script**
   - Navigate to the directory where you saved the `ExportAndDownloadFonts.ps1` file.
   - Execute the script by typing the following command:
     ```powershell
     .\ExportAndDownloadFonts.ps1
     ```

## Script

```powershell
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

Notes
Ensure you run PowerShell with administrative privileges to allow access to the system fonts directory.
The script creates a folder named DownloadedFonts on your Desktop and places all copied fonts and the list file in that folder.
License
This project is licensed under the MIT License - see the LICENSE file for details.

typescript
Copy code

Save this content in a file named `README.md` in the same directory as your PowerShell script. This will help users understand the purpose of the script, how to use it, and any prerequisites needed.