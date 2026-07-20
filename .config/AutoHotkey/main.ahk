#Include lib/IMEv2.ahk

HOME := EnvGet("USERPROFILE")

#InputLevel 1
PrintScreen:: {
    Run HOME "\.bin\rapture\rapture.exe", HOME "\.config\rapture"
    return
}

sc07B:: IME_SET(0) ; IME無効化
sc079:: IME_SET(1) ; IME有効化
