function k = evaluateTref(tref,t)
    for i=1:length(tref)
        if (tref(i)==t)
            k = i;
            break
        else
            if (tref(i)<t && tref(i+1)>t)
                k = i;
                break
            end
        end
    end
end