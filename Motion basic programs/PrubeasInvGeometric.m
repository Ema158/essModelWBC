%Pruebas invgeometricHDZ
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
figure(1)
robot_draw(robot,0,0);% Se dibuja el robot en su posicion de reposo
view(3);
axis equal;
q=robot.q;
q(2)=0.3094;
q(3)=-0.427;
q(9)=-0.3182;
q(10)=0.4269;
q(13)=1.181;
q(17)=2.019;
robot=robot_move(robot,q);
figure(2)
robot_draw(robot,0,0);%Se dibuja la posicion a la que se quiere llegar
view(3);
axis equal;
[Q,Qp]=current_states(robot);%Se obtienen los valores de xCom,ycom,zcom,xpie,ypie, etc que darian esas q's;
x=Q(21);
y=Q(22);
gait_parameters.Qdes=Q;
robot=genebot();%Para que el robot vuelva a su posicion de reposo
q2=InvGeometricHZDtime(x,y,robot,gait_parameters,0);


%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------