# Timer

Introducing Timer - a precision time measurement class for AutoHotkey v2.

Timer offers a more accurate way to measure time units compared to AutoHotkey's built-in A_TickCount method.

### How to use it?

The following code:

```ahk
Timer ; or call Timer.Reset
Loop 3 {
    Sleep(A_index * 25)
    Timer.Add("test" A_index)
}
Timer.Show()
```

will display in a `MsgBox`

```
tot	150.15 ms
avg	50.05 ms 
min	24.17 ms
max	80.00 ms
fps	19.98
n	3

test1 	24.17 ms
test2 	45.98 ms
test3 	80.00 ms
```
