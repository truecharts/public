%windir%\system32\DISM.exe /Online /Get-TargetEditions
%windir%\system32\DISM /online /Set-Edition:ServerStandard /ProductKey:N69G4-B89J2-4G8F4-WWYCC-J464C /AcceptEula
cscript %windir%\system32\slmgr.vbs /upk
cscript %windir%\system32\slmgr.vbs /ipk N69G4-B89J2-4G8F4-WWYCC-J464C
cscript %windir%\system32\slmgr.vbs /skms 192.168.10.43:1688
cscript %windir%\system32\slmgr.vbs /ato