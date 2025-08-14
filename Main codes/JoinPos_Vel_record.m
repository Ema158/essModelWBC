close all
clc
clear
%
% DataName = 'Param00_StartingPhase_WalkingPhase_SS_DS';
DataName = 'Param01_StartingPhase_WalkingPhase_SS_DS';
load(DataName); 
% -----------------------------------------------
Solution = InfNAO.Solution;
qt = Solution.JointPos; % Cell array of solution q(t) for each step
qDt = Solution.JointVel; % Cell array of solution qp(t) for each step
t = Solution.t;
%
PosVel=true;
 [q_record,qD_record,FSR_record,t_record_Pos,t_record_Vel,t_record_FSR] = TxtReading(PosVel);
% plot(t_record,q_record(:,19))
% hold on
% plot(t+0.32,qt(19,:))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Graficas de las posiciones
%
t_record = t_record_Pos;
for i=1:size(t_record,1)
    if abs(q_record(i,1) - q_record(i+1,1)) > 1e-03
        muestras=i;
        break
    end
end
t_delay = t_record(muestras);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
title('Posiciones')
subplot(3,4,1)
plot(t_record,q_record(:,1));
hold on
plot(t+t_delay,qt(1,:)*-1); %Trayectoria introducida al robot
title('q1');
% %
subplot(3,4,2)
plot(t_record,q_record(:,2));
hold on
plot(t+t_delay,qt(2,:)*-1); %Trayectoria introducida al robot
title('q2');
%
subplot(3,4,3)
plot(t_record,q_record(:,3));
hold on
plot(t+t_delay,qt(3,:)*-1); %Trayectoria introducida al robot
title('q3');
%
subplot(3,4,4)
plot(t_record,q_record(:,4));
hold on
plot(t+t_delay,qt(4,:)*-1); %Trayectoria introducida al robot
title('q4');
%
subplot(3,4,5)
plot(t_record,q_record(:,5));
hold on
plot(t+t_delay,qt(5,:)*-1); %Trayectoria introducida al robot
title('q5');
%
subplot(3,4,6)
plot(t_record,q_record(:,6));
hold on
plot(t+t_delay,qt(6,:)*-1); %Trayectoria introducida al robot
title('q6');
%
subplot(3,4,7)
plot(t_record,q_record(:,7));
hold on
plot(t+t_delay,qt(7,:)); %Trayectoria introducida al robot
title('q7');
%
subplot(3,4,8)
plot(t_record,q_record(:,8));
hold on
plot(t+t_delay,qt(8,:)); %Trayectoria introducida al robot
title('q8');
%
subplot(3,4,9)
plot(t_record,q_record(:,9));
hold on
plot(t+t_delay,qt(9,:)); %Trayectoria introducida al robot
title('q9');
%
subplot(3,4,10)
plot(t_record,q_record(:,10));
hold on
plot(t+t_delay,qt(10,:)); %Trayectoria introducida al robot
title('q10');
%
subplot(3,4,11)
plot(t_record,q_record(:,11));
hold on
plot(t+t_delay,qt(11,:)); %Trayectoria introducida al robot
title('q11');
%
subplot(3,4,12)
plot(t_record,q_record(:,12));
hold on
plot(t+t_delay,qt(12,:)); %Trayectoria introducida al robot
title('q12');
%
figure(4)
title('Posiciones')
subplot(3,4,1)
plot(t_record,q_record(:,13));
hold on
plot(t+t_delay,qt(13,:)); %Trayectoria introducida al robot
title('q13');
%
subplot(3,4,2)
plot(t_record,q_record(:,14));
hold on
plot(t+t_delay,qt(14,:)); %Trayectoria introducida al robot
title('q14');
%
subplot(3,4,3)
plot(t_record,q_record(:,15));
hold on
plot(t+t_delay,qt(15,:)); %Trayectoria introducida al robot
title('q15');
%
subplot(3,4,4)
plot(t_record,q_record(:,16));
hold on
plot(t+t_delay,qt(16,:)); %Trayectoria introducida al robot
title('q16');
%
subplot(3,4,5)
plot(t_record,q_record(:,17));
hold on
plot(t+t_delay,qt(17,:)); %Trayectoria introducida al robot
title('q17');
%
subplot(3,4,6)
plot(t_record,q_record(:,18));
hold on
plot(t+t_delay,qt(18,:)); %Trayectoria introducida al robot
title('q18');
%
subplot(3,4,7)
plot(t_record,q_record(:,19));
hold on
plot(t+t_delay,qt(19,:)); %Trayectoria introducida al robot
title('q19');
%
subplot(3,4,8)
plot(t_record,q_record(:,20));
hold on
plot(t+t_delay,qt(20,:)); %Trayectoria introducida al robot
title('q20');
%
subplot(3,4,9)
plot(t_record,q_record(:,21));
hold on
plot(t+t_delay,qt(21,:)); %Trayectoria introducida al robot
title('q21');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Velocidades
figure(5)
title('Velocidades')
subplot(3,4,1)
plot(t_record_Vel,qD_record(:,1));
hold on
plot(t+t_delay,qDt(1,:)*-1); %Trayectoria introducida al robot
title('qp1');
% %
subplot(3,4,2)
plot(t_record_Vel,qD_record(:,2));
hold on
plot(t+t_delay,qDt(2,:)*-1); %Trayectoria introducida al robot
title('qp2');
%
subplot(3,4,3)
plot(t_record_Vel,qD_record(:,3));
hold on
plot(t+t_delay,qDt(3,:)*-1); %Trayectoria introducida al robot
title('qp3');
%
subplot(3,4,4)
plot(t_record_Vel,qD_record(:,4));
hold on
plot(t+t_delay,qDt(4,:)*-1); %Trayectoria introducida al robot
title('qp4');
%
subplot(3,4,5)
plot(t_record_Vel,qD_record(:,5));
hold on
plot(t+t_delay,qDt(5,:)*-1); %Trayectoria introducida al robot
title('qp5');
%
subplot(3,4,6)
plot(t_record_Vel,qD_record(:,6));
hold on
plot(t+t_delay,qDt(6,:)*-1); %Trayectoria introducida al robot
title('qp6');
%
subplot(3,4,7)
plot(t_record_Vel,qD_record(:,7));
hold on
plot(t+t_delay,qDt(7,:)); %Trayectoria introducida al robot
title('qp7');
%
subplot(3,4,8)
plot(t_record_Vel,qD_record(:,8));
hold on
plot(t+t_delay,qDt(8,:)); %Trayectoria introducida al robot
title('qp8');
%
subplot(3,4,9)
plot(t_record_Vel,qD_record(:,9));
hold on
plot(t+t_delay,qDt(9,:)); %Trayectoria introducida al robot
title('qp9');
%
subplot(3,4,10)
plot(t_record_Vel,qD_record(:,10));
hold on
plot(t+t_delay,qDt(10,:)); %Trayectoria introducida al robot
title('qp10');
%
subplot(3,4,11)
plot(t_record_Vel,qD_record(:,11));
hold on
plot(t+t_delay,qDt(11,:)); %Trayectoria introducida al robot
title('qp11');
%
subplot(3,4,12)
plot(t_record_Vel,qD_record(:,12));
hold on
plot(t+t_delay,qDt(12,:)); %Trayectoria introducida al robot
title('qp12');
%
figure(6)
title('Velocidades')
subplot(3,4,1)
plot(t_record_Vel,qD_record(:,13));
hold on
plot(t+t_delay,qDt(13,:)); %Trayectoria introducida al robot
title('qp13');
%
subplot(3,4,2)
plot(t_record_Vel,qD_record(:,14));
hold on
plot(t+t_delay,qDt(14,:)); %Trayectoria introducida al robot
title('qp14');
%
subplot(3,4,3)
plot(t_record_Vel,qD_record(:,15));
hold on
plot(t+t_delay,qDt(15,:)); %Trayectoria introducida al robot
title('qp15');
%
subplot(3,4,4)
plot(t_record_Vel,qD_record(:,16));
hold on
plot(t+t_delay,qDt(16,:)); %Trayectoria introducida al robot
title('qp16');
%
subplot(3,4,5)
plot(t_record_Vel,qD_record(:,17));
hold on
plot(t+t_delay,qDt(17,:)); %Trayectoria introducida al robot
title('qp17');
%
subplot(3,4,6)
plot(t_record_Vel,qD_record(:,18));
hold on
plot(t+t_delay,qDt(18,:)); %Trayectoria introducida al robot
title('qp18');
%
subplot(3,4,7)
plot(t_record_Vel,qD_record(:,19));
hold on
plot(t+t_delay,qDt(19,:)); %Trayectoria introducida al robot
title('qp19');
%
subplot(3,4,8)
plot(t_record_Vel,qD_record(:,20));
hold on
plot(t+t_delay,qDt(20,:)); %Trayectoria introducida al robot
title('qp20');
%
subplot(3,4,9)
plot(t_record_Vel,qD_record(:,21));
hold on
plot(t+t_delay,qDt(21,:)); %Trayectoria introducida al robot
title('qp21');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FSR
figure(7)
plot(t_record_FSR,FSR_record(:,11))
