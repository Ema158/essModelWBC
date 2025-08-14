function vecS = sampling(vec,n)
% "vect" is a matrix. However, the rows of "vect" are the variables and the colums are the samples, at each time.
% for example a vector with 3 variables and "N" samples has the form:
% vect = [x(0) x(1) ... x(N);
%         y(0) y(1) ... x(N);
%         z(0) z(1) ... z(N)];
% Then the output is a vector with less samples, "n" samples, but well spaced.

numVar = size(vec,1); % number of rows
a = floor(numel(vec(1,:))/(n-1));
vecS = zeros(numVar,n);
for i = 1:n
    if i==1
        k=1;
    else
        k=(i-1)*a+numel(vec(1,:))-a*(n-1);
    end
    vecS(:,i) = vec(:,k);
end
