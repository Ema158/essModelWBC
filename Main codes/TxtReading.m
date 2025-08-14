function [q_record,qD_record,FSR_record,Gyros_record,t_record_Pos,t_record_Vel,t_record_FSR,t_record_Gyros] = TxtReading(PosVel)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Lectura de posiciones
path = 'D:\Maestria\Nao\Archivos_txt\PosVel_LIP\';   %Robot simulado
% path = 'D:\Maestria\Nao\Archivos_txt\PosVel_fisico3\';  %Robot fisico
if PosVel == true
    fid=fopen(strcat(path,'q1_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q1_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q1_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q2_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q2_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q2_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'q3_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q3_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q3_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'q4_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q4_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q4_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'q5_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q5_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q5_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q6_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q6_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q6_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q7_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q7_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q7_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q8_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q8_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q8_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q9_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q9_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q9_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'q10_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q10_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q10_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'q11_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q11_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q11_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q12_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q12_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q12_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q13_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q13_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q13_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q14_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q14_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q14_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q15_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q15_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q15_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q16_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q16_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q16_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q17_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q17_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q17_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q18_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q18_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q18_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q19_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q19_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q19_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q20_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q20_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q20_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q21_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q21_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q21_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'q22_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\q22_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q22_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Lectura de velocidades
if PosVel == true
    fid=fopen(strcat(path,'qD1_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD1_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD1_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'qD2_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD2_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD2_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD3_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD3_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD3_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD4_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD4_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD4_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD5_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD5_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD5_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD6_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD6_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD6_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'qD7_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD7_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD7_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD8_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD8_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD8_record=str2double(tlines);
%$%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD9_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD9_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD9_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD10_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD10_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD10_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'qD11_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD11_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD11_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD12_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD12_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD12_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD13_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD13_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD13_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'qD14_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD14_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD14_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD15_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD15_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD15_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD16_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD16_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD16_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD17_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD17_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD17_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD18_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD18_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD18_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD19_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD19_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD19_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'qD20_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD20_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD20_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'qD21_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD21_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD21_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'qD22_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\qD22_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
qD22_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
q_record = [q1_record,q2_record,q3_record,q4_record,q5_record,q6_record,...
    q7_record,q8_record,q9_record,q10_record,q11_record,q12_record,q13_record...
    q14_record,q15_record,q16_record,q17_record,q18_record,q19_record,q20_record,q21_record,q22_record];
qD_record = [qD1_record,qD2_record,qD3_record,qD4_record,qD5_record,qD6_record,...
    qD7_record,qD8_record,qD9_record,qD10_record,qD11_record,qD12_record,qD13_record...
    qD14_record,qD15_record,qD16_record,qD17_record,qD18_record,qD19_record,qD20_record,qD21_record,qD22_record];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%%%Lectura de sensores FSR
if PosVel == true
    fid=fopen(strcat(path,'f1_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\f1_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
f1_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'f2_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\f2_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
f2_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'f3_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\f3_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
f3_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'f4_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\f4_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
f4_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'f5_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\f5_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
f5_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'f6_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\f6_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
f6_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'f7_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\f7_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
f7_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'f8_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\f8_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
f8_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'LTW_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\LTW_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
LTW_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'RTW_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\RTW_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
RTW_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'LCoPX_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\LCoPX_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
LCoPX_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'LCoPY_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\LCoPY_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
LCoPY_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'RCoPX_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\RCoPX_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
RCoPX_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'RCoPY_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\RCoPY_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
RCoPY_record=str2double(tlines);
%
FSR_record =[f1_record,f2_record,f3_record,f4_record,f5_record,f6_record,...
    f7_record,f8_record,LTW_record,RTW_record,LCoPX_record,LCoPY_record,RCoPX_record,RCoPY_record];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'Gx_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Gyros\Gx_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
Gx_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'Gy_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Gyros\Gy_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
Gy_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'Gz_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Gyros\Gz_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
Gz_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'Anx_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Gyros\Anx_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
Anx_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'Any_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Gyros\Any_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
Any_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'Anz_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Gyros\Anz_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
Anz_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'Accx_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Gyros\Accx_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
Accx_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'Accy_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Gyros\Accy_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
Accy_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'Accz_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Gyros\Accz_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
Accz_record=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
Gyros_record = [Gx_record,Gy_record,Gz_record,Anx_record,Any_record,Anz_record,Accx_record,Accy_record,Accz_record];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'t_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Pos\t_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
t_record_Pos=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'t_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Vel\t_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
t_record_Vel=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PosVel == true
    fid=fopen(strcat(path,'t_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\FSR\t_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
t_record_FSR=str2double(tlines);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if PosVel == true
    fid=fopen(strcat(path,'t_record.txt'));
else
    fid=fopen('D:\Maestria\Nao\Archivos_txt\Gyros\t_record.txt');
end
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
t_record_Gyros=str2double(tlines);
