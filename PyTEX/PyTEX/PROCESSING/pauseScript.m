function pauseScript(beginHours, beginMinutes, hours, minutes, seconds)

            c = clock;
            c = fix(c);
            
            if (c(4) == beginHours) & (c(5) > beginMinutes)
                8+1
                pause(60*60*hours + 60*minutes + seconds);
            end

            8+2
end