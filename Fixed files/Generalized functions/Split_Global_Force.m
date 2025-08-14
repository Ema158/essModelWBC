function [F1,F2, ZMP1_DS,ZMP2_DS] = Split_Global_Force(ZMP1_d,ZMP2_d,F_DS,M_DS)
% Important: The objectif of the code is to split a global reaction force
% in double support into 2 forces with local ZMP in each foot.
% The global ZMP is calculate based on the global force and moment : ZMP_G
% The local ZMP is calculated based on the desired one ZMP1_d and ZMP2_d.
% The constraint is that the 3 ZMP are aligned.
% We chose that the pose along y of the local ZMP will be the desired one.
% Along x, the objectif is to minimize the error (ZMP1_d-ZMP1_DS)(1)^2 +(ZMP2_d-ZMP2_DS)(1)^2

% ZMP1_d -> Trajectory of the desired first local ZMP. Matriz 2 x m where m is the number of samples
% ZMP2_d -> Trajectory of the desired secon local ZMP. Matriz 2 x m where m is the number of samples
% F_DS -> Trajectory of the global reaction force. Matriz 3 x m where m is the number of samples
% M_DS -> Trajectory of the global reaction moment. Matriz 3 x m where m is the number of samples

% ZMP1_DS -> Trajectory of the first local ZMP. Matriz 2 x m where m is the number of samples
% ZMP2_DS -> Trajectory of the second local ZMP. Matriz 2 x m where m is the number of samples

ZMP_points=2; % this programm may be extented to a case with more local points
samples = size(F_DS,2);

% Global ZMP
zmpGx = -M_DS(2,:)./F_DS(3,:);
zmpGy = M_DS(1,:)./F_DS(3,:);

%One condition to be able to decompose the reaction force is that the
%global and the 2 local ZMP be aligned.
% on consider the value in local ZMP along y as desired value.
ZMP1_DS(2,:)=ZMP1_d(2,:);
ZMP2_DS(2,:)=ZMP2_d(2,:);
% the local ZMP along
% x are rely by the following relation :
% ZMP1_DS(1,:)= A*ZMP2_DS(1,:)+(1-A)*zmpGx
% with A=(ZMP1_DS(2,i)-zmpGy(i))/(ZMP2_DS(2,i)-zmpGy(i));

for i=1:samples
    A=(ZMP1_DS(2,i)-zmpGy(i))/(ZMP2_DS(2,i)-zmpGy(i));
    % We want to minimize C=(ZMP1_DS(1,:)-ZMP1_d(1,:))^2 +(ZMP2_DS(1,:)-ZMP2_d(1,:))^2
    % replacing the expression of ZMP1_DS(1,:) as function of ZMP2_DS(1,:), we
    % obtain C=(A*ZMP2_DS(1,:)+(1-A)*zmpGx-ZMP1_d(1,:))^2 +(ZMP2_DS(1,:)-ZMP2_d(1,:))^2
    % and the derivative of this expression with respect to ZMP2_DS(1,:) is
    % zero.
    if abs(ZMP1_DS(2,i)-zmpGy(i))<abs(ZMP2_DS(2,i)-zmpGy(i)) %in other case we use the inverse formua in order to avoid to divide by 0
        ZMP2_DS(1,i)= -(A*(1-A)*zmpGx(i)-A*ZMP1_d(1,i)-ZMP2_d(1,i))/(A*A+1);
        ZMP1_DS(1,i)= A*ZMP2_DS(1,i)+(1-A)*zmpGx(i);
    else
        B=(ZMP2_DS(2,i)-zmpGy(i))./(ZMP1_DS(2,i)-zmpGy(i));
        ZMP1_DS(1,i)= -(B*(1-B)*zmpGx(i)-B*ZMP2_d(1,i)-ZMP1_d(1,i))/(B*B+1);
        ZMP2_DS(1,i)= B*ZMP1_DS(1,i)+(1-B)*zmpGx(i);
    end
end
% Thus the pose on the two effective local ZMP is determined
% we compare the desired and effective value
% varX1=ZMP1_DS-ZMP1_d
% varX2=ZMP2_DS-ZMP2_d
% figure
% plot(ZMP1_DS(1,:),ZMP1_DS(2,:), 'r', ZMP1_d(1,:),ZMP1_d(2,:),'b')
% figure
% plot(ZMP2_DS(1,:),ZMP2_DS(2,:), 'r', ZMP2_d(1,:),ZMP2_d(2,:),'b')
% pause

% Global reaction force
Fx = F_DS(1,:);
Fy = F_DS(2,:);
Fz = F_DS(3,:);

% Global reaction moment w.r.t. frame 0
Mx = M_DS(1,:);
My = M_DS(2,:);
Mz = M_DS(3,:);

local_Fx = zeros(ZMP_points,samples);
local_Fy = zeros(ZMP_points,samples);
local_Fz = zeros(ZMP_points,samples);
fricCondition = zeros(1,samples);
for i = 1:samples
    % The reaction force in Z direction is splited according to the desired position of the ZMP in the local points and
    % the global ZMP position. Using the equilibrium equation: "M0 = ZMP x F0" and "M0 =  ZMP1 x F1 +  ZMP2 x F2 + ... +   ZMPn x Fn"
    % Therefore ZMP x F0 = ZMP1 x F1 + ZMP2 x F2  + ... +   ZMPn x Fn -> By taking the first two equations, we have "n" unknowns (Fz1, Fz2, ... , Fzn) and we solve...
    % HOWEVER in that GENERAL case it will result in a "2 x n" matrix which is not invertible, therefore in the next we
    % will consider split just into 2 forces!
    FzSplit = inv([ZMP1_DS(2,i) ZMP2_DS(2,i); ZMP1_DS(1,i) ZMP2_DS(1,i)])*[zmpGy(i)*Fz(i); zmpGx(i)*Fz(i)];
    %FzSplit = inv([ZMP1_DS(2,i) ZMP2_DS(2,i); 1 1])*[zmpGy(i)*Fz(i); Fz(i)];
    %err=FzSplit1-FzSplit
    %pause
    for j=1:ZMP_points  %split in "n" local forces
        local_Fz(j,i) = FzSplit(j);
    end
    
    % According to the friction condition, i.e. Fx^2 + Fy^2 < mu^2 Fz^2, we impose a SIMPLE relation between
    % "Fx and Fz" and "Fy and Fz" we said "Fx*alpha_x = Fz" and "Fy*alpha_y = Fz", therefore this relation can satisfied
    % the friction condition if alpha_x^2 + alpha_y^2 < mu^2
    % We're gonna keep this relation for each foot, i.e. "Fx/Fz = Fx1/Fz1 = Fx2/Fz2" and "Fy/Fz = Fy1/Fz1 = Fy2/Fz2"
    % Thus, we compute the relation with the global values we know
    alpha_x = Fx(i)/Fz(i);
    alpha_y = Fy(i)/Fz(i);
    
    % we use this relation to compute the reaction force in X direction for X and Y
    for j=1:ZMP_points  %split in "n" local forces
        local_Fx(j,i) = alpha_x * local_Fz(j,i);
        local_Fy(j,i) = alpha_y * local_Fz(j,i);
    end
    
    % Slipping condition
    mu =0.7;
    fricCondition(i) = sqrt(alpha_x^2 + alpha_y^2);
    if fricCondition(i)>mu
        disp('Possible slipping!');
    end
end

% Finally, we get the split reaction forces:

F1= [local_Fx(1,:);local_Fy(1,:);local_Fz(1,:)] ;
F2= [local_Fx(2,:);local_Fy(2,:);local_Fz(2,:)] ;

% Finally, we get the split reaction forces:
%for j=1:ZMP_points  %split in "n" local forces
%    Local_forces.(['F', int2str(j)]) = [local_Fx(j,:);local_Fy(j,:);local_Fz(j,:)] ;
%end
