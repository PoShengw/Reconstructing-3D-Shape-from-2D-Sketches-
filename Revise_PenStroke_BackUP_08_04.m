clc;    close all;      clear
global sketchID;
% data_struct=load(['data_',num2str(sketchID),'.mat']);
% data=data_struct.points;
data_struct=load('data_12.mat');
data=data_struct.points;

sketch_number=length(unique(data(:,4)));
SegPoint=zeros(2*sketch_number,2);

for i=1:sketch_number                       %Calculate segment point
      ID=find(data(:,4)==i);                % (Each line has two pont--head and back) 
      SegPoint(2*i-1,1:2)=data(ID(1),1:2);
    SegPoint(2*i,1:2)=data(ID(end),1:2);
end

length_each_seg=zeros();                    %calculate length of each line
for i=1:size(SegPoint,1)
    if mod(i,2)~=0
   %  length_each_seg(i) = sqrt((SegPoint(i,1)-SegPoint(i+1,1))^2+(SegPoint(i,2)-SegPoint(i+1,2))^2);
   length_each_seg(i) = norm( [SegPoint(i,1), SegPoint(i,2)] - [SegPoint(i+1,1), SegPoint(i+1,2)]   );
    end
end
total_length=sum(length_each_seg);          %total length of draw    
average_length=(total_length)/sketch_number;  % the average length


%%%%%%%%%%%%%%%%%%%% Draw the original picture%%%%%%%%%%%%%%%%%%%%%
% for i=1:sketch_number                     
%           [ind,not]=find(data(:,4)==i);
%           for j=ind(1):ind(end)-1
%               figure(4)
%               plot( [data(j,1) data(j+1,1)] , [data(j,2) data(j+1,2)] )
%               hold on
%           end
% end
%%%%%%%%%%%%%%%%%% Draw the original picture%%%%%%%%%%%%%%%%%%%%%



EPD_1= pdist2(SegPoint(:,1:2),SegPoint(:,1:2));   %calculate the distance between all segment point
EPD=EPD_1/average_length;                         % normalize

TL=0.3;
combine=zeros();
for i=1:size(EPD,1)
    a=find(EPD(i,:)<TL);
    combine(i,1:3)=a(1:3);        %find out the connection of the points               
end

 %for i=1:size(combine,2)
[vertex,b,c]=unique(combine,'rows');    % Eight vertix was made up from what points
  
  
pntType = mod(vertex,2);        %1 for starting point, 0 for ending point
pntType(pntType==0) = -1;       %1 for starting point, -1 for ending point
conPnt = vertex + pntType;      %shows the index of the connected point
global Con;
Con = zeros(size(vertex,1),3);               % connection matrix, the connected verteces
Adj = zeros(size(vertex,1));                 % Adjency matrix, 1 for conection
global Edg; 
Edg = zeros(size(vertex,1),2);

for i=1:size(Edg,1)
        Edg(i,:) = mean(SegPoint(vertex(i,:),1:2));
    for j=1:3
        [rid cid] = find(vertex==conPnt(i,j));
        Con(i,j) = rid;                    % the connection of eight vertex
        Adj(i,rid) = 1;
    end
end


% plotting the data after beautification
for i=1:size(Edg,1)
    for j=1:3
        figure(1)
        plot([Edg(i,1) Edg(Con(i,j),1)],[Edg(i,2) Edg(Con(i,j),2)])
        hold on
    end
end


theta=zeros();
for i=1:size(Con,1)                           % calculate local_angle
    for j=1:3
        %slope=(Edg(i,2)-Edg(Con(i,j),2))/(Edg(i,1)-Edg(Con(i,j),1));
        slope= (Edg(Con(i,j),2)- Edg(i,2))/( Edg(Con(i,j),1) - Edg(i,1));
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
              
         if theta(i,j)<180&&theta(i,j)>160
             theta(i,j)=180-theta(i,j);
         end     
         
    end
end




% for i=1:size(theta,1)             %% draw local_angle
%    subplot(1,size(theta,1),i)
%    figure(i)
%    hist(theta(i,:),0:180);
% end

   
%global_theta=unique(reshape(theta',1,3*size(theta,1))); %% global_angle
global_theta=reshape(theta,1,3*size(theta,1)); %% global_angle

    
global_angle=[];
for i=1:size(global_theta,2)              %calculte the global_angle
    global_angle = [global_angle; mvnrnd([global_theta(i)],30,5000)];  % (mean/S/cases)    (平均值/標準差/抽取樣本數)  
end

figure(2)
hist(global_angle,500)

local_angle=[];
for i=1:size(theta,1)
    for j=1:3
     lc_ang=theta(i,:);
     local_angle= [ local_angle;mvnrnd(lc_ang(j),30,size(global_theta,2)*5000/3)];
     %local_angle= [ local_angle;mvnrnd(lc_ang(j),30,sketch_number*500)];
    end
     figure(5)
     subplot(1,size(theta,1),i)
     hist(local_angle,100)
     
    %local_assem_angle(i,1:sketch_number*500*3)=local_angle';
    %local_assem_angle(i,1:length(global_theta)*1500)=local_angle';
    local_assem_angle(i,1:length(local_angle))=local_angle';
  
    local_angle=[];
end



cr=zeros();
correlation=zeros();
for i=1:size(local_assem_angle,1)
    cr=corrcoef(local_assem_angle(i,:),global_angle');
    correlation(i)=cr(1,2);  
end
[useless,origin_point]=max(correlation);            %decided the original point



k=1;
point_connection=zeros();
for i=1:size(Con,1)
  for j=1:3
      point_connection(k,1:2)=[i,Con(i,j)];
      k=k+1;
  end
end


global V1;
global V2;
global V3;  %set up the three axis ( which is connect to the origin point)

V1=[Edg(Con(origin_point,1),1)-Edg(origin_point,1), Edg(Con(origin_point,1),2)-Edg(origin_point,2)];   %set up the three axis ( which is connect to the origin point)
V2=[Edg(Con(origin_point,2),1)-Edg(origin_point,1), Edg(Con(origin_point,2),2)-Edg(origin_point,2)];   %set up the three axis ( which is connect to the origin point)
V3=[Edg(Con(origin_point,3),1)-Edg(origin_point,1), Edg(Con(origin_point,3),2)-Edg(origin_point,2)];   %set up the three axis ( which is connect to the origin point)


%V1=[Edg(origin_point,1)-Edg(Con(origin_point,1),1), Edg(origin_point,2)-Edg(Con(origin_point,1),2)];
%V2=[Edg(origin_point,1)-Edg(Con(origin_point,2),1), Edg(origin_point,2)-Edg(Con(origin_point,2),2)];   %set up the three axis ( which is connect to the origin point)
%V3=[Edg(origin_point,1)-Edg(Con(origin_point,3),1), Edg(origin_point,2)-Edg(Con(origin_point,3),2)];   %set up the three axis ( which is connect to the origin point)


weight=zeros();
for i=1:size(point_connection,1)                  %calculate the weight of each line
      Vn = [Edg(point_connection(i,1),1)-Edg(point_connection(i,2),1),Edg(point_connection(i,1),2)-Edg(point_connection(i,2),2)]; 
%     temp1= (abs(Vn(1)*V1(1)+Vn(2)*V1(2)))/ ((sqrt(Vn(1)^2+Vn(2)^2))*(sqrt(V1(1)^2+V1(2)^2)));  
%     temp2= (abs(Vn(1)*V2(1)+Vn(2)*V2(2)))/ ((sqrt(Vn(1)^2+Vn(2)^2))*(sqrt(V2(1)^2+V2(2)^2)));  
%     temp3= (abs(Vn(1)*V3(1)+Vn(2)*V3(2)))/ ((sqrt(Vn(1)^2+Vn(2)^2))*(sqrt(V3(1)^2+V3(2)^2)));  
%     temp=[temp1,temp2,temp3];
%     weight(i)=max(temp);
    NN = [norm(V1) norm(V2) norm(V3)]*norm(Vn);
    weight(i) = max(abs(Vn*([V1;V2 ;V3]')./NN));
    %k=k+1;
end

weight_negative=weight*(-1);

% u=1;
% total_line=zeros();
% for i=1:size(point_connection,1)
%     if  point_connection(i,1)<point_connection(i,2)
%         total_line(u,1:2)=point_connection(i,1:2);
%         u=u+1;
%     end
% end


First=point_connection(:,1)';
Second=point_connection(:,2)';
DDG=sparse(First,Second,weight_negative);
%view(biograph(DDG,[],'ShowArrows','off','ShowWeights','on'))
[ST,pred]=graphminspantree(DDG,'Method','Kruskal');
%[ST,pred]=graphminspantree(DDG,'Method','Prim');
%[ST,pred]=graphminspantree(DDG);

%[ST,Cost ] =  UndirectedMaximumSpanningTree ( DDG );
AAAAA=full(ST);

[fa,fb]=find(ST<0);

Z_three_axis2 = AxisDepth(Edg, Con, origin_point, [V1' V2' V3'])

%view(biograph(ST,[],'ShowArrows','off','ShowWeights','on'))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global cal_dep_point;

cal_dep_point=zeros(); 
for i=1:size(fa,1)
cal_dep_point(i,1:2)=[fb(i),fa(i)];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% global cal_dep_point;
% cal_dep_point_non_revise=zeros();
% cal_dep_point=zeros(); 
% for i=1:size(fa,1)
% cal_dep_point_non_revise(i,1:2)=[fb(i),fa(i)];
% end
% 
% u=1;
% for i=1:size(cal_dep_point_non_revise,1)
%     if  cal_dep_point_non_revise(i,1)<cal_dep_point_non_revise(i,2)
%         cal_dep_point(u,1:2)=cal_dep_point_non_revise(i,1:2);
%         u=u+1;
%     end
% end
% 
% fa=cal_dep_point(:,2);
% fb=cal_dep_point(:,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
for i=1:size(fa,1)
    figure(1)
    plot([Edg(fa(i),1) Edg(fb(i),1)],[Edg(fa(i),2) Edg(fb(i),2)],'k','LineWidth',6)   % draw minium span tree
    hold on
end
plot(Edg(origin_point,1),Edg(origin_point,2),'ro','markerfacecolor','r','markersize',12)  % draw origin point

%draw separately of three axis
plot([Edg(origin_point,1) Edg(Con(origin_point,1),1)], [Edg(origin_point,2) Edg(Con(origin_point,1),2)],'m','LineWidth',3) %V!    draw three main_axis
plot([Edg(origin_point,1) Edg(Con(origin_point,2),1)], [Edg(origin_point,2) Edg(Con(origin_point,2),2)],'c','LineWidth',3) %V2    draw three main_axis   ###
plot([Edg(origin_point,1) Edg(Con(origin_point,3),1)], [Edg(origin_point,2) Edg(Con(origin_point,3),2)],'g','LineWidth',3) %V3    draw three main_axis
%fill([Edg(1,1) Edg(2,1) Edg(3,1) Edg(4,1)],[Edg(1,2) Edg(2,2) Edg(3,2) Edg(4,2)],[1 0 0.5] );


global r21;
global r31;
global r32;
global r12;
global r13;
global r23;

%r21= (norm( [Edg(origin_point,1), Edg(origin_point,2)]-[ Edg(Con(origin_point,2),1), Edg(Con(origin_point,2),2)])) / (norm( [Edg(origin_point,1), Edg(origin_point,2)]-[ Edg(Con(origin_point,1),1), Edg(Con(origin_point,1),2)])) 

r21=sqrt((Edg(Con(origin_point,2),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,2),2)-Edg(origin_point,2))^2) / sqrt((Edg(Con(origin_point,1),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,1),2)-Edg(origin_point,2))^2);
r31=sqrt((Edg(Con(origin_point,3),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,3),2)-Edg(origin_point,2))^2) / sqrt((Edg(Con(origin_point,1),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,1),2)-Edg(origin_point,2))^2);
r32=sqrt((Edg(Con(origin_point,3),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,3),2)-Edg(origin_point,2))^2) / sqrt((Edg(Con(origin_point,2),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,2),2)-Edg(origin_point,2))^2);
r12=sqrt((Edg(Con(origin_point,1),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,1),2)-Edg(origin_point,2))^2) / sqrt((Edg(Con(origin_point,2),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,2),2)-Edg(origin_point,2))^2);
r13=sqrt((Edg(Con(origin_point,1),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,1),2)-Edg(origin_point,2))^2) / sqrt((Edg(Con(origin_point,2),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,3),2)-Edg(origin_point,2))^2);
r23=sqrt((Edg(Con(origin_point,2),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,2),2)-Edg(origin_point,2))^2) / sqrt((Edg(Con(origin_point,3),1)-Edg(origin_point,1))^2+(Edg(Con(origin_point,3),2)-Edg(origin_point,2))^2);

global Z_three_axis; 
% global P1;
% global P2;
% global P3;
% global Z1;
% global Z2;
% global Z3;
%global Zn;
% P1=[Edg(Con(origin_point,1),1)-Edg(origin_point,1),Edg(Con(origin_point,1),2)-Edg(origin_point,2),Zn(1)];   %set up the three axis ( which is connect to the origin point)
% P2=[Edg(Con(origin_point,2),1)-Edg(origin_point,1),Edg(Con(origin_point,2),2)-Edg(origin_point,2),Zn(2)];   %set up the three axis ( which is connect to the origin point)
% P3=[Edg(Con(origin_point,3),1)-Edg(origin_point,1),Edg(Con(origin_point,3),2)-Edg(origin_point,2),Zn(3)];   %set up the three axis ( which is connect to the origin point)

%%%%%%%%%%%%% function %%%%%%%%%%
z0=[0.1,0.1,0.1];
%[Z,fval]=fminunc(@myfun,z0);
opts = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt');
options = optimoptions('lsqnonlin','Jacobian','on');
[Z,fval]=lsqnonlin(@myfun_BU,z0);
%[Z,fval]=fminsearch(@myfun,z0);
Z_three_axis=[Z(1),Z(2),Z(3)]
%%%%%%%%%%%%%% function %%%%%%%%%


% %%%%%%% optimization%%%%%
% z0= [0.1,0.1,0.1];
% [Z]=optimization(origin_point,z0);
% Z_three_axis=[Z(1),Z(2),Z(3)];  % the Z value for three main axis
% %%%%%% optimization%%%%%



% ////////Test////////Test////////////Test//////////////
%dot([V1(1) V1(2) Z(1)],[V2(1) V2(2) Z(2)]');
theta_12=V1(1)*V2(1)+V1(2)*V2(2)+Z(1)*Z(2)
theta_23=V2(1)*V3(1)+V2(2)*V3(2)+Z(2)*Z(3)
theta_13=V3(1)*V1(1)+V3(2)*V1(2)+Z(3)*Z(1)
difference_ratio_12=(sqrt(V1(1)^2+V1(2)^2+Z(1)^2)/sqrt(V2(1)^2+V2(2)^2+Z(2)^2)) - (sqrt(V1(1)^2+V1(2)^2)/sqrt(V2(1)^2+V2(2)^2)) 
difference_ratio_23=(sqrt(V2(1)^2+V2(2)^2+Z(2)^2)/sqrt(V3(1)^2+V3(2)^2+Z(3)^2)) - (sqrt(V2(1)^2+V2(2)^2)/sqrt(V3(1)^2+V3(2)^2)) 
difference_ratio_13=(sqrt(V1(1)^2+V1(2)^2+Z(1)^2)/sqrt(V3(1)^2+V3(2)^2+Z(3)^2)) - (sqrt(V1(1)^2+V1(2)^2)/sqrt(V3(1)^2+V3(2)^2)) 
% ////////Test/////////Test//////////////Test////////////






main_axis=Con(origin_point,:);
     
 global Vnn;
Decided_Za=zeros();
remain_vector=zeros();
for i=1:size(Edg,1)           % calculate the original depth of each point (select V1 or V2 or V3)
       if i~=origin_point && i~=main_axis(1) && i~=main_axis(2) && i~=main_axis(3)
        first_point=origin_point;
        end_point=i;
        [pathway]=minspantree(cal_dep_point,first_point,end_point);
        cal_pathway=[pathway(size(pathway,2)-1),pathway(size(pathway,2))];
        Xn = Edg(cal_pathway(2),1)-Edg(cal_pathway(1),1);
        Yn = Edg(cal_pathway(2),2)-Edg(cal_pathway(1),2);
        %Xn = Edg(cal_pathway(1),1)-Edg(cal_pathway(2),1);
        %Yn = Edg(cal_pathway(1),2)-Edg(cal_pathway(2),2);
       remain_vector(i,1:2)=[Xn,Yn];
       temp1 = (remain_vector(i,1)*V1(1)+remain_vector(i,2)*V1(2) )/ ( norm(remain_vector(i,1:2))*norm(V1) ); 
       temp2 = (remain_vector(i,1)*V2(1)+remain_vector(i,2)*V2(2))/ ( norm(remain_vector(i,1:2))*norm(V2) );
       temp3 = (remain_vector(i,1)*V3(1)+remain_vector(i,2)*V3(2))/ ( norm(remain_vector(i,1:2))*norm(V3) );
       temp=[temp1,temp2,temp3];
       [value,axis]=max(temp);
       Decided_Za(i)=axis;
       end
       for n=1:size(fa,1)
        cal_dep_point(n,1:2)=[fb(n),fa(n)];
       end
   
end


% for i=1:size(Edg,1)   %%% NEW 
%     remain_vector(i,1:2)=Edg(i,1:2);
%     temp1 = (remain_vector(i,1)*V1(1)+remain_vector(i,2)*V1(2) )/ ( norm(remain_vector(i,1:2))*norm(V1) ); 
%        temp2 = (remain_vector(i,1)*V2(1)+remain_vector(i,2)*V2(2))/ ( norm(remain_vector(i,1:2))*norm(V2) );
%        temp3 = (remain_vector(i,1)*V3(1)+remain_vector(i,2)*V3(2))/ ( norm(remain_vector(i,1:2))*norm(V3) );
%        temp=[temp1,temp2,temp3];
%        [value,axis]=max(temp);
%        Decided_Za(i)=axis;
% end




Va=[V1 V2 V3];
 Z_depth_each_point=zeros();
 global which_axis;
 global VT;
 global cur;
 for i=1:size(Edg,1)       % calculate original depth of each point
     if i~=origin_point && i~=main_axis(1) && i~=main_axis(2) && i~=main_axis(3)
            Vnn= remain_vector(i,1:2);
            which_axis=Decided_Za(i);
            VT=[Va(which_axis*2-1) Va(which_axis*2)];
            ze0= [0.5];
            
        % opts = optimoptions('fminunc','Algorithm','levenberg-marquardt');
        % opts = optimoptions('fminunc','Algorithm','quasi-newton');
          
        % [ZE,fval]=fminsearch(@EEmyfun,ze0); % multivariable  Nelder-Mead
       
        %[ZE,fval]=fminunc(@EEmyfun,ze0);      %multivariable   (QN) BEST!!
        [ZE,fval]=lsqnonlin(@EEmyfun,ze0);
          
        %ZE=fminbnd(@EEmyfun,-1,1);     % Single variable
                     
%         A=[1;-1];
%         b=[1;1];
%         [ZE,fval] = fmincon(@EEmyfun,ze0,A,b);
%         
        
        
        
         Z_depth_each_point(i)=ZE;
     end
 % Edg(i,3) = ZE;
 end
 
 Z_depth_each_point(origin_point)=0;
 Z_depth_each_point(main_axis(1))=Z_three_axis(1);
 Z_depth_each_point(main_axis(2))=Z_three_axis(2);
 Z_depth_each_point(main_axis(3))=Z_three_axis(3);
 
 
  
AQA=reshape(cal_dep_point,1,size(cal_dep_point,1)*2);
x=unique(AQA);
y=AQA;
[times, number]=hist(y,x);
final_depth=zeros(1,size(Edg,1));
[useless,end_p]=find(times==1);
end_p(end_p==origin_point) = [];

for i=1:size(end_p,2)
     first_point=origin_point;
     end_point=end_p(i);
   
     [pathway]=minspantree(cal_dep_point,first_point,end_point);
             for k=1:size(pathway,2)
                 if pathway(k)==origin_point
                   final_depth(pathway(k))=0;

               elseif pathway(k)==main_axis(1)
                   final_depth(pathway(k))=Z_three_axis(1);

               elseif pathway(k)==main_axis(2)
                   final_depth(pathway(k))=Z_three_axis(2);

               elseif pathway(k)==main_axis(3)
                   final_depth(pathway(k))=Z_three_axis(3);
               else

                 final_depth(pathway(k))=  Z_depth_each_point(pathway(k))  +  final_depth(pathway(k-1));

                 end
             end
     
     
           for n=1:size(fa,1)
            cal_dep_point(n,1:2)=[fb(n),fa(n)];
           end
 
end

 Edg(:,3)=final_depth';
 %Edg(1,3)=9.9370;
 
for i=1:size(Edg,1)
    for j=1:3
        figure(11)
        plot3([Edg(i,1) Edg(Con(i,j),1)],[Edg(i,2) Edg(Con(i,j),2)],[Edg(i,3) Edg(Con(i,j),3)],'-')
       % plot3([Edg(origin_point,1) Edg(Con(origin_point,j),1)] , [Edg(origin_point,2) Edg(Con(origin_point,j),2)] , [Edg(origin_point,3) Edg(Con(origin_point,j),3)],'g','LineWidth',5);
       % axis(-inf,inf,-inf,inf,0,0);
        grid on
        hold on
    end
end

%fill3([Edg(1,1) Edg(2,1) Edg(3,1) Edg(4,1)], [Edg(1,2) Edg(2,2) Edg(3,2) Edg(4,2)], [Edg(1,3) Edg(2,3) Edg(3,3) Edg(4,3)],[1 0 0.5] );

% fill3([Edg(1,1) Edg(2,1) Edg(6,1) Edg(8,1)], [Edg(1,2) Edg(2,2) Edg(6,2) Edg(8,2)], [Edg(1,3) Edg(2,3) Edg(6,3) Edg(8,3)],[1 0 0.5] );
% fill3([Edg(1,1) Edg(4,1) Edg(8,1) Edg(7,1)], [Edg(1,2) Edg(4,2) Edg(8,2) Edg(7,2)], [Edg(1,3) Edg(4,3) Edg(8,3) Edg(7,3)],[1 0 0.5] );
% fill3([Edg(3,1) Edg(4,1) Edg(5,1) Edg(7,1)], [Edg(3,2) Edg(4,2) Edg(5,2) Edg(7,2)], [Edg(3,3) Edg(4,3) Edg(5,3) Edg(7,3)],[1 0 0.5] );
% fill3([Edg(2,1) Edg(3,1) Edg(6,1) Edg(5,1)], [Edg(2,2) Edg(3,2) Edg(6,2) Edg(5,2)], [Edg(2,3) Edg(3,3) Edg(6,3) Edg(5,3)],[1 0 0.5] );
% fill3([Edg(6,1) Edg(8,1) Edg(7,1) Edg(5,1)], [Edg(6,2) Edg(8,2) Edg(7,2) Edg(5,2)], [Edg(6,3) Edg(8,3) Edg(7,3) Edg(5,3)],[1 0 0.5] );


 plot3([Edg(origin_point,1) Edg(Con(origin_point,1),1)] , [Edg(origin_point,2) Edg(Con(origin_point,1),2)] , [Edg(origin_point,3) Edg(Con(origin_point,1),3)],'m','LineWidth',5); %V!
 plot3([Edg(origin_point,1) Edg(Con(origin_point,2),1)] , [Edg(origin_point,2) Edg(Con(origin_point,2),2)] , [Edg(origin_point,3) Edg(Con(origin_point,2),3)],'c','LineWidth',5); %V2
 plot3([Edg(origin_point,1) Edg(Con(origin_point,3),1)] , [Edg(origin_point,2) Edg(Con(origin_point,3),2)] , [Edg(origin_point,3) Edg(Con(origin_point,3),3)],'g','LineWidth',5); %V3
 plot3(Edg(origin_point,1),Edg(origin_point,2), Edg(origin_point,3),'ro','markerfacecolor','r','markersize',12)  % draw origin point


 
 