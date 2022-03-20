function plotting(T_p,T_f,u_f,x_1,x_2)
j=[];
j(1)=1;
for i=1:T_p*T_f
 
if u_f(i)==1
     j(i+1)=j(i);
else
     j(i+1)=j(i)+1;
end
end
t=0:(T_p*(T_f));
  
figure(1)
plotHarcColor(x_1,j',x_2,t')
grid on
xlabel('$q$','interpreter','latex')
ylabel('$r$','interpreter','latex')

end