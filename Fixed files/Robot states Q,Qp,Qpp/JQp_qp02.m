% This file compute the term JQp*qp (31x1) which is used to calculate "qpp" from Qpp = JQ*qpp + JQp*qp, i.e. 
% qpp = inv(JQ)[Qpp - JQp*qpp]
function JQpqp = JQp_qp02(robot,JQ)  
%Computation of the derivative of jacobian of f function with respect time
% In here, computation is based on "VelPartialAccCoMs_Frames.m" and NOT in Symoro =)
% q = robot.q;
qp = robot.qD;

JQpqp = zeros(robot.joints,1);
% Obtenemos las Jp*qp de los centros de masa y de los marcos
%[~, ~, JpCoMqp, ~, Jpi_qp] = VelPartialAccCoMs_Frames(robot);
 [~, ~, JpCoMqp, ~, Jpi_qp] = VelAceCoMs_Frames(robot,zeros(22,1));% Podemos utilizar tambien ésta función usando qpp = 0 =)

H7 = Jpi_qp{7};    % [^0PartialVP_7; ^0PartialWP_7] = [^0Jp_7,v*qp; ^0Jp_7,w*qp]
H12 = Jpi_qp{12};  % [^0PartialVP_12; ^0PartialWP_12] = [^0Jp_12,v*qp; ^0Jp_12,w*qp]
H14 = Jpi_qp{14};  % [^0PartialVP_14; ^0PartialWP_14] = [^0Jp_14,v*qp; ^0Jp_14,w*qp]

%% Foot 
JQpqp(1:3)= [H12(1:2);H14(3)]; % [H12(1,2);H14(3)] = J_foot,v*qp

%% Foot yaw,pitch,roll
Foot = robot.T(:,:,14)*robot.foot_f;
phi = atan2(Foot(2,1),Foot(1,1));
theta = atan2(-Foot(3,1),cos(phi)*Foot(1,1)+sin(phi)*Foot(2,1));
thetap = JQ(6,:)*qp;
phip = JQ(7,:)*qp;
Omega = OmeRPY(phi,theta);
OmegaDot = OmeDotRPY(phi,theta,phip,thetap);
% Recalling that, as we just computing JQp*qp the first term i.e. JQ*qpp is computed outside
% Note that "JQ(5:7,:) = Omega*Jfoot,w"... and for the second term (first term here) we want: "OmegaDot*J_foot,w *qp"
term2 = OmegaDot*inv(Omega)*JQ(5:7,:)*qp;  % OmegaDot*J_foot,w *qp
term3 = Omega*H14(4:6);                    % Omega*Jp_foot,w *qp     
JQpqp(4:6) = term2 + term3; 


%% Hips yaw,pitch,roll (lower Torso)
JHips = hipsJacobian(robot);
Hips = robot.T(:,:,7)*robot.torso_f; % Since frame 7 in zero potition (i.e. q=0 ) has a diferent orientation as frame 0. 
                    % It must be oriented as frame 0, so that the pitch yaw and roll angles have the same meaning for the
                    % torso and for the foot.                    
phi=atan2(Hips(2,1),Hips(1,1));
theta=atan2(-Hips(3,1),cos(phi)*Hips(1,1)+sin(phi)*Hips(2,1));
thetap = JQ(9,:)*qp;
phip = JQ(10,:)*qp;
Omega = OmeRPY(phi,theta);
OmegaDot = OmeDotRPY(phi,theta,phip,thetap);
% Recalling that, as we just computing JQp*qp the first term i.e. JQ*qpp is computed outside
% Note that "JQ(8:10,:) = Omega*Jtorso,w"... and for the second term (first term here) we want: "OmegaDot*J_torso,w *qp"
% term2 = OmegaDot*inv(Omega)*JQ(8:10,:)*qp;  % OmegaDot*J_torso,w *qp
term2 = OmegaDot*inv(Omega)*JHips*qp;  % OmegaDot*J_torso,w *qp
term3 = Omega*H7(4:6);                      % Omega*Jp_torso,w *qp     
JQpqp(8:10) = term2 + term3; 
JQpqp(10) = 0;
% Finally we introduce the two las elements that will help to compute "xpp" and "ypp"... 
% JQpqp(30)= JCoMp(1,:)*qp; % The row corresponding to xpp of the CoM
% JQpqp(31)= JCoMp(2,:)*qp; % The row corresponding to ypp of the CoM
JQpqp(20)= JpCoMqp(1); % The row corresponding to xpp of the CoM
JQpqp(21)= JpCoMqp(2); % The row corresponding to ypp of the CoM

end

