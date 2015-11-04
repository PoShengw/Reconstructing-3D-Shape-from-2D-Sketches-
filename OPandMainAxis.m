function [OP,V] = OPandMainAxis(gaussian_global,local_assem_angle,Con,Edg, theta) 

cr=zeros();
correlation=zeros();
for i=1:size(local_assem_angle,1)
    cr=corrcoef(local_assem_angle(i,:),gaussian_global);
    correlation(i)=cr(1,2);  
end
[useless,OP]=max(correlation);            %decided the original point (OP)


k=1;
point_connection=zeros();
for i=1:size(Con,1)
  for j=1:3
      point_connection(k,1:2)=[i,Con(i,j)];
      k=k+1;
  end
end

V1 = [Edg(Con(OP,1),1)-Edg(OP,1), Edg(Con(OP,1),2)-Edg(OP,2)];   %set up the three axis ( which is connect to the origin point)
V2 = [Edg(Con(OP,2),1)-Edg(OP,1), Edg(Con(OP,2),2)-Edg(OP,2)];   %set up the three axis ( which is connect to the origin point)
V3 = [Edg(Con(OP,3),1)-Edg(OP,1), Edg(Con(OP,3),2)-Edg(OP,2)];   %set up the three axis ( which is connect to the origin point)

V = [V1;V2;V3]' ; % Main axis
assignin('base','theta',theta)
assignin('base','correlation',correlation)