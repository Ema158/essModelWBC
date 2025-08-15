function qfpp = Desired_qfppDS(xRef,ZMPd,robot_i,X,gait_param_i,t)

% Este programa utiliza parte del código de los siguientes programas:
% - joints_Plus03.m - > para el cálculo de "JPhi = JQ^{-1}Jd" y "gf = Jdp*qpf - JQp*qp"

ZMPd_x = ZMPd(1);
ZMPd_y = ZMPd(2);

global robot gait_parameters FR
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
JQpqp = JQp_qp02Corrected(robot,JQ);

Case = 'acceleration';
% "Case", "gait_parameters", "qfp" and "t" are used inside "OptionDesiredTrajectory"
OptionDesiredTrajectory;
% ------------------------------
JdpPhip = [dt_dhd_Phi; 
          zeros(12,12+phiDim)]*Phip;
            
JPhipPhip = JQ\(JdpPhip - JQpqp);

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
Mtheta = [NE1-NE13, NE2-NE13, NE3-NE13, NE4-NE13, NE5-NE13,NE6-NE13,...
         NE7-NE13, NE8-NE13, NE9-NE13, NE10-NE13, NE11-NE13, NE12-NE13];
Ctheta = NE13;
J = freeFootBasicJacobian(robot);
T14_0 = inverseTransMatrix(robot.T(:,:,14)); 
X0_14 = VelocityMatrix(T14_0);
AF = zeros(30,18);
AF(:,1:12) = Mtheta;
AF(1:6,13:end) = -X0_14;
AF(7:end,13:end) = -J';
A1 = AF(1:6,:);
b1 = Ctheta(1:6);
Aess = [AF(5,:) + ZMPd_x*AF(3,:);
         AF(4,:) - ZMPd_y*AF(3,:)]; 
b_ess = [Ctheta(5) + ZMPd_x*Ctheta(3);
         Ctheta(4) - ZMPd_y*Ctheta(3)];   
%
Qx = gait_parameters.Q;
QF = gait_parameters.QF;
Q = zeros(12+6,12+6);
Q(1:12,1:12) = Qx;
Q(13:end,13:end) = QF;
Q = Q + (A1')*QF*A1;
options = optimset('Display', 'off');
k = evaluateTref(robot.tRef,t);
varThetaRef = varThetaPdControlZmpTerm2(robot,xRef,[robot.Zref(1,k);robot.Zref(2,k)],ZMPd);
p = [-varThetaRef'*Qx,zeros(1,6)];
p = p + (b1')*QF*A1;
x = quadprog(Q,p,[],[],Aess,-b_ess,[],[],[],options);
FR = x(13:end);
qfpp = x(1:12);

if abs(t-0.2)<1e-6&&gait_parameters.boolDisturbance==1 %Perturbacion en x
    qfpp(1) = qfpp(1) + gait_parameters.magnitudeDisturbance;
end

% if abs(t-0.05)<1e-6&&gait_parameters.boolDisturbance==1 %Perturbacion en y
%     qfpp(2) = qfpp(2) - gait_parameters.magnitudeDisturbance;
% end
end

function X = VelocityMatrix(T)
    X = zeros(6,6);
    R = T(1:3,1:3)';
    p = T(1:3,4);
    X(1:3,1:3) = R;
    X(4:6,1:3) = -R*cross_matrix(p);
    X(4:6,4:6) = R;
end

function Tinv = inverseTransMatrix(T)
    Tinv = zeros(4,4);
	Tinv(1:3,1:3) = T(1:3,1:3)'; 
    Tinv(1:3,4) = (-T(1:3,1:3)')*T(1:3,4);
    Tinv(4,4) = 1;
end
