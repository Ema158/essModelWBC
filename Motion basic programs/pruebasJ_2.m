clear all;
close all;
clc;
% ---------------------------------------------------------------------------------------------
currentfolder = pwd; % save current path
cd ..                % go one folder down (go out of the current folder and stay in the previous one)
add_paths;           % add all folders where all files are founded in order to acces to them
cd(currentfolder);   % return to the original path
robot=genebot();
qf=zeros(31,1);
for i=1:31
    qf(i)=0.01745329252;
end  
robot=robot_move(robot,qf);
J_CoM=robot.J_CoM;
qp=zeros(31,1);
for i=1:31
    qp(i)=0.1;
end
xp=J_CoM*qp;
qp_calc=J_CoM\xp;
%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% --------------
