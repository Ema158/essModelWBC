function lim = limits
%Position limits, velocity, torque

pos = zeros(2,24);
vel = zeros(1,24);
tor = zeros(1,24);

% Ankle roll
pos(1,1) = -deg2rad(44.06);%45 grados
pos(2,1) = deg2rad(22.8);

pos(1,12) =  -deg2rad(22.8);%45 grados
pos(2,12) = deg2rad(44.06);%25 grados

vel(1) =4.16174;
vel(12)=vel(1);

tor(1) =53.1*0.873; %on tient compte du rendement
tor(12)=tor(1);

%Ankle pitch

pos(1,2) = deg2rad(-67.97);
pos(2,2) = deg2rad(53.4);

pos(1,11) = -deg2rad(68.15);%-75 grados
pos(2,11) = deg2rad(44.06);%45 grados

vel(2) =6.40239;
vel(11)=vel(2);

tor(2) =77.24*0.873;
tor(11)=tor(2);

%Knee pitch
pos(1,3) = -deg2rad(120);
pos(2,3) = deg2rad(121.47);

pos(1,10) =  -deg2rad(120);%0
pos(2,10) =  deg2rad(121.04);%130

vel(3) =6.402;
vel(10)=vel(3);

tor(3) =50*0.873;
tor(10)=tor(3);

%Hip pitch
pos(1,4) = deg2rad(-88);
pos(2,4) = deg2rad(27.73);

pos(1,9) = deg2rad(-88);
pos(2,9) = deg2rad(27.73);

vel(4) =6.402;
vel(9)=vel(4);

tor(4) =128.17*0.873;
tor(9)=tor(4);

%Hip roll
pos(1,5) = deg2rad(-45.29);
pos(2,5) = deg2rad(21.74);

pos(1,8) = -deg2rad(21.74);%-25
pos(2,8) = deg2rad(45.29);%45

vel(5) =4.16174 ;
vel(8)=vel(5);

tor(5) =84.372*0.873;
tor(8)=tor(5);

%Hip yawPitch
pos(1,6) = -deg2rad(65.62);
pos(2,6) = deg2rad(42.44);

pos(1,7) = -deg2rad(65.62);
pos(2,7) = deg2rad(42.44);

vel(6) =4.16174;
vel(7)=vel(6);

tor(6) =25.4200000763;
tor(7)=tor(6);

%Shoulder pitch
pos(1,13) = -deg2rad(119.5);%-120
pos(2,13) = deg2rad(119.5);%120

pos(1,18) = -deg2rad(119.5);%-120
pos(2,18) =  deg2rad(119.5);%120

vel(13) =8.26797;
vel(18) =8.26797;

tor(13) =19.0949993134;
tor(18) = tor(13);

%Shoulder yaw
pos(1,14) = -deg2rad(76);%-95
pos(2,14) = deg2rad(18);%0

pos(1,19) =  -deg2rad(18);%0
pos(2,19) =  deg2rad(76);%95

vel(14) =7.19407;
vel(19) =7.19407;

tor(14) =9.03100013733;
tor(19) = tor(14);

%Elbow roll 
pos(1,15) =-(2*pi)/3 ;%-120
pos(2,15) = (2*pi)/3 ;%120

pos(1,20) = -(2*pi)/3 ;%-120
pos(2,20) = (2*pi)/3 ;%120

vel(15) =7.19407;
vel(20) =7.19407;

tor(15) = 7.40399980545;
tor(20) = tor(15);
%Elbow yaw
pos(1,16) = 0;%0
pos(2,16) = pi/2;%90

pos(1,21) =  -pi/2;%-90
pos(2,21) =  0;%0

vel(16) =8.26797;
vel(21) =8.26797;

tor(16) =6.01999998093;
tor(21) = tor(16);
%Wrist
pos(1,17) = 0;%0
pos(2,17) = pi/2;%90

pos(1,22) =  -pi/2;%-90
pos(2,22) =  0;%0

vel(17) =8.26797;
vel(22) =8.26797;

tor(17) =6.01999998093;
tor(22) = tor(17);
%Head yaw
pos(1,23) = -(2*pi)/3 ;%-120
pos(2,23) =(2*pi)/3 ;%120

vel(23) =8.26797;

tor(23) =2.17700004578;

% Head pitch
pos(1,24) = -deg2rad(38.5);%-45
pos(2,24) = deg2rad(29.5);%45

vel(24) = 7.19407;
tor(24) = 1;

lim.pos = pos;
lim.vel = vel;
lim.tor = tor;
end

