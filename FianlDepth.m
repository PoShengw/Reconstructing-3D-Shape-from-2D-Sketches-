function Edg = FianlDepth(Edg,cal_dep_point, OP, Con,fb,fa,Z_three_axis,Z_depth_each_point)

 main_axis=Con(OP,:);
   
AQA=reshape(cal_dep_point,1,size(cal_dep_point,1)*2);
x=unique(AQA);
y=AQA;
[times, number]=hist(y,x);
final_depth=zeros(1,size(Edg,1));
[useless,end_p]=find(times==1);
end_p(end_p==OP) = [];

for i=1:size(end_p,2)
     first_point=OP;
     end_point=end_p(i);
   
     [pathway]=minspantree(cal_dep_point,first_point,end_point);
             for k=1:size(pathway,2)
                 if pathway(k)==OP
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
 