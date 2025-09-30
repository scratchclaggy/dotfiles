function files -d "Open files or directories in the system's default file manager"
    set target $argv
    if test (count $target) -eq 0
        set target .
    end
    
    if test (uname) = "Darwin"
        open $target
    else if test (uname) = "Linux"; and not test -d /mnt/c
        xdg-open $target
    else
        /mnt/c/Windows/explorer.exe $target
    end
end
