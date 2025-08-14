function [CoM,J_CoM,J_Ankle,crossM,J_CoMs] = compute_com(robot,PI)

%% CoM position/velocity

%Mass informations
M = PI.masse;
CoM_j = PI.CoM;
%///////////////////////////////////////////////////////////////////////////
%Initialisations
CoM = [0;0;0];
J_CoMs = zeros(3,robot.joints,27);
J_CoM = zeros(3,robot.joints);
T = robot.T;
ant =       [0,... 1
             1,... 2
             2,... 3
             3,... 4
             4,... 5
             5,... 6
             6,... 7
             7,... 8
             8,... 9
             9,... 10
             10,...11
             11,...12
             12,...13
             13,...14
             7,... 15
             15,...16
             16,...17
             17,...18
             18,...19
             7,...20
             20,...21
             21,...22
             22,...23
             23,...24
              7,...25
             25,...26 
             26]; %27  
% act= [0,1,2,3,4,5,6,7,8,9,10,...
%         11,12,0,13,14,15,16,0,17,18,19,...
%         20,0,21,22,0];
act= [0,1,2,3,4,5,6,7,8,9,10,...
        11,12,0,13,14,15,16,17,18,19,20,...
        21,22,23,24,0];
crossM = zeros(3,3,27);

%Computation of the cross matrices
for i = 1:27
crossM(:,:,i) = cross_matrix(T(1:3,3,i)); % Transforma el vector "a" de la matriz T = [s n a p; 0 0 0 1]; en una matriz antisimétrica
end
for j = 1 : 27
    if j==7
        ema=1;
    end
    if M(j) ~=0
        %Center of mass position (X,Y)
        MS_j = T(1:3,:,j) * [CoM_j{j};1]; % Este es el vector de posicion del CoM_j respecto al marco 0
        CoM = CoM + M(j) * MS_j;         % De igual forma, aquí se va calculando el CoM total del robot "Sum(j=1:36) m* ^0Com_j"
        %Center of mass velocity (XD,YD)
        J_X = zeros(3,robot.joints);      % Se crea una matriz de 3x27 para calcular J_CoM_j
        F = j;% Se empiezan a crear los jacobianos para cada marco( los que no tienen masa asignada seran una matriz de ceros)
        while F~=1    % ¿Llegamos al marco 1? Si si, sale del "while", si no, continúa... (F nunca es menor que 1)
            % Aqui se va calculando cada columna de la matriz J_CoM_j. Nótese que se "brinca" las columnas que
            % corresponden a los marcos que NO tienen asignada una masa.. Nótese que los jacobianos empiezan de ADELANTE pa'trás
            if act(F)~=0 % ¿El marco F tiene una articulacion (q)? Si si, entra al "if", si no no =P
               J_X(:,act(F)) =crossM(:,:,F)*(MS_j-T(1:3,4,F)); %col  -> 0a_j X (0Pcom_j - 0P_j)
            end
            F = ant(F);
        end
        J_CoMs(:,:,j)=J_X;               % Se asigna 
        J_CoM = J_CoM+M(j)*J_X;
     end
end

CoM = CoM / robot.mass;   % = 1/mT Sum_{i=1}^n a_j X ^jCom_j   donde  jCom_j es el vector constante de CoM del del eslabon j 
                          % respecto al marco j, y a_j es el vector de la matriz "snap" del marco "j"
J_CoM = J_CoM/robot.mass;

%% J_Ankle is the jacobian of the ankle for x,y position and leg tip for z
% position
F = 12;
J_Ankle = zeros(3,robot.joints);
while F~=1
        if act(F)~=0 
            J = crossM(:,:,F)*(T(1:3,4,12)-T(1:3,4,F));
            J_Ankle(1:2,act(F)) =J(1:2);
        end
        F = ant(F);
end
F = 14;
while F~=1
        if act(F)~=0 
            J = crossM(:,:,F)*(T(1:3,4,14)-T(1:3,4,F));
            J_Ankle(3,act(F)) =J(3);
        end
        F = ant(F);
end








