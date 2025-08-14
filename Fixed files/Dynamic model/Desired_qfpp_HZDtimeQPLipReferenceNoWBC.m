function [qfpp, JPhi, JPhipPhip, NE1, NE2, NE3, qfp] = Desired_qfpp_HZDtimeQPLipReferenceNoWBC(xRef,ZMPd,robot_i,X,gait_param_i,t)

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
xp = X(3);
yp = X(4);
CAMxf = X(5);
CAMyf = X(6);

% =======================================================================
%   Cálculo de JPhi y JPhipPhi
% -----------------------------------------------------------------------
qf = X(1:2);
qfp = X(3:4);
[q,qD,JPhi,JQ,~] = JointsPosVel_from_CoMPosVel_HZDtimeNoWBC(qf,qfp,robot,gait_parameters,t);
robot = robot_move(robot,q);

robot.qD = qD; % Updating of the robot velocities since they will be used for the computing of several subsequent matrices
JQpqp = JQp_qp02NoWBC(robot,JQ);

Case = 'acceleration';
% "Case", "gait_parameters", "qfp" and "t" are used inside "OptionDesiredTrajectory"
OptionDesiredTrajectoryNoWBC();
% ------------------------------
JdpPhip = [dt_dhd_Phi; 
          zeros(2,2+phiDim)]*Phip;
            
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
term3 = JPhipPhip; %
[F1,M1,Tau1]= Newton_Euler(q,qD,term1);  % [F1 M1 Tau1]' = De*(Jf1 + gf) + He
[F2,M2,Tau2]= Newton_Euler(q,qD,term2);  % [F2 M2 Tau2]' = De*(Jf2 + gf) + He
[F3,M3,Tau3]= Newton_Euler(q,qD,term3);  % [F2 M2 Tau2]' = De*(Jf3 + gf) + He
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

DeBar = [NE1-NE3, NE2-NE3];
HeBar = NE3;
% m = 4.9347;
% Fz = polyval(gait_parameters.FzCoeff,t);
% Matriz 3x3
DrBar = [DeBar(5,:) + ZMPd_x*DeBar(3,:);
         DeBar(4,:) - ZMPd_y*DeBar(3,:)]; 
% Vector3x1
HrBar = [HeBar(5) + ZMPd_x*HeBar(3);
         HeBar(4) - ZMPd_y*HeBar(3)];  
z = gait_parameters.z_i;
Acam = [DeBar(4,:)-y*DeBar(3,:)+DeBar(2,:)*z;
      DeBar(5,:)+x*DeBar(3,:)-DeBar(1,:)*z];
bcam = [HeBar(4)-y*HeBar(3)+z*HeBar(2);
       HeBar(5)+x*HeBar(3)-z*HeBar(1)];
%
qfpp = -DrBar\HrBar;
% if t==0.2
%     qfpp(1) = qfpp(1) + 32.5; %Perturbacion instantanea
% end
% if t>0.2&&t<0.3
%     qfpp(1) = qfpp(1) + 1.15; %Perturbacion constante
% end
% if t>0.2&&t<0.3
%     qfpp(1) = qfpp(1) + 1.35; %Perturbacion constante
% end
if t==0.2&&gait_parameters.boolDisturbance==1
    qfpp(1) = qfpp(1) + gait_parameters.magnitudeDisturbance;
end
CAMp = Acam*qfpp + bcam;
qfpp(3:4) = CAMp;
