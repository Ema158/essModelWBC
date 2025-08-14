function q = InvGeometricHZDtime(qf,robot,gait_parameters,t)
%Numerical solver of the inverse geometric model assuming the virtual
%constraint are respected.
q_init=robot.q;
Case = 'position';
% "Case", "gait_parameters" and "t" are used inside "OptionDesiredTrajectory"
OptionDesiredTrajectory;
%
Hips = hipsAttitude(robot);
Q = [state_v(robot);robot.CoM(1:2);robot.q(13:16);robot.q(18:21);Hips(1:2)'];  % Conjunto de posiciones OPERACIONALES reales Q = [h(q)^T, q_f^T]^T
Qdes = [hd; qf];  % Qd - > Desired controlled variables set and the CoM

%Numerical threshold
Thre = 0.2;
global nQ
% ---------------------------
dQ = Qdes-Q;
nQ = max(abs(dQ));
i=0;
Analyze = false;  % 1-> Plot the robot each iteration, so we can analize who the algorithm is converging 0-> We don't analyze anything
if Analyze
    % Just to check how the algorithm adjust the position step by step until reach the desired position
    % -----------------------------------------------------
    % Posición incial
    robot = robot_move(robot,q_init);
    figure
    robot_draw(robot,0,0);
    axis equal
    % pause;
    figure
    % ------------------------
end

while nQ>1e-10
    if nQ>Thre
        dQ = dQ./norm(Q).*Thre;
    end
    dq = InvKinematic(dQ,robot);
    
    %Next iteration
    q=robot.q+dq;
    robot = robot_move(robot,q);
    hips = hipsAttitude(robot);
    Q = [state_v(robot);robot.CoM(1:2);robot.q(13:16);robot.q(18:21);hips(1:2)']; % Posiciones operacionales reales
    dQ = Qdes-Q;
    nQ = max(abs(dQ));
    i=i+1;
    if Analyze
        % Just to check how the algorithm adjust the position step by step until reach the desired position 
        % -----------------------------------------------------
        i
        hold off
        plot(0,0)
        hold off
        robot_draw(robot,0,0);
        axis equal
        view(3)
        fprintf('Ankle Roll  ->  q1 = %f, q12 = %f \n',rad2deg(q(1)),rad2deg(q(12)))
        fprintf('Ankle Pitch ->  q2 = %f, q11 = %f \n',rad2deg(q(2)),rad2deg(q(11)))
        fprintf('knee Pitch  ->  q3 = %f, q10 = %f \n',rad2deg(q(3)),rad2deg(q(10)))
        fprintf('Hip Pitch   ->  q4 = %f,  q9 = %f \n',rad2deg(q(4)),rad2deg(q(9)))
        fprintf('Hip Roll    ->  q5 = %f,  q8 = %f \n',rad2deg(q(5)),rad2deg(q(8)))
        fprintf('Hip Yaw     ->  q6 = %f,  q7 = %f \n',rad2deg(q(6)),rad2deg(q(7)))
        pause;
        % ------------------------
    end
    if i == 200
        warning('Out of the workspace!');
        global OutOfWorkSpace
        if isempty(OutOfWorkSpace)
            OutOfWorkSpace = 1;
        end
        figure(99)
        title('Out of workspace');
        [[1:24]' Qdes Q];
        nQ; 
        robot_draw(robot,0,0);
        robot = robot_move(robot,q_init);
        disp('Robot configuration re-initialized')
%         figure(100)
%          robot_draw(robot,0,0);
% %         pause;
        break
    end
end
q=robot.q;
%Test
%  figure;
%  cla;
%  robot_draw(robot,0,0);
%  q
%  pause

end

