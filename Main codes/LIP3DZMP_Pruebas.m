
function Func = LIP3DZMP_Pruebas(R0)
Dx = R0(1);
Dy = R0(2);
xpfProp = R0(3);
ypfProp = -R0(4);
global S D T
xfProp = S/2 + Dx;
yfProp = D/2 + Dy;
global ZMPxCoeff ZMPyCoeff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%ZMP
T1 = 0; % This two times are used to build the trajectory of the ZMP and are used in "dynm_HZD.m" 
T2 = T; % So the trayectory will be fixed from 0 to T1, then the motion will be from T1 to T2 and then fixed from T2 to T 
ZMPxIni = -0.005; %  Local position of the desired ZMP in X for each step
ZMPxEnd = 0.01;
ZMPyIni = 0; % Local position of the desired ZMP in Y for each step
ZMPyEnd = 0;
Pos = [T1 ZMPxIni;       
       T2 ZMPxEnd];
Vel = [T1 0;
       T2 0];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPyIni;       
       T2 ZMPyEnd];     
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);
% options = odeset('Events', @PEvents_LIP,'RelTol', 1.e-7, 'AbsTol', 1.e-9);
fprintf('Proposed values [Dx,Dy,xp,yp] = [%e,%e]\n',Dx,Dy,xpfProp,ypfProp)
fprintf('-----------------------------------------------------\n')
x0 = -S/2 + Dx;
y0 = D/2 - Dy;
[t,Xt] = ode45(@LIP3DZMP_funcion,0:1e-3:T,[x0;y0;xpfProp;ypfProp]);
xf = Xt(end,1);
yf = Xt(end,2);
xpf = Xt(end,3);
ypf = Xt(end,4);
Func = [xfProp - xf,yfProp - yf,xpfProp - xpf,ypfProp + ypf];


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
