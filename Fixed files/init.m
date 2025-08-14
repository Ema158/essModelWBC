 % All parameters are defined in "initSimulink.m" 
% ==============================================================
initial = initSimulink();
 
g = initial.g;
z0 = initial.z0;
D = initial.D;
S = initial.S;
r_poly = initial.r_poly;
Delta = initial.Delta;
z_alpha = initial.z_alpha;
% First step
z_alpha_first = initial.z_alpha_first;
yaw_alpha = initial.yaw_alpha;
yaw_alpha_first = initial.yaw_alpha_first;
%Torso
Roll_ti = initial.Roll_ti;
Roll_t_alpha = initial.Roll_t_alpha;
Pitch_ti = initial.Pitch_ti;

% For the foot polynomial, when generating the final motion, we use the
% fixed point computed value
 XD_First = initial.XD_First;
 YD_First = initial.YD_First;

