function meanPond[var] = (val, coef)

    nb = length(val)
    
    var = 0
    
    val = val.'
    
    for n = 1:nb 
        add = val(n) * coef(n)
        
        var = var + add
    end

end