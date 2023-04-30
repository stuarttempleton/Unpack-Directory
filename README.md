### SYNOPSIS

Recursively unpacks all zip files in specified directory.

### DESCRIPTION

Recursively unpacks all zip files, beginning in specified directory. Uses built in Expand-Archive. Does not unpack zips within zips, but does recurse directories.

### PARAMETER Directory

Specifies the path to begin unpacking. REQUIRED.

## PARAMETER MaxDepth

Specifies the maximum depth to recursively unpack. 
Default: 5

### PARAMETER Force

Force unpacking to overwrite target directors. Can be dangerous!

### PARAMETER WhatIf

Test unpacking to show what would happen in a real run. Good for making sure you're set up.

### INPUTS

None. You cannot pipe objects to Unpack-Directory.

### EXAMPLE

At its simplest, just give it a directory.

```powershell
PS> .\Unpack-Directory -Directory "C:\Music\"
```

### EXAMPLE

You can specify a custom maximum depth to recurse. Just in case.

```powershell
PS> .\Unpack-Directory -Directory "C:\Music\" -MaxDepth 3
```

### EXAMPLE

You can include "what if" and "force overwrite" switches, if you like.

```powershell
PS> .\Unpack-Directory -Directory "C:\Music\" -MaxDepth 15 -WhatIf -Force
```
