function [global_theta] = FindThetaSecond(Edg,Old_ST_Con)

for i=1:size(Old_ST_Con,1)
       %slope=(Edg(i,2)-Edg(Con(i,j),2))/(Edg(i,1)-Edg(Con(i,j),1));
       % slope= (Edg(Old_ST_Con(i,j),2)- Edg(i,2))/( Edg(Old_ST_Con(i,j),1) - Edg(i,1));
       slope = (Edg(Old_ST_Con(i,1),2)-Edg(Old_ST_Con(i,2),2)) / (Edg(Old_ST_Con(i,1),1)-Edg(Old_ST_Con(i,2),1)) ;
       global_theta(i)=atand(slope);
         if global_theta(i)>180
             global_theta(i)=global_theta(i)-180;
         end
         if global_theta(i)<0
             if global_theta(i)<-180
                 global_theta(i)=global_theta(i)+360;
             else
                 global_theta(i)=global_theta(i)+180;
             end
         end
              
         if global_theta(i)<180&&global_theta(i)>170
             global_theta(i)=180-global_theta(i);
         end        
end


%global_theta=reshape(global_theta',1,3*size(global_theta,1)); %% global_angle

