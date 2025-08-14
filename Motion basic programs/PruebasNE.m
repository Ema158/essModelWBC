%Pruebas NewtonEuler
clear all;
close all;
clc;
% ---------------------------------------------------------------------------------------------
currentfolder = pwd; % save current path
cd ..                % go one folder down (go out of the current folder and stay in the previous one)
add_paths;           % add all folders where all files are founded in order to acces to them
cd(currentfolder);   % return to the original path
% ---------------------------------------------------------------------------------------------
robot=genebot();
q=robot.q;
for i=1:22
    q(i)=deg2rad(5);
    qp(i)=deg2rad(4);
    qpp(i)=deg2rad(3);
end
[F01,M01,Tau1]=Newton_Euler(q,qp,qpp);
[F02,M02,Tau2]=Newton_Euler_Symoro2(q,qp,qpp);
Tau1-Tau2'


%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------