#Requires AutoHotkey v2.0

NestList(n, c := "innermost") {
    list := []
    list.Push([])
    new_list := list[1]
    n -= 2
    if n {
        loop n {
            new_list.Push([])
            new_list := new_list[1]
        }
    }
    new_list.Push(c)
    return list
}