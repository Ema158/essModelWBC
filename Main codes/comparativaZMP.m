clc
clear
close all
DataName1 = 'InfoNAO_DSNoWBCAcc';
% DataName1 = 'InfoNAO_Param_t_caminadoNoWBCDS'; % File produced in "M04d_...m" CHANGE OptionContVar = 1;
SolutionNoWBC = load(DataName1);
DataName2 = 'InfoNAO_DSAcc';
% DataName2 = 'InfoNAO_DS';
SolutionWBC = load(DataName2);
ZMPNoWBC = SolutionNoWBC.InfNAO.Solution.ZMP;
ZMPWBC = SolutionWBC.InfNAO.Solution.ZMP;
CoMSSNoWBC = SolutionNoWBC.InfNAO.Solution.XtSS;
CoMDSNoWBC = SolutionNoWBC.InfNAO.Solution.XtDS;
CoMSSWBC = SolutionWBC.InfNAO.Solution.XtSS;
CoMDSWBC = SolutionWBC.InfNAO.Solution.XtDS;
XtStartNoWBC = SolutionNoWBC.InfNAO.Solution.XtStart;
XtStartWBC = SolutionWBC.InfNAO.Solution.XtStart;
XtStartStepNoWBC = SolutionNoWBC.InfNAO.Solution.XtStartStep;
XtStartStepWBC = SolutionWBC.InfNAO.Solution.XtStartStep;
tSS = SolutionNoWBC.InfNAO.Solution.tSS{1};
tDS = SolutionNoWBC.InfNAO.Solution.tDS{1};
t = [tSS,tSS(end)+tDS];
tStart = SolutionNoWBC.InfNAO.Solution.tStart;
tStartStep = SolutionNoWBC.InfNAO.Solution.tStartStep;
tStartAll = [tStart,tStart(end)+tStartStep];
S = SolutionWBC.InfNAO.gait_parametersSS.S;
D = SolutionWBC.InfNAO.gait_parametersSS.D;
Zref = SolutionWBC.InfNAO.Solution.Zref;
tRef = SolutionWBC.InfNAO.Solution.tRef;
% [ZMax,ZMin] = ZMPConstraintsOneStep(100,0,S,0,D);
ZMax = SolutionWBC.InfNAO.Solution.ZMax;
ZMin = SolutionWBC.InfNAO.Solution.Zmin;
T = 0.5;
figure(1)
plot(tStart,XtStartNoWBC(:,2),'r--');
hold on
plot(tStart,XtStartWBC(:,2),'b--');
plot(tStartAll,ZMPNoWBC{1}(2,:),'r')
plot(tStartAll,ZMPWBC{1}(2,:),'b')
plot(tStart(end)+tStartStep,XtStartStepNoWBC(:,2),'r--');
plot(tStart(end)+tStartStep,XtStartStepWBC(:,2),'b--');
tema = tStart(end)+tStartStep(end);
plot(tRef,Zref(2,:),'k--')
plot(tRef,ZMax(2,:),'g--')
plot(tRef,ZMin(2,:),'g--')
for i=1:length(ZMPWBC)-2
    if mod(i,2)==0
        plot(tema+t+T*(i-1),ZMPNoWBC{i+1}(2,:),'r')
        plot(tema+t+T*(i-1),ZMPWBC{i+1}(2,:),'b')
        plot(tema+tSS+T*(i-1),CoMSSNoWBC{i}(:,2),'r--')
        plot(tema+tDS+tSS(end)+T*(i-1),CoMDSNoWBC{i}(:,2),'r--')
        plot(tema+tSS+T*(i-1),CoMSSWBC{i}(:,2),'b--')
        plot(tema+tDS+tSS(end)+T*(i-1),CoMDSWBC{i}(:,2),'b--')
    else
        plot(tema+t+T*(i-1),-ZMPNoWBC{i+1}(2,:)+D,'r')
        plot(tema+t+T*(i-1),-ZMPWBC{i+1}(2,:)+D,'b')
        plot(tema+tSS+T*(i-1),-CoMSSNoWBC{i}(:,2)+D,'r--')
        plot(tema+tSS(end)+tDS+T*(i-1),-CoMDSNoWBC{i}(:,2)+D,'r--')
        plot(tema+tSS+T*(i-1),-CoMSSWBC{i}(:,2)+D,'b--')
        plot(tema+tSS(end)+tDS+T*(i-1),-CoMDSWBC{i}(:,2)+D,'b--')
    end
end
figure(2)
plot(tStart,XtStartNoWBC(:,1),'r--');
hold on
plot(tStart,XtStartWBC(:,1),'b--');
plot(tStart(end)+tStartStep,XtStartStepNoWBC(:,1),'r--');
plot(tStart(end)+tStartStep,XtStartStepWBC(:,1),'b--');
plot(tStartAll,ZMPNoWBC{1}(1,:),'r')
plot(tStartAll,ZMPWBC{1}(1,:),'b')
plot(tRef,Zref(1,:),'k--')
plot(tRef,ZMax(1,:),'g--')
plot(tRef,ZMin(1,:),'g--')
for i=1:length(ZMPWBC)-2
        plot(tema+t+T*(i-1),ZMPNoWBC{i+1}(1,:)+S*(i),'r')
        plot(tema+t+T*(i-1),ZMPWBC{i+1}(1,:)+S*(i),'b')
        plot(tema+tSS+T*(i-1),CoMSSNoWBC{i}(:,1)+S*(i),'r--')
        plot(tema+tDS+tSS(end)+T*(i-1),CoMDSNoWBC{i}(:,1)+S*(i),'r--')
        plot(tema+tSS+T*(i-1),CoMSSWBC{i}(:,1)+S*(i),'b--')
        plot(tema+tDS+tSS(end)+T*(i-1),CoMDSWBC{i}(:,1)+S*(i),'b--')
end
figure(3)
plot(Zref(1,:),Zref(2,:),'k--')
plot(ZMax(1,:),ZMax(2,:),'g--')
plot(ZMin(1,:),ZMin(2,:),'g--')
for i=1:length(ZMPWBC)
    if mod(i,2)
        plot(ZMPNoWBC{i}(1,:)+S*(i-1),ZMPNoWBC{i}(2,:),'r')
        hold on
        plot(ZMPWBC{i}(1,:)+S*(i-1),ZMPWBC{i}(2,:),'b')
    else
        plot(ZMPNoWBC{i}(1,:)+S*(i-1),-ZMPNoWBC{i}(2,:)+D,'r')
        plot(ZMPWBC{i}(1,:)+S*(i-1),-ZMPWBC{i}(2,:)+D,'b')
    end
end
% figure(4)
% plot(Zref(1,:),Zref(2,:),'k--')
% hold on
% for i=1:length(CoMSSWBC)
%     if mod(i,2)
%         plot(CoMSSNoWBC{i}(:,1)+S*(i-1),CoMSSNoWBC{i}(:,2),'r')
%         plot(CoMDSNoWBC{i}(:,1)+S*(i-1),CoMDSNoWBC{i}(:,2),'r')
%         plot(CoMSSWBC{i}(:,1)+S*(i-1),CoMSSWBC{i}(:,2),'b')
%         plot(CoMDSWBC{i}(:,1)+S*(i-1),CoMDSWBC{i}(:,2),'b')
%     else
%         plot(CoMSSNoWBC{i}(:,1)+S*(i-1),-CoMSSNoWBC{i}(:,2)+D,'r')
%         plot(CoMDSNoWBC{i}(:,1)+S*(i-1),-CoMDSNoWBC{i}(:,2)+D,'r')
%         plot(CoMSSWBC{i}(:,1)+S*(i-1),-CoMSSWBC{i}(:,2)+D,'b')
%         plot(CoMDSWBC{i}(:,1)+S*(i-1),-CoMDSWBC{i}(:,2)+D,'b')
%     end
% end
figure(5)
plot(tStart,XtStartNoWBC(:,3),'r--');
hold on
plot(tStart,XtStartWBC(:,13),'b--');
plot(tStart(end)+tStartStep,XtStartStepNoWBC(:,3),'r--');
plot(tStart(end)+tStartStep,XtStartStepWBC(:,13),'b--');
for i=1:length(ZMPWBC)-2
        plot(tema+tSS+T*(i-1),CoMSSNoWBC{i}(:,3),'r--')
        plot(tema+tDS+tSS(end)+T*(i-1),CoMDSNoWBC{i}(:,3),'r--')
        plot(tema+tSS+T*(i-1),CoMSSWBC{i}(:,13),'b--')
        plot(tema+tDS+tSS(end)+T*(i-1),CoMDSWBC{i}(:,13),'b--')
end
figure(6)
plot(tStart,XtStartNoWBC(:,4),'r--');
hold on
plot(tStart,XtStartWBC(:,14),'b--');
plot(tStart(end)+tStartStep,XtStartStepNoWBC(:,4),'r--');
plot(tStart(end)+tStartStep,XtStartStepWBC(:,14),'b--');
tema = tStart(end)+tStartStep(end);
for i=1:length(ZMPWBC)-2
    if mod(i,2)==0
        plot(tema+tSS+T*(i-1),CoMSSNoWBC{i}(:,4),'r--')
        plot(tema+tDS+tSS(end)+T*(i-1),CoMDSNoWBC{i}(:,4),'r--')
        plot(tema+tSS+T*(i-1),CoMSSWBC{i}(:,14),'b--')
        plot(tema+tDS+tSS(end)+T*(i-1),CoMDSWBC{i}(:,14),'b--')
    else
        plot(tema+tSS+T*(i-1),-CoMSSNoWBC{i}(:,4),'r--')
        plot(tema+tSS(end)+tDS+T*(i-1),-CoMDSNoWBC{i}(:,4),'r--')
        plot(tema+tSS+T*(i-1),-CoMSSWBC{i}(:,14),'b--')
        plot(tema+tSS(end)+tDS+T*(i-1),-CoMDSWBC{i}(:,14),'b--')
    end
end