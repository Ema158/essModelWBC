
% rosinit     % To start ROS core
% pub = rospublisher ('/joint_states', 'sensor_msgs/JointState')
% rosshtudown % To stop ROS core
% rosnode kill /joint_state_publisher % We need to do this in ROS to disconnect the values given by the panel of the joints
%      and allow to use the values comming from here =)

%% ================================================================================
% ROS STUFF
global tftree Tmsg pub msg
if ~robotics.ros.internal.Global.isNodeActive
    rosinit
    disp('ROS has been initialized');
end

tftree = rostf;
Tmsg = rosmessage('geometry_msgs/TransformStamped');
Tmsg.ChildFrameId = 'world_link';
Tmsg.Header.FrameId = 'world_link';

Tmsg.Transform.Translation.X = 0;
Tmsg.Transform.Translation.Y = 0;
Tmsg.Transform.Translation.Z = 0;
Tmsg.Transform.Rotation.W = 1;
Tmsg.Transform.Rotation.X = 0;
Tmsg.Transform.Rotation.Y = 0;
Tmsg.Transform.Rotation.Z = 0;

pub = rospublisher ('/joint_states', 'sensor_msgs/JointState');
msg = rosmessage(pub);
% msg.Name = {'p3r3_joint_1','p3r3_joint_2','p3r3_joint_3','p3r3_joint_4','p3r3_joint_5','p3r3_joint_6'};
msg.Name = {'NeckYaw', 'NeckPitch', 'HeadPitch', 'HeadRoll', 'LHipYaw', 'LHipRoll', 'LHipPitch', 'LKneePitch', 'LAnklePitch', 'LAnkleRoll', 'RHipYaw', 'RHipRoll', 'RHipPitch', 'RKneePitch', 'RAnklePitch', 'RAnkleRoll', 'TrunkYaw', 'LShoulderPitch', 'LShoulderYaw', 'LElbowRoll', 'LElbowYaw', 'LWristRoll', 'LWristYaw', 'LWristPitch', 'RShoulderPitch', 'RShoulderYaw', 'RElbowRoll', 'RElbowYaw', 'RWristRoll', 'RWristYaw', 'RWristPitch', 'LHand', 'RHand', 'LFinger12', 'LFinger13', 'LFinger21', 'LFinger22', 'LFinger23', 'LFinger31', 'LFinger32', 'LFinger33', 'LThumb1', 'LThumb2', 'LThumb3', 'RFinger12', 'RFinger13', 'RFinger21', 'RFinger22', 'RFinger23', 'RFinger31', 'RFinger32', 'RFinger33', 'RThumb1', 'RThumb2', 'RThumb3'};
%msg.Position = zeros(1,length(msg.Name));
msg.Position = [0.0, -0.0001396264000000369, -3.479550000001774e-05, 0.0, 0.0, -2.5846599999990172e-05, -0.0002471092000002617, 0.0, -1.9999999989472883e-07, 0.0, 0.0, -5.26932000000091e-05, -0.0002471092000002617, 0.0, -1.9999999989472883e-07, 0.0, 0.0, -0.0003286209999999734, -7.499199999999595e-05, 0.0, 0.0, -0.0004185039000002, 0.0, 0.0, -0.0003286209999999734, -8.208720000002501e-05, 0.0, 0.0, -3.7500000005241674e-07, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
msg.Header.Stamp = rostime('now');
%%
q = handles.q;

% Tranformation matrix to convert MATLAB joint variables "q" to ROS joint variables "theta"
A = zeros(31,31);
A(1,14) = 1;
A(2,15) = 1;
A(3,16) = 1;
A(4,17) = 1;
A(5,7) = 1;
A(6,8) = 1;
A(7,9) = 1;
A(8,10) = 1;
A(9,11) = 1;
A(10,12) = 1;
A(11,6) = -1;
A(12,5) = -1;
A(13,4) = -1;
A(14,3) = -1;
A(15,2) = -1;
A(16,1) = -1;
A(17,13) = 1;
A(18,25) = 1;
A(19,26) = 1;
A(20,27) = 1;
A(21,28) = 1;
A(22,29) = 1;
A(23,30) = 1;
A(24,31) = 1;
A(25,18) = 1;
A(26,19) = 1;
A(27,20) = 1;
A(28,21) = 1;
A(29,22) = 1;
A(30,23) = 1;
A(31,24) = 1;

Tmsg.Header.FrameId = 'r_sole';
child = 'l_sole';
parent = 'r_sole';

% %     if k>1
%         Trel = getTransform(tftree, parent, child);
%         Tc = ROS2T(Trel.Transform)*ROS2T(Tmsg.Transform);
%         Tmsg.Transform.Translation.X = Tc(1,4);
%         Tmsg.Transform.Translation.Y = Tc(2,4);
%         Tmsg.Transform.Translation.Z = Tc(3,4);
%         q = rotm2quat(Tc(1:3,1:3));
%         Tmsg.Transform.Rotation.W = q(1);
%         Tmsg.Transform.Rotation.X = q(2);
%         Tmsg.Transform.Rotation.Y = q(3);
%         Tmsg.Transform.Rotation.Z = q(4);
%         Tmsg.Header.Stamp = rostime('now');
%         sendTransform(tftree, Tmsg);
%         pause(0.01);
%     end


% Transformation from MATLAB joint variables to ROS joint variables
th = A*q;

for j = 1:31
    msg.Position(j) = th(j);
end

msg.Header.Stamp = rostime('now');
Tmsg.Header.Stamp = msg.Header.Stamp;
send(pub, msg)
sendTransform(tftree, Tmsg);


% Function definition to use it in this code
% This function may cause an Error in MATLAB 2016 in WINDOWS (but anyway it's just useful in Linux with ROS)
% function T = ROS2T(Tmsg)
%     T = zeros(4);
%     T(1,4) = Tmsg.Translation.X;
%     T(2,4) = Tmsg.Translation.Y;
%     T(3,4) = Tmsg.Translation.Z;
%     T(4,4) = 1;
%     q = Tmsg.Rotation;
%     T(1:3,1:3) = quat2rotm([q.W, q.X, q.Y, q.Z]);
% end
