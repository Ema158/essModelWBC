% "remove_paths.m"
% ----------------------------
% Remove the paths added in "add_paths.m".
address = pwd;
if isunix
    slash = '/';
else
    slash = '\';
end

romeoFilesAddress = genpath(address);
% Removing main folder and all subfolders in there
rmpath(romeoFilesAddress);
% ----------------------------------------
cd ..
address = pwd; % Current path
inputDataAddress = genpath([address,slash,'Input data']);
% Removing 'Input data' folder and all subfolders in there 
rmpath(inputDataAddress);
display('Paths for Nao files and "Input data" folder were removed =(');