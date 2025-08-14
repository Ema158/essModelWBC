function T = DGM(robot)
%% computing of the geometric model (transformations matrix) of the robot
%theta = robot.q;
T=zeros(4,4,27);
Temp =zeros(4,4,27);
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
%//////////////////////////////////////////////////////////////////////////
%
theta(1)=pi/2;
theta(2)=robot.q(1);
theta(3)=robot.q(2);
theta(4)=robot.q(3);
theta(5)=robot.q(4);
theta(6)=robot.q(5)+pi/4;
theta(7)=robot.q(6)+pi/2;
theta(8)=robot.q(7)-pi/2;
theta(9)=robot.q(8)+pi/4;
theta(10)=robot.q(9);
theta(11)=robot.q(10);
theta(12)=robot.q(11);
theta(13)=robot.q(12);
theta(14)=0;

theta(15)=robot.q(13);
theta(16)=robot.q(14)+pi/2;
theta(17)=robot.q(15);
theta(18)=robot.q(16);
theta(19)=robot.q(17);

theta(20)=robot.q(18);
theta(21)=robot.q(19)+pi/2;
theta(22)=robot.q(20);
theta(23)=robot.q(21);
theta(24)=robot.q(22);

theta(25)=robot.q(23);
theta(26)=robot.q(24)-pi/2;
theta(27)=-pi/2;
%///////////////////////////////////////////////////////////////////////////
%Calculo de todas las Matrices de transformacion homogeneas ^i_jT en una matriz global 
mat_t=mat_trans(theta(1:27));
%Separacion de las Matrices de transformacion homogeneas ^i_jT en matrices independientes (Temp) 
Temp(:,:,1)= mat_t(1:4,:);
Temp(1,4,1)= Temp(1,4,1)+0.095; % 0.095 es r2 
for j = 2 : 27
    Temp(:,:,j) = mat_t(4*(j-1)+1:4*j,:);    
end

%Calculo de las matrices de transformacion respecto al marco cero ^0_jT 
T(:,:,1) = Temp(:,:,1);
for j = 2 : 27
    T(:,:,j) = T(:,:,ant(j)) * Temp(:,:,j); %
end

