
function [t,X_final] = Nsteps_3DLIP_model(X0)
% xpp = g/z*x;
T = 0.5;
global ZMPxCoeff ZMPyCoeff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%ZMP
T1 = 0; % This two times are used to build the trajectory of the ZMP and are used in "dynm_HZD.m" 
T2 = T; % So the trayectory will be fixed from 0 to T1, then the motion will be from T1 to T2 and then fixed from T2 to T 
ZMPxIni = 0; %  Local position of the desired ZMP in X for each step
ZMPxEnd = 0;
ZMPyIni = 0; % Local position of the desired ZMP in Y for each step
ZMPyEnd = 0;
Pos = [T1 ZMPxIni;       
       T2 ZMPxEnd];
Vel = [];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPyIni;       
       T2 ZMPyEnd];     
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);
% options = odeset('Events', @PEvents_LIP,'RelTol', 1.e-7, 'AbsTol', 1.e-9);


[t,Xt] = ode45(@LIP3DZMP_funcion,0:1e-3:T,X0);
X_final = Xt;



function Xt = LIP3DZMP_funcion(t,X)
global ZMPxCoeff ZMPyCoeff
px = polyval(ZMPxCoeff,t);
py = polyval(ZMPyCoeff,t);
g= 9.81;
z = 0.255;
x = X(1);
xp = X(3);
xpp = g/z*(x - px);
y = X(2);
yp = X(4);
ypp = g/z*(y - py);
Xt = [xp;yp;xpp;ypp];
fprintf('Final values [t,x,y,xp,yp] = [%e,%e,%e,%e,%e]\n',t,x,y,xp,yp)
