close all;
clear all;
clc
% ---------------------------------------------------------------------------------------------
currentfolder = pwd; % save current path
cd ..                % go one folder down (go out of the current folder and stay in the previous one)
add_paths;           % add all folders where all files are founded in order to acces to them
cd(currentfolder);   % return to the original path
% ---------------------------------------------------------------------------------------------

% Programa para realizar pruebas en los brazos del robot Nao

t=0.001:0.001:8;
% q11 = 0.1*sin(t) + 1.6;
% q12 = 0.35;
% q13 = 1.6;
% q14 =  0.35;
% q15 = 1.6;
% q16 =0.35;
% q17 = - 1.6;
% q18 = - 0.35;
%
q11 = 0.2*sin(t) + 1.6;
q12 = 0.1*sin(t) - 0.35;
q13 = 0.1*sin(t) + 1.6;
q14 = 0.1*sin(t) - 0.35;
q15 = 0.1*sin(t) + 1.6;
q16 = 0.1*sin(t) + 0.35;
q17 = 0.1*sin(t) - 1.6;
q18 = 0.1*sin(t) - 0.35;
%Creación de los archivos .txt para llevarlos al robot Nao
Tabla_tiempos=table(t');
writetable(Tabla_tiempos,'t_brazos.txt');
type t_brazos.txt;
%
q_brazos = [q11';q12';q13';q14';q15';q16';q17';q18'];
Tabla_tiempos=table(q_brazos);
writetable(Tabla_tiempos,'qs_brazos.txt');
type qs_brazos.txt;
%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------
diary off % Finish the recording of the log file