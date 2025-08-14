% Author: Victor de Leon
% Creation: 13/jan/2018
% Last modification: -/-/-
%     *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    
% Uncomment this line for using this file as a function:
function Coeff = findPolyCoeff(posd,veld,accd)
%     *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    

% For posd, veld and accd the First column is the evaluation point and the second column is the
% posd - > n1 x 2 matrix for desired positions at each specific evaluation points 
% veld - > n1 x 2 matrix for desired velocities at each specific evaluation points 
% accd - > n1 x 2 matrix for desired accelerations at each specific evaluation points 

% The coefficients are computed by means of
% A*Coeff = b
% where "A" is a n x n matrix and "b" a n-vector of desired positions, velocities and accelerations

% % ==============================================================================================
% % Coment the next (and the last part) for using this file as a function (and uncomment the above one)
% %     *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    
% clear all;
% close all;
% clc;
% % NOTE that it is neccesary to give at least one point for desired position in order to get a solution 
% %      if not, rank(A) = n-1 
% 
% % Example 1
% posd = [0, 5;
%         1, 9;
%         3,30;
%         8, 8];
% veld = [0, 0;
%         5, 20;   
%         8, 0];
% accd = [0, 0;
%         1, 9;
%         8, 0];
% 
% % Example 2 without taking into account acceleration
% % posd = [0, 5;
% %         8, 8];
% % veld = [0, 0;
% %         8, 0];
% % accd = [];
% 
% % Example 3 without taking into account velocity
% % posd = [0, 5;
% %         3,30];
% % veld = [];
% % accd = [0, 0;
% %         1, 9;
% %         8, 0];
% 
% % Example 4 without taking into account velocity and acceleration
% % posd = [0, 5;
% %         -1,-2;
% %         -18,5;
% %         3,30];
% % veld = [];
% % accd = [];
% 
% % % Example 5 
% % posd = [0, 0;          
% %         2, -2;        
% %         3.6, 10;
% %         5.21, 14];
% % veld = [4, 12
% %        -4,-12];
% % accd = [6 0];
% %     *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    
% % ============================================================================================

% Desired values
[RowPos, ColPos] = size(posd);
[RowVel, ColVel] = size(veld);
[RowAcc, ColAcc] = size(accd);

n = RowPos + RowVel + RowAcc; % Number of Coefficients we need

xAll = [];
if ColPos == 2
    xAll = posd(:,1);
elseif ColPos ~= 0
    disp('ERROR: First column of Position data should be evaluation points, and second column desired points...');
    Coeff = 0;
    return;
end
if ColVel == 2
    xAll = [xAll;veld(:,1)];
elseif ColVel ~= 0
    disp('ERROR: First column of Velocity data should be evaluation points, and second column desired points...');
    Coeff = 0;
    return;
end
if ColAcc == 2
    xAll = [xAll;accd(:,1)];
elseif ColAcc ~= 0
    disp('ERROR: First column of Acceleration data should be evaluation points, and second column desired points...');
    Coeff = 0;
    return;    
end
xAll = unique(xAll);  % We arrange a vector for all the points we are going to create the polynomials
nPoints = numel(xAll);

A = zeros(n,n);
b = zeros(n,1);
row = 1;
for k=1:nPoints
    x = xAll(k);
    for j=1:RowPos
        if x == posd(j,1)
            col = 1;
            for i=n-1:-1:0
                A(row,col) = x^i;
                col = col + 1;
            end
            b(row) = posd(j,2);
            row = row + 1;
        end
    end
    for j=1:RowVel
        if x == veld(j,1)
            col = 1;
            for i=n-1:-1:1
                A(row,col) = i*x^(i-1);
                col = col + 1;
            end
            b(row) = veld(j,2);
            row = row + 1;
        end
    end
    for j=1:RowAcc
        if x == accd(j,1)
            col = 1;
            for i=n-1:-1:2
                A(row,col) = i*(i-1)*x^(i-2);
                col = col + 1;
            end
            b(row) = accd(j,2);
            row = row + 1;
        end
    end
end


Coeff = linsolve(A,b); % we can simply use "inv(A)*b;". 


% % ==============================================================================================
% % TEST: Coment this last part for using this file as a function
% %     *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    
% % build trajectories
% xt = xAll(1):0.001:xAll(end);
% samples = length(xt);
% yt = zeros(1,samples);
% ypt = zeros(1,samples);
% yppt = zeros(1,samples);
% for i=1:samples
%     yt(i) = polyval(Coeff,xt(i));
%     ypt(i) = polyval(polyder(Coeff),xt(i));
%     yppt(i) = polyval(polyder(polyder(Coeff)),xt(i));
% end
% 
% figure (1)
% subplot(3,1,1)
% for i=1:RowPos
%     plot(posd(i,1),posd(i,2),'ro');
%     hold on
% end
% plot(xt,yt,'b')
% ylabel('Position');
% subplot(3,1,2)
% for i=1:RowVel
%     plot(veld(i,1),veld(i,2),'ro');
%     hold on
% end
% plot(xt,ypt,'b')
% ylabel('Velocity');
% subplot(3,1,3)
% for i=1:RowAcc
%     plot(accd(i,1),accd(i,2),'ro');
%     hold on
% end
% plot(xt,yppt,'b')
% ylabel('Acceleration');
% %     *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    
% % ============================================================================================
