function [qfpp, JPhi, JPhipPhip, NE1, NE2, NE3, qfp] = Desired_qfpp_HZDtimeCAMTestV2(xRef,ZMPd,CAMd,robot_i,X,gait_param_i,t)

% Este programa utiliza parte del código de los siguientes programas:
% - joints_Plus03.m - > para el cálculo de "JPhi = JQ^{-1}Jd" y "gf = Jdp*qpf - JQp*qp"

ZMPd_x = ZMPd(1);
ZMPd_y = ZMPd(2);

global robot gait_parameters
robot = robot_i;
gait_parameters = gait_param_i;

% states
x = X(1);
y = X(2);
xp = X(13);
yp = X(14);

% =======================================================================
%   Cálculo de JPhi y JPhipPhi
% -----------------------------------------------------------------------
qf = X(1:12);
qfp = X(13:24);
[q,qD,JPhi,JQ,~] = JointsPosVel_from_CoMPosVel_HZDtime(qf,qfp,robot,gait_parameters,t);
robot = robot_move(robot,q);

robot.qD = qD; % Updating of the robot velocities since they will be used for the computing of several subsequent matrices
JQpqp = JQp_qp02(robot,JQ);

Case = 'acceleration';
% "Case", "gait_parameters", "qfp" and "t" are used inside "OptionDesiredTrajectory"
OptionDesiredTrajectory;
% ------------------------------
JdpPhip = [dt_dhd_Phi; 
          zeros(12,12+phiDim)]*Phip;
            
JPhipPhip = JQ\(JdpPhip - JQpqp);

% ====================================================================================
% Cálculo de pares y fuerza y momento de reacción para PARTE de la acceleración qpp.
% ------------------------------------------------------------------------------------
% Se toma en cuenta que
% qpp = Jf*qpp + gf = Jf(col1)*xpp + Jf(col2)*ypp  + gf.. entonces, se calculan las pares y fuerzas para
%  "Jf(col1) + gf", "Jf(col2)+ gf"  y "gf" de tal forma que podamos despejar y encontrar "qfpp"
% -----------------------------------------------------------------------
% Utilizando la OPCION III utilizada en "RomeoNewtonEuler02.m"  (Se usa el algoritmo de NE 3 VECES, -opción 2 en el reporte-)
% -----------------------------------------------------
term1 = JPhi(:,1) + JPhipPhip; %
term2 = JPhi(:,2) + JPhipPhip; %
term3 = JPhi(:,3) + JPhipPhip;
term4 = JPhi(:,4) + JPhipPhip;
term5 = JPhi(:,5) + JPhipPhip;
term6 = JPhi(:,6) + JPhipPhip;
term7 = JPhi(:,7) + JPhipPhip;
term8 = JPhi(:,8) + JPhipPhip;
term9 = JPhi(:,9) + JPhipPhip;
term10 = JPhi(:,10) + JPhipPhip;
term11 = JPhi(:,11) + JPhipPhip;
term12 = JPhi(:,12) + JPhipPhip;
term13 = JPhipPhip; %
[F1,M1,Tau1]= Newton_Euler(q,qD,term1);  % [F1 M1 Tau1]' = De*(Jf1 + gf) + He
[F2,M2,Tau2]= Newton_Euler(q,qD,term2);  % [F2 M2 Tau2]' = De*(Jf2 + gf) + He
[F3,M3,Tau3]= Newton_Euler(q,qD,term3);  % [F2 M2 Tau2]' = De*(Jf3 + gf) + He
[F4,M4,Tau4]= Newton_Euler(q,qD,term4);  % [F2 M2 Tau2]' = De*(Jf3 + gf) + He
[F5,M5,Tau5]= Newton_Euler(q,qD,term5);  % [F2 M2 Tau2]' = De*(Jf3 + gf) + He
[F6,M6,Tau6]= Newton_Euler(q,qD,term6);  % [F2 M2 Tau2]' = De*(Jf3 + gf) + He
[F7,M7,Tau7]= Newton_Euler(q,qD,term7);  % [F2 M2 Tau2]' = De*(Jf3 + gf) + He
[F8,M8,Tau8]= Newton_Euler(q,qD,term8);  % [F2 M2 Tau2]' = De*(Jf3 + gf) + He
[F9,M9,Tau9]= Newton_Euler(q,qD,term9);  % [F2 M2 Tau2]' = De*(Jf3 + gf) + He
[F10,M10,Tau10]= Newton_Euler(q,qD,term10);  % [F2 M2 Tau2]' = De*(Jf3 + gf) + He
[F11,M11,Tau11]= Newton_Euler(q,qD,term11);  % [F2 M2 Tau2]' = De*(Jf3 + gf) + He
[F12,M12,Tau12]= Newton_Euler(q,qD,term12);  % [F2 M2 Tau2]' = De*(Jf3 + gf) + He
[F13,M13,Tau13]= Newton_Euler(q,qD,term13);  % [F3 M3 Tau3]' = De*gf + He
% =================================================================================================
% Si quisiéramos encontrar la fuerza F momento M y pares Tau reales debido a q, qp y qpp, deberíamos utilizar qppf de tal
% forma que 
%  F = (F1-F3)*xpp + (F2-F3)*ypp + F3 ;  
%  M = (M1-M3)*xpp + (M2-M3)*ypp + M3 ;  
%  Tau = (Tau1-Tau3)*xpp +  (Tau2-Tau3)*ypp + Tau3;
% Sin embargo lo que queremos encontrar es la trayectoria de "qfpp" que hará que el ZMPd = ZMP.
% AHORA, usando F0a despejaremos "xpp" y "ypp" y luego lo compararemos con XDD
% ---------------------------------------------------------------------------
%  vect1 = [F1 - F3; M1 - M3; Tau1 - Tau3]; % Vector de 37 x 1
%  vect2 = [F2 - F3; M2 - M3; Tau2 - Tau3]; % Vector de 37 x 1
%  vect3 = [F3; M3; Tau3]; % Vector de 37 x 1
%  vect0 = [F; M; Tau]; % Estos son los pares y fuerzas completos obtenidos con NE(q,qp,qpp)
%  Jfe = [vect1 vect2]; % Matriz de 37 x 2
%  XDDn = inv(Jfe'*Jfe)*Jfe'*(vect0 - vect3); 

% =======================================================================
%   Cálculo de qfpp
% -----------------------------------------------------------------------
NE1 = [F1;M1;Tau1];
NE2 = [F2;M2;Tau2];
NE3 = [F3;M3;Tau3];
NE4 = [F4;M4;Tau4];
NE5 = [F5;M5;Tau5];
NE6 = [F6;M6;Tau6];
NE7 = [F7;M7;Tau7];
NE8 = [F8;M8;Tau8];
NE9 = [F9;M9;Tau9];
NE10 = [F10;M10;Tau10];
NE11 = [F11;M11;Tau11];
NE12 = [F12;M12;Tau12];
NE13 = [F13;M13;Tau13];
DeBar = [NE1-NE13, NE2-NE13, NE3-NE13, NE4-NE13, NE5-NE13,NE6-NE13,...
         NE7-NE13, NE8-NE13, NE9-NE13, NE10-NE13, NE11-NE13, NE12-NE13];
HeBar = NE13;
DrBar = [DeBar(5,:) + ZMPd_x*DeBar(3,:);
         DeBar(4,:) - ZMPd_y*DeBar(3,:)]; 
HrBar = [HeBar(5) + ZMPd_x*HeBar(3);
         HeBar(4) - ZMPd_y*HeBar(3)];     
Q = gait_parameters.Q;
Azmp = DrBar;
bzmp = -HrBar;
options = optimset('Display', 'off');
k = evaluateTref(robot.tRef,t);
% varThetaRef = varThetaPdControlZmpTerm(robot,xRef,[robot.Zref(1,k);robot.Zref(2,k)]);
varThetaRef = varThetaPdControlZmpTerm2(robot,xRef,[robot.Zref(1,k);robot.Zref(2,k)],ZMPd);
p = -varThetaRef'*Q;
%
z = gait_parameters.z_i;
Acam = [DeBar(4,:)-y*DeBar(3,:)+DeBar(2,:)*z;
      DeBar(5,:)+x*DeBar(3,:)-DeBar(1,:)*z];
bcam = [HeBar(4)-y*HeBar(3)+z*HeBar(2)-CAMd(1);
       HeBar(5)+x*HeBar(3)-z*HeBar(1)-CAMd(2)];
%
A = [Azmp;Acam];
b = [bzmp;-bcam];
qfpp = quadprog(Q,[],[],[],A,b,[],[],[],options); 
% if t==0
%     qfpp(1) = qfpp(1) - 10;
% end
