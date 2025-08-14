function plotZMPConstraints(S,DeltaX,Nsteps)
    for i=1:Nsteps
        xPos1 = S*(i-1)+DeltaX;
        xPos2 = S*(i-1)-DeltaX;
        yPos1 = -0.02;
        yPos2 = 0.1;
        plot([xPos1 xPos1],[yPos1 yPos2],'r--')
%         plot([xPos2 xPos2],[yPos1 yPos2],'b--')
    end
end