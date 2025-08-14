% Runs GUI
% ============================
clear all;
clc;
close all;

% ---------------------------------------------------------------------------------------------
currentfolder = pwd; % save actual path
cd ..                % go one folder down (go out of the current folder and stay in the previous one)
add_paths;           % add all folders where all files are founded in order to acces to them
cd(currentfolder);   % return to the original path
% ---------------------------------------------------------------------------------------------

% ROMEO GUI
% =====================================================================
global continueCode
continueCode = 0;
% launch GUI to see robot configuration
disp('------------------------------------------------------------------------')
disp('Launching NaO GUI')
GUIjointsRomeo;
disp('Nao GUI is running. Close it and press any key to continue with the code')
disp('------------------------------------------------------------------------')
while continueCode == 0
    pause();
    if continueCode == 0
        disp('The GUI is  still running, please close it and press any key to continue...')
    else
        disp('The GUI was closed succesfully.')
    end
end
disp('------------------------------------------------------------------------')
% =====================================================================
    
%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..              % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;      % Remove the paths of the folders added at the begining
cd(currentfolder); % Return to the original folder
% ----------------------------------------------------------------------------------------------



  