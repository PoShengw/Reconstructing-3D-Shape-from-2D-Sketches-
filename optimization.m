function [Z]=optimization(origin_point,z0)
iteration=1;
global r32;
global r31;
global r21;
%global Zn;
%global Zn_plus;
global Edg
global Con
distance=zeros();
Zn=[z0(1), z0(2), z0(3)]';
Zn_plus=zeros();
r=[0 0 0; r21 0 0 ; r31 r32 0];
W=0.5;
J=zeros();

while(iteration==1)
       
P1=[Edg(Con(origin_point,1),1)-Edg(origin_point,1),Edg(Con(origin_point,1),2)-Edg(origin_point,2),Zn(1)];   %set up the three axis ( which is connect to the origin point)
P2=[Edg(Con(origin_point,2),1)-Edg(origin_point,1),Edg(Con(origin_point,2),2)-Edg(origin_point,2),Zn(2)];   %set up the three axis ( which is connect to the origin point)
P3=[Edg(Con(origin_point,3),1)-Edg(origin_point,1),Edg(Con(origin_point,3),2)-Edg(origin_point,2),Zn(3)];   %set up the three axis ( which is connect to the origin point)
P=[P1 ;P2 ;P3];   

f2= (dot(P2,P3)/(norm(P2)*norm(P3)))^2+W*(r32-norm(P3)/norm(P2))^2;
f3= (dot(P1,P3)/(norm(P1)*norm(P3)))^2+W*(r31-norm(P3)/norm(P1))^2;
f1= (dot(P1,P2)/(norm(P1)*norm(P2)))^2+W*(r21-norm(P2)/norm(P1))^2;    
F=[f1,f2,f3]';

for i=1:3
    for j=1:3
       if i==1;
            if j==i
                J(i,j)=  -2* (dot(P(i,:),P(j+1,:))/(norm(P(i,:))*norm(P(j+1,:))))*(Zn(j+1,:)/(norm(P(i,:))*norm(P(j+1,:)))+dot(P(i,:),P(j+1,:))/norm(P(j+1,:)))*(Zn(i)/(norm(P(i,:)))^3)+2*W*(r(j+1,i)-norm(P(j+1,:))/norm(P(i,:)))*(Zn(i)*norm(P(j+1,:))/(norm(P(i,:)))^3);    
            elseif j==i+1
                J(i,j)= -2*(dot(P(i,:),P(j,:))/ (norm(P(i,:))*norm(P(j,:))))*(Zn(i)/(norm(P(i,:))*norm(P(j,:)))+  (dot(P(i,:),P(j,:))) / norm(P(i,:)))* (Zn(j)/(norm(P(j,:)))^3) + 2*W*(r(j,i)-norm(P(j,:))/norm(P(i,:)))*(Zn(j)/(norm(P(j,:))*norm(P(j+1,:))));                  
            elseif j==i+2
                  J(i,j)=0;
            end    
       elseif i==2
           if j==i 
                J(i,j)=  -2* (dot(P(i,:),P(j+1,:))/(norm(P(i,:))*norm(P(j+1,:))))*(Zn(j+1)/(norm(P(i,:))*norm(P(j+1,:)))+dot(P(i,:),P(j+1,:))/norm(P(j+1,:)))*(Zn(i)/(norm(Zn(i)))^3)+2*W*(r(j+1,i)-norm(P(j+1,:))/norm(P(i,:)))*(Zn(i)*norm(P(j+1,:))/(norm(P(i,:)))^3);    
          elseif j==i+1
                J(i,j)= -2*(dot(P(i,:),P(j,:))/ (norm(P(i,:))*norm(P(j,:))))*(Zn(i)/(norm(P(i,:))*norm(P(j,:)))+  (dot(P(i,:),P(j,:))) / norm(P(i,:)))* (Zn(j)/(norm(P(j,:)))^3) + 2*W*(r(j,i)-norm(P(j,:))/norm(P(i,:)))*(Zn(j)/(norm(P(j,:))*norm(P(j-2,:))));                   
          elseif j==i-1
                 J(i,j)=0;
           end
           
       elseif i==3
           if j==i
                  J(i,3)=-2* (dot(P(i,:),P(j-2,:))/(norm(P(i,:))*norm(P(j-2,:))))*(Zn(j)/(norm(P(i,:))*norm(P(j-2,:)))+dot(P(i,:),P(j-2,:))/norm(P(j-2,:)))*(Zn(i)/(norm(Zn(i)))^3)+2*W*(r(i,j-2)-norm(P(i,:))/norm(P(j-2,:)))*(Zn(i)*norm(P(j-2,:))/(norm(P(i,:)))^3);    
           elseif j==i-2
                   J(i,j)= -2*(dot(P(i,:),P(j,:))/ (norm(P(i,:))*norm(P(j,:))))*(Zn(i)/(norm(P(i,:))*norm(P(j,:)))+  (dot(P(i,:),P(j,:))) / norm(P(i,:)))* (Zn(j)/(norm(P(j,:)))^3) + 2*W*(r(i,j)-norm(P(i,:))/norm(P(j,:)))*(  Zn(j)/(norm(P(j,:))*norm(P(j+1,:))));                  
           elseif j==i-1
                  J(i,j)=0;
           end
       end
    end  %j
end %i
           
    
Zn_plus=Zn-(inv(J))*F;
distance=abs(Zn_plus-Zn);
        if distance(1)<0.01 && distance(2)<0.01 && distance(3)<0.01
            Z=Zn_plus;
            iteration=0;
            break;
        else
            Zn=Zn_plus;
            
            iteration=1;
        end
            
       
            
end            
            
            
            
            
            
            
            