function Z_three_axis = AxisDepth(Edg,Con, OP, V)
disp('Entering AxisDepth<<')

V1 = V(:,1)';    V2 = V(:,2)';    V3 = V(:,3)';   

%%%%%%%%%%%%% function %%%%%%%%%%
z0 = [0.1,0.1,0.1];
hfun = @(Z)myfun(Z,V);
%[Z,fval]=fminunc(@myfun,z0);
opts = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt');
options = optimoptions('lsqnonlin','Jacobian','on');
[Z,fval] = lsqnonlin(hfun,z0);
%[Z,fval]=fminsearch(@myfun,z0);
Z_three_axis = Z;
%%%%%%%%%%%%%% function %%%%%%%%%


% %%%%%%% optimization%%%%%
% z0= [0.1,0.1,0.1];
% [Z]=optimization(OP,z0);
% Z_three_axis=[Z(1),Z(2),Z(3)];  % the Z value for three main axis
% %%%%%% optimization%%%%%

disp('Testing the axis to be perpendicualr')

% ////////Test////////Test////////////Test//////////////
%dot([V1(1) V1(2) Z(1)],[V2(1) V2(2) Z(2)]');
theta_12=V1(1)*V2(1)+V1(2)*V2(2)+Z(1)*Z(2)
theta_23=V2(1)*V3(1)+V2(2)*V3(2)+Z(2)*Z(3)
theta_13=V3(1)*V1(1)+V3(2)*V1(2)+Z(3)*Z(1)
difference_ratio_12=(sqrt(V1(1)^2+V1(2)^2+Z(1)^2)/sqrt(V2(1)^2+V2(2)^2+Z(2)^2)) - (sqrt(V1(1)^2+V1(2)^2)/sqrt(V2(1)^2+V2(2)^2)) 
difference_ratio_23=(sqrt(V2(1)^2+V2(2)^2+Z(2)^2)/sqrt(V3(1)^2+V3(2)^2+Z(3)^2)) - (sqrt(V2(1)^2+V2(2)^2)/sqrt(V3(1)^2+V3(2)^2)) 
difference_ratio_13=(sqrt(V1(1)^2+V1(2)^2+Z(1)^2)/sqrt(V3(1)^2+V3(2)^2+Z(3)^2)) - (sqrt(V1(1)^2+V1(2)^2)/sqrt(V3(1)^2+V3(2)^2)) 
% ////////Test/////////Test//////////////Test////////////

disp('Exiting Axis Depth>>')

