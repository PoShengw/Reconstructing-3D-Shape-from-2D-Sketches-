function Z_depth_each_point = AllPointDepth(Edg,cal_dep_point, OP,V,fa,fb,main_axis,Z_three_axis)

V1 = V(:,1)';    V2 = V(:,2)';    V3 = V(:,3)';   

%main_axis=Con(OP,:);

Decided_Za=zeros();
remain_vector=zeros();
for i=1:size(Edg,1)           % calculate the original depth of each point (select V1 or V2 or V3)
       if i~=OP && i~=main_axis(1) && i~=main_axis(2) && i~=main_axis(3)
        first_point=OP;
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

%global Vnn;
Va=[V1 V2 V3];
 Z_depth_each_point=zeros();
%global which_axis;
%global VT;

 for i=1:size(Edg,1)       % calculate original depth of each point
     if i~=OP && i~=main_axis(1) && i~=main_axis(2) && i~=main_axis(3)
            Vnn= remain_vector(i,1:2);
            which_axis=Decided_Za(i);
            VT=[Va(which_axis*2-1) Va(which_axis*2)];
            ze0= [0.5];
            hEEmyfun = @(ZE)EEmyfun(ZE,Vnn,which_axis,VT,Z_three_axis);
        % opts = optimoptions('fminunc','Algorithm','levenberg-marquardt');
        % opts = optimoptions('fminunc','Algorithm','quasi-newton');
          
        % [ZE,fval]=fminsearch(@EEmyfun,ze0); % multivariable  Nelder-Mead
       
        %[ZE,fval]=fminunc(@EEmyfun,ze0);      %multivariable   (QN) BEST!!
        [ZE,fval]=lsqnonlin(hEEmyfun,ze0);
          
        %ZE=fminbnd(@EEmyfun,-1,1);     % Single variable
                     
%       A=[1;-1];
%       b=[1;1];
%       [ZE,fval] = fmincon(@EEmyfun,ze0,A,b);
%              
         Z_depth_each_point(i)=ZE;
     end

 end
  
 Z_depth_each_point(OP)=0;
 Z_depth_each_point(main_axis(1))=Z_three_axis(1);
 Z_depth_each_point(main_axis(2))=Z_three_axis(2);
 Z_depth_each_point(main_axis(3))=Z_three_axis(3);
 