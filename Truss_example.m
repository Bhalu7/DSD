[num,txt,raw] = xlsread('structure_data.xlsx');
data = num;

n_element = data(1,1);
n_nodes = data(1,2);
E = data(1,7);
A = data(:,8);
ncon = [data(:,3),data(:,4)];
X = data(:,5);
Y = data(:,6);
NDU = data(1,10);
dzero = data(:,11);
F = data(:,9);

%Plot the structure

for i = 1:n_element
    n1 = ncon(i,1);
    n2 = ncon(i,2);
    x1 = X(n1);
    x2 = X(n2);
    y1 = Y(n1);
    y2 = Y(n2);
    plot([x1,x2],[y1 y2],'LineWidth',10);
    hold on;
    plot([x1 x2],[y1 y2],'ro');
end

% Initiate matrices

KE = zeros(4);
K = zeros(2*n_nodes);
KT = zeros(2*n_nodes);

% Pre-processing 
for i = 1:n_element
%Evaluate elemental stiffness matrices
n1 = ncon(i,1);
n2 = ncon(i,2);
x1 = X(n1);
x2 = X(n2);
y1 = Y(n1);
y2 = Y(n2);

if((x2 - x1)==0)
    if(y2>y1)
        alpha = pi/2;
    else
        alpha = -pi/2;
    end
    else 
        alpha = atan((y2-y1)/(x2-x1));
end
c = cos(alpha);
s = sin(alpha);

L = sqrt((x2-x1)^2+(y2-y1)^2);

const = (A(i)*E)/L;
KE = [c*c c*s -c*c -c*s;c*s s*s -c*s -s*s;-c*c -c*s c*c c*s;-c*s -s*s c*s s*s]

KE = const*KE;

%Assemble into overall stiffness matrix

j=n1;
k=n2;

II(1) = (2*j) - 1;
II(2) = (2*j);
II(3) = (2*k) - 1;
II(4) = (2*k);

for IX = 1:4
    MI = II(IX);
for JX = 1:4
    MJ =II(JX);
    
    K(MI,MJ) = K(MI,MJ) + KE(IX,JX);
end
end
end

%Develop modified K matrix: KTEMP for calculations
KT=K;

for k = 1:NDU
    n = dzero(k);
    KT(n,:)=0;
end 

for k = 1:NDU
    n = dzero(k);
    KT(:,n)=0;
end 

for k = 1:NDU
    n = dzero(k);
    KT(n,n)=KT(n,n)+1;
end 

%Calculate Unknown displacements and reaction forces
d = inv(KT)*F
F=K*d


% Pre-processing 
for i = 1:n_element
%Evaluate elemental stiffness matrices
n1 = ncon(i,1);
n2 = ncon(i,2);
x1 = X(n1);
x2 = X(n2);
y1 = Y(n1);
y2 = Y(n2);


u1 = d(2*n1-1);
v1 = d(2*n1);
u2 = d(2*n2);
v2 = d(2*n2-1);


if((x2 - x1)==0)
    if(y2>y1)
        alpha = pi/2;
    else
        alpha = -pi/2;
    end
    else 
        alpha = atan((y2-y1)/(x2-x1));
end
c = cos(alpha);
s = sin(alpha);

L = sqrt((x2-x1)^2+(y2-y1)^2);

FR(i) = (A(i)*E/L)*(((u2-u1)*c)+((v2-v1)*s));
Sigma(i) = FR(i)/A(i);
end
% Transpose - write row as column. Matlab function '
FR = FR.'
Sigma = Sigma

% Generate Output Files

dlmwrite('Displacment.txt',d,'')
dlmwrite('Nodal_Force.xls',F,'')
dlmwrite('Ele_Force.xls',FR,'')
dlmwrite('Stress.xls',Sigma,'')

%Graphical presentation of Structural Deformation
%Evaluate new nodal coordinates

for i=1:n_nodes
    u(i) = d(2*i-1);
    v(i) = d(2*i);
end
for i=1:n_nodes
    Xnew(i) = X(i)+1000*u(i);
    Ynew(i) = Y(i)+1000*v(i);
end

    
    
    
    
% Pre-processing 
for i = 1:n_element
%Evaluate elemental stiffness matrices
n1 = ncon(i,1);
n2 = ncon(i,2);
x1 = X(n1);
x2 = X(n2);
y1 = Y(n1);
y2 = Y(n2);
plot([x1,x2],[y1 y2],'LineWidth',10);
hold on;
plot([x1,x2],[y1 y2],'ro');
hold on;

x1 = Xnew(n1);
x2 = Xnew(n2);
y1 = Ynew(n1);
y2 = Ynew(n2);

plot([x1,x2],[y1 y2],'LineWidth',10);
hold on;
plot([x1,x2],[y1 y2],'ro');
hold on;
end