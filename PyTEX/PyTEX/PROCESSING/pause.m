function pauseScript(begin, hours, minutes)

            c = clock;
            c = fix(c);
            
            if c(4) == begin
                pause(60*60*hours + 60*minutes);
            end

end