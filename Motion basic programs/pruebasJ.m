clear all;
close all;
clc;
% ---------------------------------------------------------------------------------------------
currentfolder = pwd; % save current path
cd ..                % go one folder down (go out of the current folder and stay in the previous one)
add_paths;           % add all folders where all files are founded in order to acces to them
cd(currentfolder);   % return to the original path
robot=genebot();
qi = zeros(22,1);
robot = robot_move(robot,qi); 
CoM_i=robot.CoM;
J_CoM=robot.J_CoM;
qf = zeros(22,1);
for i=1:22
    qf(i)=deg2rad(0.1);
end   
robot = robot_move(robot,qf); 
CoM_f=robot.CoM;
difCoM=CoM_f-CoM_i;
difCoMf_calc=J_CoM*(qf-qi);
errores=difCoMf_calc-difCoM;
for i=1:3
    errrores_porc(1)=(errores(1)/difCoMf_calc(1))*100;
    errrores_porc(2)=(errores(2)/difCoMf_calc(2))*100;
    errrores_porc(3)=(errores(3)/difCoMf_calc(3))*100;
end
i;
%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------