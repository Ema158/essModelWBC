function NumFig = plot_joints(t,joints,q,qD,qDD,figIni,Group,LineType)

% figIni -> it is the number of the first figure is going to be created
% Grupo -> it is the number of joints per figure
% Linea -> it is the type of line that's going to be used to plot

% Since it's going to be plotted "length(joints)" joints in "group" groups, sometimes these groups are not going to be
% complete, therefore the leftover joints are going to be plotted in a separated figure
rest = mod(length(joints),Group);  % The joints that not reach to form a group are going to be plotted separately
if rest ==0
    nFigs = floor(length(joints)/Group);   % Number of figures needed when the number of groups are exact
else
    nFigs = floor(length(joints)/Group) + 1; % Number of figures needed when there are leftover joints to plot separately
end
k = 1;
for j=1:nFigs
    figure((j-1)+ figIni)  
    if j ~= nFigs || rest == 0
        for i=1:Group
            subplot(3,Group,i)   % It will be plotted the positions in the FIRST row with "Group" elements
            hold on
            plot(t,q(joints(k),:),LineType)
            axis([min(t) max(t) -inf inf])
            ylabel('Position ');
            title(['Joint q(' int2str(joints(k)) ')']);
            subplot(3,Group, Group + i)  % It will be plotted the velocities in the SECOND row with "Group" elements
            hold on
            plot(t,qD(joints(k),:),LineType)
            axis([min(t) max(t) -inf inf])
            ylabel('Velocity ');
            subplot(3,Group, 2*Group + i) % It will be plotted the accelerations in the THIRD row with "Group" elements
            hold on
            plot(t,qDD(joints(k),:),LineType)
            axis([min(t) max(t) -inf inf])
            xlabel('$t$ [s]','interpreter','Latex');
            ylabel('Acceleration ');
            k = k+1;
        end
    else
        for i=1:rest
            subplot(3,rest,i)   % It will be plotted the positions in the FIRST row with "rest" elements  
            hold on
            plot(t,q(joints(k),:),LineType)
            axis([min(t) max(t) -inf inf])
            ylabel('Position ');
            title(['Joint q(' int2str(joints(k)) ')']);
            subplot(3,rest, rest + i) % It will be plotted the velocities in the SECOND row with "rest" elements  
            hold on
            plot(t,qD(joints(k),:),LineType)
            axis([min(t) max(t) -inf inf])
            ylabel('Velocity ');
            subplot(3,rest, 2*rest + i) % It will be plotted the accelerations in the THIRD row with "rest" elements  
            hold on
            plot(t,qDD(joints(k),:),LineType)
            axis([min(t) max(t) -inf inf])
            xlabel('$t$ [s]','interpreter','Latex');
            ylabel('Acceleration ');
            k = k+1;
        end
    end
end
NumFig = figIni + nFigs; % The next figure that can be used