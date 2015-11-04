function F = myfun(Z, V)
 
V1 = V(:,1)';    V2 = V(:,2)';    V3 = V(:,3)'; 

r21 = norm(V2)/norm(V1);
r31 = norm(V3)/norm(V1);
r32 = norm(V3)/norm(V2);

W = 0.5;

P1 = [V1 Z(1)]';        P2 = [V2 Z(2)]';        P3 = [V3 Z(3)]';
L1 = norm(P1);          L2 = norm(P2);          L3 = norm(P3);

F = (P1'*P2/L1/L2)^2 + (P3'*P2/L3/L2)^2 + (P1'*P3/L1/L3)^2 + W*(...
    (r21-L2/L1)^2    + (r32-L3/L2)^2    + (r31-L3/L1)^2);