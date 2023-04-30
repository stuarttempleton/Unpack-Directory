## Unpack-Directory

Recursively unpacks all zip files, beginning in specified directory. Uses built in Expand-Archive. Does not unpack zips within zips, but does recurse directories.

#### -Directory

Specifies the path to begin unpacking. REQUIRED.

#### -MaxDepth

Specifies the maximum depth to recursively unpack. 
Default: 5

#### -Force

Force unpacking to overwrite target directors. Can be dangerous!

#### -WhatIf

Test unpacking to show what would happen in a real run. Good for making sure you're set up.

*Note: You cannot pipe objects to Unpack-Directory.*

## Examples

At its simplest, just give it a directory.

```powershell
PS> .\Unpack-Directory -Directory "C:\Music\"
```

You can specify a custom maximum depth to recurse. Just in case.

```powershell
PS> .\Unpack-Directory -Directory "C:\Music\" -MaxDepth 3
```

You can include "what if" and "force overwrite" switches, if you like.

```powershell
PS> .\Unpack-Directory -Directory "C:\Music\" -MaxDepth 15 -WhatIf -Force
```
