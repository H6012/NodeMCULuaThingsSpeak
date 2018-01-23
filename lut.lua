local outs={-20    ,-10    ,0  ,10 ,20 ,25 ,30 ,40 ,50 ,60 ,70 }
local ins={96 , 177   , 259   , 355   , 460   , 512   , 567   , 668   , 753   , 820   , 871}


function thermistor(raw_val)
    local val = nil
 
    if raw_val < ins[1] then
        --print(10*outs[1])
        return 10*outs[1]
    end


    if raw_val >ins[#ins] then
        --print(10*outs[#outs])
        return 10*outs[#outs]
    end

    -- find a value in a list
    local found = nil
    for i=1,#ins do
      if raw_val <= ins[i] then
        found = i      -- save value of `i'
        break
      end
    end
    
    --interpolat based on array position

    val = 10*outs[found]+ 10*(raw_val - ins[found])*(outs[found]-outs[found+1])/(ins[found]-ins[found+1])
    


    --
    
   -- print(outs[found])
    --print(val)
    
    return val;
    
end


