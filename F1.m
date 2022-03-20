function output=F1(AA,A_g,h1,h2,M11,M12,M2,M13,M23,m11,m12,m2,m13,m23,sigma1,alpha1,sigma2,alpha2)

A0=[1 0 0 M11 0 -M11 -M11
    0 1 0 M12 0 -M12 -M12
    0 0 1 M2 0 -M2 -M2
    -1 0 0 -m11 0 m11 m11
    0 -1 0 -m12 0 m12 m12
    0 0 -1 -m2 0 m2 m2
    1 0 0 m11 0 -m11 -m11
    0 1 0 m12 0 -m12 -m12
    0 0 1 m2 -1 -m2 -m2
    -1 0 0 -M11 0 M11 M11
    0 -1 0 -M12 0 M12 M12
    0 0 -1 -M2 1 M2 M2
    0 0 0 0 0 (m13+sigma1-alpha1) 0
    0 0 0 0 0 (M13-sigma1-alpha1) 0
    0 0 0 0 0 0 (m23+sigma2-alpha2)
    0 0 0 0 0 0 (M23-sigma2-alpha2)
    0 0 0 0 0 0 0
    0 0 0 0 0 0 0
    0 0 0 0 0 0 0
    0 0 0 0 0 0 0
    0 0 0 0 1 0 0
    0 0 0 0 -1 0 0
    0 0 0 1 0 -1 0
    0 0 0 -1 0 0 0
    0 0 0 1 0 0 -1
    0 0 0 -1 0 1 1];
%% for one step befor
H1=[h1(1,1)*AA(1,:)+h1(1,2)*AA(2,:)
    h2(1,1)*AA(1,:)+h2(1,2)*AA(2,:)];



A_10=[zeros(6,7)
    -AA
    zeros(1,7)
    AA
    zeros(1,7)
    -H1
    H1
    AA
    -AA
    zeros(6,7)];

%% for two step befor
AA2=A_g*AA;

H1=[h1(1,1)*AA2(1,:)+h1(1,2)*AA2(2,:)
    h2(1,1)*AA2(1,:)+h2(1,2)*AA2(2,:)];



A_20=[zeros(6,7)
    -AA2
    zeros(1,7)
    AA2
    zeros(1,7)
    -H1
    H1
    AA2
    -AA2
    zeros(6,7)];

%% for three step befor
AA3=A_g^2*AA;

H1=[h1(1,1)*AA3(1,:)+h1(1,2)*AA3(2,:)
    h2(1,1)*AA3(1,:)+h2(1,2)*AA3(2,:)];



A_30=[zeros(6,7)
    -AA3
    zeros(1,7)
    AA3
    zeros(1,7)
    -H1
    H1
    AA3
    -AA3
    zeros(6,7)];


%% 


ZZ=zeros(26,7);

 output=[A0 ZZ ZZ ZZ
     A_10 A0 ZZ ZZ
     A_20 A_10 A0 ZZ
     A_30 A_20 A_10 A0];

end

