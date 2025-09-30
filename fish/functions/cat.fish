function cat
    if command -v bat > /dev/null
        bat $argv
    else
        command cat $argv
    end
end