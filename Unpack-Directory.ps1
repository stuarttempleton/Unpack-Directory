<#
.SYNOPSIS

Recursively unpacks all zip files in specified directory.

.DESCRIPTION

Recursively unpacks all zip files, beginning in specified directory. Uses built in Expand-Archive. Does not unpack zips within zips, but does recurse directories.

.PARAMETER Directory

Specifies the path to begin unpacking. REQUIRED.

.PARAMETER MaxDepth

Specifies the maximum depth to recursively unpack. 
Default: 5

.PARAMETER Force

Force unpacking to overwrite target directors. Can be dangerous!

.PARAMETER WhatIf

Test unpacking to show what would happen in a real run. Good for making sure you're set up.

.INPUTS

None. You cannot pipe objects to Unpack-Directory.

.EXAMPLE

PS> .\Unpack-Directory -Directory "C:\Music\"

.EXAMPLE

PS> .\Unpack-Directory -Directory "C:\Music\" -MaxDepth 3

.EXAMPLE

PS> .\Unpack-Directory -Directory "C:\Music\" -MaxDepth 15 -WhatIf
#>


param 
(
    [string]$Directory = $(throw "Directory parameter is required."),
    [int]$MaxDepth,
    [switch]$Force,
    [switch]$WhatIf
)
$CurrentDepth = 0

if ($MaxDepth -lt 1) 
{
    $MaxDepth = 5 
    Write-Output "Using default max depth: $MaxDepth"
}


function Invoke-UncompressFile([string]$FilePath, [string]$DestinationPath) 
{
    Write-Output "Unpacking: $FilePath > $DestinationPath" 
    Expand-Archive -LiteralPath $FilePath -DestinationPath $DestinationPath -Force:$Force -WhatIf:$WhatIf -ErrorAction Ignore
}

function Invoke-UncompressDirectory([string]$DirectoryPath)
{
    Write-Output "Looking in $DirectoryPath"
    $CurrentDepth += 1
    Get-ChildItem $DirectoryPath | ForEach-Object {
        $o = $_.fullname
        if ( -not $_.psiscontainer) {
            if ($o -like "*.zip"){
                Invoke-UncompressFile -FilePath $o -DestinationPath $DirectoryPath
            }
        }
        elseif ( $CurrentDepth -lt $MaxDepth) {
            Invoke-UncompressDirectory -DirectoryPath "$o\"
        }
        else {
            Write-Output "Max depth reached! $CurrentDepth"
        }
    }
    $CurrentDepth -= 1 
}

Write-Output "Starting: $Directory"
$cmd_time = Measure-Command { Invoke-UncompressDirectory -DirectoryPath $Directory | Out-Default }
Write-Output( "Completed in " + $cmd_time.ToString() + ".")

Exit