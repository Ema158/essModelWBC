% (********************************************)
% (** SYMORO+ : SYmbolic MOdelling of RObots **)
% (**========================================**)
% (**      IRCCyN-ECN - 1, rue de la Noe     **)
% (**      B.P.92101                         **)
% (**      44321 Nantes cedex 3, FRANCE      **)
% (**      www.irccyn.ec-nantes.fr           **)
% (********************************************)


%    Name of file : C:\Documents and Settings\Emanuel\Escritorio\symoro\NAO q\264s positivas\NAO_1.1_dyn2.dyn




%      Geometric parameters   


% j         ant       mu        sigma     gamma     b         alpha     d         theta     r

%                                         Pi                  Pi                  Pi
% 1         0         0         2         --        0         --        0         --        0
%                                         2                   2                   2

% 2         1         1         0         0         0         0         d2        q1        -l1

%                                                             Pi
% 3         2         1         0         0         0         --        0         q2        0
%                                                             2

% 4         3         1         0         0         0         0         d4        q3        0


% 5         4         1         0         0         0         0         d5        q4        0

%                                                             -Pi                 Pi
% 6         5         1         0         0         0         ---       0         -- + q5   0
%                                                              2                  4
%                                                             Pi                  Pi
% 7         6         1         0         0         0         --        0         -- + q6   r7
%                                                             2                   2
%                                                             -Pi                 -Pi
% 8         7         1         0         0         0         ---       0         --- + q7  r7
%                                                              2                   2
%                                                             -Pi                 Pi
% 9         8         1         0         0         0         ---       0         -- + q8   0
%                                                              2                  4
%                                                             Pi
% 10        9         1         0         0         0         --        0         q9        0
%                                                             2

% 11        10        1         0         0         0         0         -d5       q10       0


% 12        11        1         0         0         0         0         -d4       q11       0

%                                                             -Pi
% 13        12        1         0         0         0         ---       0         q12       0
%                                                              2

% 14        13        0         2         0         0         0         -d2       0         l1

%                                                             -Pi
% 15        7         1         0         0         b15       ---       0         q13       r15
%                                                              4
%                                                             Pi                  Pi
% 16        15        1         0         0         0         --        0         -- + q14  0
%                                                             2                   2
%                                                             Pi
% 17        16        1         0         0         0         --        0         q15       r17
%                                                             2
%                                                             -Pi
% 18        17        1         0         0         0         ---       0         q16       0
%                                                              2
%                                                             Pi
% 19        18        0         2         0         0         --        0         0         r19
%                                                             2
%                                                             -Pi
% 20        7         1         0         0         b20       ---       0         q17       r20
%                                                              4
%                                                             Pi                  Pi
% 21        20        1         0         0         0         --        0         -- + q18  0
%                                                             2                   2
%                                                             Pi
% 22        21        1         0         0         0         --        0         q19       r17
%                                                             2
%                                                             -Pi
% 23        22        1         0         0         0         ---       0         q20       0
%                                                              2
%                                                             Pi
% 24        23        0         2         0         0         --        0         0         r19
%                                                             2
%                                                             Pi
% 25        7         1         0         0         0         --        0         q21       r25
%                                                             4
%                                                             -Pi                 -Pi
% 26        25        1         0         0         0         ---       0         --- + q22 0
%                                                              2                   2
%                                         Pi                  -Pi                 -Pi
% 27        26        0         2         --        0         ---       d27       ---       0
%                                         2                    2                   2



%              Inertial parameters

% j      XX     XY     XZ     YY     YZ     ZZ     MX     MY     MZ     M      Ia

% 1      XX1    XY1    XZ1    YY1    YZ1    ZZ1    MX1    MY1    MZ1    M1     0

% 2      XX2    XY2    XZ2    YY2    YZ2    ZZ2    MX2    MY2    MZ2    M2     IA2

% 3      XX3    XY3    XZ3    YY3    YZ3    ZZ3    MX3    MY3    MZ3    M3     IA3

% 4      XX4    XY4    XZ4    YY4    YZ4    ZZ4    MX4    MY4    MZ4    M4     IA4

% 5      XX5    XY5    XZ5    YY5    YZ5    ZZ5    MX5    MY5    MZ5    M5     IA5

% 6      XX6    XY6    XZ6    YY6    YZ6    ZZ6    MX6    MY6    MZ6    M6     IA6

% 7      XX7    XY7    XZ7    YY7    YZ7    ZZ7    MX7    MY7    MZ7    M7     IA7

% 8      XX8    XY8    XZ8    YY8    YZ8    ZZ8    MX8    MY8    MZ8    M8     IA8

% 9      XX9    XY9    XZ9    YY9    YZ9    ZZ9    MX9    MY9    MZ9    M9     IA9

% 10     XX10   XY10   XZ10   YY10   YZ10   ZZ10   MX10   MY10   MZ10   M10    IA10

% 11     XX11   XY11   XZ11   YY11   YZ11   ZZ11   MX11   MY11   MZ11   M11    IA11

% 12     XX12   XY12   XZ12   YY12   YZ12   ZZ12   MX12   MY12   MZ12   M12    IA12

% 13     XX13   XY13   XZ13   YY13   YZ13   ZZ13   MX13   MY13   MZ13   M13    IA13

% 14     XX14   XY14   XZ14   YY14   YZ14   ZZ14   MX14   MY14   MZ14   M14    0

% 15     XX15   XY15   XZ15   YY15   YZ15   ZZ15   MX15   MY15   MZ15   M15    IA15

% 16     XX16   XY16   XZ16   YY16   YZ16   ZZ16   MX16   MY16   MZ16   M16    IA16

% 17     XX17   XY17   XZ17   YY17   YZ17   ZZ17   MX17   MY17   MZ17   M17    IA17

% 18     XX18   XY18   XZ18   YY18   YZ18   ZZ18   MX18   MY18   MZ18   M18    IA18

% 19     XX19   XY19   XZ19   YY19   YZ19   ZZ19   MX19   MY19   MZ19   M19    0

% 20     XX20   XY20   XZ20   YY20   YZ20   ZZ20   MX20   MY20   MZ20   M20    IA20

% 21     XX21   XY21   XZ21   YY21   YZ21   ZZ21   MX21   MY21   MZ21   M21    IA21

% 22     XX22   XY22   XZ22   YY22   YZ22   ZZ22   MX22   MY22   MZ22   M22    IA22

% 23     XX23   XY23   XZ23   YY23   YZ23   ZZ23   MX23   MY23   MZ23   M23    IA23

% 24     XX24   XY24   XZ24   YY24   YZ24   ZZ24   MX24   MY24   MZ24   M24    0

% 25     XX25   XY25   XZ25   YY25   YZ25   ZZ25   MX25   MY25   MZ25   M25    IA25

% 26     XX26   XY26   XZ26   YY26   YZ26   ZZ26   MX26   MY26   MZ26   M26    IA26

% 27     XX27   XY27   XZ27   YY27   YZ27   ZZ27   MX27   MY27   MZ27   M27    0



%  External forces,friction parameters, joint velocities and accelerations

% j       FX      FY      FZ      CX      CY      CZ      FS      FV      QP      QDP

% 1       0       0       0       0       0       0       0       0       0       0

% 2       0       0       0       0       0       0       0       0       qp1     qpp1

% 3       0       0       0       0       0       0       0       0       qp2     qpp2

% 4       0       0       0       0       0       0       0       0       qp3     qpp3

% 5       0       0       0       0       0       0       0       0       qp4     qpp4

% 6       0       0       0       0       0       0       0       0       qp5     qpp5

% 7       0       0       0       0       0       0       0       0       qp6     qpp6

% 8       0       0       0       0       0       0       0       0       qp7     qpp7

% 9       0       0       0       0       0       0       0       0       qp8     qpp8

% 10      0       0       0       0       0       0       0       0       qp9     qpp9

% 11      0       0       0       0       0       0       0       0       qp10    qpp10

% 12      0       0       0       0       0       0       0       0       qp11    qpp11

% 13      0       0       0       0       0       0       0       0       qp12    qpp12

% 14      FX14    FY14    FZ14    CX14    CY14    CZ14    0       0       0       0

% 15      0       0       0       0       0       0       0       0       qp13    qpp13

% 16      0       0       0       0       0       0       0       0       qp14    qpp14

% 17      0       0       0       0       0       0       0       0       qp15    qpp15

% 18      0       0       0       0       0       0       0       0       qp16    qpp16

% 19      0       0       0       0       0       0       0       0       0       0

% 20      0       0       0       0       0       0       0       0       qp17    qpp17

% 21      0       0       0       0       0       0       0       0       qp18    qpp18

% 22      0       0       0       0       0       0       0       0       qp19    qpp19

% 23      0       0       0       0       0       0       0       0       qp20    qpp20

% 24      0       0       0       0       0       0       0       0       0       0

% 25      0       0       0       0       0       0       0       0       qp21    qpp21

% 26      0       0       0       0       0       0       0       0       qp22    qpp22

% 27      0       0       0       0       0       0       0       0       0       0

% Base velocity, base accelerations, and gravity

% j     W0    WP0   V0    VP0   G

% 1     0     0     0     0     0

% 2     0     0     0     0     0

% 3     0     0     0     0     G3

%  Dynamic model: Newton Euler method
% Equations:

% Declaration of the function
% Declaration of global input variables
% global q1 q2 q3 q4 Pi q5 q6 q7 q8 q9
% global q10 q11 q12 q13 Sqrt r15 b15 q14 q15 q16
% global q17 r20 b20 q18 q19 q20 q21 r25 q22 G3
% global M1 qp1 MX2 MY2 qpp1 M2 XZ2 YZ2 ZZ2 qp2
% global qpp2 MX3 MY3 MZ3 M3 YY3 ZZ3 XX3 XY3 XZ3
% global YZ3 qp3 qpp3 d4 MX4 MY4 MZ4 M4 YY4 ZZ4
% global XX4 XY4 XZ4 YZ4 qp4 qpp4 d5 MX5 MY5 MZ5
% global M5 YY5 ZZ5 XX5 XY5 XZ5 YZ5 qp5 qpp5 MX6
% global MY6 MZ6 M6 YY6 ZZ6 XX6 XY6 XZ6 YZ6 qp6
% global qpp6 r7 MX7 MY7 MZ7 M7 YY7 ZZ7 XX7 XY7
% global XZ7 YZ7 qp7 qpp7 MX8 MY8 MZ8 M8 YY8 ZZ8
% global XX8 XY8 XZ8 YZ8 qp8 qpp8 MX9 MY9 MZ9 M9
% global YY9 ZZ9 XX9 XY9 XZ9 YZ9 qp9 qpp9 MX10 MY10
% global MZ10 M10 YY10 ZZ10 XX10 XY10 XZ10 YZ10 qp10 qpp10
% global MX11 MY11 MZ11 M11 YY11 ZZ11 XX11 XY11 XZ11 YZ11
% global qp11 qpp11 MX12 MY12 MZ12 M12 YY12 ZZ12 XX12 XY12
% global XZ12 YZ12 qp12 qpp12 MX13 MY13 MZ13 M13 YY13 ZZ13
% global XX13 XY13 XZ13 YZ13 d2 l1 MX14 MY14 MZ14 M14
% global YY14 ZZ14 XX14 XY14 XZ14 YZ14 qp13 qpp13 MX15 MY15
% global MZ15 M15 YY15 ZZ15 XX15 XY15 XZ15 YZ15 qp14 qpp14
% global MX16 MY16 MZ16 M16 YY16 ZZ16 XX16 XY16 XZ16 YZ16
% global qp15 qpp15 r17 MX17 MY17 MZ17 M17 YY17 ZZ17 XX17
% global XY17 XZ17 YZ17 qp16 qpp16 MX18 MY18 MZ18 M18 YY18
% global ZZ18 XX18 XY18 XZ18 YZ18 r19 MX19 MY19 MZ19 M19
% global YY19 ZZ19 XX19 XY19 XZ19 YZ19 qp17 qpp17 MX20 MY20
% global MZ20 M20 YY20 ZZ20 XX20 XY20 XZ20 YZ20 qp18 qpp18
% global MX21 MY21 MZ21 M21 YY21 ZZ21 XX21 XY21 XZ21 YZ21
% global qp19 qpp19 MX22 MY22 MZ22 M22 YY22 ZZ22 XX22 XY22
% global XZ22 YZ22 qp20 qpp20 MX23 MY23 MZ23 M23 YY23 ZZ23
% global XX23 XY23 XZ23 YZ23 MX24 MY24 MZ24 M24 YY24 ZZ24
% global XX24 XY24 XZ24 YZ24 qp21 qpp21 MX25 MY25 MZ25 M25
% global YY25 ZZ25 XX25 XY25 XZ25 YZ25 qp22 qpp22 MX26 MY26
% global MZ26 M26 YY26 ZZ26 XX26 XY26 XZ26 YZ26 d27 MX27
% global MY27 MZ27 M27 YY27 ZZ27 XX27 XY27 XZ27 YZ27 FX14
% global FY14 FZ14 CX14 CY14 CZ14 MZ2 MZ1 MY1 IA2 IA3
% global IA4 IA5 IA6 IA7 IA8 IA9 IA10 IA11 IA12 IA13
% global IA15 IA16 IA17 IA18 IA20 IA21 IA22 IA23 IA25 IA26

% Declaration of global output variables
% global GAM2 GAM3 GAM4 GAM5 GAM6 GAM7 GAM8 GAM9 GAM10 GAM11
% global GAM12 GAM13 GAM15 GAM16 GAM17 GAM18 GAM20 GAM21 GAM22 GAM23
% global GAM25 GAM26 E10 E20 E30 N10 N20 N30

% Function description:
function [F0,M0,Gamma]= Newton_Euler_Symoro2(q,qp,qpp)
d2=0.04519;
l1=0.095;
d4=0.1029;
d5=0.1;
r7=0.07071;
r15=-0.233;
r17=0.105;
r19=0.1137;
b15=0.19091;
b20=0.19091;
r20=-0.037;
r25=0.1615;
d27=0.030;

q1=q(1);
q2=q(2);
q3=q(3);
q4=q(4);
q5=q(5);
q6=q(6);
q7=q(7);
q8=q(8);
q9=q(9);
q10=q(10);
q11=q(11);
q12=q(12);
q13=q(13);
q14=q(14);
q15=q(15);
q16=q(16);
q17=q(17);
q18=q(18);
q19=q(19);
q20=q(20);
q21=q(21);
q22=q(22);

qp1=qp(1);
qp2=qp(2);
qp3=qp(3);
qp4=qp(4);
qp5=qp(5);
qp6=qp(6);
qp7=qp(7);
qp8=qp(8);
qp9=qp(9);
qp10=qp(10);
qp11=qp(11);
qp12=qp(12);
qp13=qp(13);
qp14=qp(14);
qp15=qp(15);
qp16=qp(16);
qp17=qp(17);
qp18=qp(18);
qp19=qp(19);
qp20=qp(20);
qp21=qp(21);
qp22=qp(22);

qpp1=qpp(1);
qpp2=qpp(2);
qpp3=qpp(3);
qpp4=qpp(4);
qpp5=qpp(5);
qpp6=qpp(6);
qpp7=qpp(7);
qpp8=qpp(8);
qpp9=qpp(9);
qpp10=qpp(10);
qpp11=qpp(11);
qpp12=qpp(12);
qpp13=qpp(13);
qpp14=qpp(14);
qpp15=qpp(15);
qpp16=qpp(16);
qpp17=qpp(17);
qpp18=qpp(18);
qpp19=qpp(19);
qpp20=qpp(20);
qpp21=qpp(21);
qpp22=qpp(22);

PI=Mass_information;
Ia=actuator_inertia;

IA2=Ia(1);
IA3=Ia(2);
IA4=Ia(3);
IA5=Ia(4);
IA6=Ia(5);
IA7=Ia(6);
IA8=Ia(7);
IA9=Ia(8);
IA10=Ia(9);
IA11=Ia(10);
IA12=Ia(11);
IA13=Ia(12);
IA15=Ia(13);
IA16=Ia(14);
IA17=Ia(15);
IA18=Ia(16);
IA20=Ia(17);
IA21=Ia(18);
IA22=Ia(19);
IA23=Ia(20);
IA25=Ia(21);
IA26=Ia(22);

M=PI.masse;
M1=M(1);
M2=M(2);
M3=M(3);
M4=M(4);
M5=M(5);
M6=M(6);
M7=M(7);
M8=M(8);
M9=M(9);
M10=M(10);
M11=M(11);
M12=M(12);
M13=M(13);
M14=M(14);
M15=M(15);
M16=M(16);
M17=M(17);
M18=M(18);
M19=M(19);
M20=M(20);
M21=M(21);
M22=M(22);
M23=M(23);
M24=M(24);
M25=M(25);
M26=M(26);
M27=M(27);

% External forces at frame 14 (free foot point)
FX14=0;    
FY14=0;    
FZ14=0; 
CX14=0; 
CY14=0;     
CZ14=0;    

I=PI.I;
robot=genebot();
robot.q=q;
T = DGM(robot);

MjSj = cell(1,27);
for i=1:27
    MjSj{i} = M(i)*PI.CoM{i};
end

XX1 = I{1}(1,1);
XY1 = I{1}(1,2);
XZ1 = I{1}(1,3);
YY1 = I{1}(2,2);
YZ1 = I{1}(2,3); 
ZZ1 = I{1}(3,3);
MX1 = MjSj{1}(1);
MY1 = MjSj{1}(2);
MZ1 = MjSj{1}(3);

XX2 = I{2}(1,1);
XY2 = I{2}(1,2);
XZ2 = I{2}(1,3);
YY2 = I{2}(2,2);
YZ2 = I{2}(2,3); 
ZZ2 = I{2}(3,3);
MX2 = MjSj{2}(1);
MY2 = MjSj{2}(2);
MZ2 = MjSj{2}(3);

XX3 = I{3}(1,1);
XY3 = I{3}(1,2);
XZ3 = I{3}(1,3);
YY3 = I{3}(2,2);
YZ3 = I{3}(2,3); 
ZZ3 = I{3}(3,3);
ZZ3 = I{3}(3,3);
MX3 = MjSj{3}(1);
MY3 = MjSj{3}(2);
MZ3 = MjSj{3}(3);

XX4 = I{4}(1,1);
XY4 = I{4}(1,2);
XZ4 = I{4}(1,3);
YY4 = I{4}(2,2);
YZ4 = I{4}(2,3); 
ZZ4 = I{4}(3,3);
MX4 = MjSj{4}(1);
MY4 = MjSj{4}(2);
MZ4 = MjSj{4}(3);

XX5 = I{5}(1,1);
XY5 = I{5}(1,2);
XZ5 = I{5}(1,3);
YY5 = I{5}(2,2);
YZ5 = I{5}(2,3); 
ZZ5 = I{5}(3,3);
MX5 = MjSj{5}(1);
MY5 = MjSj{5}(2);
MZ5 = MjSj{5}(3);

XX6 = I{6}(1,1);
XY6 = I{6}(1,2);
XZ6 = I{6}(1,3);
YY6 = I{6}(2,2);
YZ6 = I{6}(2,3); 
ZZ6 = I{6}(3,3);
MX6 = MjSj{6}(1);
MY6 = MjSj{6}(2);
MZ6 = MjSj{6}(3);

XX7 = I{7}(1,1);
XY7 = I{7}(1,2);
XZ7 = I{7}(1,3);
YY7 = I{7}(2,2);
YZ7 = I{7}(2,3); 
ZZ7 = I{7}(3,3);
MX7 = MjSj{7}(1);
MY7 = MjSj{7}(2);
MZ7 = MjSj{7}(3);

XX8 = I{8}(1,1);
XY8 = I{8}(1,2);
XZ8 = I{8}(1,3);
YY8 = I{8}(2,2);
YZ8 = I{8}(2,3); 
ZZ8 = I{8}(3,3);
MX8 = MjSj{8}(1);
MY8 = MjSj{8}(2);
MZ8 = MjSj{8}(3);

XX9 = I{9}(1,1);
XY9 = I{9}(1,2);
XZ9 = I{9}(1,3);
YY9 = I{9}(2,2);
YZ9 = I{9}(2,3); 
ZZ9 = I{9}(3,3);
MX9 = MjSj{9}(1);
MY9 = MjSj{9}(2);
MZ9 = MjSj{9}(3);

XX10 = I{10}(1,1);
XY10 = I{10}(1,2);
XZ10 = I{10}(1,3);
YY10 = I{10}(2,2);
YZ10 = I{10}(2,3); 
ZZ10 = I{10}(3,3);
MX10 = MjSj{10}(1);
MY10 = MjSj{10}(2);
MZ10 = MjSj{10}(3);

XX11 = I{11}(1,1);
XY11 = I{11}(1,2);
XZ11 = I{11}(1,3);
YY11 = I{11}(2,2);
YZ11 = I{11}(2,3); 
ZZ11 = I{11}(3,3);
MX11 = MjSj{11}(1);
MY11 = MjSj{11}(2);
MZ11 = MjSj{11}(3);

XX12 = I{12}(1,1);
XY12 = I{12}(1,2);
XZ12 = I{12}(1,3);
YY12 = I{12}(2,2);
YZ12 = I{12}(2,3); 
ZZ12 = I{12}(3,3);
MX12 = MjSj{12}(1);
MY12 = MjSj{12}(2);
MZ12 = MjSj{12}(3);

XX13 = I{13}(1,1);
XY13 = I{13}(1,2);
XZ13 = I{13}(1,3);
YY13 = I{13}(2,2);
YZ13 = I{13}(2,3); 
ZZ13 = I{13}(3,3);
MX13 = MjSj{13}(1);
MY13 = MjSj{13}(2);
MZ13 = MjSj{13}(3);

XX14 = I{14}(1,1);
XY14 = I{14}(1,2);
XZ14 = I{14}(1,3);
YY14 = I{14}(2,2);
YZ14 = I{14}(2,3); 
ZZ14 = I{14}(3,3);
MX14 = MjSj{14}(1);
MY14 = MjSj{14}(2);
MZ14 = MjSj{14}(3);

XX15 = I{15}(1,1);
XY15 = I{15}(1,2);
XZ15 = I{15}(1,3);
YY15 = I{15}(2,2);
YZ15 = I{15}(2,3); 
ZZ15 = I{15}(3,3);
MX15 = MjSj{15}(1);
MY15 = MjSj{15}(2);
MZ15 = MjSj{15}(3);

XX16 = I{16}(1,1);
XY16 = I{16}(1,2);
XZ16 = I{16}(1,3);
YY16 = I{16}(2,2);
YZ16 = I{16}(2,3); 
ZZ16 = I{16}(3,3);
MX16 = MjSj{16}(1);
MY16 = MjSj{16}(2);
MZ16 = MjSj{16}(3);

XX17 = I{17}(1,1);
XY17 = I{17}(1,2);
XZ17 = I{17}(1,3);
YY17 = I{17}(2,2);
YZ17 = I{17}(2,3); 
ZZ17 = I{17}(3,3);
MX17 = MjSj{17}(1);
MY17 = MjSj{17}(2);
MZ17 = MjSj{17}(3);

XX18 = I{18}(1,1);
XY18 = I{18}(1,2);
XZ18 = I{18}(1,3);
YY18 = I{18}(2,2);
YZ18 = I{18}(2,3); 
ZZ18 = I{18}(3,3);
MX18 = MjSj{18}(1);
MY18 = MjSj{18}(2);
MZ18 = MjSj{18}(3);

XX19 = I{19}(1,1);
XY19 = I{19}(1,2);
XZ19 = I{19}(1,3);
YY19 = I{19}(2,2);
YZ19 = I{19}(2,3); 
ZZ19 = I{19}(3,3);
MX19 = MjSj{19}(1);
MY19 = MjSj{19}(2);
MZ19 = MjSj{19}(3);

XX20 = I{20}(1,1);
XY20 = I{20}(1,2);
XZ20 = I{20}(1,3);
YY20 = I{20}(2,2);
YZ20 = I{20}(2,3); 
ZZ20 = I{20}(3,3);
MX20 = MjSj{20}(1);
MY20 = MjSj{20}(2);
MZ20 = MjSj{20}(3);

XX21 = I{21}(1,1);
XY21 = I{21}(1,2);
XZ21 = I{21}(1,3);
YY21 = I{21}(2,2);
YZ21 = I{21}(2,3); 
ZZ21 = I{21}(3,3);
MX21 = MjSj{21}(1);
MY21 = MjSj{21}(2);
MZ21 = MjSj{21}(3);

XX22 = I{22}(1,1);
XY22 = I{22}(1,2);
XZ22 = I{22}(1,3);
YY22 = I{22}(2,2);
YZ22 = I{22}(2,3); 
ZZ22 = I{22}(3,3);
MX22 = MjSj{22}(1);
MY22 = MjSj{22}(2);
MZ22 = MjSj{22}(3);

XX23 = I{23}(1,1);
XY23 = I{23}(1,2);
XZ23 = I{23}(1,3);
YY23 = I{23}(2,2);
YZ23 = I{23}(2,3); 
ZZ23 = I{23}(3,3);
MX23 = MjSj{23}(1);
MY23 = MjSj{23}(2);
MZ23 = MjSj{23}(3);

XX24 = I{24}(1,1);
XY24 = I{24}(1,2);
XZ24 = I{24}(1,3);
YY24 = I{24}(2,2);
YZ24 = I{24}(2,3); 
ZZ24 = I{24}(3,3);
MX24 = MjSj{24}(1);
MY24 = MjSj{24}(2);
MZ24 = MjSj{24}(3);

XX25 = I{25}(1,1);
XY25 = I{25}(1,2);
XZ25 = I{25}(1,3);
YY25 = I{25}(2,2);
YZ25 = I{25}(2,3); 
ZZ25 = I{25}(3,3);
MX25 = MjSj{25}(1);
MY25 = MjSj{25}(2);
MZ25 = MjSj{25}(3);

XX26 = I{26}(1,1);
XY26 = I{26}(1,2);
XZ26 = I{26}(1,3);
YY26 = I{26}(2,2);
YZ26 = I{26}(2,3); 
ZZ26 = I{26}(3,3);
MX26 = MjSj{26}(1);
MY26 = MjSj{26}(2);
MZ26 = MjSj{26}(3);

XX27 = I{27}(1,1);
XY27 = I{27}(1,2);
XZ27 = I{27}(1,3);
YY27 = I{27}(2,2);
YZ27 = I{27}(2,3); 
ZZ27 = I{27}(3,3);
MX27 = MjSj{27}(1);
MY27 = MjSj{27}(2);
MZ27 = MjSj{27}(3);

G3=-9.81;

	S2=sin(q1);
	C2=cos(q1);
	S3=sin(q2);
	C3=cos(q2);
	S4=sin(q3);
	C4=cos(q3);
	S5=sin(q4);
	C5=cos(q4);
	S6=sin(pi./4. + q5);
	C6=cos(pi./4. + q5);
	S7=cos(q6);
	C7=-sin(q6);
	S8=-cos(q7);
	C8=sin(q7);
	S9=sin(pi./4. + q8);
	C9=cos(pi./4. + q8);
	S10=sin(q9);
	C10=cos(q9);
	S11=sin(q10);
	C11=cos(q10);
	S12=sin(q11);
	C12=cos(q11);
	S13=sin(q12);
	C13=cos(q12);
	S15=sin(q13);
	C15=cos(q13);
	Sa15=-(1./sqrt(2));
	Ca15=1./sqrt(2);
	A2115=Ca15.*S15;
	A2215=C15.*Ca15;
	A3115=S15.*Sa15;
	A3215=C15.*Sa15;
	LOO215=-(r15.*Sa15);
	LOO315=b15 + Ca15.*r15;
	S16=cos(q14);
	C16=-sin(q14);
	S17=sin(q15);
	C17=cos(q15);
	S18=sin(q16);
	C18=cos(q16);
	S20=sin(q17);
	C20=cos(q17);
	Sa20=-(1./sqrt(2));
	Ca20=1./sqrt(2);
	A2120=Ca20.*S20;
	A2220=C20.*Ca20;
	A3120=S20.*Sa20;
	A3220=C20.*Sa20;
	LOO220=-(r20.*Sa20);
	LOO320=b20 + Ca20.*r20;
	S21=cos(q18);
	C21=-sin(q18);
	S22=sin(q19);
	C22=cos(q19);
	S23=sin(q20);
	C23=cos(q20);
	S25=sin(q21);
	C25=cos(q21);
	Sa25=1./sqrt(2);
	Ca25=1./sqrt(2);
	A2125=Ca25.*S25;
	A2225=C25.*Ca25;
	A3125=S25.*Sa25;
	A3225=C25.*Sa25;
	LOO225=-(r25.*Sa25);
	LOO325=Ca25.*r25;
	S26=-cos(q22);
	C26=sin(q22);
	F11=-(G3.*M1);
	DV332=-qp1.^2;
	VP12=-(C2.*G3);
	VP22=G3.*S2;
	F12=DV332.*MX2 - MY2.*qpp1 + M2.*VP12;
	F22=DV332.*MY2 + MX2.*qpp1 + M2.*VP22;
	No12=qpp1.*XZ2 + DV332.*YZ2;
	No22=-(DV332.*XZ2) + qpp1.*YZ2;
	No32=qpp1.*ZZ2;
	WI13=qp1.*S3;
	WI23=C3.*qp1;
	WP13=qpp1.*S3 + qp2.*WI23;
	WP23=C3.*qpp1 - qp2.*WI13;
	DV113=-WI13.^2;
	DV223=-WI23.^2;
	DV333=-qp2.^2;
	DV123=WI13.*WI23;
	DV133=qp2.*WI13;
	DV233=qp2.*WI23;
	U113=DV223 + DV333;
	U123=DV123 - qpp2;
	U133=DV133 + WP23;
	U213=DV123 + qpp2;
	U223=DV113 + DV333;
	U233=DV233 - WP13;
	U313=DV133 - WP23;
	U323=DV233 + WP13;
	U333=DV113 + DV223;
	VP13=C3.*VP12;
	VP23=-(S3.*VP12);
	F13=MX3.*U113 + MY3.*U123 + MZ3.*U133 + M3.*VP13;
	F23=MX3.*U213 + MY3.*U223 + MZ3.*U233 + M3.*VP23;
	F33=MX3.*U313 + MY3.*U323 + MZ3.*U333 - M3.*VP22;
	PIS13=-YY3 + ZZ3;
	PIS23=XX3 - ZZ3;
	PIS33=-XX3 + YY3;
	No13=DV233.*PIS13 + WP13.*XX3 - U313.*XY3 + U213.*XZ3 + (-DV223 + DV333).*YZ3;
	No23=DV133.*PIS23 + U323.*XY3 + (DV113 - DV333).*XZ3 + WP23.*YY3 - U123.*YZ3;
	No33=DV123.*PIS33 + (-DV113 + DV223).*XY3 - U233.*XZ3 + U133.*YZ3 + qpp2.*ZZ3;
	WI14=C4.*WI13 + S4.*WI23;
	WI24=-(S4.*WI13) + C4.*WI23;
	W34=qp2 + qp3;
	WP14=qp3.*WI24 + C4.*WP13 + S4.*WP23;
	WP24=-(qp3.*WI14) - S4.*WP13 + C4.*WP23;
	WP34=qpp2 + qpp3;
	DV114=-WI14.^2;
	DV224=-WI24.^2;
	DV334=-W34.^2;
	DV124=WI14.*WI24;
	DV134=W34.*WI14;
	DV234=W34.*WI24;
	U114=DV224 + DV334;
	U124=DV124 - WP34;
	U134=DV134 + WP24;
	U214=DV124 + WP34;
	U224=DV114 + DV334;
	U234=DV234 - WP14;
	U314=DV134 - WP24;
	U324=DV234 + WP14;
	U334=DV114 + DV224;
	VSP14=d4.*U113 + VP13;
	VSP24=d4.*U213 + VP23;
	VSP34=d4.*U313 - VP22;
	VP14=C4.*VSP14 + S4.*VSP24;
	VP24=-(S4.*VSP14) + C4.*VSP24;
	F14=MX4.*U114 + MY4.*U124 + MZ4.*U134 + M4.*VP14;
	F24=MX4.*U214 + MY4.*U224 + MZ4.*U234 + M4.*VP24;
	F34=MX4.*U314 + MY4.*U324 + MZ4.*U334 + M4.*VSP34;
	PIS14=-YY4 + ZZ4;
	PIS24=XX4 - ZZ4;
	PIS34=-XX4 + YY4;
	No14=DV234.*PIS14 + WP14.*XX4 - U314.*XY4 + U214.*XZ4 + (-DV224 + DV334).*YZ4;
	No24=DV134.*PIS24 + U324.*XY4 + (DV114 - DV334).*XZ4 + WP24.*YY4 - U124.*YZ4;
	No34=DV124.*PIS34 + (-DV114 + DV224).*XY4 - U234.*XZ4 + U134.*YZ4 + WP34.*ZZ4;
	WI15=C5.*WI14 + S5.*WI24;
	WI25=-(S5.*WI14) + C5.*WI24;
	W35=qp4 + W34;
	WP15=qp4.*WI25 + C5.*WP14 + S5.*WP24;
	WP25=-(qp4.*WI15) - S5.*WP14 + C5.*WP24;
	WP35=qpp4 + WP34;
	DV115=-WI15.^2;
	DV225=-WI25.^2;
	DV335=-W35.^2;
	DV125=WI15.*WI25;
	DV135=W35.*WI15;
	DV235=W35.*WI25;
	U115=DV225 + DV335;
	U125=DV125 - WP35;
	U135=DV135 + WP25;
	U215=DV125 + WP35;
	U225=DV115 + DV335;
	U235=DV235 - WP15;
	U315=DV135 - WP25;
	U325=DV235 + WP15;
	U335=DV115 + DV225;
	VSP15=d5.*U114 + VP14;
	VSP25=d5.*U214 + VP24;
	VSP35=d5.*U314 + VSP34;
	VP15=C5.*VSP15 + S5.*VSP25;
	VP25=-(S5.*VSP15) + C5.*VSP25;
	F15=MX5.*U115 + MY5.*U125 + MZ5.*U135 + M5.*VP15;
	F25=MX5.*U215 + MY5.*U225 + MZ5.*U235 + M5.*VP25;
	F35=MX5.*U315 + MY5.*U325 + MZ5.*U335 + M5.*VSP35;
	PIS15=-YY5 + ZZ5;
	PIS25=XX5 - ZZ5;
	PIS35=-XX5 + YY5;
	No15=DV235.*PIS15 + WP15.*XX5 - U315.*XY5 + U215.*XZ5 + (-DV225 + DV335).*YZ5;
	No25=DV135.*PIS25 + U325.*XY5 + (DV115 - DV335).*XZ5 + WP25.*YY5 - U125.*YZ5;
	No35=DV125.*PIS35 + (-DV115 + DV225).*XY5 - U235.*XZ5 + U135.*YZ5 + WP35.*ZZ5;
	WI16=-(S6.*W35) + C6.*WI15;
	WI26=-(C6.*W35) - S6.*WI15;
	W36=qp5 + WI25;
	WP16=qp5.*WI26 + C6.*WP15 - S6.*WP35;
	WP26=-(qp5.*WI16) - S6.*WP15 - C6.*WP35;
	WP36=qpp5 + WP25;
	DV116=-WI16.^2;
	DV226=-WI26.^2;
	DV336=-W36.^2;
	DV126=WI16.*WI26;
	DV136=W36.*WI16;
	DV236=W36.*WI26;
	U116=DV226 + DV336;
	U126=DV126 - WP36;
	U136=DV136 + WP26;
	U216=DV126 + WP36;
	U226=DV116 + DV336;
	U236=DV236 - WP16;
	U316=DV136 - WP26;
	U326=DV236 + WP16;
	U336=DV116 + DV226;
	VP16=C6.*VP15 - S6.*VSP35;
	VP26=-(S6.*VP15) - C6.*VSP35;
	F16=MX6.*U116 + MY6.*U126 + MZ6.*U136 + M6.*VP16;
	F26=MX6.*U216 + MY6.*U226 + MZ6.*U236 + M6.*VP26;
	F36=MX6.*U316 + MY6.*U326 + MZ6.*U336 + M6.*VP25;
	PIS16=-YY6 + ZZ6;
	PIS26=XX6 - ZZ6;
	PIS36=-XX6 + YY6;
	No16=DV236.*PIS16 + WP16.*XX6 - U316.*XY6 + U216.*XZ6 + (-DV226 + DV336).*YZ6;
	No26=DV136.*PIS26 + U326.*XY6 + (DV116 - DV336).*XZ6 + WP26.*YY6 - U126.*YZ6;
	No36=DV126.*PIS36 + (-DV116 + DV226).*XY6 - U236.*XZ6 + U136.*YZ6 + WP36.*ZZ6;
	WI17=S7.*W36 + C7.*WI16;
	WI27=C7.*W36 - S7.*WI16;
	W37=qp6 - WI26;
	WP17=qp6.*WI27 + C7.*WP16 + S7.*WP36;
	WP27=-(qp6.*WI17) - S7.*WP16 + C7.*WP36;
	WP37=qpp6 - WP26;
	DV117=-WI17.^2;
	DV227=-WI27.^2;
	DV337=-W37.^2;
	DV127=WI17.*WI27;
	DV137=W37.*WI17;
	DV237=W37.*WI27;
	U117=DV227 + DV337;
	U127=DV127 - WP37;
	U137=DV137 + WP27;
	U217=DV127 + WP37;
	U227=DV117 + DV337;
	U237=DV237 - WP17;
	U317=DV137 - WP27;
	U327=DV237 + WP17;
	U337=DV117 + DV227;
	VSP17=-(r7.*U126) + VP16;
	VSP27=-(r7.*U226) + VP26;
	VSP37=-(r7.*U326) + VP25;
	VP17=C7.*VSP17 + S7.*VSP37;
	VP27=-(S7.*VSP17) + C7.*VSP37;
	F17=MX7.*U117 + MY7.*U127 + MZ7.*U137 + M7.*VP17;
	F27=MX7.*U217 + MY7.*U227 + MZ7.*U237 + M7.*VP27;
	F37=MX7.*U317 + MY7.*U327 + MZ7.*U337 - M7.*VSP27;
	PIS17=-YY7 + ZZ7;
	PIS27=XX7 - ZZ7;
	PIS37=-XX7 + YY7;
	No17=DV237.*PIS17 + WP17.*XX7 - U317.*XY7 + U217.*XZ7 + (-DV227 + DV337).*YZ7;
	No27=DV137.*PIS27 + U327.*XY7 + (DV117 - DV337).*XZ7 + WP27.*YY7 - U127.*YZ7;
	No37=DV127.*PIS37 + (-DV117 + DV227).*XY7 - U237.*XZ7 + U137.*YZ7 + WP37.*ZZ7;
	WI18=-(S8.*W37) + C8.*WI17;
	WI28=-(C8.*W37) - S8.*WI17;
	W38=qp7 + WI27;
	WP18=qp7.*WI28 + C8.*WP17 - S8.*WP37;
	WP28=-(qp7.*WI18) - S8.*WP17 - C8.*WP37;
	WP38=qpp7 + WP27;
	DV118=-WI18.^2;
	DV228=-WI28.^2;
	DV338=-W38.^2;
	DV128=WI18.*WI28;
	DV138=W38.*WI18;
	DV238=W38.*WI28;
	U118=DV228 + DV338;
	U128=DV128 - WP38;
	U138=DV138 + WP28;
	U218=DV128 + WP38;
	U228=DV118 + DV338;
	U238=DV238 - WP18;
	U318=DV138 - WP28;
	U328=DV238 + WP18;
	U338=DV118 + DV228;
	VSP18=r7.*U127 + VP17;
	VSP28=r7.*U227 + VP27;
	VSP38=r7.*U327 - VSP27;
	VP18=C8.*VSP18 - S8.*VSP38;
	VP28=-(S8.*VSP18) - C8.*VSP38;
	F18=MX8.*U118 + MY8.*U128 + MZ8.*U138 + M8.*VP18;
	F28=MX8.*U218 + MY8.*U228 + MZ8.*U238 + M8.*VP28;
	F38=MX8.*U318 + MY8.*U328 + MZ8.*U338 + M8.*VSP28;
	PIS18=-YY8 + ZZ8;
	PIS28=XX8 - ZZ8;
	PIS38=-XX8 + YY8;
	No18=DV238.*PIS18 + WP18.*XX8 - U318.*XY8 + U218.*XZ8 + (-DV228 + DV338).*YZ8;
	No28=DV138.*PIS28 + U328.*XY8 + (DV118 - DV338).*XZ8 + WP28.*YY8 - U128.*YZ8;
	No38=DV128.*PIS38 + (-DV118 + DV228).*XY8 - U238.*XZ8 + U138.*YZ8 + WP38.*ZZ8;
	WI19=-(S9.*W38) + C9.*WI18;
	WI29=-(C9.*W38) - S9.*WI18;
	W39=qp8 + WI28;
	WP19=qp8.*WI29 + C9.*WP18 - S9.*WP38;
	WP29=-(qp8.*WI19) - S9.*WP18 - C9.*WP38;
	WP39=qpp8 + WP28;
	DV119=-WI19.^2;
	DV229=-WI29.^2;
	DV339=-W39.^2;
	DV129=WI19.*WI29;
	DV139=W39.*WI19;
	DV239=W39.*WI29;
	U119=DV229 + DV339;
	U129=DV129 - WP39;
	U139=DV139 + WP29;
	U219=DV129 + WP39;
	U229=DV119 + DV339;
	U239=DV239 - WP19;
	U319=DV139 - WP29;
	U329=DV239 + WP19;
	U339=DV119 + DV229;
	VP19=C9.*VP18 - S9.*VSP28;
	VP29=-(S9.*VP18) - C9.*VSP28;
	F19=MX9.*U119 + MY9.*U129 + MZ9.*U139 + M9.*VP19;
	F29=MX9.*U219 + MY9.*U229 + MZ9.*U239 + M9.*VP29;
	F39=MX9.*U319 + MY9.*U329 + MZ9.*U339 + M9.*VP28;
	PIS19=-YY9 + ZZ9;
	PIS29=XX9 - ZZ9;
	PIS39=-XX9 + YY9;
	No19=DV239.*PIS19 + WP19.*XX9 - U319.*XY9 + U219.*XZ9 + (-DV229 + DV339).*YZ9;
	No29=DV139.*PIS29 + U329.*XY9 + (DV119 - DV339).*XZ9 + WP29.*YY9 - U129.*YZ9;
	No39=DV129.*PIS39 + (-DV119 + DV229).*XY9 - U239.*XZ9 + U139.*YZ9 + WP39.*ZZ9;
	WI110=S10.*W39 + C10.*WI19;
	WI210=C10.*W39 - S10.*WI19;
	W310=qp9 - WI29;
	WP110=qp9.*WI210 + C10.*WP19 + S10.*WP39;
	WP210=-(qp9.*WI110) - S10.*WP19 + C10.*WP39;
	WP310=qpp9 - WP29;
	DV1110=-WI110.^2;
	DV2210=-WI210.^2;
	DV3310=-W310.^2;
	DV1210=WI110.*WI210;
	DV1310=W310.*WI110;
	DV2310=W310.*WI210;
	U1110=DV2210 + DV3310;
	U1210=DV1210 - WP310;
	U1310=DV1310 + WP210;
	U2110=DV1210 + WP310;
	U2210=DV1110 + DV3310;
	U2310=DV2310 - WP110;
	U3110=DV1310 - WP210;
	U3210=DV2310 + WP110;
	U3310=DV1110 + DV2210;
	VP110=C10.*VP19 + S10.*VP28;
	VP210=-(S10.*VP19) + C10.*VP28;
	F110=MX10.*U1110 + MY10.*U1210 + MZ10.*U1310 + M10.*VP110;
	F210=MX10.*U2110 + MY10.*U2210 + MZ10.*U2310 + M10.*VP210;
	F310=MX10.*U3110 + MY10.*U3210 + MZ10.*U3310 - M10.*VP29;
	PIS110=-YY10 + ZZ10;
	PIS210=XX10 - ZZ10;
	PIS310=-XX10 + YY10;
	No110=DV2310.*PIS110 + WP110.*XX10 - U3110.*XY10 + U2110.*XZ10 + (-DV2210 + DV3310).*YZ10;
	No210=DV1310.*PIS210 + U3210.*XY10 + (DV1110 - DV3310).*XZ10 + WP210.*YY10 - U1210.*YZ10;
	No310=DV1210.*PIS310 + (-DV1110 + DV2210).*XY10 - U2310.*XZ10 + U1310.*YZ10 + WP310.*ZZ10;
	WI111=C11.*WI110 + S11.*WI210;
	WI211=-(S11.*WI110) + C11.*WI210;
	W311=qp10 + W310;
	WP111=qp10.*WI211 + C11.*WP110 + S11.*WP210;
	WP211=-(qp10.*WI111) - S11.*WP110 + C11.*WP210;
	WP311=qpp10 + WP310;
	DV1111=-WI111.^2;
	DV2211=-WI211.^2;
	DV3311=-W311.^2;
	DV1211=WI111.*WI211;
	DV1311=W311.*WI111;
	DV2311=W311.*WI211;
	U1111=DV2211 + DV3311;
	U1211=DV1211 - WP311;
	U1311=DV1311 + WP211;
	U2111=DV1211 + WP311;
	U2211=DV1111 + DV3311;
	U2311=DV2311 - WP111;
	U3111=DV1311 - WP211;
	U3211=DV2311 + WP111;
	U3311=DV1111 + DV2211;
	VSP111=-(d5.*U1110) + VP110;
	VSP211=-(d5.*U2110) + VP210;
	VSP311=-(d5.*U3110) - VP29;
	VP111=C11.*VSP111 + S11.*VSP211;
	VP211=-(S11.*VSP111) + C11.*VSP211;
	F111=MX11.*U1111 + MY11.*U1211 + MZ11.*U1311 + M11.*VP111;
	F211=MX11.*U2111 + MY11.*U2211 + MZ11.*U2311 + M11.*VP211;
	F311=MX11.*U3111 + MY11.*U3211 + MZ11.*U3311 + M11.*VSP311;
	PIS111=-YY11 + ZZ11;
	PIS211=XX11 - ZZ11;
	PIS311=-XX11 + YY11;
	No111=DV2311.*PIS111 + WP111.*XX11 - U3111.*XY11 + U2111.*XZ11 + (-DV2211 + DV3311).*YZ11;
	No211=DV1311.*PIS211 + U3211.*XY11 + (DV1111 - DV3311).*XZ11 + WP211.*YY11 - U1211.*YZ11;
	No311=DV1211.*PIS311 + (-DV1111 + DV2211).*XY11 - U2311.*XZ11 + U1311.*YZ11 + WP311.*ZZ11;
	WI112=C12.*WI111 + S12.*WI211;
	WI212=-(S12.*WI111) + C12.*WI211;
	W312=qp11 + W311;
	WP112=qp11.*WI212 + C12.*WP111 + S12.*WP211;
	WP212=-(qp11.*WI112) - S12.*WP111 + C12.*WP211;
	WP312=qpp11 + WP311;
	DV1112=-WI112.^2;
	DV2212=-WI212.^2;
	DV3312=-W312.^2;
	DV1212=WI112.*WI212;
	DV1312=W312.*WI112;
	DV2312=W312.*WI212;
	U1112=DV2212 + DV3312;
	U1212=DV1212 - WP312;
	U1312=DV1312 + WP212;
	U2112=DV1212 + WP312;
	U2212=DV1112 + DV3312;
	U2312=DV2312 - WP112;
	U3112=DV1312 - WP212;
	U3212=DV2312 + WP112;
	U3312=DV1112 + DV2212;
	VSP112=-(d4.*U1111) + VP111;
	VSP212=-(d4.*U2111) + VP211;
	VSP312=-(d4.*U3111) + VSP311;
	VP112=C12.*VSP112 + S12.*VSP212;
	VP212=-(S12.*VSP112) + C12.*VSP212;
	F112=MX12.*U1112 + MY12.*U1212 + MZ12.*U1312 + M12.*VP112;
	F212=MX12.*U2112 + MY12.*U2212 + MZ12.*U2312 + M12.*VP212;
	F312=MX12.*U3112 + MY12.*U3212 + MZ12.*U3312 + M12.*VSP312;
	PIS112=-YY12 + ZZ12;
	PIS212=XX12 - ZZ12;
	PIS312=-XX12 + YY12;
	No112=DV2312.*PIS112 + WP112.*XX12 - U3112.*XY12 + U2112.*XZ12 + (-DV2212 + DV3312).*YZ12;
	No212=DV1312.*PIS212 + U3212.*XY12 + (DV1112 - DV3312).*XZ12 + WP212.*YY12 - U1212.*YZ12;
	No312=DV1212.*PIS312 + (-DV1112 + DV2212).*XY12 - U2312.*XZ12 + U1312.*YZ12 + WP312.*ZZ12;
	WI113=-(S13.*W312) + C13.*WI112;
	WI213=-(C13.*W312) - S13.*WI112;
	W313=qp12 + WI212;
	WP113=qp12.*WI213 + C13.*WP112 - S13.*WP312;
	WP213=-(qp12.*WI113) - S13.*WP112 - C13.*WP312;
	WP313=qpp12 + WP212;
	DV1113=-WI113.^2;
	DV2213=-WI213.^2;
	DV3313=-W313.^2;
	DV1213=WI113.*WI213;
	DV1313=W313.*WI113;
	DV2313=W313.*WI213;
	U1113=DV2213 + DV3313;
	U1213=DV1213 - WP313;
	U1313=DV1313 + WP213;
	U2113=DV1213 + WP313;
	U2213=DV1113 + DV3313;
	U2313=DV2313 - WP113;
	U3113=DV1313 - WP213;
	U3213=DV2313 + WP113;
	U3313=DV1113 + DV2213;
	VP113=C13.*VP112 - S13.*VSP312;
	VP213=-(S13.*VP112) - C13.*VSP312;
	F113=MX13.*U1113 + MY13.*U1213 + MZ13.*U1313 + M13.*VP113;
	F213=MX13.*U2113 + MY13.*U2213 + MZ13.*U2313 + M13.*VP213;
	F313=MX13.*U3113 + MY13.*U3213 + MZ13.*U3313 + M13.*VP212;
	PIS113=-YY13 + ZZ13;
	PIS213=XX13 - ZZ13;
	PIS313=-XX13 + YY13;
	No113=DV2313.*PIS113 + WP113.*XX13 - U3113.*XY13 + U2113.*XZ13 + (-DV2213 + DV3313).*YZ13;
	No213=DV1313.*PIS213 + U3213.*XY13 + (DV1113 - DV3313).*XZ13 + WP213.*YY13 - U1213.*YZ13;
	No313=DV1213.*PIS313 + (-DV1113 + DV2213).*XY13 - U2313.*XZ13 + U1313.*YZ13 + WP313.*ZZ13;
	DV1114=-WI113.^2;
	DV2214=-WI213.^2;
	DV3314=-W313.^2;
	DV1214=WI113.*WI213;
	DV1314=W313.*WI113;
	DV2314=W313.*WI213;
	U1114=DV2214 + DV3314;
	U1214=DV1214 - WP313;
	U1314=DV1314 + WP213;
	U2114=DV1214 + WP313;
	U2214=DV1114 + DV3314;
	U2314=DV2314 - WP113;
	U3114=DV1314 - WP213;
	U3214=DV2314 + WP113;
	U3314=DV1114 + DV2214;
	VSP114=-(d2.*U1113) + l1.*U1313 + VP113;
	VSP214=-(d2.*U2113) + l1.*U2313 + VP213;
	VSP314=-(d2.*U3113) + l1.*U3313 + VP212;
	F114=MX14.*U1114 + MY14.*U1214 + MZ14.*U1314 + M14.*VSP114;
	F214=MX14.*U2114 + MY14.*U2214 + MZ14.*U2314 + M14.*VSP214;
	F314=MX14.*U3114 + MY14.*U3214 + MZ14.*U3314 + M14.*VSP314;
	PIS114=-YY14 + ZZ14;
	PIS214=XX14 - ZZ14;
	PIS314=-XX14 + YY14;
	No114=DV2314.*PIS114 + WP113.*XX14 - U3114.*XY14 + U2114.*XZ14 + (-DV2214 + DV3314).*YZ14;
	No214=DV1314.*PIS214 + U3214.*XY14 + (DV1114 - DV3314).*XZ14 + WP213.*YY14 - U1214.*YZ14;
	No314=DV1214.*PIS314 + (-DV1114 + DV2214).*XY14 - U2314.*XZ14 + U1314.*YZ14 + WP313.*ZZ14;
	WI115=A3115.*W37 + C15.*WI17 + A2115.*WI27;
	WI215=A3215.*W37 - S15.*WI17 + A2215.*WI27;
	WI315=Ca15.*W37 - Sa15.*WI27;
	W315=qp13 + WI315;
	WP115=qp13.*WI215 + C15.*WP17 + A2115.*WP27 + A3115.*WP37;
	WP215=-(qp13.*WI115) - S15.*WP17 + A2215.*WP27 + A3215.*WP37;
	WP315=qpp13 - Sa15.*WP27 + Ca15.*WP37;
	DV1115=-WI115.^2;
	DV2215=-WI215.^2;
	DV3315=-W315.^2;
	DV1215=WI115.*WI215;
	DV1315=W315.*WI115;
	DV2315=W315.*WI215;
	U1115=DV2215 + DV3315;
	U1215=DV1215 - WP315;
	U1315=DV1315 + WP215;
	U2115=DV1215 + WP315;
	U2215=DV1115 + DV3315;
	U2315=DV2315 - WP115;
	U3115=DV1315 - WP215;
	U3215=DV2315 + WP115;
	U3315=DV1115 + DV2215;
	VSP115=LOO215.*U127 + LOO315.*U137 + VP17;
	VSP215=LOO215.*U227 + LOO315.*U237 + VP27;
	VSP315=LOO215.*U327 + LOO315.*U337 - VSP27;
	VP115=C15.*VSP115 + A2115.*VSP215 + A3115.*VSP315;
	VP215=-(S15.*VSP115) + A2215.*VSP215 + A3215.*VSP315;
	VP315=-(Sa15.*VSP215) + Ca15.*VSP315;
	F115=MX15.*U1115 + MY15.*U1215 + MZ15.*U1315 + M15.*VP115;
	F215=MX15.*U2115 + MY15.*U2215 + MZ15.*U2315 + M15.*VP215;
	F315=MX15.*U3115 + MY15.*U3215 + MZ15.*U3315 + M15.*VP315;
	PIS115=-YY15 + ZZ15;
	PIS215=XX15 - ZZ15;
	PIS315=-XX15 + YY15;
	No115=DV2315.*PIS115 + WP115.*XX15 - U3115.*XY15 + U2115.*XZ15 + (-DV2215 + DV3315).*YZ15;
	No215=DV1315.*PIS215 + U3215.*XY15 + (DV1115 - DV3315).*XZ15 + WP215.*YY15 - U1215.*YZ15;
	No315=DV1215.*PIS315 + (-DV1115 + DV2215).*XY15 - U2315.*XZ15 + U1315.*YZ15 + WP315.*ZZ15;
	WI116=S16.*W315 + C16.*WI115;
	WI216=C16.*W315 - S16.*WI115;
	W316=qp14 - WI215;
	WP116=qp14.*WI216 + C16.*WP115 + S16.*WP315;
	WP216=-(qp14.*WI116) - S16.*WP115 + C16.*WP315;
	WP316=qpp14 - WP215;
	DV1116=-WI116.^2;
	DV2216=-WI216.^2;
	DV3316=-W316.^2;
	DV1216=WI116.*WI216;
	DV1316=W316.*WI116;
	DV2316=W316.*WI216;
	U1116=DV2216 + DV3316;
	U1216=DV1216 - WP316;
	U1316=DV1316 + WP216;
	U2116=DV1216 + WP316;
	U2216=DV1116 + DV3316;
	U2316=DV2316 - WP116;
	U3116=DV1316 - WP216;
	U3216=DV2316 + WP116;
	U3316=DV1116 + DV2216;
	VP116=C16.*VP115 + S16.*VP315;
	VP216=-(S16.*VP115) + C16.*VP315;
	F116=MX16.*U1116 + MY16.*U1216 + MZ16.*U1316 + M16.*VP116;
	F216=MX16.*U2116 + MY16.*U2216 + MZ16.*U2316 + M16.*VP216;
	F316=MX16.*U3116 + MY16.*U3216 + MZ16.*U3316 - M16.*VP215;
	PIS116=-YY16 + ZZ16;
	PIS216=XX16 - ZZ16;
	PIS316=-XX16 + YY16;
	No116=DV2316.*PIS116 + WP116.*XX16 - U3116.*XY16 + U2116.*XZ16 + (-DV2216 + DV3316).*YZ16;
	No216=DV1316.*PIS216 + U3216.*XY16 + (DV1116 - DV3316).*XZ16 + WP216.*YY16 - U1216.*YZ16;
	No316=DV1216.*PIS316 + (-DV1116 + DV2216).*XY16 - U2316.*XZ16 + U1316.*YZ16 + WP316.*ZZ16;
	WI117=S17.*W316 + C17.*WI116;
	WI217=C17.*W316 - S17.*WI116;
	W317=qp15 - WI216;
	WP117=qp15.*WI217 + C17.*WP116 + S17.*WP316;
	WP217=-(qp15.*WI117) - S17.*WP116 + C17.*WP316;
	WP317=qpp15 - WP216;
	DV1117=-WI117.^2;
	DV2217=-WI217.^2;
	DV3317=-W317.^2;
	DV1217=WI117.*WI217;
	DV1317=W317.*WI117;
	DV2317=W317.*WI217;
	U1117=DV2217 + DV3317;
	U1217=DV1217 - WP317;
	U1317=DV1317 + WP217;
	U2117=DV1217 + WP317;
	U2217=DV1117 + DV3317;
	U2317=DV2317 - WP117;
	U3117=DV1317 - WP217;
	U3217=DV2317 + WP117;
	U3317=DV1117 + DV2217;
	VSP117=-(r17.*U1216) + VP116;
	VSP217=-(r17.*U2216) + VP216;
	VSP317=-(r17.*U3216) - VP215;
	VP117=C17.*VSP117 + S17.*VSP317;
	VP217=-(S17.*VSP117) + C17.*VSP317;
	F117=MX17.*U1117 + MY17.*U1217 + MZ17.*U1317 + M17.*VP117;
	F217=MX17.*U2117 + MY17.*U2217 + MZ17.*U2317 + M17.*VP217;
	F317=MX17.*U3117 + MY17.*U3217 + MZ17.*U3317 - M17.*VSP217;
	PIS117=-YY17 + ZZ17;
	PIS217=XX17 - ZZ17;
	PIS317=-XX17 + YY17;
	No117=DV2317.*PIS117 + WP117.*XX17 - U3117.*XY17 + U2117.*XZ17 + (-DV2217 + DV3317).*YZ17;
	No217=DV1317.*PIS217 + U3217.*XY17 + (DV1117 - DV3317).*XZ17 + WP217.*YY17 - U1217.*YZ17;
	No317=DV1217.*PIS317 + (-DV1117 + DV2217).*XY17 - U2317.*XZ17 + U1317.*YZ17 + WP317.*ZZ17;
	WI118=-(S18.*W317) + C18.*WI117;
	WI218=-(C18.*W317) - S18.*WI117;
	W318=qp16 + WI217;
	WP118=qp16.*WI218 + C18.*WP117 - S18.*WP317;
	WP218=-(qp16.*WI118) - S18.*WP117 - C18.*WP317;
	WP318=qpp16 + WP217;
	DV1118=-WI118.^2;
	DV2218=-WI218.^2;
	DV3318=-W318.^2;
	DV1218=WI118.*WI218;
	DV1318=W318.*WI118;
	DV2318=W318.*WI218;
	U1118=DV2218 + DV3318;
	U1218=DV1218 - WP318;
	U1318=DV1318 + WP218;
	U2118=DV1218 + WP318;
	U2218=DV1118 + DV3318;
	U2318=DV2318 - WP118;
	U3118=DV1318 - WP218;
	U3218=DV2318 + WP118;
	U3318=DV1118 + DV2218;
	VP118=C18.*VP117 + S18.*VSP217;
	VP218=-(S18.*VP117) + C18.*VSP217;
	F118=MX18.*U1118 + MY18.*U1218 + MZ18.*U1318 + M18.*VP118;
	F218=MX18.*U2118 + MY18.*U2218 + MZ18.*U2318 + M18.*VP218;
	F318=MX18.*U3118 + MY18.*U3218 + MZ18.*U3318 + M18.*VP217;
	PIS118=-YY18 + ZZ18;
	PIS218=XX18 - ZZ18;
	PIS318=-XX18 + YY18;
	No118=DV2318.*PIS118 + WP118.*XX18 - U3118.*XY18 + U2118.*XZ18 + (-DV2218 + DV3318).*YZ18;
	No218=DV1318.*PIS218 + U3218.*XY18 + (DV1118 - DV3318).*XZ18 + WP218.*YY18 - U1218.*YZ18;
	No318=DV1218.*PIS318 + (-DV1118 + DV2218).*XY18 - U2318.*XZ18 + U1318.*YZ18 + WP318.*ZZ18;
	DV1119=-WI118.^2;
	DV2219=-W318.^2;
	DV3319=-WI218.^2;
	DV1219=W318.*WI118;
	DV1319=-(WI118.*WI218);
	DV2319=-(W318.*WI218);
	U1119=DV2219 + DV3319;
	U1219=DV1219 + WP218;
	U1319=DV1319 + WP318;
	U2119=DV1219 - WP218;
	U2219=DV1119 + DV3319;
	U2319=DV2319 - WP118;
	U3119=DV1319 - WP318;
	U3219=DV2319 + WP118;
	U3319=DV1119 + DV2219;
	VSP119=-(r19.*U1218) + VP118;
	VSP219=-(r19.*U2218) + VP218;
	VSP319=-(r19.*U3218) + VP217;
	F119=MX19.*U1119 + MY19.*U1219 + MZ19.*U1319 + M19.*VSP119;
	F219=MX19.*U2119 + MY19.*U2219 + MZ19.*U2319 + M19.*VSP319;
	F319=MX19.*U3119 + MY19.*U3219 + MZ19.*U3319 - M19.*VSP219;
	PIS119=-YY19 + ZZ19;
	PIS219=XX19 - ZZ19;
	PIS319=-XX19 + YY19;
	No119=DV2319.*PIS119 + WP118.*XX19 - U3119.*XY19 + U2119.*XZ19 + (-DV2219 + DV3319).*YZ19;
	No219=DV1319.*PIS219 + U3219.*XY19 + (DV1119 - DV3319).*XZ19 + WP318.*YY19 - U1219.*YZ19;
	No319=DV1219.*PIS319 + (-DV1119 + DV2219).*XY19 - U2319.*XZ19 + U1319.*YZ19 - WP218.*ZZ19;
	WI120=A3120.*W37 + C20.*WI17 + A2120.*WI27;
	WI220=A3220.*W37 - S20.*WI17 + A2220.*WI27;
	WI320=Ca20.*W37 - Sa20.*WI27;
	W320=qp17 + WI320;
	WP120=qp17.*WI220 + C20.*WP17 + A2120.*WP27 + A3120.*WP37;
	WP220=-(qp17.*WI120) - S20.*WP17 + A2220.*WP27 + A3220.*WP37;
	WP320=qpp17 - Sa20.*WP27 + Ca20.*WP37;
	DV1120=-WI120.^2;
	DV2220=-WI220.^2;
	DV3320=-W320.^2;
	DV1220=WI120.*WI220;
	DV1320=W320.*WI120;
	DV2320=W320.*WI220;
	U1120=DV2220 + DV3320;
	U1220=DV1220 - WP320;
	U1320=DV1320 + WP220;
	U2120=DV1220 + WP320;
	U2220=DV1120 + DV3320;
	U2320=DV2320 - WP120;
	U3120=DV1320 - WP220;
	U3220=DV2320 + WP120;
	U3320=DV1120 + DV2220;
	VSP120=LOO220.*U127 + LOO320.*U137 + VP17;
	VSP220=LOO220.*U227 + LOO320.*U237 + VP27;
	VSP320=LOO220.*U327 + LOO320.*U337 - VSP27;
	VP120=C20.*VSP120 + A2120.*VSP220 + A3120.*VSP320;
	VP220=-(S20.*VSP120) + A2220.*VSP220 + A3220.*VSP320;
	VP320=-(Sa20.*VSP220) + Ca20.*VSP320;
	F120=MX20.*U1120 + MY20.*U1220 + MZ20.*U1320 + M20.*VP120;
	F220=MX20.*U2120 + MY20.*U2220 + MZ20.*U2320 + M20.*VP220;
	F320=MX20.*U3120 + MY20.*U3220 + MZ20.*U3320 + M20.*VP320;
	PIS120=-YY20 + ZZ20;
	PIS220=XX20 - ZZ20;
	PIS320=-XX20 + YY20;
	No120=DV2320.*PIS120 + WP120.*XX20 - U3120.*XY20 + U2120.*XZ20 + (-DV2220 + DV3320).*YZ20;
	No220=DV1320.*PIS220 + U3220.*XY20 + (DV1120 - DV3320).*XZ20 + WP220.*YY20 - U1220.*YZ20;
	No320=DV1220.*PIS320 + (-DV1120 + DV2220).*XY20 - U2320.*XZ20 + U1320.*YZ20 + WP320.*ZZ20;
	WI121=S21.*W320 + C21.*WI120;
	WI221=C21.*W320 - S21.*WI120;
	W321=qp18 - WI220;
	WP121=qp18.*WI221 + C21.*WP120 + S21.*WP320;
	WP221=-(qp18.*WI121) - S21.*WP120 + C21.*WP320;
	WP321=qpp18 - WP220;
	DV1121=-WI121.^2;
	DV2221=-WI221.^2;
	DV3321=-W321.^2;
	DV1221=WI121.*WI221;
	DV1321=W321.*WI121;
	DV2321=W321.*WI221;
	U1121=DV2221 + DV3321;
	U1221=DV1221 - WP321;
	U1321=DV1321 + WP221;
	U2121=DV1221 + WP321;
	U2221=DV1121 + DV3321;
	U2321=DV2321 - WP121;
	U3121=DV1321 - WP221;
	U3221=DV2321 + WP121;
	U3321=DV1121 + DV2221;
	VP121=C21.*VP120 + S21.*VP320;
	VP221=-(S21.*VP120) + C21.*VP320;
	F121=MX21.*U1121 + MY21.*U1221 + MZ21.*U1321 + M21.*VP121;
	F221=MX21.*U2121 + MY21.*U2221 + MZ21.*U2321 + M21.*VP221;
	F321=MX21.*U3121 + MY21.*U3221 + MZ21.*U3321 - M21.*VP220;
	PIS121=-YY21 + ZZ21;
	PIS221=XX21 - ZZ21;
	PIS321=-XX21 + YY21;
	No121=DV2321.*PIS121 + WP121.*XX21 - U3121.*XY21 + U2121.*XZ21 + (-DV2221 + DV3321).*YZ21;
	No221=DV1321.*PIS221 + U3221.*XY21 + (DV1121 - DV3321).*XZ21 + WP221.*YY21 - U1221.*YZ21;
	No321=DV1221.*PIS321 + (-DV1121 + DV2221).*XY21 - U2321.*XZ21 + U1321.*YZ21 + WP321.*ZZ21;
	WI122=S22.*W321 + C22.*WI121;
	WI222=C22.*W321 - S22.*WI121;
	W322=qp19 - WI221;
	WP122=qp19.*WI222 + C22.*WP121 + S22.*WP321;
	WP222=-(qp19.*WI122) - S22.*WP121 + C22.*WP321;
	WP322=qpp19 - WP221;
	DV1122=-WI122.^2;
	DV2222=-WI222.^2;
	DV3322=-W322.^2;
	DV1222=WI122.*WI222;
	DV1322=W322.*WI122;
	DV2322=W322.*WI222;
	U1122=DV2222 + DV3322;
	U1222=DV1222 - WP322;
	U1322=DV1322 + WP222;
	U2122=DV1222 + WP322;
	U2222=DV1122 + DV3322;
	U2322=DV2322 - WP122;
	U3122=DV1322 - WP222;
	U3222=DV2322 + WP122;
	U3322=DV1122 + DV2222;
	VSP122=-(r17.*U1221) + VP121;
	VSP222=-(r17.*U2221) + VP221;
	VSP322=-(r17.*U3221) - VP220;
	VP122=C22.*VSP122 + S22.*VSP322;
	VP222=-(S22.*VSP122) + C22.*VSP322;
	F122=MX22.*U1122 + MY22.*U1222 + MZ22.*U1322 + M22.*VP122;
	F222=MX22.*U2122 + MY22.*U2222 + MZ22.*U2322 + M22.*VP222;
	F322=MX22.*U3122 + MY22.*U3222 + MZ22.*U3322 - M22.*VSP222;
	PIS122=-YY22 + ZZ22;
	PIS222=XX22 - ZZ22;
	PIS322=-XX22 + YY22;
	No122=DV2322.*PIS122 + WP122.*XX22 - U3122.*XY22 + U2122.*XZ22 + (-DV2222 + DV3322).*YZ22;
	No222=DV1322.*PIS222 + U3222.*XY22 + (DV1122 - DV3322).*XZ22 + WP222.*YY22 - U1222.*YZ22;
	No322=DV1222.*PIS322 + (-DV1122 + DV2222).*XY22 - U2322.*XZ22 + U1322.*YZ22 + WP322.*ZZ22;
	WI123=-(S23.*W322) + C23.*WI122;
	WI223=-(C23.*W322) - S23.*WI122;
	W323=qp20 + WI222;
	WP123=qp20.*WI223 + C23.*WP122 - S23.*WP322;
	WP223=-(qp20.*WI123) - S23.*WP122 - C23.*WP322;
	WP323=qpp20 + WP222;
	DV1123=-WI123.^2;
	DV2223=-WI223.^2;
	DV3323=-W323.^2;
	DV1223=WI123.*WI223;
	DV1323=W323.*WI123;
	DV2323=W323.*WI223;
	U1123=DV2223 + DV3323;
	U1223=DV1223 - WP323;
	U1323=DV1323 + WP223;
	U2123=DV1223 + WP323;
	U2223=DV1123 + DV3323;
	U2323=DV2323 - WP123;
	U3123=DV1323 - WP223;
	U3223=DV2323 + WP123;
	U3323=DV1123 + DV2223;
	VP123=C23.*VP122 + S23.*VSP222;
	VP223=-(S23.*VP122) + C23.*VSP222;
	F123=MX23.*U1123 + MY23.*U1223 + MZ23.*U1323 + M23.*VP123;
	F223=MX23.*U2123 + MY23.*U2223 + MZ23.*U2323 + M23.*VP223;
	F323=MX23.*U3123 + MY23.*U3223 + MZ23.*U3323 + M23.*VP222;
	PIS123=-YY23 + ZZ23;
	PIS223=XX23 - ZZ23;
	PIS323=-XX23 + YY23;
	No123=DV2323.*PIS123 + WP123.*XX23 - U3123.*XY23 + U2123.*XZ23 + (-DV2223 + DV3323).*YZ23;
	No223=DV1323.*PIS223 + U3223.*XY23 + (DV1123 - DV3323).*XZ23 + WP223.*YY23 - U1223.*YZ23;
	No323=DV1223.*PIS323 + (-DV1123 + DV2223).*XY23 - U2323.*XZ23 + U1323.*YZ23 + WP323.*ZZ23;
	DV1124=-WI123.^2;
	DV2224=-W323.^2;
	DV3324=-WI223.^2;
	DV1224=W323.*WI123;
	DV1324=-(WI123.*WI223);
	DV2324=-(W323.*WI223);
	U1124=DV2224 + DV3324;
	U1224=DV1224 + WP223;
	U1324=DV1324 + WP323;
	U2124=DV1224 - WP223;
	U2224=DV1124 + DV3324;
	U2324=DV2324 - WP123;
	U3124=DV1324 - WP323;
	U3224=DV2324 + WP123;
	U3324=DV1124 + DV2224;
	VSP124=-(r19.*U1223) + VP123;
	VSP224=-(r19.*U2223) + VP223;
	VSP324=-(r19.*U3223) + VP222;
	F124=MX24.*U1124 + MY24.*U1224 + MZ24.*U1324 + M24.*VSP124;
	F224=MX24.*U2124 + MY24.*U2224 + MZ24.*U2324 + M24.*VSP324;
	F324=MX24.*U3124 + MY24.*U3224 + MZ24.*U3324 - M24.*VSP224;
	PIS124=-YY24 + ZZ24;
	PIS224=XX24 - ZZ24;
	PIS324=-XX24 + YY24;
	No124=DV2324.*PIS124 + WP123.*XX24 - U3124.*XY24 + U2124.*XZ24 + (-DV2224 + DV3324).*YZ24;
	No224=DV1324.*PIS224 + U3224.*XY24 + (DV1124 - DV3324).*XZ24 + WP323.*YY24 - U1224.*YZ24;
	No324=DV1224.*PIS324 + (-DV1124 + DV2224).*XY24 - U2324.*XZ24 + U1324.*YZ24 - WP223.*ZZ24;
	WI125=A3125.*W37 + C25.*WI17 + A2125.*WI27;
	WI225=A3225.*W37 - S25.*WI17 + A2225.*WI27;
	WI325=Ca25.*W37 - Sa25.*WI27;
	W325=qp21 + WI325;
	WP125=qp21.*WI225 + C25.*WP17 + A2125.*WP27 + A3125.*WP37;
	WP225=-(qp21.*WI125) - S25.*WP17 + A2225.*WP27 + A3225.*WP37;
	WP325=qpp21 - Sa25.*WP27 + Ca25.*WP37;
	DV1125=-WI125.^2;
	DV2225=-WI225.^2;
	DV3325=-W325.^2;
	DV1225=WI125.*WI225;
	DV1325=W325.*WI125;
	DV2325=W325.*WI225;
	U1125=DV2225 + DV3325;
	U1225=DV1225 - WP325;
	U1325=DV1325 + WP225;
	U2125=DV1225 + WP325;
	U2225=DV1125 + DV3325;
	U2325=DV2325 - WP125;
	U3125=DV1325 - WP225;
	U3225=DV2325 + WP125;
	U3325=DV1125 + DV2225;
	VSP125=LOO225.*U127 + LOO325.*U137 + VP17;
	VSP225=LOO225.*U227 + LOO325.*U237 + VP27;
	VSP325=LOO225.*U327 + LOO325.*U337 - VSP27;
	VP125=C25.*VSP125 + A2125.*VSP225 + A3125.*VSP325;
	VP225=-(S25.*VSP125) + A2225.*VSP225 + A3225.*VSP325;
	VP325=-(Sa25.*VSP225) + Ca25.*VSP325;
	F125=MX25.*U1125 + MY25.*U1225 + MZ25.*U1325 + M25.*VP125;
	F225=MX25.*U2125 + MY25.*U2225 + MZ25.*U2325 + M25.*VP225;
	F325=MX25.*U3125 + MY25.*U3225 + MZ25.*U3325 + M25.*VP325;
	PIS125=-YY25 + ZZ25;
	PIS225=XX25 - ZZ25;
	PIS325=-XX25 + YY25;
	No125=DV2325.*PIS125 + WP125.*XX25 - U3125.*XY25 + U2125.*XZ25 + (-DV2225 + DV3325).*YZ25;
	No225=DV1325.*PIS225 + U3225.*XY25 + (DV1125 - DV3325).*XZ25 + WP225.*YY25 - U1225.*YZ25;
	No325=DV1225.*PIS325 + (-DV1125 + DV2225).*XY25 - U2325.*XZ25 + U1325.*YZ25 + WP325.*ZZ25;
	WI126=-(S26.*W325) + C26.*WI125;
	WI226=-(C26.*W325) - S26.*WI125;
	W326=qp22 + WI225;
	WP126=qp22.*WI226 + C26.*WP125 - S26.*WP325;
	WP226=-(qp22.*WI126) - S26.*WP125 - C26.*WP325;
	WP326=qpp22 + WP225;
	DV1126=-WI126.^2;
	DV2226=-WI226.^2;
	DV3326=-W326.^2;
	DV1226=WI126.*WI226;
	DV1326=W326.*WI126;
	DV2326=W326.*WI226;
	U1126=DV2226 + DV3326;
	U1226=DV1226 - WP326;
	U1326=DV1326 + WP226;
	U2126=DV1226 + WP326;
	U2226=DV1126 + DV3326;
	U2326=DV2326 - WP126;
	U3126=DV1326 - WP226;
	U3226=DV2326 + WP126;
	U3326=DV1126 + DV2226;
	VP126=C26.*VP125 - S26.*VP325;
	VP226=-(S26.*VP125) - C26.*VP325;
	F126=MX26.*U1126 + MY26.*U1226 + MZ26.*U1326 + M26.*VP126;
	F226=MX26.*U2126 + MY26.*U2226 + MZ26.*U2326 + M26.*VP226;
	F326=MX26.*U3126 + MY26.*U3226 + MZ26.*U3326 + M26.*VP225;
	PIS126=-YY26 + ZZ26;
	PIS226=XX26 - ZZ26;
	PIS326=-XX26 + YY26;
	No126=DV2326.*PIS126 + WP126.*XX26 - U3126.*XY26 + U2126.*XZ26 + (-DV2226 + DV3326).*YZ26;
	No226=DV1326.*PIS226 + U3226.*XY26 + (DV1126 - DV3326).*XZ26 + WP226.*YY26 - U1226.*YZ26;
	No326=DV1226.*PIS326 + (-DV1126 + DV2226).*XY26 - U2326.*XZ26 + U1326.*YZ26 + WP326.*ZZ26;
	DV1127=-W326.^2;
	DV2227=-WI226.^2;
	DV3327=-WI126.^2;
	DV1227=W326.*WI226;
	DV1327=-(W326.*WI126);
	DV2327=-(WI126.*WI226);
	U1127=DV2227 + DV3327;
	U1227=DV1227 + WP126;
	U1327=DV1327 + WP226;
	U2127=DV1227 - WP126;
	U2227=DV1127 + DV3327;
	U2327=DV2327 - WP326;
	U3127=DV1327 - WP226;
	U3227=DV2327 + WP326;
	U3327=DV1127 + DV2227;
	VSP127=d27.*U1226 + VP126;
	VSP227=d27.*U2226 + VP226;
	VSP327=d27.*U3226 + VP225;
	F127=MX27.*U1127 + MY27.*U1227 + MZ27.*U1327 + M27.*VSP327;
	F227=MX27.*U2127 + MY27.*U2227 + MZ27.*U2327 + M27.*VSP227;
	F327=MX27.*U3127 + MY27.*U3227 + MZ27.*U3327 - M27.*VSP127;
	PIS127=-YY27 + ZZ27;
	PIS227=XX27 - ZZ27;
	PIS327=-XX27 + YY27;
	No127=DV2327.*PIS127 + WP326.*XX27 - U3127.*XY27 + U2127.*XZ27 + (-DV2227 + DV3327).*YZ27;
	No227=DV1327.*PIS227 + U3227.*XY27 + (DV1127 - DV3327).*XZ27 + WP226.*YY27 - U1227.*YZ27;
	No327=DV1227.*PIS327 + (-DV1127 + DV2227).*XY27 - U2327.*XZ27 + U1327.*YZ27 - WP126.*ZZ27;
	N127=No127 - MY27.*VSP127 - MZ27.*VSP227;
	N227=No227 + MX27.*VSP127 + MZ27.*VSP327;
	N327=No327 + MX27.*VSP227 - MY27.*VSP327;
	E126=F126 - F327;
	E226=F226 + F227;
	E326=F127 + F326;
	N126=d27.*F127 - N327 + No126 + MY26.*VP225 - MZ26.*VP226;
	N226=N227 + No226 + MZ26.*VP126 - MX26.*VP225;
	N326=d27.*F327 + N127 + No326 - MY26.*VP126 + MX26.*VP226;
	FDI126=C26.*E126 - E226.*S26;
	FDI326=-(C26.*E226) - E126.*S26;
	E125=F125 + FDI126;
	E225=E326 + F225;
	E325=F325 + FDI326;
	N125=C26.*N126 + No125 - N226.*S26 - MZ25.*VP225 + MY25.*VP325;
	N225=N326 + No225 + MZ25.*VP125 - MX25.*VP325;
	N325=-(C26.*N226) + No325 - N126.*S26 - MY25.*VP125 + MX25.*VP225;
	FDI125=C25.*E125 - E225.*S25;
	FDI225=A2125.*E125 + A2225.*E225 - E325.*Sa25;
	FDI325=A3125.*E125 + A3225.*E225 + Ca25.*E325;
	N124=No124 - MY24.*VSP224 - MZ24.*VSP324;
	N224=No224 + MZ24.*VSP124 + MX24.*VSP224;
	N324=No324 - MY24.*VSP124 + MX24.*VSP324;
	E123=F123 + F124;
	E223=F223 - F324;
	E323=F224 + F323;
	N123=N124 + No123 - F224.*r19 + MY23.*VP222 - MZ23.*VP223;
	N223=-N324 + No223 + MZ23.*VP123 - MX23.*VP222;
	N323=N224 + No323 + F124.*r19 - MY23.*VP123 + MX23.*VP223;
	FDI123=C23.*E123 - E223.*S23;
	FDI323=-(C23.*E223) - E123.*S23;
	E122=F122 + FDI123;
	E222=E323 + F222;
	E322=F322 + FDI323;
	N122=C23.*N123 + No122 - N223.*S23 - MZ22.*VP222 - MY22.*VSP222;
	N222=N323 + No222 + MZ22.*VP122 + MX22.*VSP222;
	N322=-(C23.*N223) + No322 - N123.*S23 - MY22.*VP122 + MX22.*VP222;
	FDI122=C22.*E122 - E222.*S22;
	FDI322=C22.*E222 + E122.*S22;
	E121=F121 + FDI122;
	E221=-E322 + F221;
	E321=F321 + FDI322;
	N121=C22.*N122 + No121 - FDI322.*r17 - N222.*S22 - MY21.*VP220 - MZ21.*VP221;
	N221=-N322 + No221 + MZ21.*VP121 + MX21.*VP220;
	N321=C22.*N222 + No321 + FDI122.*r17 + N122.*S22 - MY21.*VP121 + MX21.*VP221;
	FDI121=C21.*E121 - E221.*S21;
	FDI321=C21.*E221 + E121.*S21;
	E120=F120 + FDI121;
	E220=-E321 + F220;
	E320=F320 + FDI321;
	N120=C21.*N121 + No120 - N221.*S21 - MZ20.*VP220 + MY20.*VP320;
	N220=-N321 + No220 + MZ20.*VP120 - MX20.*VP320;
	N320=C21.*N221 + No320 + N121.*S21 - MY20.*VP120 + MX20.*VP220;
	FDI120=C20.*E120 - E220.*S20;
	FDI220=A2120.*E120 + A2220.*E220 - E320.*Sa20;
	FDI320=A3120.*E120 + A3220.*E220 + Ca20.*E320;
	N119=No119 - MY19.*VSP219 - MZ19.*VSP319;
	N219=No219 + MZ19.*VSP119 + MX19.*VSP219;
	N319=No319 - MY19.*VSP119 + MX19.*VSP319;
	E118=F118 + F119;
	E218=F218 - F319;
	E318=F219 + F318;
	N118=N119 + No118 - F219.*r19 + MY18.*VP217 - MZ18.*VP218;
	N218=-N319 + No218 + MZ18.*VP118 - MX18.*VP217;
	N318=N219 + No318 + F119.*r19 - MY18.*VP118 + MX18.*VP218;
	FDI118=C18.*E118 - E218.*S18;
	FDI318=-(C18.*E218) - E118.*S18;
	E117=F117 + FDI118;
	E217=E318 + F217;
	E317=F317 + FDI318;
	N117=C18.*N118 + No117 - N218.*S18 - MZ17.*VP217 - MY17.*VSP217;
	N217=N318 + No217 + MZ17.*VP117 + MX17.*VSP217;
	N317=-(C18.*N218) + No317 - N118.*S18 - MY17.*VP117 + MX17.*VP217;
	FDI117=C17.*E117 - E217.*S17;
	FDI317=C17.*E217 + E117.*S17;
	E116=F116 + FDI117;
	E216=-E317 + F216;
	E316=F316 + FDI317;
	N116=C17.*N117 + No116 - FDI317.*r17 - N217.*S17 - MY16.*VP215 - MZ16.*VP216;
	N216=-N317 + No216 + MZ16.*VP116 + MX16.*VP215;
	N316=C17.*N217 + No316 + FDI117.*r17 + N117.*S17 - MY16.*VP116 + MX16.*VP216;
	FDI116=C16.*E116 - E216.*S16;
	FDI316=C16.*E216 + E116.*S16;
	E115=F115 + FDI116;
	E215=-E316 + F215;
	E315=F315 + FDI316;
	N115=C16.*N116 + No115 - N216.*S16 - MZ15.*VP215 + MY15.*VP315;
	N215=-N316 + No215 + MZ15.*VP115 - MX15.*VP315;
	N315=C16.*N216 + No315 + N116.*S16 - MY15.*VP115 + MX15.*VP215;
	FDI115=C15.*E115 - E215.*S15;
	FDI215=A2115.*E115 + A2215.*E215 - E315.*Sa15;
	FDI315=A3115.*E115 + A3215.*E215 + Ca15.*E315;
	E114=F114 + FX14;
	E214=F214 + FY14;
	E314=F314 + FZ14;
	N114=CX14 + No114 - MZ14.*VSP214 + MY14.*VSP314;
	N214=CY14 + No214 + MZ14.*VSP114 - MX14.*VSP314;
	N314=CZ14 + No314 - MY14.*VSP114 + MX14.*VSP214;
	E113=E114 + F113;
	E213=E214 + F213;
	E313=E314 + F313;
	N113=-(E214.*l1) + N114 + No113 + MY13.*VP212 - MZ13.*VP213;
	N213=d2.*E314 + E114.*l1 + N214 + No213 + MZ13.*VP113 - MX13.*VP212;
	N313=-(d2.*E214) + N314 + No313 - MY13.*VP113 + MX13.*VP213;
	FDI113=C13.*E113 - E213.*S13;
	FDI313=-(C13.*E213) - E113.*S13;
	E112=F112 + FDI113;
	E212=E313 + F212;
	E312=F312 + FDI313;
	N112=C13.*N113 + No112 - N213.*S13 - MZ12.*VP212 + MY12.*VSP312;
	N212=N313 + No212 + MZ12.*VP112 - MX12.*VSP312;
	N312=-(C13.*N213) + No312 - N113.*S13 - MY12.*VP112 + MX12.*VP212;
	FDI112=C12.*E112 - E212.*S12;
	FDI212=C12.*E212 + E112.*S12;
	E111=F111 + FDI112;
	E211=F211 + FDI212;
	E311=E312 + F311;
	N111=C12.*N112 + No111 - N212.*S12 - MZ11.*VP211 + MY11.*VSP311;
	N211=d4.*E312 + C12.*N212 + No211 + N112.*S12 + MZ11.*VP111 - MX11.*VSP311;
	N311=-(d4.*FDI212) + N312 + No311 - MY11.*VP111 + MX11.*VP211;
	FDI111=C11.*E111 - E211.*S11;
	FDI211=C11.*E211 + E111.*S11;
	E110=F110 + FDI111;
	E210=F210 + FDI211;
	E310=E311 + F310;
	N110=C11.*N111 + No110 - N211.*S11 - MZ10.*VP210 - MY10.*VP29;
	N210=d5.*E311 + C11.*N211 + No210 + N111.*S11 + MZ10.*VP110 + MX10.*VP29;
	N310=-(d5.*FDI211) + N311 + No310 - MY10.*VP110 + MX10.*VP210;
	FDI110=C10.*E110 - E210.*S10;
	FDI310=C10.*E210 + E110.*S10;
	E19=F19 + FDI110;
	E29=-E310 + F29;
	E39=F39 + FDI310;
	N19=C10.*N110 + No19 - N210.*S10 + MY9.*VP28 - MZ9.*VP29;
	N29=-N310 + No29 + MZ9.*VP19 - MX9.*VP28;
	N39=C10.*N210 + No39 + N110.*S10 - MY9.*VP19 + MX9.*VP29;
	FDI19=C9.*E19 - E29.*S9;
	FDI39=-(C9.*E29) - E19.*S9;
	E18=F18 + FDI19;
	E28=E39 + F28;
	E38=F38 + FDI39;
	N18=C9.*N19 + No18 - N29.*S9 - MZ8.*VP28 + MY8.*VSP28;
	N28=N39 + No28 + MZ8.*VP18 - MX8.*VSP28;
	N38=-(C9.*N29) + No38 - N19.*S9 - MY8.*VP18 + MX8.*VP28;
	FDI18=C8.*E18 - E28.*S8;
	FDI38=-(C8.*E28) - E18.*S8;
	E17=F17 + FDI115 + FDI120 + FDI125 + FDI18;
	E27=E38 + F27 + FDI215 + FDI220 + FDI225;
	E37=F37 + FDI315 + FDI320 + FDI325 + FDI38;
	N17=FDI315.*LOO215 + FDI320.*LOO220 + FDI325.*LOO225 - FDI215.*LOO315 - FDI220.*LOO320 - FDI225.*LOO325 + C15.*N115 + C20.*N120 + C25.*N125 + C8.*N18 + No17 + FDI38.*r7 - N215.*S15 - N220.*S20 - N225.*S25 - N28.*S8 - MZ7.*VP27 - MY7.*VSP27;
	N27=FDI115.*LOO315 + FDI120.*LOO320 + FDI125.*LOO325 + A2115.*N115 + A2120.*N120 + A2125.*N125 + A2215.*N215 + A2220.*N220 + A2225.*N225 + N38 + No27 - N315.*Sa15 - N320.*Sa20 - N325.*Sa25 + MZ7.*VP17 + MX7.*VSP27;
	N37=-(FDI115.*LOO215) - FDI120.*LOO220 - FDI125.*LOO225 + A3115.*N115 + A3120.*N120 + A3125.*N125 + A3215.*N215 + A3220.*N220 + A3225.*N225 - C8.*N28 + Ca15.*N315 + Ca20.*N320 + Ca25.*N325 + No37 - FDI18.*r7 - N18.*S8 - MY7.*VP17 + MX7.*VP27;
	FDI17=C7.*E17 - E27.*S7;
	FDI37=C7.*E27 + E17.*S7;
	E16=F16 + FDI17;
	E26=-E37 + F26;
	E36=F36 + FDI37;
	N16=C7.*N17 + No16 - FDI37.*r7 - N27.*S7 + MY6.*VP25 - MZ6.*VP26;
	N26=-N37 + No26 + MZ6.*VP16 - MX6.*VP25;
	N36=C7.*N27 + No36 + FDI17.*r7 + N17.*S7 - MY6.*VP16 + MX6.*VP26;
	FDI16=C6.*E16 - E26.*S6;
	FDI36=-(C6.*E26) - E16.*S6;
	E15=F15 + FDI16;
	E25=E36 + F25;
	E35=F35 + FDI36;
	N15=C6.*N16 + No15 - N26.*S6 - MZ5.*VP25 + MY5.*VSP35;
	N25=N36 + No25 + MZ5.*VP15 - MX5.*VSP35;
	N35=-(C6.*N26) + No35 - N16.*S6 - MY5.*VP15 + MX5.*VP25;
	FDI15=C5.*E15 - E25.*S5;
	FDI25=C5.*E25 + E15.*S5;
	E14=F14 + FDI15;
	E24=F24 + FDI25;
	E34=E35 + F34;
	N14=C5.*N15 + No14 - N25.*S5 - MZ4.*VP24 + MY4.*VSP34;
	N24=-(d5.*E35) + C5.*N25 + No24 + N15.*S5 + MZ4.*VP14 - MX4.*VSP34;
	N34=d5.*FDI25 + N35 + No34 - MY4.*VP14 + MX4.*VP24;
	FDI14=C4.*E14 - E24.*S4;
	FDI24=C4.*E24 + E14.*S4;
	E13=F13 + FDI14;
	E23=F23 + FDI24;
	E33=E34 + F33;
	N13=C4.*N14 + No13 - N24.*S4 - MY3.*VP22 - MZ3.*VP23;
	N23=-(d4.*E34) + C4.*N24 + No23 + N14.*S4 + MZ3.*VP13 + MX3.*VP22;
	N33=d4.*FDI24 + N34 + No33 - MY3.*VP13 + MX3.*VP23;
	FDI13=C3.*E13 - E23.*S3;
	FDI33=C3.*E23 + E13.*S3;
	E12=F12 + FDI13;
	E22=-E33 + F22;
	N12=C3.*N13 + No12 - N23.*S3 - MZ2.*VP22;
	N22=-N33 + No22 + MZ2.*VP12;
	N32=C3.*N23 + No32 + N13.*S3 - MY2.*VP12 + MX2.*VP22;
	FDI12=C2.*E12 - E22.*S2;
	FDI22=C2.*E22 + E12.*S2;
	E11=F11 + FDI12;
	N11=FDI22.*l1 + C2.*N12 - N22.*S2;
	N21=-(d2.*FDI33) - FDI12.*l1 - G3.*MZ1 + C2.*N22 + N12.*S2;
	N31=d2.*FDI22 + G3.*MY1 + N32;
	GAM2=N32 + IA2.*qpp1;
	GAM3=N33 + IA3.*qpp2;
	GAM4=N34 + IA4.*qpp3;
	GAM5=N35 + IA5.*qpp4;
	GAM6=N36 + IA6.*qpp5;
	GAM7=N37 + IA7.*qpp6;
	GAM8=N38 + IA8.*qpp7;
	GAM9=N39 + IA9.*qpp8;
	GAM10=N310 + IA10.*qpp9;
	GAM11=N311 + IA11.*qpp10;
	GAM12=N312 + IA12.*qpp11;
	GAM13=N313 + IA13.*qpp12;
	GAM15=N315 + IA15.*qpp13;
	GAM16=N316 + IA16.*qpp14;
	GAM17=N317 + IA17.*qpp15;
	GAM18=N318 + IA18.*qpp16;
	GAM20=N320 + IA20.*qpp17;
	GAM21=N321 + IA21.*qpp18;
	GAM22=N322 + IA22.*qpp19;
	GAM23=N323 + IA23.*qpp20;
	GAM25=N325 + IA25.*qpp21;
	GAM26=N326 + IA26.*qpp22;
	E10=FDI33;
	E20=-FDI22;
	E30=E11;
	N10=N31;
	N20=-N21;
	N30=N11;
F0_0 = [E10; E20; E30]; 
M0_0 = [N10; N20; N30]; 
F0 = F0_0;
M0 = M0_0;
% IMPORTANTE: EN SYMORO LA MATRIZ T01 NO contiene la distancia "d1",i.e. di=0, es decir el marco 0 y el marco 1 estan en el
%             mismo punto (esto es a 0.1 m adelante (en x) del marco 2, o bien el marco 2 está -0.1m atras del marco 1 (y 0)
%             por lo que, los dos marcos se encuentran en la punta del pie de apoyo. Sin embargo ya que queremos saber cual
%             es el par y la fuerza en el suelo exactamente debajo del marco 2, necesitamos proyectar la fuerza F0 y el
%             momento M0 previamente calculado. Ya que el marco 0 y 1 tienen la misma orientación F0 queda igual, pero
M0 = M0 + cross_matrix(T(1:3,4,1))*F0;
Gamma=[GAM2,GAM3,GAM4,GAM5,GAM6,GAM7,GAM8,GAM9,GAM10,GAM11,GAM12,GAM13,...
    GAM15,GAM16,GAM17,GAM18,GAM20,GAM21,GAM22,GAM23,GAM25,GAM26];



% *=*
% Number of operations : 1680 '+' or '-', 1669 '*' or '/'
