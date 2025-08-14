function [varThetaRef] = varThetaPdControlZmpTerm2(robot,xRef,Zref,ZMP)
    HipArmsPos = [1.8;-0.15;1.6;0.15;1.8;0.15;-1.6;-0.15;0;0];
    HipArmsVel = zeros(10,1);
    HipArmsAcc = zeros(10,1);
    thetaDes = [xRef(1);xRef(4);HipArmsPos];
    thetapDes = [xRef(2);xRef(5);HipArmsVel];
    thetappDes = [xRef(3);xRef(6);HipArmsAcc];
    %
    Hips = hipsAttitude(robot);
    theta = [robot.CoM(1:2);robot.q(13);robot.q(14);robot.q(15);robot.q(16);robot.q(18);...
            robot.q(19);robot.q(20);robot.q(21);Hips(1:2)'];
    %
    qD = robot.qD;
    Jhips = hipsJacobian(robot);
    thetap = [robot.J_CoM(1:2,:)*qD;qD(13);qD(14);qD(15);qD(16);qD(18);qD(19);qD(20);qD(21);Jhips(1:2,:)*qD];
    Kp = robot.Kp;
    Kd = robot.Kd;
    Kz = robot.Kz;
%     Kz2 = 300;
    Kz2 = 0;
%     thetaDes(1) = 0;
%     thetapDes(1) = 0;
    varThetaRef = Kp*(thetaDes-theta) + Kd*(thetapDes - thetap) + thetappDes;
    varThetaRef(1) = varThetaRef(1) + Kz*(Zref(1)-theta(1));
    varThetaRef(2) = varThetaRef(2) + Kz*(Zref(2)-theta(2));
%     varThetaRef(11) = varThetaRef(11) + Kz2*(ZMP(2)-theta(2));
    varThetaRef(12) = varThetaRef(12) + Kz2*(ZMP(1)-theta(1));
%     varThetaRef(12) = Kd(12,12)*(thetapDes(12) - thetap(12)) + thetappDes(12);
end