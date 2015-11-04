function [pathway]=minspantree(cal_dep_point,first_point,end_point)

j=1;
k=2;
m=1;
n=2;
tim=1;
%first_point=3;
%end_point=8;
tem_head=[first_point];
tem_back=[end_point];
run=1;
%head(1)=first_point;
%back(1)=end_point;
while (run==1)
    for w=1:size(first_point)
        [colum_1,row_1,value_1]=find(cal_dep_point==first_point(w));
             if isempty(colum_1)
                colum_1=0;
             end
             if isempty(row_1)
                row_1=0;
             end
        ss=size(colum_1,1);
        while (ss~=0)
             if row_1(ss)==2
               change=cal_dep_point(colum_1(ss),2);
               cal_dep_point(colum_1(ss),2)=cal_dep_point(colum_1(ss),1);
               cal_dep_point(colum_1(ss),1)=change;
             end
                        if colum_1~=0 
                       % head(j,1:k)= head(j,[tem_head(e,1:k-1),cal_dep_point(colum_1(ss),2)]);
                       % head(j,1:k)= tem_head(w,[tem_head(w,1:k-1),cal_dep_point(colum_1(ss),2)]);
                        head(j,1:k)=[tem_head(w,1:k-1),cal_dep_point(colum_1(ss),2)];
                        else
                        %head(j,1:k)= head(j,[tem_head(w,1:k-1),0]);   
                        head(j,1:k)=[tem_head(w,1:k-1),0];
                        end
                       ss=ss-1;
                       j=j+1;
         end
       
    end 
       k=k+1;
       j=1;
       tem_head=head;
       
       
     if tim==1
                minus=head(:,end)-end_point;
                position=find(minus==0);
                tim=tim+1;
                if isempty(position)
                    position=0;
                end
                   
               if position~=0
                run=0;
                path=[head(position,:),end_point];
                break;
               elseif position==0
                 [colum_2,row_2,value_2]=find(cal_dep_point==end_point);
                 ss=size(colum_2,1);
                   while(ss~=0)
                         if row_2(ss)==2
                         change=cal_dep_point(colum_2(ss),2);
                         cal_dep_point(colum_2(ss),2)=cal_dep_point(colum_2(ss),1);
                         cal_dep_point(colum_2(ss),1)=change;
                         end
                         e=1;
                         back(m,1:n)=[tem_back(e,1:n-1),cal_dep_point(colum_2(ss),2)];
                          %back(m,n)= cal_dep_point(colum_1(ss),2);
                          ss=ss-1;
                          m=m+1;
                   end
                   n=n+1;
                   m=1;
                                      
                    for i=1:size(head,1)
                          for t=1:size(back,1)
                               minus=head(i,end)-back(t,end);
                             if minus==0
                             run=0;
                             path=[head(i,:), fliplr(back(t,:))];
                               break;
                             end
                          end
                    end
                                    
                   
               end
              tem_back=back;  
                    
           
                              
     elseif tim~=1
         
         for i=1:size(head,1)
              for t=1:size(back,1)
                   minus=head(i,end)-back(t,end);
                   if minus==0
                       run=0;
                        path=[head(i,:), fliplr(back(t,:))];
                        break;
                   end
              end
         end
          
        for e=1:size(end_point)
             [colum_2,row_2,value_2]=find(cal_dep_point==end_point(e));
             if isempty(colum_2)
                colum_2=0;
             end
             if isempty(row_2)
                row_2=0;
             end
             ss=size(colum_2,1);
                while(ss~=0)
                     if row_2(ss)==2
                         change=cal_dep_point(colum_2(ss),2);
                         cal_dep_point(colum_2(ss),2)=cal_dep_point(colum_2(ss),1);
                         cal_dep_point(colum_2(ss),1)=change;
                     end
                         if colum_2~=0  
                         %back(m,n)= cal_dep_point(colum_2(ss),2);
                          back(m,1:n)=[tem_back(e,1:n-1),cal_dep_point(colum_2(ss),2)];
                          %head(j,1:k)=[tem_head(w,1:k-1),cal_dep_point(colum_1(ss),2)]; 
                        
                          else
                        back(m,1:n)=[tem_back(e,1:n-1),0];
                         end
                     
                          ss=ss-1;
                          m=m+1;
                end
          end
         n=n+1;
         m=1;
         tem_back=back;
         
               for i=1:size(head,1)
                          for t=1:size(back,1)
                               minus=head(i,end)-back(t,end);
                             if minus==0
                             run=0;
                             path=[head(i,:), fliplr(back(t,:))];
                             break;
                             end
                         end
               end
         
                  
     end
     
     first_point=head(:,end);
     end_point=back(:,end);
     if colum_1~=0
     cal_dep_point(colum_1,:)=0;
     end
     if colum_2~=0
     cal_dep_point(colum_2,:)=0;
     end
       
end
    
 [qw,er]=unique(path,'first');
 pathway=path(sort(er));    
 pathway(pathway==0)=[];%% Find the pathway!!!!!!!!!!!!!!!!

