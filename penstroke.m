global break_point;
global sketchID;
break_point;
global index;
%%data_3.mat
data_struct=load(['data_',num2str(sketchID),'.mat']);
data=data_struct.points;
% 
g=1;
tem=1;
for i=1:sketchID
    if i~=sketchID
          if (data(break_point(i)+1,3)-data(break_point(i),3))>5
                             
              data(tem:break_point(i),5)=g;
              tem=break_point(i)+1;
              g=g+1;
          else
             data(tem:break_point(i),5)=g;
             tem=break_point(i)+1;
          end
    else
        if (data(break_point(i-1)+1,3)-data(break_point(i-1),3))>5
            data(break_point(i-1)+1:end,5)=g+1;
        else
            data(break_point(i-1)+1:end,5)=g;
        end
    end
    
end




combination=zeros();
for i=1:sketchID*2
    if mod(i,2)~=0
        if i==1
            combination(i,1:5)=data(1,1:5);
        else
            int=fix(i/2);
        combination(i,1:5)=data(break_point(int)+1,1:5);
        end
      elseif mod(i,2)==0
         combination(i,1:5)=data(break_point(i/2),1:5);
    end   
end



global direction_first;
global direction_second;
%%vertex=zeros(sketchID,2);
vertex=zeros(); 
v=1;
for i=1:sketchID*2-1
    for j=i+1:sketchID*2
       if (sqrt((combination(i,1)-combination(j,1))^2+(combination(i,2)-combination(j,2))^2)<0.05)
             if mod(i,2)~=0 %% 表示是頭
               if i==1
                  for h=1:5
                   x_for_merge_first(h)=data(h,1);
                   y_for_merge_first(h)=data(h,2);
                   direction_first=0;
                   sketch_number_first=1;
                  end
                  
               else
               c_1=i/2;
               c=fix(c_1);  %% 表示第幾c+1個sketch
               sketch_number_first=c+1;
                for h=1:5
                 x_for_merge_first(h)=data(break_point(c)+1+h,1);
                 y_for_merge_first(h)=data(break_point(c)+1+h,2);
               direction_first=0;
                end
               end
               
              
        elseif mod(i,2)==0 %% 表示是尾
                c=i/2;
                sketch_number_first=c;
                for h=0:4
                    x_for_merge_first(h+1)=data(break_point(c)-h,1);
                    y_for_merge_first(h+1)=data(break_point(c)-h,2);
                end
                direction_first=1;      
         end
                     
         if mod(j,2)~=0; %%代表是頭
               d_1=j/2;
               d=fix(d_1);
               sketch_number_second=d+1;
                for h=1:5
                   x_for_merge_second(h)=data(break_point(d)+1+h,1);
                   y_for_merge_second(h)=data(break_point(d)+1+h,2);
                end
                    direction_second=0;  
           elseif mod(j,2)==0 %% 代表是尾
                   d=j/2;
                   sketch_number_second=d;
                   for h=0:4
                    x_for_merge_second(h+1)=data(break_point(d)-h,1);
                    y_for_merge_second(h+1)=data(break_point(d)-h,2);
                   end
                   
                 direction_second=1; 
         end
         
       
           [x_cross,y_cross]=merge_point(x_for_merge_first,y_for_merge_first,x_for_merge_second,y_for_merge_second);
         vertex(v,1)=x_cross;
         vertex(v,2)=y_cross;
         vertex(v,3)=sketch_number_first;
         vertex(v,5)=sketch_number_second;
         if direction_first==0
         vertex(v,4)=0;
         else
         vertex(v,4)=1;
         end
         if direction_second==0
         vertex(v,6)=0;
         else
         vertex(v,6)=1;
         end
         v=v+1;
         
         
         
         if i==1
         data(1,1)=x_cross;
         data(1,2)=y_cross;
         elseif direction_first==0
         data(break_point(c)+1,1)=x_cross;
         data(break_point(c)+1,2)=y_cross;
         end
         
       if direction_first==1
        data(break_point(c),1)=x_cross;
        data(break_point(c),2)=y_cross;
       end
       
       
       if direction_second==0
         data(break_point(d)+1,1)=x_cross;
         data(break_point(d)+1,2)=y_cross;
       end
       if direction_second==1
        data(break_point(d),1)=x_cross;
        data(break_point(d),2)=y_cross;
       end 
          
          
       end
    end
end

s=1;
tem_j=zeros();
for i=1:size(vertex,1)
    for j=1:size(vertex,1)
       if sqrt((vertex(i,1)-vertex(j,1))^2+(vertex(i,2)-vertex(j,2))^2)<0.1
          %%vertex(i,1:2)=vertex(j,1:2);
          tem_i=i;
          tem_j(s)=j;
          s=s+1;
       end
    end
    tem_com=[tem_i tem_j];
    for e=1:length(tem_com)
        vertex(tem_com(e),1:2)=vertex(i,1:2);
    end
        
    for h=1:length(tem_com)
        iindex=vertex(tem_com(h),3:6);
        
        if iindex(2)==0
            if iindex(1)==1
                data(1,1:2)=vertex(i,1:2);
            else
            data(break_point(iindex(1)-1)+1,1:2)=vertex(i,1:2);
            end
         end
        if iindex(2)==1
            data(break_point(iindex(1)),1:2)=vertex(i,1:2);
        end
        if iindex(4)==0
            if iindex(3)==1
                data(1,1:2)=vertex(i,1:2);
            else
             data(break_point(iindex(3)-1)+1,1:2)=vertex(i,1:2);
            end
        end
        if iindex(4)==1
            data(break_point(iindex(3)),1:2)=vertex(i,1:2);
        end
    end
    tem_j=zeros();
    s=1;
end

new_data_x=vertex(:,1);
new_data_y=vertex(:,2);

[aa,bb]=unique(new_data_x);
vertex_revise(:,1)=new_data_x(sort(bb));
[cc,dd]=unique(new_data_y);
vertex_revise(:,2)=new_data_y(sort(dd));


k=1;
f=1;
record=zeros();
matrix_for_calculate=zeros();
local_angle=zeros();


for i=1:size(vertex_revise,1)
       for j=1:size(data,1)
             if data(j,1)==vertex_revise(i,1)&& data(j,2)==vertex_revise(i,2)
                 record(k)=data(j,4);
                 k=k+1;
             end
       end
    
        for p=1:size(record,2)
           for n=1:size(data,1)
             if data(n,4)==record(p);
               matrix_for_calculate(f,1:5)=data(n,1:5);
               f=f+1;
             end
           end
           delt_y=(matrix_for_calculate(end,2)-matrix_for_calculate(1,2));
           delt_x=(matrix_for_calculate(end,1)-matrix_for_calculate(1,1));
           slope=delt_y/delt_x;
           local_angle(p)=atand(slope);
           f=1;
           matrix_for_calculate=zeros();
             for r=1:length(local_angle)
                if local_angle(r)>180
                  local_angle(r)=local_angular(r)-180;
                end
                  if local_angle(r)<0
                    if local_angle(r)<-180
                     local_angle(r)=local_angle(r)+360;   
                    else
                    local_angle(r)=local_angle(r)+180;
                    end
                  end
                
%                   if global_angle(r)>170&&global_angle(r)<180
%                   global_angle(r)=5;
%                   end     
                  
             end          
        end   
    figure(1)
    subplot(1,size(vertex_revise,1),i)
    hist(local_angle, -180:180);   
    k=1;
    record=zeros();
end


u=1;
global_angle=zeros();
global_matrix=zeros();
for i=1:sketchID
    for j=1:size(data,1)
      if data(j,4)==i
          global_matrix(u,1:5)=data(j,1:5);
          u=u+1;
      end
    end
      global_delt_y=(global_matrix(end,2)-global_matrix(1,2));
      global_delt_x=(global_matrix(end,1)-global_matrix(1,1));
      global_slope=global_delt_y/global_delt_x;
      global_angle(i)= atand(global_slope) ;
          for r=1:length(global_angle)
                if global_angle(r)>180
                  global_angle(r)=global_angular(r)-180;
                end
                  if global_angle(r)<0
                    if global_angle(r)<-180
                     global_angle(r)=global_angle(r)+360;   
                    else
                    global_angle(r)=global_angle(r)+180;
                    end
                  end
                  
%                   if global_angle(r)>170&&global_angle(r)<180
%                   global_angle(r)=5;
%                   end              
          end    
      u=1;
      global_matrix=zeros();
end

figure(2)
hist(global_angle,0:180);

% aangless=[];
% for i=1:length(global_angle)
%     aangless=[aangless;mvnrnd(global_angle(i),100,10000)];
% end
% 
%  hist(aangless,1000);
%           
        
        
        
        
        
        
        