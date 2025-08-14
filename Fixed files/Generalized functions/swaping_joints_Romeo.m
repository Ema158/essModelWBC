function q = swaping_joints_Romeo(q)
% q is a matrix of 31 x m where 31 is the number of joints and "m" is the number of samples

q(1:12,:)=[q(12,:);-q(11,:);-q(10,:);-q(9,:);q(8,:);q(7,:);q(6,:);q(5,:);-q(4,:);-q(3,:);-q(2,:);q(1,:)];  % q+ = E*q-
                  % now the positive twist is from -Y to X instead of X to Y (or viceversa)
q(21,:)=-q(21,:); % Neck_yaw
q([13,17],:)=[q(17,:); q(13,:)]; % Swap Shoulders Pitch
% CHECK THIS SWAPING....
q([14,15,16,18,19,20],:)=[-q(18,:); -q(19,:); -q(20,:); -q(14,:); -q(15,:); -q(16,:)]; % Swap Shoulders Yaw and rest of the arm
