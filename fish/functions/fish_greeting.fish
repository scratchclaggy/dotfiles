function fish_greeting
    # Get current hour (0-23)
    set current_hour (date +%H)
    
    # Convert to integer for comparison
    set current_hour (math $current_hour)
    
    if test $current_hour -lt 11
        echo "お早う！"
    else if test $current_hour -lt 13
        echo "やほー!"
    else
        echo "お疲れ!"
    end
end
