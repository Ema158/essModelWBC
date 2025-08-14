clear all;
close all;
% clc;
% ---------------------------------------------------------------------------------------------
currentfolder = pwd; % save current path
cd ..                % go one folder down (go out of the current folder and stay in the previous one)
add_paths;           % add all folders where all files are founded in order to acces to them
cd(currentfolder);   % return to the original path
robot=genebot();
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
act= [0,1,2,3,4,5,6,7,8,9,10,...
        11,12,0,13,14,15,16,0,17,18,19,...
        20,0,21,22,0];
crossM = zeros(3,3,27);

%Computation of the cross matrices
for i = 1:27
crossM(:,:,i) = cross_matrix(T(1:3,3,i)); % Transforma el vector "a" de la matriz T = [s n a p; 0 0 0 1]; en una matriz antisimétrica
end
J1=PruebasJacAnkle12(robot.q);
J2=PruebasJacAnkle14(robot.q);
JAnkleSymoro=zeros(3,22);
JAnkleSymoro(1:2,1:11)=J1(1:2,:);
JAnkleSymoro(3,1:12)=J2(3,:);
Resta=robot.J_Ankle-JAnkleSymoro;
for i=1:22
    q(i)=deg2rad(5);
end
robot_move(robot,q);
J7Symoro=JMarco7(robot.q);
%Marco 7
F = 7;
J_7 = zeros(6,robot.joints);
while F~=1
        if act(F)~=0 
            J = crossM(:,:,F)*(T(1:3,4,7)-T(1:3,4,F));
            J_7(1:3,act(F)) =J;
        end;
        F = ant(F);
end
%Orientacion


%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------