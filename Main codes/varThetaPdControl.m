function [varThetaRef] = varThetaPdControl(robot,xRef)
    HipArmsPos = [1.8;-0.15;1.6;0.15;1.8;0.15;-1.6;-0.15;0;0];
    HipArmsVel = zeros(10,1);
    HipArmsAcc = zeros(10,1);
    thetaDes = [xRef(1);xRef(4);HipArmsPos];
    thetapDes = [xRef(2);xRef(5);HipArmsVel];
    thetappDes = [xRef(3);xRef(6);HipArmsAcc];
    %
    Hips = hipsAttitude(robot);
    theta = [robot.CoM(1:2);robot.q(13);robot.q(14);robot.q(15);robot.q(16);robot.q(17);...
            robot.q(18);robot.q(19);robot.q(20);Hips(1:2)'];
    %
    qD = robot.qD;
    Jhips = hipsJacobian(robot);
    thetap = [robot.J_CoM(1:2,:)*qD;qD(13);qD(14);qD(15);qD(16);qD(17);qD(18);qD(19);qD(20);Jhips(1:2,:)*qD];
    Kp = eye(12,12);
%     Kp(1,1) = 5;
%     Kp(2,2) = 5;
%     Kp(3:10,3:10) = 20*eye(8,8);
%     Kp(11,11) = 10;
%     Kp(12,12) = 10;
%     Kd = 0.5*eye(12,12);
    Kd = eye(12,12);
    % [x,y,q13,q14,q15,q16,q17,q18,q19,q20,HipRoll,PitchRoll]
%     thetaDes(2) = 0;
    varThetaRef = Kp*(thetaDes-theta) + Kd*(thetapDes - thetap) + thetappDes;
end