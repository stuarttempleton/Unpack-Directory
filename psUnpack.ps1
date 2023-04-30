<#
.SYNOPSIS

Recursively unpacks all zip files in specified directory.

.DESCRIPTION

Recursively unpacks all zip files, beginning in specified directory.

.PARAMETER Directory

Specifies the path to begin unpacking.

.PARAMETER MaxDepth

Specifies the maximum depth to recursively unpack. 
Default: 5

.INPUTS

None. You cannot pipe objects to psUnpack.ps1.

.EXAMPLE

PS> .\psUnpack.ps1 -Directory C:\Music\
#>


param 
(
    [string]$Directory = $(throw "Directory parameter is required."),
    [int]$MaxDepth
)
$CurrentDepth = 0

if ($MaxDepth -lt 1) 
{
    $MaxDepth = 5 
    Write-Output "Using default max depth: $MaxDepth"
}


function Invoke-UncompressFile([string]$FilePath, [string]$DestinationPath, [bool]$Overwrite) 
{
    Write-Output "Unpacking: $FilePath > $DestinationPath" 
}

function Invoke-UncompressDirectory([string]$DirectoryPath)
{
    Write-Output "Looking in $DirectoryPath"
    $CurrentDepth += 1
    Get-ChildItem $DirectoryPath | ForEach-Object {
        $o = $_.fullname #-replace [regex]::escape($DirectoryPath), (split-path $DirectoryPath -leaf)
        if ( -not $_.psiscontainer) {
            Invoke-UncompressFile -FilePath $o -DestinationPath $DirectoryPath
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