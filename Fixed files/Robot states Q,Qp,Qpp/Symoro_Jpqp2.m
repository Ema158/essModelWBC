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
function [h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13, h14, h15,...
    h16,h17,h18,h19,h20,h21,h22,h23,h24,h25,h26,h27]=Symoro_Jpqp2(q,qp)
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
	WPJ11=0;
	WPJ21=0;
	WPJ31=0;
	VPJ11=0;
	VPJ21=0;
	VPJ31=0;
	WPJ12=0;
	WPJ22=0;
	WPJ32=0;
	VPJ12=0;
	VPJ22=0;
	VPJ32=0;
	WI13=qp1.*S3;
	WI23=C3.*qp1;
	WPJ13=qp2.*WI23;
	WPJ23=-(qp2.*WI13);
	WPJ33=0;
	DV223=-WI23.^2;
	DV333=-qp2.^2;
	DV123=WI13.*WI23;
	DV133=qp2.*WI13;
	U113=DV223 + DV333;
	U313=DV133 - WPJ23;
	VPJ13=0;
	VPJ23=0;
	VPJ33=0;
	WI14=C4.*WI13 + S4.*WI23;
	WI24=-(S4.*WI13) + C4.*WI23;
	W34=qp2 + qp3;
	WPJ14=qp3.*WI24 + C4.*WPJ13 + S4.*WPJ23;
	WPJ24=-(qp3.*WI14) - S4.*WPJ13 + C4.*WPJ23;
	WPJ34=0;
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
	VPJ34=VSP34;
	WI15=C5.*WI14 + S5.*WI24;
	WI25=-(S5.*WI14) + C5.*WI24;
	W35=qp4 + W34;
	WPJ15=qp4.*WI25 + C5.*WPJ14 + S5.*WPJ24;
	WPJ25=-(qp4.*WI15) - S5.*WPJ14 + C5.*WPJ24;
	WPJ35=0;
	VSP15=d5.*U114 + VPJ14;
	VSP25=d5.*DV124 + VPJ24;
	VSP35=d5.*U314 + VSP34;
	VPJ15=C5.*VSP15 + S5.*VSP25;
	VPJ25=-(S5.*VSP15) + C5.*VSP25;
	VPJ35=VSP35;
	WI16=-(S6.*W35) + C6.*WI15;
	WI26=-(C6.*W35) - S6.*WI15;
	W36=qp5 + WI25;
	WPJ16=qp5.*WI26 + C6.*WPJ15;
	WPJ26=-(qp5.*WI16) - S6.*WPJ15;
	WPJ36=WPJ25;
	DV116=-WI16.^2;
	DV336=-W36.^2;
	DV126=WI16.*WI26;
	DV236=W36.*WI26;
	U126=DV126 - WPJ25;
	U226=DV116 + DV336;
	U326=DV236 + WPJ16;
	VPJ16=C6.*VPJ15 - S6.*VSP35;
	VPJ26=-(S6.*VPJ15) - C6.*VSP35;
	VPJ36=VPJ25;
	WI17=S7.*W36 + C7.*WI16;
	WI27=C7.*W36 - S7.*WI16;
	W37=qp6 - WI26;
	WPJ17=qp6.*WI27 + C7.*WPJ16 + S7.*WPJ25;
	WPJ27=-(qp6.*WI17) - S7.*WPJ16 + C7.*WPJ25;
	WPJ37=-WPJ26;
	DV117=-WI17.^2;
	DV227=-WI27.^2;
	DV337=-W37.^2;
	DV127=WI17.*WI27;
	DV137=W37.*WI17;
	DV237=W37.*WI27;
	U127=DV127 + WPJ26;
	U137=DV137 + WPJ27;
	U227=DV117 + DV337;
	U237=DV237 - WPJ17;
	U327=DV237 + WPJ17;
	U337=DV117 + DV227;
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
	WPJ38=WPJ27;
	VSP18=r7.*U127 + VPJ17;
	VSP28=r7.*U227 + VPJ27;
	VSP38=r7.*U327 - VSP27;
	VPJ18=C8.*VSP18 - S8.*VSP38;
	VPJ28=-(S8.*VSP18) - C8.*VSP38;
	VPJ38=VSP28;
	WI19=-(S9.*W38) + C9.*WI18;
	WI29=-(C9.*W38) - S9.*WI18;
	W39=qp8 + WI28;
	WPJ19=qp8.*WI29 + C9.*WPJ18 - S9.*WPJ27;
	WPJ29=-(qp8.*WI19) - S9.*WPJ18 - C9.*WPJ27;
	WPJ39=WPJ28;
	VPJ19=C9.*VPJ18 - S9.*VSP28;
	VPJ29=-(S9.*VPJ18) - C9.*VSP28;
	VPJ39=VPJ28;
	WI110=S10.*W39 + C10.*WI19;
	WI210=C10.*W39 - S10.*WI19;
	W310=qp9 - WI29;
	WPJ110=qp9.*WI210 + C10.*WPJ19 + S10.*WPJ28;
	WPJ210=-(qp9.*WI110) - S10.*WPJ19 + C10.*WPJ28;
	WPJ310=-WPJ29;
	DV2210=-WI210.^2;
	DV3310=-W310.^2;
	DV1210=WI110.*WI210;
	DV1310=W310.*WI110;
	U1110=DV2210 + DV3310;
	U2110=DV1210 - WPJ29;
	U3110=DV1310 - WPJ210;
	VPJ110=C10.*VPJ19 + S10.*VPJ28;
	VPJ210=-(S10.*VPJ19) + C10.*VPJ28;
	VPJ310=-VPJ29;
	WI111=C11.*WI110 + S11.*WI210;
	WI211=-(S11.*WI110) + C11.*WI210;
	W311=qp10 + W310;
	WPJ111=qp10.*WI211 + C11.*WPJ110 + S11.*WPJ210;
	WPJ211=-(qp10.*WI111) - S11.*WPJ110 + C11.*WPJ210;
	WPJ311=-WPJ29;
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
	VPJ311=VSP311;
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
	WPJ313=WPJ212;
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
	VPJ313=VPJ212;
	WPJ114=WPJ113;
	WPJ214=WPJ213;
	WPJ314=WPJ212;
	VSP114=-(d2.*U1113) + l1.*U1313 + VPJ113;
	VSP214=-(d2.*U2113) + l1.*U2313 + VPJ213;
	VSP314=-(d2.*U3113) + l1.*U3313 + VPJ212;
	VPJ114=VSP114;
	VPJ214=VSP214;
	VPJ314=VSP314;
	WI115=A3115.*W37 + C15.*WI17 + A2115.*WI27;
	WI215=A3215.*W37 - S15.*WI17 + A2215.*WI27;
	WI315=Ca15.*W37 - Sa15.*WI27;
	W315=qp13 + WI315;
	WPJ115=qp13.*WI215 + C15.*WPJ17 - A3115.*WPJ26 + A2115.*WPJ27;
	WPJ215=-(qp13.*WI115) - S15.*WPJ17 - A3215.*WPJ26 + A2215.*WPJ27;
	WPJ315=-(Ca15.*WPJ26) - Sa15.*WPJ27;
	VSP115=LOO215.*U127 + LOO315.*U137 + VPJ17;
	VSP215=LOO215.*U227 + LOO315.*U237 + VPJ27;
	VSP315=LOO215.*U327 + LOO315.*U337 - VSP27;
	VPJ115=C15.*VSP115 + A2115.*VSP215 + A3115.*VSP315;
	VPJ215=-(S15.*VSP115) + A2215.*VSP215 + A3215.*VSP315;
	VPJ315=-(Sa15.*VSP215) + Ca15.*VSP315;
	WI116=S16.*W315 + C16.*WI115;
	WI216=C16.*W315 - S16.*WI115;
	W316=qp14 - WI215;
	WPJ116=qp14.*WI216 + C16.*WPJ115 + S16.*WPJ315;
	WPJ216=-(qp14.*WI116) - S16.*WPJ115 + C16.*WPJ315;
	WPJ316=-WPJ215;
	DV1116=-WI116.^2;
	DV3316=-W316.^2;
	DV1216=WI116.*WI216;
	DV2316=W316.*WI216;
	U1216=DV1216 + WPJ215;
	U2216=DV1116 + DV3316;
	U3216=DV2316 + WPJ116;
	VPJ116=C16.*VPJ115 + S16.*VPJ315;
	VPJ216=-(S16.*VPJ115) + C16.*VPJ315;
	VPJ316=-VPJ215;
	WI117=S17.*W316 + C17.*WI116;
	WI217=C17.*W316 - S17.*WI116;
	W317=qp15 - WI216;
	WPJ117=qp15.*WI217 + C17.*WPJ116 - S17.*WPJ215;
	WPJ217=-(qp15.*WI117) - S17.*WPJ116 - C17.*WPJ215;
	WPJ317=-WPJ216;
	VSP117=-(r17.*U1216) + VPJ116;
	VSP217=-(r17.*U2216) + VPJ216;
	VSP317=-(r17.*U3216) - VPJ215;
	VPJ117=C17.*VSP117 + S17.*VSP317;
	VPJ217=-(S17.*VSP117) + C17.*VSP317;
	VPJ317=-VSP217;
	WI118=-(S18.*W317) + C18.*WI117;
	WI218=-(C18.*W317) - S18.*WI117;
	W318=qp16 + WI217;
	WPJ118=qp16.*WI218 + C18.*WPJ117 + S18.*WPJ216;
	WPJ218=-(qp16.*WI118) - S18.*WPJ117 + C18.*WPJ216;
	WPJ318=WPJ217;
	DV1118=-WI118.^2;
	DV3318=-W318.^2;
	DV1218=WI118.*WI218;
	DV2318=W318.*WI218;
	U1218=DV1218 - WPJ217;
	U2218=DV1118 + DV3318;
	U3218=DV2318 + WPJ118;
	VPJ118=C18.*VPJ117 + S18.*VSP217;
	VPJ218=-(S18.*VPJ117) + C18.*VSP217;
	VPJ318=VPJ217;
	WPJ119=WPJ118;
	WPJ219=WPJ217;
	WPJ319=-WPJ218;
	VSP119=-(r19.*U1218) + VPJ118;
	VSP219=-(r19.*U2218) + VPJ218;
	VSP319=-(r19.*U3218) + VPJ217;
	VPJ119=VSP119;
	VPJ219=VSP319;
	VPJ319=-VSP219;
	WI120=A3120.*W37 + C20.*WI17 + A2120.*WI27;
	WI220=A3220.*W37 - S20.*WI17 + A2220.*WI27;
	WI320=Ca20.*W37 - Sa20.*WI27;
	W320=qp17 + WI320;
	WPJ120=qp17.*WI220 + C20.*WPJ17 - A3120.*WPJ26 + A2120.*WPJ27;
	WPJ220=-(qp17.*WI120) - S20.*WPJ17 - A3220.*WPJ26 + A2220.*WPJ27;
	WPJ320=-(Ca20.*WPJ26) - Sa20.*WPJ27;
	VSP120=LOO220.*U127 + LOO320.*U137 + VPJ17;
	VSP220=LOO220.*U227 + LOO320.*U237 + VPJ27;
	VSP320=LOO220.*U327 + LOO320.*U337 - VSP27;
	VPJ120=C20.*VSP120 + A2120.*VSP220 + A3120.*VSP320;
	VPJ220=-(S20.*VSP120) + A2220.*VSP220 + A3220.*VSP320;
	VPJ320=-(Sa20.*VSP220) + Ca20.*VSP320;
	WI121=S21.*W320 + C21.*WI120;
	WI221=C21.*W320 - S21.*WI120;
	W321=qp18 - WI220;
	WPJ121=qp18.*WI221 + C21.*WPJ120 + S21.*WPJ320;
	WPJ221=-(qp18.*WI121) - S21.*WPJ120 + C21.*WPJ320;
	WPJ321=-WPJ220;
	DV1121=-WI121.^2;
	DV3321=-W321.^2;
	DV1221=WI121.*WI221;
	DV2321=W321.*WI221;
	U1221=DV1221 + WPJ220;
	U2221=DV1121 + DV3321;
	U3221=DV2321 + WPJ121;
	VPJ121=C21.*VPJ120 + S21.*VPJ320;
	VPJ221=-(S21.*VPJ120) + C21.*VPJ320;
	VPJ321=-VPJ220;
	WI122=S22.*W321 + C22.*WI121;
	WI222=C22.*W321 - S22.*WI121;
	W322=qp19 - WI221;
	WPJ122=qp19.*WI222 + C22.*WPJ121 - S22.*WPJ220;
	WPJ222=-(qp19.*WI122) - S22.*WPJ121 - C22.*WPJ220;
	WPJ322=-WPJ221;
	VSP122=-(r17.*U1221) + VPJ121;
	VSP222=-(r17.*U2221) + VPJ221;
	VSP322=-(r17.*U3221) - VPJ220;
	VPJ122=C22.*VSP122 + S22.*VSP322;
	VPJ222=-(S22.*VSP122) + C22.*VSP322;
	VPJ322=-VSP222;
	WI123=-(S23.*W322) + C23.*WI122;
	WI223=-(C23.*W322) - S23.*WI122;
	W323=qp20 + WI222;
	WPJ123=qp20.*WI223 + C23.*WPJ122 + S23.*WPJ221;
	WPJ223=-(qp20.*WI123) - S23.*WPJ122 + C23.*WPJ221;
	WPJ323=WPJ222;
	DV1123=-WI123.^2;
	DV3323=-W323.^2;
	DV1223=WI123.*WI223;
	DV2323=W323.*WI223;
	U1223=DV1223 - WPJ222;
	U2223=DV1123 + DV3323;
	U3223=DV2323 + WPJ123;
	VPJ123=C23.*VPJ122 + S23.*VSP222;
	VPJ223=-(S23.*VPJ122) + C23.*VSP222;
	VPJ323=VPJ222;
	WPJ124=WPJ123;
	WPJ224=WPJ222;
	WPJ324=-WPJ223;
	VSP124=-(r19.*U1223) + VPJ123;
	VSP224=-(r19.*U2223) + VPJ223;
	VSP324=-(r19.*U3223) + VPJ222;
	VPJ124=VSP124;
	VPJ224=VSP324;
	VPJ324=-VSP224;
	WI125=A3125.*W37 + C25.*WI17 + A2125.*WI27;
	WI225=A3225.*W37 - S25.*WI17 + A2225.*WI27;
	WI325=Ca25.*W37 - Sa25.*WI27;
	W325=qp21 + WI325;
	WPJ125=qp21.*WI225 + C25.*WPJ17 - A3125.*WPJ26 + A2125.*WPJ27;
	WPJ225=-(qp21.*WI125) - S25.*WPJ17 - A3225.*WPJ26 + A2225.*WPJ27;
	WPJ325=-(Ca25.*WPJ26) - Sa25.*WPJ27;
	VSP125=LOO225.*U127 + LOO325.*U137 + VPJ17;
	VSP225=LOO225.*U227 + LOO325.*U237 + VPJ27;
	VSP325=LOO225.*U327 + LOO325.*U337 - VSP27;
	VPJ125=C25.*VSP125 + A2125.*VSP225 + A3125.*VSP325;
	VPJ225=-(S25.*VSP125) + A2225.*VSP225 + A3225.*VSP325;
	VPJ325=-(Sa25.*VSP225) + Ca25.*VSP325;
	WI126=-(S26.*W325) + C26.*WI125;
	WI226=-(C26.*W325) - S26.*WI125;
	W326=qp22 + WI225;
	WPJ126=qp22.*WI226 + C26.*WPJ125 - S26.*WPJ325;
	WPJ226=-(qp22.*WI126) - S26.*WPJ125 - C26.*WPJ325;
	WPJ326=WPJ225;
	DV1126=-WI126.^2;
	DV3326=-W326.^2;
	DV1226=WI126.*WI226;
	DV2326=W326.*WI226;
	U1226=DV1226 - WPJ225;
	U2226=DV1126 + DV3326;
	U3226=DV2326 + WPJ126;
	VPJ126=C26.*VPJ125 - S26.*VPJ325;
	VPJ226=-(S26.*VPJ125) - C26.*VPJ325;
	VPJ326=VPJ225;
	WPJ127=WPJ225;
	WPJ227=WPJ226;
	WPJ327=-WPJ126;
	VSP127=d27.*U1226 + VPJ126;
	VSP227=d27.*U2226 + VPJ226;
	VSP327=d27.*U3226 + VPJ225;
	VPJ127=VSP327;
	VPJ227=VSP227;
	VPJ327=-VSP127;

h1  =  [VPJ11; VPJ21; VPJ31; WPJ11; WPJ21; WPJ31]; 
h2  =  [VPJ12; VPJ22; VPJ32; WPJ12; WPJ22; WPJ32]; 
h3  =  [VPJ13; VPJ23; VPJ33; WPJ13; WPJ23; WPJ33]; 
h4  =  [VPJ14; VPJ24; VPJ34; WPJ14; WPJ24; WPJ34]; 
h5  =  [VPJ15; VPJ25; VPJ35; WPJ15; WPJ25; WPJ35]; 
h6  =  [VPJ16; VPJ26; VPJ36; WPJ16; WPJ26; WPJ36]; 
h7  =  [VPJ17; VPJ27; VPJ37; WPJ17; WPJ27; WPJ37]; 
h8  =  [VPJ18; VPJ28; VPJ38; WPJ18; WPJ28; WPJ38]; 
h9  =  [VPJ19; VPJ29; VPJ39; WPJ19; WPJ29; WPJ39]; 
h10  =  [VPJ110; VPJ210; VPJ310; WPJ110; WPJ210; WPJ310]; 
h11  =  [VPJ111; VPJ211; VPJ311; WPJ111; WPJ211; WPJ311]; 
h12  =  [VPJ112; VPJ212; VPJ312; WPJ112; WPJ212; WPJ312]; 
h13  =  [VPJ113; VPJ213; VPJ313; WPJ113; WPJ213; WPJ313]; 
h14  =  [VPJ114; VPJ214; VPJ314; WPJ114; WPJ214; WPJ314]; 
h15  =  [VPJ115; VPJ215; VPJ315; WPJ115; WPJ215; WPJ315]; 
h16  =  [VPJ116; VPJ216; VPJ316; WPJ116; WPJ216; WPJ316]; 
h17  =  [VPJ117; VPJ217; VPJ317; WPJ117; WPJ217; WPJ317]; 
h18  =  [VPJ118; VPJ218; VPJ318; WPJ118; WPJ218; WPJ318]; 
h19  =  [VPJ119; VPJ219; VPJ319; WPJ119; WPJ219; WPJ319]; 
h20  =  [VPJ120; VPJ220; VPJ320; WPJ120; WPJ220; WPJ320]; 
h21  =  [VPJ121; VPJ221; VPJ321; WPJ121; WPJ221; WPJ321]; 
h22  =  [VPJ122; VPJ222; VPJ322; WPJ122; WPJ222; WPJ322]; 
h23  =  [VPJ123; VPJ223; VPJ323; WPJ123; WPJ223; WPJ323]; 
h24  =  [VPJ124; VPJ224; VPJ324; WPJ124; WPJ224; WPJ324]; 
h25  =  [VPJ125; VPJ225; VPJ325; WPJ125; WPJ225; WPJ325]; 
h26  =  [VPJ126; VPJ226; VPJ326; WPJ126; WPJ226; WPJ326]; 
h27  =  [VPJ127; VPJ227; VPJ327; WPJ127; WPJ227; WPJ327]; 


% *=*
% Number of operations : 305 '+' or '-', 455 '*' or '/'
