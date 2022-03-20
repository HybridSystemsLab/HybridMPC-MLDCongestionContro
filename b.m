function output=b(A_g,x,x1,x2,m2,M11,M12,M2,h1,h2,sigma1,M13,M23,xmax,xmin,m11,m12,u_max,u_min,alpha1,sigma2,alpha2)


 b_0=[zeros(6,1)
    x1
    x2
    -m2
    -x1
    -x2
    M2
    0+h1(1,1)*x1+h1(1,2)*x2
    -h1(1,1)*x1-h1(1,2)*x2
    0+h2(1,1)*x1+h2(1,2)*x2
    -h2(1,1)*x1-h2(1,2)*x2
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0];

 b00=[zeros(6,1)
    -m11
    -m12
    -m2
    +M11
    +M12
    M2
    0+sigma1-alpha1
    M13
    0+sigma2-alpha2
    M23
    0
    0
    0
    0
    u_max
    -u_min
     0
     0
     0
     1];
b0=b00+b_0;

%% for one step befor
x=A_g*x;
b_1=[zeros(6,1)
    x
    0
    -x
    0
    h1(1,1)*x(1)+h1(1,2)*x(2)
    -h1(1,1)*x(1)-h1(1,2)*x(2)
    h2(1,1)*x(1)+h2(1,2)*x(2)
    -h2(1,1)*x(1)-h2(1,2)*x(2)
    -x+xmax
    x-xmin
    u_max
    -u_min
     zeros(4,1)];

b1=b00+b_1;
%% for two step befor
x=A_g*x;
b_2=[zeros(6,1)
    x
    0
    -x
    0
    h1(1,1)*x(1)+h1(1,2)*x(2)
    -h1(1,1)*x(1)-h1(1,2)*x(2)
    h2(1,1)*x(1)+h2(1,2)*x(2)
    -h2(1,1)*x(1)-h2(1,2)*x(2)
    -x+xmax
    x-xmin
    u_max
    -u_min
     zeros(4,1)];

b2=b00+b_2;

%% for two step befor
x=A_g*x;
b_3=[zeros(6,1)
    x
    0
    -x
    0
    h1(1,1)*x(1)+h1(1,2)*x(2)
    -h1(1,1)*x(1)-h1(1,2)*x(2)
    h2(1,1)*x(1)+h2(1,2)*x(2)
    -h2(1,1)*x(1)-h2(1,2)*x(2)
    -x+xmax
    x-xmin
    u_max
    -u_min
     zeros(4,1)];

b3=b00+b_3;

output=[b0
    b1
    b2
    b3];
end