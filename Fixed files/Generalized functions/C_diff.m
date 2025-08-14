function XDot = C_diff(X,time)
%Centered differenciation
% X es una matriz (n X m) donde "n" es el numero de variables x1, x2, ... xn y "m" es el numero de datos de cada variable
% Por ejemplo si X(1,100), solo hay una variable x1 con 100 muestras (donde se supone que cada muestra está espaciada un
% tiempo "t", de tal forma que el resultado Xdot, será un vector xp1 con 100 muestras.
% El único problema con esta derivada es que el primer y el último valor de la derivada son CERO.
% time is either a vector of "n" elements or a constant increment value. 

nVar = numel(X(:,1));
samples = numel(X(1,:));
if numel(time)==1 % if time is a constant increment value we build a vector of time with that increment
    t = 0:time:(samples-1)*time;
else
    t = time;
end

XDot = zeros(nVar,samples);

for j=1:nVar
    for i=2:samples-1
        dt1 = t(i)-t(i-1); % delta time before the sample
        dt2 = t(i+1)-t(i); % delta time after the sample
        XDot(j,i)=(X(j,i+1)-X(j,i-1))/(dt1 + dt2);
    end
end

% % Para evitar que el primero y el último valor sean CERO, podemos:
% ------------------------------------------------------------------------
% OPCION 1: asignar los valores calculados mas cercanos:
% XDot(:,1)= XDot(:,2); % La primer muestra de todas las variables va a ser igual a su segunda valor  
% XDot(:,end)= XDot(:,end-1); % La última muestra de todas las variables va a ser igual a su pénultimo valor

% OPCION 2: Calcular esos valores (el primero y el último) con la misma pendiende que hay entre las dos muestras más cercanas
% --------- Mejor opción =) ---------------------
dt2 = t(3)-t(2);
mIni(:,1) = (XDot(:,3) - XDot(:,2))./dt2; % Pendiente que hay entre las muestras 2 y 3   m = (X(3) - X(2))/t
dt1 = t(2)-t(1);
XDot(:,1)=  -mIni.*dt1 + XDot(:,2); % X(1) = -m*t + X(2)     % Viene de despejar X(1) de:  m = (X(2) - X(1))/t

dt1 = t(end-1)-t(end-2);
mFin(:,1) = (XDot(:,end-1)-XDot(:,end-2))./dt1;  % Pendiente que hay entre las muestras n-2 y n-1   m = (X(n-1) - X(n-2))/t
dt2 = t(end)-t(end-1);
XDot(:,end)= mFin.*dt2 + XDot(:,end-1); % X(1) = -m*t + X(2)     % Viene de despejar X(n) de:  m = (X(n) - X(n-1))/t

% Ya que la distancia en X entre los 2 puntos es siempre igual, i.e "t" los puntos 1 y "n" tambien Ser calculados así (es equivalente a lo de arriba):
% XDot(:,1)= -XDot(:,3) + 2*XDot(:,2); % Viene de igualar las pendientes entre el punto 2 y 3 y el 1 y 2 y despejar el 1
% XDot(:,end)= 2*XDot(:,end-1) - XDot(:,end-2); % Viene de igualar las pendientes entre el punto n-2 y n-1 y el n-1 y n y despejar el n
