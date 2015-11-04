 function f=EEmyfun(ZE,Vnn,which_axis,VT,Z_three_axis)
 
 %global Z_three_axis; 
 %global which_axis;
 %global VT;
 %global Vnn;

%f=(1-(VT(1)*Vnn(1)+VT(2)*Vnn(2)+ZE*Z_three_axis(which_axis))/sqrt(VT(1)^2+VT(2)^2+Z_three_axis(which_axis)^2)*sqrt(Vnn(1)^2+Vnn(2)^2+ZE^2))^2;

 %VT(1)*Vnn(1)+VT(2)*Vnn(2)+ZE*Z_three_axis()

%f=(1-((VT(1)*Vnn(1)+VT(2)*Vnn(2)+ZE*Z_three_axis(which_axis))/(norm([VT(1) VT(2) Z_three_axis(which_axis)])*(norm([Vnn(1) Vnn(2) ZE])))))^2;
%f = (1-((dot([VT(1) VT(2) Z_three_axis(which_axis)],[Vnn(1) Vnn(2) ZE]')) / (norm([VT(1) VT(2) Z_three_axis(which_axis)])*(norm([Vnn(1) Vnn(2) ZE])))))^2;




W=0.5;

%f=(1-W*((VT(1)*Vnn(1)+VT(2)*Vnn(2)+Z_three_axis(which_axis)*ZE)/   (sqrt(VT(1)^2+VT(2)^2+Z_three_axis(which_axis)^2)*sqrt(Vnn(1)^2+Vnn(2)^2+ZE^2))  ))^2;  % RIGHT NOW

f= (1-W*(dot([VT(1) VT(2) Z_three_axis(which_axis)],[Vnn(1) Vnn(2) ZE])  /    (norm([VT(1) VT(2) Z_three_axis(which_axis)])*norm([Vnn(1) Vnn(2) ZE])) ))^2;