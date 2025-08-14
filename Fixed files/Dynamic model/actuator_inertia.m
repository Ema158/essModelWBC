function [ Im ] = actuator_inertia
%Motor inertias generated from NAO
%http://doc.aldebaran.com/2-1/family/nao_h25/motors_h25_v4.html
%https://www.portescap.com/sites/default/files/ed_about_brush_dc_motors.pdf
%Taking into account the rotor inertia and the reudction ratio

%Rotor inertia
Ir = [3;...q1
    3;...q2
    3;...q3
    3;...q4
    3;...q5
    3;...q6
    3;...q7
    3;...q8
    3;...q9
    3;...q10
    3;...q11
    3;...q12
    0.8;...q13
    0.8;...q14
    0.8;...q15
    0.8;...q16
    0.8;...q17
    0.8;...q18
    0.8;...q19
    0.8;...q20
    0.8;...q21
    0.8;...q22
    0.8;...q23
    0.8]; %q24
 

Ir = Ir*1e-7;

%Reduction ratios
N = [201.3;...q1
    130.85;...q2
    130.85;...q3
    130.85;...q4
    201.3;...q5
    201.3;...q6
    201.3;...q7
    201.3;...q8
    130.85;...q9
    130.85;...q10
    130.85;...q11
    201.3;...q12
    150.27;...q13
    173.22;...q14
    150.27;...q15
    173.22;...q16
    150.27;...q17
    173.22;...q18
    150.27;...q19
    173.22;...q20
    150.27;...q21
    173.22;...q22
    150.27;...q23
    173.22];...q24
    
Im = Ir.*N.^2;

% % ==============================================================================================
% % The NEXT part of the code is added in order to concentrate the mass of the robot in one point
% % ==============================================================================================
global alphaM % alphaM = [0-1]. Allow to remove gradually the value of all masses and inertias of the robot
% alphaM = 0 -> all masses are 0 -> all mass is concentrated in one point
% alphaM = 1 -> all masses are normal -> all masses are distributed
% If alphaM is empty it means it was not initialized by other codes, therefore it is not required to do this 
if ~isempty(alphaM) 
    if alphaM > 1
        alphaM = 1;
    elseif alphaM < 0
        alphaM = 0;
    end           
    Im=alphaM*Im;
end

