
global OptionContVar
if isempty(OptionContVar)  % If OptionContVar is empty we decide to chose the first option as default    
    error(['The variable "OptionContVar" is empty, you need to choose which files are used to build \n',...
           'the desired trajectories "hd(Phi)", defined in the file "OptionDesiredTrajectory.m"'],OptionContVar);
end
    
switch Case
    case 'position'    
        switch OptionContVar
            case 1
                hd = hd_Polyn(gait_parameters,t);
            otherwise
                error(['The value of the variable "OptionContVar" is %d. However this option is no \n',...
                       'valid in the file "OptionDesiredTrajectory.m"'],OptionContVar);       
        end
    %  *    *     *     *      *    *     *     *     *    *     *     *        
    case 'velocity'        
        switch OptionContVar
            case 1
                Phip = [qfp; 1];
                phiDim = length(Phip) - 12; %dimension of vector "phi", where Phi = [qf^T phi^T]^T
                % terms for building matrix Jd
                dhd_Phi(:,1) = zeros(12,1); % partial derivative of "hd" w.r.t. x
                dhd_Phi(:,2) = zeros(12,1); % partial derivative of "hd" w.r.t. y
                dhd_Phi(:,3) = zeros(12,1); % partial derivative of "hd" w.r.t. q13
                dhd_Phi(:,4) = zeros(12,1); % partial derivative of "hd" w.r.t. q14
                dhd_Phi(:,5) = zeros(12,1); % partial derivative of "hd" w.r.t. q15
                dhd_Phi(:,6) = zeros(12,1); % partial derivative of "hd" w.r.t. q16
                dhd_Phi(:,7) = zeros(12,1); % partial derivative of "hd" w.r.t. q17
                dhd_Phi(:,8) = zeros(12,1); % partial derivative of "hd" w.r.t. q18
                dhd_Phi(:,9) = zeros(12,1); % partial derivative of "hd" w.r.t. q19
                dhd_Phi(:,10) = zeros(12,1); % partial derivative of "hd" w.r.t. q20
                dhd_Phi(:,11) = zeros(12,1); % partial derivative of "hd" w.r.t. q20
                dhd_Phi(:,12) = zeros(12,1); % partial derivative of "hd" w.r.t. q20
                dhd_Phi(:,13) = hpd_Polyn_t(gait_parameters,t); % partial derivative of "hd" w.r.t. phi1 = t
        end        
    %  *    *     *     *      *    *     *     *     *    *     *     *        
    case 'acceleration'
        switch OptionContVar
            case 1
                Phip = [qfp; 1];
                phiDim = length(Phip) - 12; %dimension of vector "phi", where Phi = [qf^T phi^T]^T
                % terms for building matrix "Jdp"...
                dPhi_dhd_x = zeros(12,12+phiDim);
                dPhi_dhd_y = zeros(12,12+phiDim);
                dPhi_dhd_q13 = zeros(12,12+phiDim);
                dPhi_dhd_q14 = zeros(12,12+phiDim);
                dPhi_dhd_q15 = zeros(12,12+phiDim);
                dPhi_dhd_q16 = zeros(12,12+phiDim);
                dPhi_dhd_q17 = zeros(12,12+phiDim);
                dPhi_dhd_q18 = zeros(12,12+phiDim);
                dPhi_dhd_q19 = zeros(12,12+phiDim);
                dPhi_dhd_q20 = zeros(12,12+phiDim);
                dPhi_dhd_Roll = zeros(12,12+phiDim);
                dPhi_dhd_Pitch = zeros(12,12+phiDim);
                dPhi_dhd_t = [zeros(12,1), zeros(12,1), zeros(12,1), zeros(12,1),...
                             zeros(12,1), zeros(12,1), zeros(12,1), zeros(12,1),...
                             zeros(12,1), zeros(12,1), zeros(12,1), zeros(12,1), hppd_Polyn_t(gait_parameters,t)];
                dt_dhd_Phi = [dPhi_dhd_x*Phip, dPhi_dhd_y*Phip, dPhi_dhd_q13*Phip,...
                              dPhi_dhd_q14*Phip, dPhi_dhd_q15*Phip, dPhi_dhd_q16*Phip,...
                              dPhi_dhd_q17*Phip, dPhi_dhd_q18*Phip, dPhi_dhd_q19*Phip,...
                              dPhi_dhd_q20*Phip, dPhi_dhd_Roll*Phip, dPhi_dhd_Pitch*Phip, dPhi_dhd_t*Phip];
                
        end           
    %  *    *     *     *      *    *     *     *     *    *     *     *       
   
   
end