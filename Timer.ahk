; Script     Timer.ahk
; License:   MIT License
; Author:    Bence Markiel (bceenaeiklmr)
; Github:    https://github.com/bceenaeiklmr/Timer
; Date       28.01.2023
; Version    0.1

#Requires AutoHotkey >=2.0
#Warn

/*
    Add()     Records a qpc timestamp ; you can add a name: Add('Name')
    Reset()   Resets the counter      ; same as calling Timer
    Result()  Returns the test result as string
    Show()    Displays the result in a msgbox
*/
class Timer {

    static Freq := 0, Counter := 0

    static __New() {
        if !this.Freq {
            DllCall("QueryPerformanceFrequency", "Int64*", &Freq := 0)
            this.Freq := Freq
        }
        this.Reset()
    }

    static Add(Name := "") {
        DllCall("QueryPerformanceCounter", "Int64*", &QPC := 0)
        this.Counter.Push([QPC, Name])
    }

    static Reset() {
        DllCall("QueryPerformanceCounter", "Int64*", &QPC := 0)
        this.Counter := Array([QPC, ""])
    }

    static Show() => MsgBox(this.Result(), "Result") 

    static Result() {

        this.Min := this.Counter[2][1] - this.Counter[1][1],
        this.Max := 0,
        this.Total := 0,
        Out := ""

        for v in this.Counter {
            if (A_index !== 1) {
                Recent := this.Counter[A_Index][1],
                Previous := this.Counter[A_Index - 1][1],
                this.Total += Dur := (Recent - Previous) / this.Freq * 1000,
                (Dur < this.Min) ? this.Min := Dur : "",
                (Dur > this.Max) ? this.Max := Dur : "",
                Name := (v[2] ? v[2] " " : ""),
                Out .= Name "`t" Format("{:.2f}", Dur) " ms" "`n"
            }
        }

        Out := "tot`t" Format("{:.2f}", this.Total) " ms`n"
             . "avg`t" Format("{:.2f}", this.Total / (this.Counter.Length - 1)) " ms `n"
             . "min`t" Format("{:.2f}", this.Min) " ms`n"
             . "max`t" Format("{:.2f}", this.Max) " ms`n"
             . "fps`t" Format("{:.2f}", (1000 / this.Total * (this.Counter.Length - 1))) "`n"
             . "n`t" this.Counter.Length - 1 "`n`n" Out

        return SubStr(Out, 1, -1)
    }
}
