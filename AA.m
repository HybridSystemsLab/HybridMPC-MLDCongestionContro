function output=AA(A_f,A_g,B_f,B_g,C_f,C_g)
A_fg=A_f-A_g;
B_fg=B_f-B_g;
C_fg=C_f-C_g;
output=[A_fg B_fg -C_fg B_g C_fg C_fg];
end