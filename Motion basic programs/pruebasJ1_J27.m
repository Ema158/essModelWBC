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
q=robot.q;
JCoMs_Symoro=zeros(3,robot.joints,27);
J1=JMarco1(q);
J2=JMarco2(q);
J3=JMarco3(q);
J4=JMarco4(q);
J5=JMarco5(q);
J6=JMarco6(q);
J7=jmarco7nueva(q);
J8=JMarco8(q);
J9=JMarco9(q);
J10=JMarco10_nueva(q);
J11=JMarco11(q);
J12=PruebasJacAnkle12(q);
J13=JMarco13(q);
J14=PruebasJacAnkle14(q);
J15=JMarco15(q);
J16=JMarco16(q);
J17=JMarco17(q);
J18=JMarco18(q);
J19=JMarco19(q);
J20=JMarco20(q);
J21=JMarco21(q);
J22=JMarco22(q);
J23=JMarco23(q);
J24=JMarco24(q);
J25=JMarco25(q);
J26=JMarco26(q);
J27=JMarco27(q);
JCoMs_Symoro(:,1,1)=J1(1:3,:);
JCoMs_Symoro(:,1,2)=J2(1:3,:);
JCoMs_Symoro(:,1:2,3)=J3(1:3,:);
JCoMs_Symoro(:,1:3,4)=J4(1:3,:);
JCoMs_Symoro(:,1:4,5)=J5(1:3,:);
JCoMs_Symoro(:,1:5,6)=J6(1:3,:);
JCoMs_Symoro(:,1:6,7)=J7(1:3,:);
JCoMs_Symoro(:,1:7,8)=J8(1:3,:);
JCoMs_Symoro(:,1:8,9)=J9(1:3,:);
JCoMs_Symoro(:,1:9,10)=J10(1:3,:);
JCoMs_Symoro(:,1:10,11)=J11(1:3,:);
JCoMs_Symoro(:,1:11,12)=J12(1:3,:);
JCoMs_Symoro(:,1:12,13)=J13(1:3,:);
JCoMs_Symoro(:,1:7,15)=J15(1:3,:);
JCoMs_Symoro(:,1:8,16)=J16(1:3,:);

JCoMs_Symoro(:,1:6,17)=J17(1:3,1:6);
JCoMs_Symoro(:,13:15,17)=J17(1:3,7:9);

JCoMs_Symoro(:,1:6,18)=J18(1:3,1:6);
JCoMs_Symoro(:,13:16,18)=J18(1:3,7:10);

JCoMs_Symoro(:,1:7,20)=J20(1:3,:);
JCoMs_Symoro(:,1:8,21)=J21(1:3,:);

JCoMs_Symoro(:,1:6,22)=J22(1:3,1:6);
JCoMs_Symoro(:,17:19,22)=J22(1:3,7:9);

JCoMs_Symoro(:,1:6,23)=J23(1:3,1:6);
JCoMs_Symoro(:,17:20,23)=J23(1:3,7:10);

JCoMs_Symoro(:,1:7,25)=J25(1:3,:);
JCoMs_Symoro(:,1:8,26)=J26(1:3,:);
Resta_JCoMs=JCoMs_Symoro-robot.J_CoMs;
absJ=abs(Resta_JCoMs);
dif=max(absJ);
max(dif)
%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------