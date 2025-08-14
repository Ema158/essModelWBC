%Pruebas JQp_qp
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
for i=1:22
    qp(i)=0.2;
end
[h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11, h12,h13, h14,h15,...
    h16,h17,h18,h19,h20,h21,h22,h23,h24,h25,h26,h27]=Symoro_Jpqp2(robot.q,qp);

h1a=robot.T(1:3,1:3,1)*h1(1:3);
h1b=robot.T(1:3,1:3,1)*h1(4:6);
h1=[h1a;h1b];

h2a=robot.T(1:3,1:3,2)*h2(1:3);
h2b=robot.T(1:3,1:3,2)*h2(4:6);
h2=[h2a;h2b];

h3a=robot.T(1:3,1:3,3)*h3(1:3);
h3b=robot.T(1:3,1:3,3)*h3(4:6);
h3=[h3a;h3b];

h4a=robot.T(1:3,1:3,4)*h4(1:3);
h4b=robot.T(1:3,1:3,4)*h4(4:6);
h4=[h4a;h4b];

h5a=robot.T(1:3,1:3,5)*h5(1:3);
h5b=robot.T(1:3,1:3,5)*h5(4:6);
h5=[h5a;h5b];

h6a=robot.T(1:3,1:3,6)*h6(1:3);
h6b=robot.T(1:3,1:3,6)*h6(4:6);
h6=[h6a;h6b];

h7a=robot.T(1:3,1:3,7)*h7(1:3);
h7b=robot.T(1:3,1:3,7)*h7(4:6);
h7=[h7a;h7b];

h8a=robot.T(1:3,1:3,8)*h8(1:3);
h8b=robot.T(1:3,1:3,8)*h8(4:6);
h8=[h8a;h8b];

h9a=robot.T(1:3,1:3,9)*h9(1:3);
h9b=robot.T(1:3,1:3,9)*h9(4:6);
h9=[h9a;h9b];

h10a=robot.T(1:3,1:3,10)*h10(1:3);
h10b=robot.T(1:3,1:3,10)*h10(4:6);
h10=[h10a;h10b];

h11a=robot.T(1:3,1:3,11)*h11(1:3);
h11b=robot.T(1:3,1:3,11)*h11(4:6);
h11=[h11a;h11b];

h12a=robot.T(1:3,1:3,12)*h12(1:3);
h12b=robot.T(1:3,1:3,12)*h12(4:6);
h12=[h12a;h12b];

h13a=robot.T(1:3,1:3,13)*h13(1:3);
h13b=robot.T(1:3,1:3,13)*h13(4:6);
h13=[h13a;h13b];

h14a=robot.T(1:3,1:3,14)*h14(1:3);
h14b=robot.T(1:3,1:3,14)*h14(4:6);
h14=[h14a;h14b];

h15a=robot.T(1:3,1:3,15)*h15(1:3);
h15b=robot.T(1:3,1:3,15)*h15(4:6);
h15=[h15a;h15b];

h16a=robot.T(1:3,1:3,16)*h16(1:3);
h16b=robot.T(1:3,1:3,16)*h16(4:6);
h16=[h16a;h16b];

h17a=robot.T(1:3,1:3,17)*h17(1:3);
h17b=robot.T(1:3,1:3,17)*h17(4:6);
h17=[h17a;h17b];

h18a=robot.T(1:3,1:3,18)*h18(1:3);
h18b=robot.T(1:3,1:3,18)*h18(4:6);
h18=[h18a;h18b];

h19a=robot.T(1:3,1:3,19)*h19(1:3);
h19b=robot.T(1:3,1:3,19)*h19(4:6);
h19=[h19a;h19b];

h20a=robot.T(1:3,1:3,20)*h20(1:3);
h20b=robot.T(1:3,1:3,20)*h20(4:6);
h20=[h20a;h20b];

h21a=robot.T(1:3,1:3,21)*h21(1:3);
h21b=robot.T(1:3,1:3,21)*h21(4:6);
h21=[h21a;h21b];

h22a=robot.T(1:3,1:3,22)*h22(1:3);
h22b=robot.T(1:3,1:3,22)*h22(4:6);
h22=[h22a;h22b];

h23a=robot.T(1:3,1:3,23)*h23(1:3);
h23b=robot.T(1:3,1:3,23)*h23(4:6);
h23=[h23a;h23b];

h24a=robot.T(1:3,1:3,24)*h24(1:3);
h24b=robot.T(1:3,1:3,24)*h24(4:6);
h24=[h24a;h24b];

h25a=robot.T(1:3,1:3,25)*h25(1:3);
h25b=robot.T(1:3,1:3,25)*h25(4:6);
h25=[h25a;h25b];

h26a=robot.T(1:3,1:3,26)*h26(1:3);
h26b=robot.T(1:3,1:3,26)*h26(4:6);
h26=[h26a;h26b];

h27a=robot.T(1:3,1:3,27)*h27(1:3);
h27b=robot.T(1:3,1:3,27)*h27(4:6);
h27=[h27a;h27b];

[~, ~, JpCoMqp, ~, Jpi_qp] = VelAceCoMs_Frames(robot,zeros(22,1));
%H1 = Jpi_qp{1}; 
H2 = Jpi_qp{2}; 
H3 = Jpi_qp{3}; 
H4 = Jpi_qp{4}; 
H5 = Jpi_qp{5}; 
H6 = Jpi_qp{6}; 
H7 = Jpi_qp{7};    % [^0PartialVP_7; ^0PartialWP_7] = [^0Jp_7,v*qp; ^0Jp_7,w*qp]
H8 = Jpi_qp{8}; 
H9 = Jpi_qp{9}; 
H10 = Jpi_qp{10}; 
H11 = Jpi_qp{11}; 
H12 = Jpi_qp{12};  % [^0PartialVP_12; ^0PartialWP_12] = [^0Jp_12,v*qp; ^0Jp_12,w*qp]
H13 = Jpi_qp{13}; 
H14 = Jpi_qp{14};  % [^0PartialVP_14; ^0PartialWP_14] = [^0Jp_14,v*qp; ^0Jp_14,w*qp]
H15 = Jpi_qp{15}; 
H16 = Jpi_qp{16}; 
H17 = Jpi_qp{17}; 
H18 = Jpi_qp{18}; 
H19 = Jpi_qp{19}; 
H20 = Jpi_qp{20}; 
H21 = Jpi_qp{21}; 
H22 = Jpi_qp{22}; 
H23 = Jpi_qp{23}; 
H24 = Jpi_qp{24}; 
H25 = Jpi_qp{25}; 
H26 = Jpi_qp{26}; 
H27 = Jpi_qp{27}; 


%dif1=h1-H1
dif2=h2-H2
dif3=h3-H3
dif4=h4-H4
dif5=h5-H5
dif6=h6-H6
dif7=h7-H7
dif8=h8-H8
dif9=h9-H9
dif10=h10-H10
dif11=h11-H11
dif12=h12-H12
dif13=h13-H13
dif14=h14-H14
dif15=h15-H15
dif16=h16-H16
dif17=h17-H17
dif18=h18-H18
dif19=h19-H19
dif20=h20-H20
dif21=h21-H21
dif22=h22-H22
dif23=h23-H23
dif24=h24-H24
dif25=h25-H25
dif26=h26-H26
dif27=h27-H27
%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------