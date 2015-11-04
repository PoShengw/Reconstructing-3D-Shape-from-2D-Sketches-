function [gaussian_global, local_assem_angle] = Gaussian(theta,global_theta)

%global_theta=reshape(theta',1,3*size(theta,1)); %% global_angle
gaussian_global=[];
global_theta_size=size(global_theta,2);
for i=1:global_theta_size              %calculte the global_angle
    global_theta=sort(global_theta); %% add new
    gaussian_global = [gaussian_global; mvnrnd([global_theta(i)],10,  size(theta,2)*3000      )];  % (mean/S/cases)    (平均值/標準差/抽取樣本數)  
end
gaussian_global=gaussian_global';
% figure(2)
% hist(gaussian_global,500)



% Calculate Local !!

gaussian_local=[];
for i=1:size(theta,1)
    for j=1:3
     lc_ang=theta(i,:);
     lc_ang=sort(lc_ang); % add new
     gaussian_local= [ gaussian_local;mvnrnd(lc_ang(j),10,   size(gaussian_global,2)/3   )];
     %local_angle= [ local_angle;mvnrnd(lc_ang(j),30,sketch_number*500)];
    end
    % figure(5)
   %  subplot(1,size(theta,1),i)
    % hist(local_angle,100)
     
    %local_assem_angle(i,1:sketch_number*500*3)=local_angle';
    %local_assem_angle(i,1:length(global_theta)*1500)=local_angle';
    local_assem_angle(i,1:length(gaussian_local))=gaussian_local;
    gaussian_local=[];
end
