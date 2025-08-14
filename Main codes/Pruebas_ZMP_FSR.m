Fd1L = zeros(size(FSR_record,1),2);
Fd2L = zeros(size(FSR_record,1),2);
Fd3L = zeros(size(FSR_record,1),2);
Fd4L = zeros(size(FSR_record,1),2);
FdtL = zeros(size(FSR_record,1),2);
FtL = zeros(size(FSR_record,1),1);
%
Fd1R = zeros(size(FSR_record,1),2);
Fd2R = zeros(size(FSR_record,1),2);
Fd3R = zeros(size(FSR_record,1),2);
Fd4R = zeros(size(FSR_record,1),2);
FdtR = zeros(size(FSR_record,1),2);
Fdt_DS = zeros(size(FSR_record,1),2);
FtR = zeros(size(FSR_record,1),1);
for i=1:size(FSR_record,1)
    Fd1L(i,:) = FSR_record(i,1)*[0.07025;0.0299];
    Fd2L(i,:) = FSR_record(i,2)*[0.07025;-0.0231];
    Fd3L(i,:) = FSR_record(i,3)*[-0.03025;0.0299];
    Fd4L(i,:) = FSR_record(i,4)*[-0.02965;-0.0191];
    FdtL(i,:) = Fd1L(i,:) + Fd2L(i,:) + Fd3L(i,:) + Fd4L(i,:);
    FtL(i) = FSR_record(i,1) + FSR_record(i,2) + FSR_record(i,3) + FSR_record(i,4);
    ZMP_xL(i) = FdtL(i,1)/FtL(i);
    ZMP_yL(i) = FdtL(i,2)/FtL(i);
    %
    Fd1R(i,:) = FSR_record(i,5)*[0.07025;0.0231];
    Fd2R(i,:) = FSR_record(i,6)*[0.07025;-0.0299];
    Fd3R(i,:) = FSR_record(i,7)*[-0.03025;0.0191];
    Fd4R(i,:) = FSR_record(i,8)*[-0.02965;-0.0299];
    FdtR(i,:) = Fd1R(i,:) + Fd2R(i,:) + Fd3R(i,:) + Fd4R(i,:);
    FtR(i) = FSR_record(i,5) + FSR_record(i,6) + FSR_record(i,7) + FSR_record(i,8);
    ZMP_xR(i) = FdtR(i,1)/FtR(i);
    ZMP_yR(i) = FdtR(i,2)/FtR(i);
    %
    Fdt_DS(i,:) = [ZMP_xR(i);ZMP_yR(i)]*FtR(i) + [ZMP_xL(i);ZMP_yL(i) + 0.1]*FtL(i);
    ZMP_DS_x(i) = Fdt_DS(i,1)/(FtR(i) + FtL(i));
    ZMP_DS_y(i) = Fdt_DS(i,2)/(FtR(i) + FtL(i));
end
plot(ZMP_DS_x(1:127),ZMP_DS_y(1:127))
