function FigNum = plot_vector(t,var,x,figIni,Matrix,LineType,LabelX,LabelY)
% t -> vector of "m" samples w.r.t.which all variables "x" will be plotted (normally is the time).
% x -> it is a n X m matrix, where "n" represent the variable and "m" represents the value of the variable at each sample
% n-> rows, m - > columns
% ej.
% x = [ 1 2 3 4 5 ...;  .. in here there are  2 variables x1 = [1   2  3  4  5  ...]   and x2 = [9  8  7   6  5 ...]
%       9 8 7 6 5 ...]                             at instants  t0  t1 t2 t3 t4 ... at instants  t0 t1 t2  t3 t4...
% var - > vector that tell us which variables are going to be plotted (i.e. it is not neccessary to plot all variables)
% figIni -> it is the number of the first figure that is going to be plotted
% Matriz -> 2-element vector that tell us how the subplot of each figure will be constituted
% LineType -> it is the color of the line which be used to plot
% LabelY -> Tell us what is going to written in the Y axis, ej. '$\dot{q}$','interpreter','latex';
% LabelX -> Tell us what is going to written in the X axis, ej. '$t_s \dot{q}$','interpreter','latex';

% Since it is going to be plotted "length(var)" variables in "Matrix(1) x Matrix(2)" figures, we must identify how many
% variables fit in each figure
varFig = prod(Matrix); % Number of variables per figura
varGraf = length(var); % Number of variables to plot
rest = mod(varGraf,varFig);  % The joints that not reach to form a group are going to be plotted separately
if rest ==0
    nFigs =  floor(varGraf/varFig);  % Number of figures needed when the number of groups are exact
else
    nFigs =  floor(varGraf/varFig) + 1; % Number of figures needed when there are leftover variables to plot separately
    % This part of the code is for the LAST FIGURE
    % --------------------------------------------
    % By taking into account the dimensions of "Matrix" the number of rows and columns that the LAST FIGURE must have are defined    
    renExact = mod(rest,Matrix(2));  % This is to know if the last figure will have exact nomber of rows or not. if 0 -> yes, otherwise -> no.
    renRest = floor(rest/Matrix(2)); % from the leftover elements to be plotted, it is identified how many rows of "Matrix(2)" columns remain
    colEnd = 0;                     % At the beginning it is assumed that the last row of the last figure is complete
    if  renExact == 0  % ...if the rows are exact
        % number of columns that are going to be used
        colRest = Matrix(2);
    else                % if the rows are NOT exact
        if renRest > 0 % at least is one row completed?            
            colRest = Matrix(2);
            colEnd = rest - renRest*colRest;
            renRest = renRest + 1; % Another row is added
        else
            renRest = 1;
            colRest = rest;            
        end
    end
    colLastFig = colRest; % Number of columns of the last figure
    % --------------------------------------------    
end
    % -----------------------------------------------------------------------
nVar = 1; % Counter for the current variable to be plotted
for j=1:nFigs
    figure((j-1)+ figIni)  % Create figure with number "(j-1)+ figIni"
    k = 1;
    if j ~= nFigs || rest == 0
        for i=1:Matrix(1) % Scanning by rows
            for l=1:Matrix(2) % Scanning by columns
                subplot(Matrix(1),Matrix(2),k)  
                hold on
                plot(t,x(var(nVar),:),LineType)
                if length(t)>1
                    axis([min(t) max(t) -inf inf])
                end
                ylabel([LabelY '(' int2str(var(nVar)) ')'],'interpreter','latex');
                xlabel(LabelX,'interpreter','latex');
                k = k+1 ;
                nVar = nVar+1;
            end
        end
    else
        for i=1:renRest % Scanning by rows for the last figure
            l = 1;            
            while l<=colRest % Scanning by columns for the last figure
                subplot(renRest,colLastFig,k)   
                hold on
                plot(t,x(var(nVar),:),LineType)
                if length(t)>1
                    axis([min(t) max(t) -inf inf])
                end
                ylabel([LabelY '(' int2str(var(nVar)) ')'],'interpreter','latex'); 
                xlabel(LabelX,'interpreter','latex');
                k = k+1 ;
                nVar = nVar+1;
                l = l+1;
                % when the second last row of the last figure is finished, the value of the remaining columns to be used is changed
                if (i == renRest-1) && (l == colRest + 1)
                    colRest  = colEnd;                    
                end                
            end
        end
    end
end

FigNum = figIni + nFigs; % The next figure that can be used in other code