% This function calculate the Origin Point (OP) and the thrre main axis in 
% 2D palne V in order to construct the 3D shape

% Input: Edge and Connection matrix
% Output: Origin Point and 3 Main axis in 2D space V=[V1 V2 V3] 

% Last update:
% 08-04-14 ET


function [global_theta,theta] = FindThetaFirst(Edg, Con)


theta=zeros(size(Con,1),3);

for i=1:size(Con,1)                           % calculate local_angle
    for j=1:3
        %slope=(Edg(i,2)-Edg(Con(i,j),2))/(Edg(i,1)-Edg(Con(i,j),1));
        slope= ( Edg(Con(i,j),2)- Edg(i,2) ) / (  Edg(Con(i,j),1) - Edg(i,1)  );
        theta(i,j)=atand(slope);
         if theta(i,j)>180
             theta(i,j)=theta(i,j)-180;
         end
         if theta(i,j)<0
             if theta(i,j)<-180
                 theta(i,j)=theta(i,j)+360;
             else
                 theta(i,j)=theta(i,j)+180;
             end
         end
              
         if theta(i,j)<180&&theta(i,j)>170
             theta(i,j)=180-theta(i,j);
         end     
         
    end
end
global_theta=reshape(theta',1,3*size(theta,1)); %% global_angle



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %%%360
% theta=zeros(size(Con,1),3);
% 
% for i=1:size(Con,1)                           % calculate local_angle
%     for j=1:3
%         %slope=(Edg(i,2)-Edg(Con(i,j),2))/(Edg(i,1)-Edg(Con(i,j),1));
%         slope= ( Edg(Con(i,j),2)- Edg(i,2) ) / (  Edg(Con(i,j),1) - Edg(i,1)  );
%         theta(i,j)=atand(slope);
%         
%         if slope==0
%             if (  Edg(Con(i,j),1) - Edg(i,1)  ) >0
%                 theta(i,j)=0;
%             else
%                 theta(i,j)=180;
%             end
%         end
%                 
%             
%         
%         
%         if slope>0
%             if ( Edg(Con(i,j),2) - Edg(i,2) )>0 
%                 theta(i,j)=theta(i,j);
%             else
%                 theta(i,j)=theta(i,j)+180;
%             end
%         end
%         
%         if slope<0
%             if ( Edg(Con(i,j),2) - Edg(i,2) ) < 0
%                 theta(i,j)=theta(i,j)+360;
%             else
%                 theta(i,j)=theta(i,j)+180;
%             end
%         end
%         
%         
%        if theta(i,j)>355 && theta(i,j)<360 || theta(i,j)>0 && theta(i,j)<5
%            theta(i,j)=0;
%        end
%        if theta(i,j)>180 && theta(i,j)<183 || theta(i,j)>175 && theta(i,j)<180
%            theta(i,j)= 180;
%        end
%                 
%            
%     end
% end
%   
%         
%         
% global_theta=reshape(theta',1,3*size(theta,1)); %% global_angle



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








% global_theta=reshape(theta',1,3*size(theta,1)); %% global_angle
% global_angle=[];
% for i=1:size(global_theta,2)              %calculte the global_angle
%     global_theta=sort(global_theta); %% add new
%     global_angle = [global_angle; mvnrnd([global_theta(i)],10,10000)];  % (mean/S/cases)    (平均值/標準差/抽取樣本數)  
% end
% figure(2)
% hist(global_angle,500)



% local_angle=[];
% for i=1:size(theta,1)
%     for j=1:3
%      lc_ang=theta(i,:);
%      lc_ang=sort(lc_ang); % add new
%      local_angle= [ local_angle;mvnrnd(lc_ang(j),10,size(global_theta,2)*10000/3)];
%      %local_angle= [ local_angle;mvnrnd(lc_ang(j),30,sketch_number*500)];
%     end
%     % figure(5)
%    %  subplot(1,size(theta,1),i)
%     % hist(local_angle,100)
%      
%     %local_assem_angle(i,1:sketch_number*500*3)=local_angle';
%     %local_assem_angle(i,1:length(global_theta)*1500)=local_angle';
%     local_assem_angle(i,1:length(local_angle))=local_angle;
%     local_angle=[];
% end



% cr=zeros();
% correlation=zeros();
% for i=1:size(local_assem_angle,1)
%     cr=corrcoef(local_assem_angle(i,:),global_angle);
%     correlation(i)=cr(1,2);  
% end
% [useless,OP]=max(correlation);            %decided the original point (OP)
% 
% 
% k=1;
% point_connection=zeros();
% for i=1:size(Con,1)
%   for j=1:3
%       point_connection(k,1:2)=[i,Con(i,j)];
%       k=k+1;
%   end
% end
% 
% V1 = [Edg(Con(OP,1),1)-Edg(OP,1), Edg(Con(OP,1),2)-Edg(OP,2)];   %set up the three axis ( which is connect to the origin point)
% V2 = [Edg(Con(OP,2),1)-Edg(OP,1), Edg(Con(OP,2),2)-Edg(OP,2)];   %set up the three axis ( which is connect to the origin point)
% V3 = [Edg(Con(OP,3),1)-Edg(OP,1), Edg(Con(OP,3),2)-Edg(OP,2)];   %set up the three axis ( which is connect to the origin point)
% 
% V = [V1;V2;V3]' ; % Main axis
% assignin('base','theta',theta)