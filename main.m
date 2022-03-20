clear
close all
clc
%% flow map parameters
B=1;
T_s=.001;
lambda=.25;
q_max=1;
a=1;
 A_f=[1 0
     0 1]+T_s*[0 1
     0 0];
B_f=[0
    0];
C_f=T_s*[-B
    a];
%% jump map parameters
A_g=[0 0
    0 lambda];
B_g=[0
    0];
C_g=[q_max
    0];
%% jump and flow set  parameters
h1=[1, 0];
sigma1=0;
alpha1=q_max;
%%
h2=[0, 1];
sigma2=0;
alpha2=B;
%% feasiblity set
x_1max=10;
x_1min=-10;
x_2max=10;
x_2min=-89990;
u_max=100;
u_min=-100;
xmax=[x_1max
    x_2max];
xmin=[x_1min
    x_2min];
%% finding max and min of flow map
%M11=A_f(1,:)*[10;-10]+B_f(1);
M11=x_1max;
M12=x_2max;
m11=x_1min;
m12=x_2min;
m1=[m11
    m12];
M1=[M11
    M12];
%% finding max and min of jump map
M2=u_max;
m2=u_min;
%% max and min on h1(x)
cc8=[h1(1);h1(2)]>=0;
M13=h1(1)*(cc8(1)*x_1max+(1-cc8(1))*x_1min)+h1(2)*(cc8(2)*x_2max+(1-cc8(2))*x_2min);
cc9=[h1(1);h1(2)]<=0;
m13=h1(1)*(cc9(1)*x_1max+(1-cc9(1))*x_1min)+h1(2)*(cc9(2)*x_2max+(1-cc9(2))*x_2min);
%% max and min on h2(x)
cc8=[h2(1);h2(2)]>=0;
M23=h2(1)*(cc8(1)*x_1max+(1-cc8(1))*x_1min)+h2(2)*(cc8(2)*x_2max+(1-cc8(2))*x_2min);
cc9=[h2(1);h2(2)]<=0;
m23=h2(1)*(cc9(1)*x_1max+(1-cc9(1))*x_1min)+h2(2)*(cc9(2)*x_2max+(1-cc9(2))*x_2min);
%% calculating AA for x(\ell)=AA*[z(\ell-1),u_f(\ell-1),u(\ell-1)]
AA=AA(A_f,A_g,B_f,B_g,C_f,C_g);
%% calculating A for AX<b
A=F1(AA,A_g,h1,h2,M11,M12,M2,M13,M23,m11,m12,m2,m13,m23,sigma1,alpha1,sigma2,alpha2);
%% cost function parameters
Q_c=2e-1*eye(2);
Q_d=2e-1*eye(2);
P=1e-1*eye(2);
R_c=1e-2;
R_d=1e-2;
S1=zeros(28,28);
S2=zeros(28,1);

%% initial value
x0=zeros(28,1);
x1=.5;
x2=0;
T_f=100; % simulation time
T_p=1; % control horizon
x_1=x1;
x_2=x2;
u_f=[];
u_=[];
u_f_1=[];
u_f_2=[];
%%
 for i=1:T_f
%% b for next steps that x(i) is written as sumation of z_1 and z_2 so we dont need them in b
x=[x1
    x2];
%%
     bb=b(A_g,x,x1,x2,m2,M11,M12,M2,h1,h2,sigma1,M13,M23,xmax,xmin,m11,m12,u_max,u_min,alpha1,sigma2,alpha2);
%% binary variabels

ivar=[4,6,7,9,11,12,14,16,17,19,21,22];
options = [];
miqp(S1,S2,A,bb,[],[],ivar,[],[],x0,options);
x_11=AA*ans(1:7)+A_g*x+C_g;

x_12=[x_11]';     
x1=x_11(1);
x2=x_11(2);    
x_1=[x_1; x_12(:,1)];
x_2=[x_2; x_12(:,2)];
u_fi=[-ans(4)+ans(6)+ans(7)];
u_f=[u_f,u_fi] ;
u_f_1=[ u_f_1 ans(6)];
u_f_2=[ u_f_2 ans(7)];
u_i=[ans(5)];
u_=[u_,u_i] ;
x0=ans;
 end
 % ploting
plotting(T_p,T_f,u_f,x_1,x_2)