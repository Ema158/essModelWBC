function [q,qD,qDD]=joints_fromCoMpos_Vel_HZDtimeNoWBC(robot_i,X,gait_param_i,time)
% Based on "joints_Plus_Pos_Vel".
% last modification: 1-Abril-2017
% -----------------------------------------------------------------------------------------------------------------------
% Aqu�, adem�s de las posiciones y velocidades articulares tambien se calculan las aceleraciones, mediante la siguiente 
% ecuaci�n expl�cita ->  qpp = JQ\(Jd*Phipp + Jdp*Phip - JQp*qp)
% Todos �stos t�rminos son obtenidos expl�citamente en cada iteracion!! =) ... S�lamente XDD (qfpp) no =(
% Y ya que se desea calcular qDD, entonces en este archivo se guardan todos los valores necesarios para
% calcular "qpp" al final del ciclo... pero si se conocieran los valores de XDD se podr�an calcular "qpp" inmediatamente =)

robot = robot_i;
gait_parameters =gait_param_i;

% Estados
x = X(:,1); 
y = X(:,2); 
xp = X(:,3); 
yp = X(:,4); 

muestras = numel(x); % Numero de muestras o datos
% Inicializaci�n
q=zeros(robot.joints,muestras);
qD = zeros(robot.joints,muestras);
qDD = zeros(robot.joints,muestras);
JdAll = cell(1,muestras);     % Para guardar todas las matrices "Jd" para cada iteraci�n
JdpPhipAll = cell(1,muestras);     % Para guardar todas los vectores "Jdp*Phip" para cada iteraci�n
JQAll = cell(1,muestras);     % Para guardar todas las matrices "JQ" para cada iteraci�n
JQpqpAll = cell(1,muestras);     % Para guardar todas los vectores  "JQp*qp" para cada iteraci�n

for i=1:muestras
    % Estados
    qf(1,1) = X(i,1);
    qf(2,1) = X(i,2);
    qfp(1,1) = X(i,3);
    qfp(2,1) = X(i,4);
    if isempty(time)
        t = 1;
    else
        t = time(i);
    end
    
    [q(:,i),qD(:,i),~,JQ,Jd] = JointsPosVel_from_CoMPosVel_HZDtimeNoWBC(qf,qfp,robot,gait_parameters,t);
    % ----------------------------- 
    robot=robot_move(robot,q(:,i)); % Actualizaci�n de los par�metros de "robot", ya que se usar� ams adelante
    robot.qD = qD(:,i); % Actualizaci�n de las velocidades del robot porque ser�n utilizadas para el c�lculos de varias matrices siguientes
    % JQpqp = JQp_qp(robot,JQ); % Cualquiera de las 2 funciona, aunque con "JQp_qp02" hacemos los c�lculos m�s r�pido =)
    JQpqp = JQp_qp02NoWBC(robot,JQ);
    
    %Vector hp
    Case = 'acceleration';
    x = qf(1);
    % "Case", "gait_parameters", "qfp" and "x" are used inside "OptionDesiredTrajectory"
    OptionDesiredTrajectoryNoWBC();

    JdpPhip = [dt_dhd_Phi; 
                zeros(2,2+phiDim)]*Phip;
    
    JQAll{i} = JQ;   % Guarda todas las matrices "JQ" calculadas para cada instante de tiempo (p/cada muestra)
    JQpqpAll{i} = JQpqp;   % Guarda todos los vectores "JQp*qp" calculadas para cada instante de tiempo (p/cada muestra)
    JdAll{i} = Jd;   % Guarda todas las matrices "Jd" calculadas para cada instante de tiempo (p/cada muestra)
    JdpPhipAll{i} = JdpPhip;   % Guarda todas los vectores "Jdp*Phip" calculadas para cada instante de tiempo (p/cada muestra)
    
    PhipAll(:,i) = Phip; % Guarda todas las derivadas temporales de los estados "x" y "y" para cada instante de tiempo (p/cada muestra)
    % The dimension of PhipAll can change acording to the Case in "OptionDesiredTrajectory", that's why we don't initialice it
        
end
     
Phipp = C_diff(PhipAll,time); % 1e-3 % C�clulo num�rico de la derivada temporal del vector de estados "qfp = [xp yp]^T"
% Finalmente se calculan las aceleraciones articulares para toda la evoluci�n del paso... (cada columna de qDD es la
% aceleraci�n para ese instante del paso)
for i=1:muestras 
    qDD(:,i) = JQAll{i}\(JdAll{i}*Phipp(:,i) + JdpPhipAll{i} - JQpqpAll{i} );
end
