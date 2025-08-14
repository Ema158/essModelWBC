function [c,ceq] = Optim_Constraints(R)

global NonLinearIneqCons NonLinearEqCons

% Inequality constraints
% ------------------------------
% c = NonLinearIneqCons;
 c = [];
% Equality constraints
% ------------------------------
 ceq = [];
% ceq = NonLinearEqCons;
% 
% IneqConsMax = max(c);
% 
% disp('-----Inequality constraints  (All values must be negative)---------------')
% disp('Joint    +Velocity    -Velocity    +Torque    -Torque')
% disp([(1:31)', c(1:31)', c(32:62)', c(63:93)', c(94:end)'])
% if IneqConsMax<0
%     disp('All constraints satisfied =)');
% else
%     disp('NOT all constraints satisfied!');
% end
% disp('----- Equality constraints  (All values must cero)---------------')
% disp('Fix point [xf_k - xf_{k-1}, yf_k - yf_{k-1}, xpf_k - xpf_{k-1}, ypf_k - ypf_{k-1}];')
% disp(ceq)

