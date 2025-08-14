function [XrefEval,ZMPEval,k] = evaluateXrefPosVelAccPoly(Xref,ZMPref,tref,t)
    for i=1:length(tref)
        if (tref(i)==t)
            XrefEval(1) = Xref(1,i);
            XrefEval(2) = Xref(2,i);
            XrefEval(3) = Xref(3,i);
            XrefEval(4) = Xref(4,i);
            XrefEval(5) = Xref(5,i);
            XrefEval(6) = Xref(6,i);
            ZMPEval(1) = ZMPref(1,i);
            ZMPEval(2) = ZMPref(2,i);
            k = i;
            break
        else
            if (tref(i)<t && tref(i+1)>t)
                Pos = [tref(i) Xref(1,i);
                       tref(i+1) Xref(1,i+1)];
                polX = findPolyCoeff(Pos,[],[]);
                XrefEval(1) = polyval(polX,t);
                %
                Pos = [tref(i) Xref(2,i);
                       tref(i+1) Xref(2,i+1)];
                polXp = findPolyCoeff(Pos,[],[]);
                XrefEval(2) = polyval(polXp,t);
                %
                Pos = [tref(i) Xref(3,i);
                       tref(i+1) Xref(3,i+1)];
                polXpp = findPolyCoeff(Pos,[],[]);
                XrefEval(3) = polyval(polXpp,t);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
                Pos = [tref(i) Xref(4,i);
                       tref(i+1) Xref(4,i+1)];
                polY = findPolyCoeff(Pos,[],[]);
                XrefEval(4) = polyval(polY,t);
                %
                Pos = [tref(i) Xref(5,i);
                       tref(i+1) Xref(5,i+1)];
                polYp = findPolyCoeff(Pos,[],[]);
                XrefEval(5) = polyval(polYp,t);
                %
                Pos = [tref(i) Xref(6,i);
                       tref(i+1) Xref(6,i+1)];
                polYpp = findPolyCoeff(Pos,[],[]);
                XrefEval(6) = polyval(polYpp,t);
                %
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