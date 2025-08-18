function [F0,M0,Tau] = Newton_EulerDS(q,qD,qDD,FR)
%NEWTON_EULER Algorithm to compute torques (model single mass)
PI=Mass_information();
%init;
g=9.81;
Ia = actuator_inertia;
Tau = zeros(24,1);
frame=[2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,23,24,25,26];

tree1 =[1,2,3,4,5,6,7,8,9,10,11,12];%Piernas
tree2 =[23,24];%Cabeza
tree3 = [13,14,15,16,17];%Brazo derecho
tree4 = [18,19,20,21,22];%Brazo izquierdo
M= PI.masse;
I =PI.I;
COM = PI.CoM;

robot=genebot;
robot.q=q;
T=DGM(robot);

%Initialisation
ome =[0;0;0];
omeD = [0;0;0];
vD = [0;0;g];
tree = tree1;
ft = zeros(3,24);
mt = zeros(3,24);
%Forward algorithm
% =========================================
for i=1:numel(tree)
    if i~=1
    L = T(1:3,4,frame(tree(i)))-T(1:3,4,frame(tree(i-1))); % 0L = 0Pi - OP{i-1}
    else
    L = T(1:3,4,frame(tree(i)))-T(1:3,4,1);  % 0L = 0P2 - OP1
    end
    % Note que en las siguientes 2 ecuaciones se usan los valores anteriores de w, i.e "w_{i-1}" luego en la 3era ecuacion de
    % calcula el nuevo w, i.e "w_i"
    % 0vp = 0vp_a  +  0wp X 0L  +  0w x 0w x 0L
    vD = vD + cross_matrix(omeD)*L+cross_matrix(ome)*(cross_matrix(ome)*L);
    % 0wp = 0wp_a  +  0a*qpp  +  0w x 0a*qp 
    omeD = omeD + T(1:3,3,frame(tree(i)))*qDD(tree(i))+cross_matrix(ome)*T(1:3,3,frame(tree(i)))*qD(tree(i));
    % w = w_a + qp*0a
    ome = ome + qD(tree(i))*T(1:3,3,frame(tree(i)));
    if tree(i)==6
        omei = ome;
        omeDi = omeD;
        vDi = vD;
    end
    R=T(1:3,1:3,frame(tree(i)));  % R = 0^R_{i}
    S = R*COM{frame(tree(i))}; % S = 0Pcom = 0^R_i i^Pcom
    % 0Finercial = m[0vp  +  0wp x 0Pcom  +  0w x 0w x 0Pcom]
    ft(:,tree(i)) = M(frame(tree(i)))*(vD+cross_matrix(omeD)*S + cross_matrix(ome)*(cross_matrix(ome)*S));
    % 0Minercial = m*0Pcom X 0vp  +  0Ij*wp  +  w x 0Ij x ome    
    mt(:,tree(i))= M(frame(tree(i)))*cross_matrix(S)*vD + R*I{frame(tree(i))}*R'*omeD + cross_matrix(ome)*R*I{frame(tree(i))}*R'*ome;
end

%Tree 2 Initialisation
ome =omei;
omeD = omeDi;
vD = vDi;
tree=tree2;

%Forward algorithm
for i=1:numel(tree)
    if i~=1
    L = T(1:3,4,frame(tree(i)))-T(1:3,4,frame(tree(i-1)));
    else
    L = T(1:3,4,frame(tree(i)))-T(1:3,4,frame(6));
    end
    vD = vD + cross_matrix(omeD)*L+cross_matrix(ome)*(cross_matrix(ome)*L);
    omeD = omeD+T(1:3,3,frame(tree(i)))*qDD(tree(i))+cross_matrix(ome)*T(1:3,3,frame(tree(i)))*qD(tree(i));
    ome = ome + qD(tree(i))*T(1:3,3,frame(tree(i)));
%     if tree(i)==13
%         omei = ome;
%         omeDi = omeD;
%         vDi = vD;
%     end
    R=T(1:3,1:3,frame(tree(i)));
    S = R*COM{frame(tree(i))};
    ft(:,tree(i)) = M(frame(tree(i)))*(vD+cross_matrix(omeD)*S+cross_matrix(ome)*(cross_matrix(ome)*S));
    mt(:,tree(i))= M(frame(tree(i)))*cross_matrix(S)*vD+R*I{frame(tree(i))}*R'*omeD+cross_matrix(ome)*R*I{frame(tree(i))}*R'*ome;
end

%Tree 3 Initialisation
ome =omei;
omeD = omeDi;
vD = vDi;
tree=tree3;

%Forward algorithm
for i=1:numel(tree)
    if i~=1
    L = T(1:3,4,frame(tree(i)))-T(1:3,4,frame(tree(i-1)));
    else
    L = T(1:3,4,frame(tree(i)))-T(1:3,4,frame(6));
    end
    vD = vD + cross_matrix(omeD)*L+cross_matrix(ome)*(cross_matrix(ome)*L);
    omeD = omeD+T(1:3,3,frame(tree(i)))*qDD(tree(i))+cross_matrix(ome)*T(1:3,3,frame(tree(i)))*qD(tree(i));
    ome = ome + qD(tree(i))*T(1:3,3,frame(tree(i)));
    R=T(1:3,1:3,frame(tree(i)));
    S = R*COM{frame(tree(i))};
    ft(:,tree(i)) = M(frame(tree(i)))*(vD+cross_matrix(omeD)*S+cross_matrix(ome)*(cross_matrix(ome)*S));
    mt(:,tree(i))= M(frame(tree(i)))*cross_matrix(S)*vD+R*I{frame(tree(i))}*R'*omeD+cross_matrix(ome)*R*I{frame(tree(i))}*R'*ome;
end

%Tree 4 Initialisation
ome =omei;
omeD = omeDi;
vD = vDi;
tree=tree4;

%Forward algorithm
for i=1:numel(tree)
    if i~=1
    L = T(1:3,4,frame(tree(i)))-T(1:3,4,frame(tree(i-1)));
    else
    L = T(1:3,4,frame(tree(i)))-T(1:3,4,frame(6));
    end
    vD = vD + cross_matrix(omeD)*L+cross_matrix(ome)*(cross_matrix(ome)*L);
    omeD = omeD+T(1:3,3,frame(tree(i)))*qDD(tree(i))+cross_matrix(ome)*T(1:3,3,frame(tree(i)))*qD(tree(i));
    ome = ome + qD(tree(i))*T(1:3,3,frame(tree(i)));
    R=T(1:3,1:3,frame(tree(i)));
    S = R*COM{frame(tree(i))};
    ft(:,tree(i)) = M(frame(tree(i)))*(vD+cross_matrix(omeD)*S+cross_matrix(ome)*(cross_matrix(ome)*S));
    mt(:,tree(i))= M(frame(tree(i)))*cross_matrix(S)*vD+R*I{frame(tree(i))}*R'*omeD+cross_matrix(ome)*R*I{frame(tree(i))}*R'*ome;
end

%Backward algorithm 
% =========================================
f =[0;0;0];
% f = W4(1:3,1);
m = [0;0;0];
% m = W4(4:6,1);

%Tree 4
tree = tree4;
for i = numel(tree):-1:1
    if i == numel(tree)
        L=[0;0;0];
    else
        L = T(1:3,4,frame(tree(i+1)))-T(1:3,4,frame(tree(i)));
    end
    % 0M = 0Minercial + 0M_{i+1} + 0L x 0F
    m = mt(:,tree(i))+m+cross_matrix(L)*f;
    % 0F = 0Finercial + 0F_{i+1}
    f = ft(:,tree(i))+f;
    % Las 3 componentes del par estarían dadas por ^iTau = ^iR0 0M, sin embargo ya que el par solo se aplica en "z" sólo se
    % calcula el ultimo rengon, i.e. ^iTau_z = ^iR0(i,:) 0M -> [0ax 0ay 0az]*[0Mx 0My 0Mz]
    Tau(tree(i))=m'*T(1:3,3,frame(tree(i)))+Ia(tree(i))*qDD(tree(i)); % Así estaba... + Ia(i)*qDD(i); pero así no es por que no toma las inercias de los actuadores superiores
    % Ésto sería lo mismo:
    % Par = T(1:3,1:3,frame(tree(i)))'*m; % iR0*0M y luego se toma el 3er elemento
    % Tau(tree(i))= Par(3) + Ia(i)*qDD(i);  % iTau = iMz + iIa*qpp
    % NOTE que el par "tau" está expresado en su PROPIO MARCO
end
f_temp = f;
m_temp = m;

%Tree 3
f =[0;0;0];
% f = W3(1:3,1);
m = [0;0;0];
% m =W3(4:6,1);
tree = tree3;
for i = numel(tree):-1:1
    if i == numel(tree)
        L=[0;0;0];
    else
        L = T(1:3,4,frame(tree(i+1)))-T(1:3,4,frame(tree(i)));
    end
    m = mt(:,tree(i))+m+cross_matrix(L)*f;
    f = ft(:,tree(i))+f;    
    Tau(tree(i))=m'*T(1:3,3,frame(tree(i)))+Ia(tree(i))*qDD(tree(i)); % Así estaba... + Ia(i)*qDD(i); pero así no es 
    % Ésto sería lo mismo:
    % Par = T(1:3,1:3,frame(tree(i)))'*m; % iR0*0M y luego se toma el 3er elemento
    % Tau(tree(i))= Par(3) + Ia(i)*qDD(i);  % iTau = iMz + iIa*qpp
end
f_temp2 = f;
m_temp2 = m;

%Tree 2
f =[0;0;0];
m = [0;0;0];
tree = tree2;
for i = numel(tree):-1:1
    if i == numel(tree)
        L=[0;0;0];
    else
        L = T(1:3,4,frame(tree(i+1)))-T(1:3,4,frame(tree(i)));
    end
    m = mt(:,tree(i))+m+cross_matrix(L)*f;
    f = ft(:,tree(i))+f;
    Tau(tree(i))=m'*T(1:3,3,frame(tree(i)))+Ia(tree(i))*qDD(tree(i)); % Así estaba... + Ia(i)*qDD(i); pero así no es 
    % Ésto sería lo mismo:
    % Par = T(1:3,1:3,frame(tree(i)))'*m; % iR0*0M y luego se toma el 3er elemento
    % Tau(tree(i))= Par(3) + Ia(i)*qDD(i);   % iTau = iMz + iIa*qpp
end
f_temp3= f;
m_temp3 = m;

%Tree 1

f = -FR(1:3)';
m = -FR(4:6)';

tree = tree1;
for i = numel(tree):-1:1
    if i == numel(tree)
        L=[0;0;0];
    else
        L = T(1:3,4,frame(tree(i+1)))-T(1:3,4,frame(tree(i)));
    end
    m = mt(:,tree(i)) + m + cross_matrix(L)*f;
    f = ft(:,tree(i)) + f;
    if tree(i) ==6
        f = f + f_temp + f_temp2 + f_temp3;
        L1 = T(1:3,4,frame(18))-T(1:3,4,frame(6));
        L2 = T(1:3,4,frame(13))-T(1:3,4,frame(6));
        L3 = T(1:3,4,frame(24))-T(1:3,4,frame(6));
        m = m + cross_matrix(L1)*f_temp+ + cross_matrix(L2)*f_temp2 + cross_matrix(L3)*f_temp3 + m_temp + m_temp2 + m_temp3;
    end
    Tau(tree(i))=m'*T(1:3,3,frame(tree(i)))+Ia(tree(i))*qDD(tree(i)); % Así estaba: + Ia(i)*qDD(i); pero así no es 
    % Ésto sería lo mismo:
    % Par = T(1:3,1:3,frame(tree(i)))'*m; % iR0*0M y luego se toma el 3er elemento
    % Tau(tree(i))= Par(3) + Ia(i)*qDD(i);  % iTau = iMz + iIa*qpp
end
F0 = f; % En realidad esta es la fuerza en el marco 2 respecto a cero, i.e. 0f2
M0 = m + cross_matrix(T(1:3,4,frame(1)))*f; % 0M2 + 0p2 x 0F2 donde p es la distancia del marco de 0 al marco 2 (el uno es el de soporte)

% Sin embargo falta agregar la fuerza debido al peso de la masa 1 (del pie), y el par que produce la masa 1 en el marco 0 i.e
% Recordemos que la masa 1 no se ha utilizado para los cálculos anteriores
W_1 = M(1)*[0;0;g]; % Peso del pie de soporte
F0 = F0 + W_1;  % 0F0 = 0F2 + 0W_1
P0com1 = T(1:3,:,1)*[COM{1}; 1];  % Posición del CoM1 medido respecto el marco 0 i.e. 0Pcom1 = 0T1*1Pcom1 (Aquí no solo se rota 
                             % sino que se desea conocer la posicion desde el marco 0)
M0 = M0 + cross_matrix(P0com1)*W_1;  % 0M0 = 0M2 + 0Pcom1*0W_1


end
