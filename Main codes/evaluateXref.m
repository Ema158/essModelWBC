function [XrefEval,ZMPEval] = evaluateXref(Xref,ZMPref,tref,t)
    for i=1:length(tref)
        if abs(tref(i)-t)<1e-06
            XrefEval(1) = Xref(3,i);
            XrefEval(2) = Xref(6,i);
            ZMPEval(1) = ZMPref(1,i);
            ZMPEval(2) = ZMPref(2,i);
        end
    end
end