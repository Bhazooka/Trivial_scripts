# Path to the default screenshots directory
$screenshotDir = "$env:USERPROFILE\Pictures\Screenshots"

# Function to move items to Recycle Bin
function Move-ToRecycleBin {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    
    $shell = New-Object -ComObject Shell.Application
    $recycleBin = $shell.Namespace(0xA)
    $item = $shell.Namespace((Get-Item $Path).Parent.FullName).ParseName((Get-Item $Path).Name)
    
    if ($item -ne $null) {
        $recycleBin.MoveHere($item)
        return $true
    } else {
        return $false
    }
}

# Check if the directory exists
if (Test-Path -Path $screenshotDir) {
    # Get all files in the directory
    $files = Get-ChildItem -Path $screenshotDir

    if ($files.Count -eq 0) {
        Write-Output "No screenshots to delete."
    } else {
        # Move each file to the Recycle Bin and print the file names
        foreach ($file in $files) {
            $result = Move-ToRecycleBin -Path $file.FullName
            if ($result) {
                Write-Output "Moved to Recycle Bin: $($file.Name)"
            } else {
                Write-Output "Failed to move: $($file.Name)"
            }
        }
    }
} else {
    Write-Output "Screenshots directory does not exist."
}

pause
