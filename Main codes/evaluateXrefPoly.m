function [XrefEval,ZMPEval,k] = evaluateXrefPoly(Xref,ZMPref,tref,t)
    for i=1:length(tref)
        if (tref(i)==t)
            XrefEval(1) = Xref(3,i);
            XrefEval(2) = Xref(6,i);
            ZMPEval(1) = ZMPref(1,i);
            ZMPEval(2) = ZMPref(2,i);
            k = i;
            break
        else
            if (tref(i)<t && tref(i+1)>t)
                Pos = [tref(i) Xref(3,i);
                       tref(i+1) Xref(3,i+1)];
                polXpp = findPolyCoeff(Pos,[],[]);
                XrefEval(1) = polyval(polXpp,t);
                Pos = [tref(i) Xref(6,i);
                       tref(i+1) Xref(6,i+1)];
                polYpp = findPolyCoeff(Pos,[],[]);
                XrefEval(2) = polyval(polYpp,t);
                Pos = [tref(i) ZMPref(1,i);
                       tref(i+1) ZMPref(1,i+1)];
                polZMPx = findPolyCoeff(Pos,[],[]);
                ZMPEval(1) = polyval(polZMPx,t);
                Pos = [tref(i) ZMPref(2,i);
                       tref(i+1) ZMPref(2,i+1)];
                polZMPy = findPolyCoeff(Pos,[],[]);
                ZMPEval(2) = polyval(polZMPy,t);
                k = i;
                break
            end
        end
    end
end