% figure(7)
% plot(t_record,qD_record(:,1))
% xnew= linspace(max(t_record),min(t_record),1000);
% ynew = interp1(t_record,qD_record(:,1),xnew,'spline');
% figure(8)
% plot(xnew,ynew)
% qDD_record_new = C_diff(ynew,xnew);
% figure(9)
% plot(xnew,qDD_record_new)
% hold on
% plot(t_all + t_delay, qDD_all(1,:)*-1)
% figure(10)
% plot(t_record,qDD_record(1,:))
% hold on
% plot(t_all + t_delay, qDD_all(1,:)*-1)
%
% figure(7)
% plot(t_record,q_record(:,1))
% xnew= linspace(max(t_record),min(t_record),2000);
% ynew = interp1(t_record,q_record(:,1),xnew,'cubic');
% figure(8)
% plot(xnew,ynew)
% qD_record_new = C_diff(ynew,xnew);
% figure(9)
% plot(xnew,qD_record_new)
% hold on
% plot(t_all + t_delay, qD_all(1,:)*-1)
% figure(10)
% plot(t_record,qD_record(:,1))
% hold on
% plot(t_all + t_delay, qD_all(1,:)*-1)
%%%%%%%%55%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
[qD1_s, index]= unique(qD_record(:,1),'stable');
t_s = t_record(index);
xnew= linspace(min(t_record),max(t_record),100);
ynew = interp1(t_s,qD1_s,xnew,'linear');
qDD_record_new = C_diff(ynew,xnew);
%qDD_record_new = C_diff(qD1_s',t_s);
figure(7)
plot(xnew,qDD_record_new)
%plot(t_s,qDD_record_new)
hold on
plot(t_all + t_delay, qDD_all(1,:)*-1)
figure(8)
plot(t_record,qDD_record(1,:))
hold on
plot(t_all + t_delay,qDD_all(1,:)*-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%
% [q1_s, index]= unique(q_record(:,1),'stable');
% t_s = t_record(index);
% xnew= linspace(min(t_record),max(t_record),200);
% ynew = interp1(t_s,q1_s,xnew,'linear');
% %qD_record_new = C_diff(ynew,xnew);
% qD_record_new = C_diff(q1_s',t_s);
% figure(7)
% % plot(xnew,qD_record_new)
% plot(t_s,qD_record_new)
% hold on
% plot(t_all + t_delay, qD_all(1,:)*-1)
% figure(8)
% plot(t_record,qD_record(:,1))
% hold on
% plot(t_all + t_delay,qD_all(1,:)*-1)

