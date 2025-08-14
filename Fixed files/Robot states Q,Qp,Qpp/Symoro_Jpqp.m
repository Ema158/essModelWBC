% (********************************************)
% (** SYMORO+ : SYmbolic MOdelling of RObots **)
% (**========================================**)
% (**      IRCCyN-ECN - 1, rue de la Noe     **)
% (**      B.P.92101                         **)
% (**      44321 Nantes cedex 3, FRANCE      **)
% (**      www.irccyn.ec-nantes.fr           **)
% (********************************************)


%    Name of file : C:\Documents and Settings\Emanuel\Escritorio\symoro\NAO q\264s positivas\Jpqp1.jpqp




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

%                             JPQP 


% Equations:

% Declaration of the function
function [h7, h12, h14]=Symoro_Jpqp(q,qp)
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

% Function description:

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
	WI13=qp1.*S3;
	WI23=C3.*qp1;
	WPJ13=qp2.*WI23;
	WPJ23=-(qp2.*WI13);
	DV223=-WI23.^2;
	DV333=-qp2.^2;
	DV123=WI13.*WI23;
	DV133=qp2.*WI13;
	U113=DV223 + DV333;
	U313=DV133 - WPJ23;
	WI14=C4.*WI13 + S4.*WI23;
	WI24=-(S4.*WI13) + C4.*WI23;
	W34=qp2 + qp3;
	WPJ14=qp3.*WI24 + C4.*WPJ13 + S4.*WPJ23;
	WPJ24=-(qp3.*WI14) - S4.*WPJ13 + C4.*WPJ23;
	DV224=-WI24.^2;
	DV334=-W34.^2;
	DV124=WI14.*WI24;
	DV134=W34.*WI14;
	U114=DV224 + DV334;
	U314=DV134 - WPJ24;
	VSP14=d4.*U113;
	VSP24=d4.*DV123;
	VSP34=d4.*U313;
	VPJ14=C4.*VSP14 + S4.*VSP24;
	VPJ24=-(S4.*VSP14) + C4.*VSP24;
	WI15=C5.*WI14 + S5.*WI24;
	WI25=-(S5.*WI14) + C5.*WI24;
	W35=qp4 + W34;
	WPJ15=qp4.*WI25 + C5.*WPJ14 + S5.*WPJ24;
	WPJ25=-(qp4.*WI15) - S5.*WPJ14 + C5.*WPJ24;
	VSP15=d5.*U114 + VPJ14;
	VSP25=d5.*DV124 + VPJ24;
	VSP35=d5.*U314 + VSP34;
	VPJ15=C5.*VSP15 + S5.*VSP25;
	VPJ25=-(S5.*VSP15) + C5.*VSP25;
	WI16=-(S6.*W35) + C6.*WI15;
	WI26=-(C6.*W35) - S6.*WI15;
	W36=qp5 + WI25;
	WPJ16=qp5.*WI26 + C6.*WPJ15;
	WPJ26=-(qp5.*WI16) - S6.*WPJ15;
	DV116=-WI16.^2;
	DV336=-W36.^2;
	DV126=WI16.*WI26;
	DV236=W36.*WI26;
	U126=DV126 - WPJ25;
	U226=DV116 + DV336;
	U326=DV236 + WPJ16;
	VPJ16=C6.*VPJ15 - S6.*VSP35;
	VPJ26=-(S6.*VPJ15) - C6.*VSP35;
	WI17=S7.*W36 + C7.*WI16;
	WI27=C7.*W36 - S7.*WI16;
	W37=qp6 - WI26;
	WPJ17=qp6.*WI27 + C7.*WPJ16 + S7.*WPJ25;
	WPJ27=-(qp6.*WI17) - S7.*WPJ16 + C7.*WPJ25;
	WPJ37=-WPJ26;
	DV117=-WI17.^2;
	DV337=-W37.^2;
	DV127=WI17.*WI27;
	DV237=W37.*WI27;
	U127=DV127 + WPJ26;
	U227=DV117 + DV337;
	U327=DV237 + WPJ17;
	VSP17=-(r7.*U126) + VPJ16;
	VSP27=-(r7.*U226) + VPJ26;
	VSP37=-(r7.*U326) + VPJ25;
	VPJ17=C7.*VSP17 + S7.*VSP37;
	VPJ27=-(S7.*VSP17) + C7.*VSP37;
	VPJ37=-VSP27;
	WI18=-(S8.*W37) + C8.*WI17;
	WI28=-(C8.*W37) - S8.*WI17;
	W38=qp7 + WI27;
	WPJ18=qp7.*WI28 + C8.*WPJ17 + S8.*WPJ26;
	WPJ28=-(qp7.*WI18) - S8.*WPJ17 + C8.*WPJ26;
	VSP18=r7.*U127 + VPJ17;
	VSP28=r7.*U227 + VPJ27;
	VSP38=r7.*U327 - VSP27;
	VPJ18=C8.*VSP18 - S8.*VSP38;
	VPJ28=-(S8.*VSP18) - C8.*VSP38;
	WI19=-(S9.*W38) + C9.*WI18;
	WI29=-(C9.*W38) - S9.*WI18;
	W39=qp8 + WI28;
	WPJ19=qp8.*WI29 + C9.*WPJ18 - S9.*WPJ27;
	WPJ29=-(qp8.*WI19) - S9.*WPJ18 - C9.*WPJ27;
	VPJ19=C9.*VPJ18 - S9.*VSP28;
	VPJ29=-(S9.*VPJ18) - C9.*VSP28;
	WI110=S10.*W39 + C10.*WI19;
	WI210=C10.*W39 - S10.*WI19;
	W310=qp9 - WI29;
	WPJ110=qp9.*WI210 + C10.*WPJ19 + S10.*WPJ28;
	WPJ210=-(qp9.*WI110) - S10.*WPJ19 + C10.*WPJ28;
	DV2210=-WI210.^2;
	DV3310=-W310.^2;
	DV1210=WI110.*WI210;
	DV1310=W310.*WI110;
	U1110=DV2210 + DV3310;
	U2110=DV1210 - WPJ29;
	U3110=DV1310 - WPJ210;
	VPJ110=C10.*VPJ19 + S10.*VPJ28;
	VPJ210=-(S10.*VPJ19) + C10.*VPJ28;
	WI111=C11.*WI110 + S11.*WI210;
	WI211=-(S11.*WI110) + C11.*WI210;
	W311=qp10 + W310;
	WPJ111=qp10.*WI211 + C11.*WPJ110 + S11.*WPJ210;
	WPJ211=-(qp10.*WI111) - S11.*WPJ110 + C11.*WPJ210;
	DV2211=-WI211.^2;
	DV3311=-W311.^2;
	DV1211=WI111.*WI211;
	DV1311=W311.*WI111;
	U1111=DV2211 + DV3311;
	U2111=DV1211 - WPJ29;
	U3111=DV1311 - WPJ211;
	VSP111=-(d5.*U1110) + VPJ110;
	VSP211=-(d5.*U2110) + VPJ210;
	VSP311=-(d5.*U3110) - VPJ29;
	VPJ111=C11.*VSP111 + S11.*VSP211;
	VPJ211=-(S11.*VSP111) + C11.*VSP211;
	WI112=C12.*WI111 + S12.*WI211;
	WI212=-(S12.*WI111) + C12.*WI211;
	W312=qp11 + W311;
	WPJ112=qp11.*WI212 + C12.*WPJ111 + S12.*WPJ211;
	WPJ212=-(qp11.*WI112) - S12.*WPJ111 + C12.*WPJ211;
	WPJ312=-WPJ29;
	VSP112=-(d4.*U1111) + VPJ111;
	VSP212=-(d4.*U2111) + VPJ211;
	VSP312=-(d4.*U3111) + VSP311;
	VPJ112=C12.*VSP112 + S12.*VSP212;
	VPJ212=-(S12.*VSP112) + C12.*VSP212;
	VPJ312=VSP312;
	WI113=-(S13.*W312) + C13.*WI112;
	WI213=-(C13.*W312) - S13.*WI112;
	W313=qp12 + WI212;
	WPJ113=qp12.*WI213 + C13.*WPJ112 + S13.*WPJ29;
	WPJ213=-(qp12.*WI113) - S13.*WPJ112 + C13.*WPJ29;
	DV1113=-WI113.^2;
	DV2213=-WI213.^2;
	DV3313=-W313.^2;
	DV1213=WI113.*WI213;
	DV1313=W313.*WI113;
	DV2313=W313.*WI213;
	U1113=DV2213 + DV3313;
	U1313=DV1313 + WPJ213;
	U2113=DV1213 + WPJ212;
	U2313=DV2313 - WPJ113;
	U3113=DV1313 - WPJ213;
	U3313=DV1113 + DV2213;
	VPJ113=C13.*VPJ112 - S13.*VSP312;
	VPJ213=-(S13.*VPJ112) - C13.*VSP312;
	WPJ114=WPJ113;
	WPJ214=WPJ213;
	WPJ314=WPJ212;
	VSP114=-(d2.*U1113) + l1.*U1313 + VPJ113;
	VSP214=-(d2.*U2113) + l1.*U2313 + VPJ213;
	VSP314=-(d2.*U3113) + l1.*U3313 + VPJ212;
	VPJ114=VSP114;
	VPJ214=VSP214;
	VPJ314=VSP314;

% *=*
% Number of operations : 135 '+' or '-', 200 '*' or '/'
%Se agrupan los productos Jp*qp de los marcos 7,12 y 14
h7  =  [VPJ17; VPJ27; VPJ37; WPJ17; WPJ27; WPJ37];  
h12 =  [VPJ112; VPJ212; VPJ312; WPJ112; WPJ212; WPJ312]; 
h14 =  [VPJ114; VPJ214; VPJ314; WPJ114; WPJ214; WPJ314]; 
