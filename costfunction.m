function [output1,output2]=costfunction(AA,Q_c,A_g,Q_d,R_d,R_c,P,x)
%%  cost function for step 0
s00=[zeros(2,5)
    zeros(1,4),1/2*(R_c-R_d)
    zeros(1,5)
    zeros(1,2),1/2*(R_c-R_d),0,R_d];
s0=s00+AA'*Q_d*AA;
%%  cost function for step 1

Q_cda=(Q_c-Q_d)*AA;
s01=[Q_cda
    zeros(3,5)];
s1=s0+AA'*A_g'*A_g'*P*A_g*A_g*AA;
%%  cost function for step 2

Q_cda=(Q_c-Q_d)*A_g*AA;
s02=[Q_cda
    zeros(3,5)];
s2=s0+AA'*A_g'*P*A_g*AA;
%%  cost function for step 3

Q_cda=(Q_c-Q_d)*A_g*A_g*AA;
s03=[Q_cda
    zeros(3,5)];
s3=s0+AA'*P*AA;

%%  cost function for step 3 and 2 for P

s23=AA'*A_g'*P*AA;
%%  cost function for step 3 and 1 for P

s13=AA'*A_g'*A_g'*P*AA;

%%  cost function for step 3 and 0 for P

s30=AA'*A_g'*A_g'*A_g'*P*AA;
%%  cost function for step 2 and 1 for P

s12=AA'*A_g'*A_g'*A_g'*P*A_g*AA;

%%  cost function for step 2 and 0 for P

s20=AA'*A_g'*A_g'*A_g'*A_g'*P*A_g*AA;
%%  cost function for step 1 and 0 for P

s10=AA'*A_g'*A_g'*A_g'*A_g'*A_g'*P*A_g*A_g*AA;
%% finding S1 in S1'*Z*S1+S2*Z
S1=[s0,.5*s01+s10,.5*s02+s20,.5*s03+s30
    .5*s01+s10,s1,.5*s10+s12,.5*s02+s13
    .5*s02+s20,.5*s01+s12,s2,.5*s01+s23
    .5*s03+s30,.5*s02+s13,.5*s01+s23,s3];
%% finding S2 in S1'*Z*S1+S2*Z
 %% 
b0=[x'*(Q_c-Q_d)',0,0,0]+2*x'*(A_g')^7*P*A_g^3*AA;
b1=[x'*A_g'*(Q_c-Q_d)',0,0,0]+2*x'*(A_g')^6*P*A_g^2*AA;
b2=[x'*A_g'^2*(Q_c-Q_d)',0,0,0]+2*x'*(A_g')^5*P*A_g*AA;
b3=[x'*A_g'^3*(Q_c-Q_d)',0,0,0]+2*x'*(A_g')^4*P*AA;
S2=[b0,b1,b2,b3]';
output1=S1;
output2=S2;

end