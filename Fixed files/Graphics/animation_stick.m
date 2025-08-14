function GlobalSupportfoot = animation_stick(stored,Nsteps,alpha)
% Modified: 25-jul-2018 -> Victor 
% alpha -> Orientation of the robot in the plane X-Y

%ANIMATION of a robot given the joints values
% stored : configuration et vitesse articulaire g�n�r� dans le reportoire
% motion sim; Nsteps doit �tre inf�rieur ou egal au nombre de pas simul�
% nom du fichier avi

if nargin == 2
    alpha = 0;
end

robot = genebot();
%fig = figure('Position',[0 0 1000 1000]);
figure
axis image
grid on;
view(0,0);
hold on;

reverse=1;
x0=0;
y0=0;
COM_trace = [];
pied_trace = [];
GlobalSupportfoot = zeros(3,Nsteps);  % X_s, Y_s and Psi_s
GlobalSupportfoot(1,1) = x0;
GlobalSupportfoot(2,1) = y0;
GlobalSupportfoot(3,1) = alpha;
for k = 1:Nsteps
    % stored a et� stock� pas par pas : qs : vecteur articulaire pour le
    % pas k : qs =matrice de dimension n (31) par le nombre d'�chantillon
    qs=stored{k,1};
    n=numel(qs(1,:));
    for i = 1:n
        robot=robot_move(robot,qs(:,i));
        if reverse==1
            RotZ_01_3x3 = [cos(alpha), -sin(alpha), 0; sin(alpha), cos(alpha), 0; 0 0 1];
            pied_trace = [pied_trace, RotZ_01_3x3*robot.T(1:3,4,14)+[x0;y0;0]];
            CoM_Rotated = RotZ_01_3x3*robot.CoM;
            COM_trace = [COM_trace,CoM_Rotated + [x0;y0;0]];%           
            if i==1||i==n,
                robot_draw(robot,x0,y0,alpha);
            end
            if i==n,
                plot3(COM_trace(1,:),COM_trace(2,:),COM_trace(3,:),'k','LineWidth',2);
                plot3(pied_trace(1,:),pied_trace(2,:),pied_trace(3,:),'k:','LineWidth',2);
                COM_trace = [];
                pied_trace = [];
            end
        else
            RotZ_01_3x3 = [cos(-alpha), -sin(-alpha), 0; sin(-alpha), cos(-alpha), 0; 0 0 1];
            tempo = RotZ_01_3x3*robot.CoM+[x0;-y0;0];            
            tempo(2)=-tempo(2);
            tempo2 = RotZ_01_3x3*robot.T(1:3,4,14)+[x0;-y0;0];
            tempo2(2)=-tempo2(2);
            COM_trace = [COM_trace,tempo];
            pied_trace = [pied_trace, tempo2];
            if i==1||i==n,
                robot_draw_reverse(robot,x0,y0,alpha);
            end
            if i==n,
                plot3(COM_trace(1,:),COM_trace(2,:),COM_trace(3,:),'k','LineWidth',2);
                plot3(pied_trace(1,:),pied_trace(2,:),pied_trace(3,:),'k:','LineWidth',2);
                COM_trace = [];
                pied_trace = [];
            end
        end
        axis image
    end;    
    % for the next step...
    foot = RotZ_01_3x3*robot.T(1:3,4,12); 
    frameFoot = RotZ_01_3x3*robot.T(1:3,1:3,14)*robot.Tconst(1:3,1:3,14); %DEbido a que el marco 14 no esta aliniado al marco del mundo
    YawFootRotation = atan2(frameFoot(2,1),frameFoot(1,1));  %Se alinea al marco del mundo en posicion 0
    if mod(k,2)==0
        alpha = - YawFootRotation;
    else
        alpha = YawFootRotation;
    end
    x0 = x0+foot(1);
    y0 = y0+reverse*foot(2);
    
    reverse = -reverse;
    GlobalSupportfoot(1,k+1) = x0;
    GlobalSupportfoot(2,k+1) = y0;
    GlobalSupportfoot(3,k+1) = alpha;
end

