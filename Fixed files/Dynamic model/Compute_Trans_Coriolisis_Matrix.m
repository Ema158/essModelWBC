function Ct = Compute_Trans_Coriolisis_Matrix( robot )
%COMPUTE_CORIOLISIS_MATRIX Compute the coriolisis matrix of the dynamic model of the robot, first TWO collumns only
ant =       [0,... 1
             1,... 2
             2,... 3
             3,... 4
             4,... 5
             5,... 6
             6,... 7
             7,... 8
             8,... 9
             9,... 10
             10,...11
             11,...12
             12,...13
             13,...14
             7,... 15
             15,...16
             16,...17
             17,...18
             18,...19
             7,...20
             20,...21
             21,...22
             22,...23
             23,...24
              7,...25
             25,...%26
             26]; %27
act= [ 0,0,1,2,3,4,5,6,7,8,9,10,...
        11,12,0,13,14,15,16,0,17,18,19,...
        20,0,21,22,0];
qD=robot.qD;
Ct = zeros(2,robot.joints);

JDotw = zeros(3,2);   % Jacobian_omega time derivative
JDotw(:,1) = [0;0;0];
JDotw(:,2) = robot.crossM(:,:,2)*robot.T(1:3,3,3)*qD(1);  % (0a2 X 0a3)*qp1  % Donde iaj es el vector "a" de SNAP del marco "j" respecto al "i"
for k = 3:27
    if robot.PI.masse(k)~=0  % If the frame does not correspond to a link (it doesn't have attached a mass) nothing is done
        JDot = zeros(3,2);
        F = k;
        Jw = zeros(3,robot.joints);
        while F~=1
            Jw(:,act(F)) = robot.T(1:3,3,F); % Vector "0aF" is assigned. First "0a3 to Jw(:2)", then "0a2 to Jw(:1)"...
            F = ant(F);
        end
        for j = 1:2  
            F=k;
            JDot(:,j) = robot.crossM(:,:,2)*robot.J_CoMs(:,j,k)*qD(1); % (0a2 X .... )*qp1
            while F~=2
                JDot(:,j) = JDot(:,j)+robot.crossM(:,:,j+1)*robot.J_CoMs(:,act(F),k)*qD(act(F));
                F = ant(F);
            end;
        end
        
        Ct = Ct+robot.PI.masse(k)*JDot'*robot.J_CoMs(:,:,k);

        inter = robot.PI.CoM{k};
        Y = [inter(2)^2+inter(3)^2,-inter(1)*inter(2),-inter(1)*inter(3);
         -inter(1)*inter(2),inter(3)^2+inter(1)^2,-inter(2)*inter(3);
         -inter(1)*inter(3),-inter(2)*inter(3),inter(1)^2+inter(2)^2];
        R = robot.T(1:3,1:3,k);
        
        Ct = Ct+JDotw'*R*(robot.PI.I{k}-robot.PI.masse(k)*Y)*R'*Jw;
    end
end


