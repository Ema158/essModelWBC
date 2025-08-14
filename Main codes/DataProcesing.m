clear all
close all
clc
% Data
% ====================================
% Color	Descripción
% y % amarillo
% m % magenta
% c % cian
% r % rojo
% g % verde
% b % azul
% w % blanco
% k % negro

load Param01_StartingPhase_WalkingPhase_SS_DS_repeat_nsteps

% Parameters
stime = 0.03;     % Sample time
tdelay = 0.0;     % time delay

t = InfNAO.Solution.t_record;
q1 = InfNAO.Solution.q_record(:,1);
q1p = InfNAO.Solution.qD_record(:,1);

% Sampling
[q1_s, index]= unique(q1,'stable');
t_s = t(index)+tdelay;

% Interpolating
t_i=t(1):stime:t(end);
q1_il=interp1(t_s,q1_s,t_i,'linear');
q1_is=interp1(t_s,q1_s,t_i,'spline');
q1_ipch=interp1(t_s,q1_s,t_i,'pchim');
q1_in=interp1(t_s,q1_s,t_i,'nex');
q1_ipr=interp1(t_s,q1_s,t_i,'pr');

% time derivative (velocity computation)
q1p_s = C_diff(q1_s',t_s);
q1p_il = C_diff(q1_il,t_i);
q1p_ipch = C_diff(q1_ipch,t_i);

% Second time derivative (acceleration computation)
q1pp = C_diff(q1p',t);
q1pp_s = C_diff(q1p_s,t_s);
q1pp_il = C_diff(q1p_il,t_i);
q1pp_ipch = C_diff(q1p_ipch,t_i);


% Plotting
% ====================
figure (1)
% ---------------------
plot(t,q1,'k')
title('Position')
hold on
plot(t_s,q1_s,'b')
plot(t_i,q1_il,'r')
% plot(t_i,q1_is,'c')
plot(t_i,q1_ipch,'g')
% plot(t_i,q1_in,'m')
% plot(t_i,q1_ipr,'y')
% legend('Original','Sampled','Linear','Spline','Pchim','Next','Previous')
legend('Original','Sampled (Less data)','Linear','Pchim')

figure (2)
% ---------------------
plot(t,q1p,'k')
title('Velocity')
hold on
plot(t_s,q1p_s,'b')
plot(t_i,q1p_il,'r')
plot(t_i,q1p_ipch,'g')
legend('Original','Sampled (Less data)','Linear','Pchim')

figure (3)
% ---------------------
plot(t,q1pp,'k')
title('Acceleration')
hold on
plot(t_s,q1pp_s,'b')
plot(t_i,q1pp_il,'r')
plot(t_i,q1pp_ipch,'g')
legend('Original','Sampled (Less data)','Linear','Pchim')



% ======================================
%        Conclusions
% ======================================
% 'Next' and 'Previous' are not good at all
% Spline is not good either
% It is suggested to use LINEAR or PCHIM at 30 ms or MORE, or SAMPLED (with less data)