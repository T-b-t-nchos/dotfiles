#Include lib/IMEv2.ahk

#InputLevel 1
PrintScreen:: {
    Run A_UserProfile "\.bin\rapture\rapture.exe"
    return
}

sc07B:: IME_SET(0) ; IME無効化
sc079:: IME_SET(1) ; IME有効化
