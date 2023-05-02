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

#### -RemoveArchiveAfterUse

Force clean up of all zip files after use. Use with caution!


*Note: You cannot pipe objects to Unpack-Directory.*

## Directory Structures

What does this work on? What directory structures is this for? Anything with a smattering of archives that might be stored in some kind of heirarchy.

Something like a music library, where the albums are archived individually. (ex., e-music.com)
```
C:\Music\
  Artist\
    album.zip
    album2.zip
  Artist2
    album.zip
    album2.zip
```

Maybe a user directory that has individual user archives. Use the -MaxDepth flag for fine-tuned control.
```
C:\Users\
  Alice\
    archive.zip
  Bob\
    archive.zip
  Reginald\
    archive.zip
    mail\
      another_archive.zip
```

## Examples

At its simplest, just give it a directory.

```powershell
PS> .\Unpack-Directory -Directory "C:\Music\"
```

You can specify a custom maximum depth to recurse. Just in case.

```powershell
PS> .\Unpack-Directory -Directory "C:\Music\" -MaxDepth 3
```

You can include "what if", "force overwrite", and "remove archive files" switches, if you like.

```powershell
PS> .\Unpack-Directory -Directory "C:\Music\" -MaxDepth 15 -WhatIf -Force -RemoveArchiveAfterUse
```
