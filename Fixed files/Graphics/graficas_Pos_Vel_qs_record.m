function NumFig_nuevo = graficas_Pos_Vel_qs_record(t_record_Pos,t_record_Vel,q_record,qD_record,qDD_record,t,qt,qDt,qDDt,NumFig)
%
for i=1:size(t_record_Pos,1)
    if abs(q_record(i,1) - q_record(i+1,1)) > 1e-02 %1e-03
        muestras=i;
        break
    end
end
t_delay_Pos = t_record_Pos(muestras);
%
for i=1:size(t_record_Vel,1)
    if abs(qD_record(i,1) - qD_record(i+1,1)) > 1e-01 %Tolerancias pueden cambiar 1e-01 para físico, 1e-03 para simulado
        muestras=i;
        break
    end
end
t_delay_Vel = t_record_Vel(muestras);
%
figure(NumFig)
title('Posiciones')
subplot(3,4,1)
plot(t_record_Pos,q_record(:,1),'LineWidth',0.5);
hold on
plot(t+t_delay_Pos,qt(1,:)*-1,'LineWidth',0.5); %Trayectoria introducida al robot
title('q1');
% %
subplot(3,4,2)
plot(t_record_Pos,q_record(:,2));
hold on
plot(t+t_delay_Pos,qt(2,:)*-1); %Trayectoria introducida al robot
title('q2');
%
subplot(3,4,3)
plot(t_record_Pos,q_record(:,3));
hold on
plot(t+t_delay_Pos,qt(3,:)*-1); %Trayectoria introducida al robot
title('q3');
%
subplot(3,4,4)
plot(t_record_Pos,q_record(:,4));
hold on
plot(t+t_delay_Pos,qt(4,:)*-1); %Trayectoria introducida al robot
title('q4');
%
subplot(3,4,5)
plot(t_record_Pos,q_record(:,5));
hold on
plot(t+t_delay_Pos,qt(5,:)*-1); %Trayectoria introducida al robot
title('q5');
%
subplot(3,4,6)
plot(t_record_Pos,q_record(:,6));
hold on
plot(t+t_delay_Pos,qt(6,:)*-1); %Trayectoria introducida al robot
title('q6');
%
subplot(3,4,7)
plot(t_record_Pos,q_record(:,7));
hold on
plot(t+t_delay_Pos,qt(7,:)); %Trayectoria introducida al robot
title('q7');
%
subplot(3,4,8)
plot(t_record_Pos,q_record(:,8));
hold on
plot(t+t_delay_Pos,qt(8,:)); %Trayectoria introducida al robot
title('q8');
%
subplot(3,4,9)
plot(t_record_Pos,q_record(:,9));
hold on
plot(t+t_delay_Pos,qt(9,:)); %Trayectoria introducida al robot
title('q9');
%
subplot(3,4,10)
plot(t_record_Pos,q_record(:,10));
hold on
plot(t+t_delay_Pos,qt(10,:)); %Trayectoria introducida al robot
title('q10');
%
subplot(3,4,11)
plot(t_record_Pos,q_record(:,11));
hold on
plot(t+t_delay_Pos,qt(11,:)); %Trayectoria introducida al robot
title('q11');
%
subplot(3,4,12)
plot(t_record_Pos,q_record(:,12));
hold on
plot(t+t_delay_Pos,qt(12,:)); %Trayectoria introducida al robot
title('q12');
%
figure(NumFig+1)
title('Posiciones')
subplot(3,4,1)
plot(t_record_Pos,q_record(:,13));
hold on
plot(t+t_delay_Pos,qt(13,:)); %Trayectoria introducida al robot
title('q13');
%
subplot(3,4,2)
plot(t_record_Pos,q_record(:,14));
hold on
plot(t+t_delay_Pos,qt(14,:)); %Trayectoria introducida al robot
title('q14');
%
subplot(3,4,3)
plot(t_record_Pos,q_record(:,15));
hold on
plot(t+t_delay_Pos,qt(15,:)); %Trayectoria introducida al robot
title('q15');
%
subplot(3,4,4)
plot(t_record_Pos,q_record(:,16));
hold on
plot(t+t_delay_Pos,qt(16,:)); %Trayectoria introducida al robot
title('q16');
%
subplot(3,4,5)
plot(t_record_Pos,q_record(:,17));
hold on
plot(t+t_delay_Pos,qt(17,:)); %Trayectoria introducida al robot
title('q17');
%
subplot(3,4,6)
plot(t_record_Pos,q_record(:,18));
hold on
plot(t+t_delay_Pos,qt(18,:)); %Trayectoria introducida al robot
title('q18');
%
subplot(3,4,7)
plot(t_record_Pos,q_record(:,19));
hold on
plot(t+t_delay_Pos,qt(19,:)); %Trayectoria introducida al robot
title('q19');
%
subplot(3,4,8)
plot(t_record_Pos,q_record(:,20));
hold on
plot(t+t_delay_Pos,qt(20,:)); %Trayectoria introducida al robot
title('q20');
%
subplot(3,4,9)
plot(t_record_Pos,q_record(:,21));
hold on
plot(t+t_delay_Pos,qt(21,:)); %Trayectoria introducida al robot
title('q21');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Velocidades
figure(NumFig+2)
title('Velocidades')
subplot(3,4,1)
plot(t_record_Vel,qD_record(:,1));
hold on
plot(t+t_delay_Vel,qDt(1,:)*-1); %Trayectoria introducida al robot
title('qp1');
% %
subplot(3,4,2)
plot(t_record_Vel,qD_record(:,2));
hold on
plot(t+t_delay_Vel,qDt(2,:)*-1); %Trayectoria introducida al robot
title('qp2');
%
subplot(3,4,3)
plot(t_record_Vel,qD_record(:,3));
hold on
plot(t+t_delay_Vel,qDt(3,:)*-1); %Trayectoria introducida al robot
title('qp3');
%
subplot(3,4,4)
plot(t_record_Vel,qD_record(:,4));
hold on
plot(t+t_delay_Vel,qDt(4,:)*-1); %Trayectoria introducida al robot
title('qp4');
%
subplot(3,4,5)
plot(t_record_Vel,qD_record(:,5));
hold on
plot(t+t_delay_Vel,qDt(5,:)*-1); %Trayectoria introducida al robot
title('qp5');
%
subplot(3,4,6)
plot(t_record_Vel,qD_record(:,6));
hold on
plot(t+t_delay_Vel,qDt(6,:)*-1); %Trayectoria introducida al robot
title('qp6');
%
subplot(3,4,7)
plot(t_record_Vel,qD_record(:,7));
hold on
plot(t+t_delay_Vel,qDt(7,:)); %Trayectoria introducida al robot
title('qp7');
%
subplot(3,4,8)
plot(t_record_Vel,qD_record(:,8));
hold on
plot(t+t_delay_Vel,qDt(8,:)); %Trayectoria introducida al robot
title('qp8');
%
subplot(3,4,9)
plot(t_record_Vel,qD_record(:,9));
hold on
plot(t+t_delay_Vel,qDt(9,:)); %Trayectoria introducida al robot
title('qp9');
%
subplot(3,4,10)
plot(t_record_Vel,qD_record(:,10));
hold on
plot(t+t_delay_Vel,qDt(10,:)); %Trayectoria introducida al robot
title('qp10');
%
subplot(3,4,11)
plot(t_record_Vel,qD_record(:,11));
hold on
plot(t+t_delay_Vel,qDt(11,:)); %Trayectoria introducida al robot
title('qp11');
%
subplot(3,4,12)
plot(t_record_Vel,qD_record(:,12));
hold on
plot(t+t_delay_Vel,qDt(12,:)); %Trayectoria introducida al robot
title('qp12');
%
figure(NumFig+3)
title('Velocidades')
subplot(3,4,1)
plot(t_record_Vel,qD_record(:,13));
hold on
plot(t+t_delay_Vel,qDt(13,:)); %Trayectoria introducida al robot
title('qp13');
%
subplot(3,4,2)
plot(t_record_Vel,qD_record(:,14));
hold on
plot(t+t_delay_Vel,qDt(14,:)); %Trayectoria introducida al robot
title('qp14');
%
subplot(3,4,3)
plot(t_record_Vel,qD_record(:,15));
hold on
plot(t+t_delay_Vel,qDt(15,:)); %Trayectoria introducida al robot
title('qp15');
%
subplot(3,4,4)
plot(t_record_Vel,qD_record(:,16));
hold on
plot(t+t_delay_Vel,qDt(16,:)); %Trayectoria introducida al robot
title('qp16');
%
subplot(3,4,5)
plot(t_record_Vel,qD_record(:,17));
hold on
plot(t+t_delay_Vel,qDt(17,:)); %Trayectoria introducida al robot
title('qp17');
%
subplot(3,4,6)
plot(t_record_Vel,qD_record(:,18));
hold on
plot(t+t_delay_Vel,qDt(18,:)); %Trayectoria introducida al robot
title('qp18');
%
subplot(3,4,7)
plot(t_record_Vel,qD_record(:,19));
hold on
plot(t+t_delay_Vel,qDt(19,:)); %Trayectoria introducida al robot
title('qp19');
%
subplot(3,4,8)
plot(t_record_Vel,qD_record(:,20));
hold on
plot(t+t_delay_Vel,qDt(20,:)); %Trayectoria introducida al robot
title('qp20');
%
subplot(3,4,9)
plot(t_record_Vel,qD_record(:,21));
hold on
plot(t+t_delay_Vel,qDt(21,:)); %Trayectoria introducida al robot
title('qp21');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Aceleraciones
figure(NumFig+4)
title('Aceleraciones')
subplot(3,4,1)
plot(t_record_Vel,qDD_record(1,:));
hold on
plot(t+t_delay_Vel,qDDt(1,:)*-1); %Trayectoria introducida al robot
title('qpp1');
% %
subplot(3,4,2)
plot(t_record_Vel,qDD_record(2,:));
hold on
plot(t+t_delay_Vel,qDDt(2,:)*-1); %Trayectoria introducida al robot
title('qpp2');
%
subplot(3,4,3)
plot(t_record_Vel,qDD_record(3,:));
hold on
plot(t+t_delay_Vel,qDDt(3,:)*-1); %Trayectoria introducida al robot
title('qpp3');
%
subplot(3,4,4)
plot(t_record_Vel,qDD_record(4,:));
hold on
plot(t+t_delay_Vel,qDDt(4,:)*-1); %Trayectoria introducida al robot
title('qpp4');
%
subplot(3,4,5)
plot(t_record_Vel,qDD_record(5,:));
hold on
plot(t+t_delay_Vel,qDDt(5,:)*-1); %Trayectoria introducida al robot
title('qpp5');
%
subplot(3,4,6)
plot(t_record_Vel,qDD_record(6,:));
hold on
plot(t+t_delay_Vel,qDDt(6,:)*-1); %Trayectoria introducida al robot
title('qpp6');
%
subplot(3,4,7)
plot(t_record_Vel,qDD_record(7,:));
hold on
plot(t+t_delay_Vel,qDDt(7,:)); %Trayectoria introducida al robot
title('qpp7');
%
subplot(3,4,8)
plot(t_record_Vel,qDD_record(8,:));
hold on
plot(t+t_delay_Vel,qDDt(8,:)); %Trayectoria introducida al robot
title('qpp8');
%
subplot(3,4,9)
plot(t_record_Vel,qDD_record(9,:));
hold on
plot(t+t_delay_Vel,qDDt(9,:)); %Trayectoria introducida al robot
title('qpp9');
%
subplot(3,4,10)
plot(t_record_Vel,qDD_record(10,:));
hold on
plot(t+t_delay_Vel,qDDt(10,:)); %Trayectoria introducida al robot
title('qpp10');
%
subplot(3,4,11)
plot(t_record_Vel,qDD_record(11,:));
hold on
plot(t+t_delay_Vel,qDDt(11,:)); %Trayectoria introducida al robot
title('qpp11');
%
subplot(3,4,12)
plot(t_record_Vel,qDD_record(12,:));
hold on
plot(t+t_delay_Vel,qDDt(12,:)); %Trayectoria introducida al robot
title('qpp12');
%
figure(NumFig+5)
title('Aceleraciones')
subplot(3,4,1)
plot(t_record_Vel,qDD_record(13,:));
hold on
plot(t+t_delay_Vel,qDDt(13,:)); %Trayectoria introducida al robot
title('qpp13');
%
subplot(3,4,2)
plot(t_record_Vel,qDD_record(14,:));
hold on
plot(t+t_delay_Vel,qDDt(14,:)); %Trayectoria introducida al robot
title('qp14');
%
subplot(3,4,3)
plot(t_record_Vel,qDD_record(15,:));
hold on
plot(t+t_delay_Vel,qDDt(15,:)); %Trayectoria introducida al robot
title('qpp15');
%
subplot(3,4,4)
plot(t_record_Vel,qDD_record(16,:));
hold on
plot(t+t_delay_Vel,qDDt(16,:)); %Trayectoria introducida al robot
title('qpp16');
%
subplot(3,4,5)
plot(t_record_Vel,qDD_record(17,:));
hold on
plot(t+t_delay_Vel,qDDt(17,:)); %Trayectoria introducida al robot
title('qpp17');
%
subplot(3,4,6)
plot(t_record_Vel,qDD_record(18,:));
hold on
plot(t+t_delay_Vel,qDDt(18,:)); %Trayectoria introducida al robot
title('qpp18');
%
subplot(3,4,7)
plot(t_record_Vel,qDD_record(19,:));
hold on
plot(t+t_delay_Vel,qDDt(19,:)); %Trayectoria introducida al robot
title('qpp19');
%
subplot(3,4,8)
plot(t_record_Vel,qDD_record(20,:));
hold on
plot(t+t_delay_Vel,qDDt(20,:)); %Trayectoria introducida al robot
title('qpp20');
%
subplot(3,4,9)
plot(t_record_Vel,qDD_record(21,:));
hold on
plot(t+t_delay_Vel,qDDt(21,:)); %Trayectoria introducida al robot
title('qpp21');
%
NumFig_nuevo = NumFig+6;