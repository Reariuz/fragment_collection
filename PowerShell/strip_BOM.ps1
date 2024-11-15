# This PowerShell script defines a function called ContainsBOM that checks if files in a specified directory contain a UTF-8 Byte Order Mark (BOM).
# It reads the first three bytes of each file and verifies if they match the BOM sequence (0xEF, 0xBB, 0xBF).
# The script retrieves all files from Programm location that are not directories and have a size greater than 2 bytes,
# then filters those files through the ContainsBOM function to identify which ones contain the BOM.



Function ContainsBOM
{   
    return $input | Where-Object {
        $contents = new-object byte[] 3
        $stream = [System.IO.File]::OpenRead($_.FullName)
        $stream.Read($contents, 0, 3) | Out-Null
        $stream.Close()
        $contents[0] -eq 0xEF -and $contents[1] -eq 0xBB -and $contents[2] -eq 0xBF }
}

# Use the directory of the current script as the target location
$directory = $PSScriptRoot

get-childitem "$directory\*.*" | Where-Object {!$_.PsIsContainer -and $_.Length -gt 2 } | ContainsBOM

timeout 30
