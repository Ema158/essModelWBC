clc
clear 
close all
fid=fopen('D:\Maestria\Nao\Archivos_txt\Pruebas_brazos\q13_record.txt');
%fid=fopen('D:\Maestria\Nao\Archivos_txt\PosVel\q1_record.txt');
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q13_record=str2double(tlines);
%
fid=fopen('D:\Maestria\Nao\Archivos_txt\Pruebas_brazos\q17_record.txt');
%fid=fopen('D:\Maestria\Nao\Archivos_txt\PosVel\q1_record.txt');
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
q17_record=str2double(tlines);
%
fid=fopen('D:\Maestria\Nao\Archivos_txt\Pruebas_brazos\t_record.txt');
%fid=fopen('D:\Maestria\Nao\Archivos_txt\PosVel\q1_record.txt');
tline = fgetl(fid);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
t_record=str2double(tlines);
%
% t_1 = 0.001:0.001:2;
% q13_a = 1.6:(1.75-1.6)/(size(t_1,2)-1):1.75;
% q17_a = 1.6:(1.75-1.6)/(size(t_1,2)-1):1.75;
% t_2 = 2.001:0.001:3;
% q13_b = 1.75*ones(size(t_2));
% q17_b = 1.75*ones(size(t_2));
% t_3 = 3.001:0.001:5;
% q13_c = 1.75:-(1.75-1.6)/(size(t_1,2)-1):1.6;
% q17_c = 1.75:-(1.75-1.6)/(size(t_1,2)-1):1.6;
% q13 = [q13_a q13_b q13_c];
% q17 = [q17_a q17_b q17_c];
%
t_1 = 0.001:0.001:2;
q13_a = 1.6:-(1.75-1.6)/(size(t_1,2)-1):1.45;
q17_a = 1.6:(1.75-1.6)/(size(t_1,2)-1):1.75;
t_2 = 2.001:0.001:3;
q13_b = 1.45*ones(size(t_2));
q17_b = 1.75*ones(size(t_2));
t_3 = 3.001:0.001:5;
q13_c = 1.45:(1.75-1.6)/(size(t_1,2)-1):1.6;
q17_c = 1.75:-(1.75-1.6)/(size(t_1,2)-1):1.6;
q13 = [q13_a q13_b q13_c];
q17 = [q17_a q17_b q17_c];
t = [t_1 t_2 t_3];
figure(1)
plot(t_record,q13_record);
hold on
plot(t+0.52,q13);
figure(2)
plot(t_record,q17_record);
hold on
plot(t+0.52,q17);
%Creación de los archivos .txt para llevarlos a choregraph
Tabla_tiempos=table(t');
writetable(Tabla_tiempos,'t_pruebas_brazos.txt');
type t_pruebas_brazos.txt;
%
qs = [q13';q17'];
Tabla_tiempos=table(qs);
writetable(Tabla_tiempos,'qs_pruebas_brazos.txt');
type qs_pruebas_brazos.txt;