function[x_cross,y_cross]=merge_point(x_for_merge_first,y_for_merge_first,x_for_merge_second,y_for_merge_second)
global direction_first;
global direction_second;
% xx1=[ones(5,1),x_for_merge_first'];
% y1=y_for_merge_first;
% [b1,bint1,r1,rint1,stats1]=regress(y1,xx1);
% 
% xx2=[ones(5,1),x_for_merge_second'];
% y2=y_for_merge_second;
% [b2,bint2,r2,rint2,stats2]=regress(y2,xx2);
n=5;
A=0;
B=0;
C=0;
D=0;
A_second=0;
B_second=0;
C_second=0;
D_second=0;


for i=1:n
A=A+x_for_merge_first(i);
B=B+y_for_merge_first(i);
C=C+x_for_merge_first(i)*x_for_merge_first(i);
D=D+x_for_merge_first(i)*y_for_merge_first(i);
end

for i=1:n
A_second=A_second+x_for_merge_second(i);
B_second=B_second+y_for_merge_second(i);
C_second=C_second+x_for_merge_second(i)*x_for_merge_second(i);
D_second=D_second+x_for_merge_second(i)*y_for_merge_second(i);
end

if x_for_merge_first(1)==x_for_merge_first(2)&&x_for_merge_first(2)==x_for_merge_first(3)&&x_for_merge_first(3)==x_for_merge_first(4)&& x_for_merge_first(4)==x_for_merge_first(5)
          if x_for_merge_second(1)==x_for_merge_second(2)&&x_for_merge_second(2)==x_for_merge_second(3)&&x_for_merge_second(3)==x_for_merge_second(4)&& x_for_merge_second(4)==x_for_merge_second(5)&&x_for_merge_second(5)~=x_for_merge_first(5)
              if direction_first==0
                  x_cross=((x_for_merge_first(1))+x_for_merge_second(1))/2;
                  y_cross=y_for_merge_first(1);
              elseif direction_first==1
                  x_cross=(x_for_merge_first(0)+x_for_merge_second(1))/2;
                  y_cross=y_for_merge_second(5);
              end
           elseif  x_for_merge_second(1)==x_for_merge_second(2)&&x_for_merge_second(2)==x_for_merge_second(3)&&x_for_merge_second(3)==x_for_merge_second(4)&& x_for_merge_second(4)==x_for_merge_second(5)&&x_for_merge_second(5)==x_for_merge_first(5)
              x_cross=x_for_merge_first(0);
              y_cross=y_for_merge_first(0);
          elseif y_for_merge_second(1)==y_for_merge_second(2)&&y_for_merge_second(2)==y_for_merge_second(3)&&y_for_merge_second(3)==y_for_merge_second(4)&& y_for_merge_second(4)==y_for_merge_second(5)
              m_second=0;
              e_second=(B_second-m_second*A_second)/n;
              x_cross=x_for_merge_first(1);
              y_cross=y_for_merge_second(1);
          else
              m_second=(n*D_second-A_second*B_second)/(n*C_second-A_second*A_second);
              e_second=(B_second-m_second*A_second)/n;
              x_cross=x_for_merge_first(1);
              y_cross=m_second*x_cross+e_second;
          end
elseif y_for_merge_first(1)==y_for_merge_first(2)&&y_for_merge_first(2)==y_for_merge_first(3)&&y_for_merge_first(3)==y_for_merge_first(4)&& y_for_merge_first(4)==y_for_merge_first(5)
      if x_for_merge_second(1)==x_for_merge_second(2)&&x_for_merge_second(2)==x_for_merge_second(3)&&x_for_merge_second(3)==x_for_merge_second(4)&& x_for_merge_second(4)==x_for_merge_second(5)
      x_cross=x_for_merge_second(1);
      y_cross=y_for_merge_first(1);
      elseif y_for_merge_second(1)==y_for_merge_second(2)&&y_for_merge_second(2)==y_for_merge_second(3)&&y_for_merge_second(3)==y_for_merge_second(4)&&y_for_merge_second(4)==y_for_merge_second(5)
        x_cross=x_for_merge_first(1);
        y_cross=y_for_merge_second(1);
      else
          m=0;
          e=(B-m*A)/n;
          m_second=(n*D_second-A_second*B_second)/(n*C_second-A_second*A_second);
          e_second=(B_second-m_second*A_second)/n;
          y_cross=y_for_merge_first(1);
          x_cross=(y_cross-e_second)/m_second;
%           x_cross=(e_second-e)/(m-m_second);
%           y_cross=(m*x_cross)+e;   
      end
           
       
else
       if x_for_merge_second(1)==x_for_merge_second(2)&&x_for_merge_second(2)==x_for_merge_second(3)&&x_for_merge_second(3)==x_for_merge_second(4)&& x_for_merge_second(4)==x_for_merge_second(5)
       m=(n*D-A*B)/(n*C-A*A);
       e=(B-m*A)/n;
       x_cross=x_for_merge_second(1);
       y_cross=(m*x_cross)+e;
       elseif y_for_merge_second(1)==y_for_merge_second(2)&&y_for_merge_second(2)==y_for_merge_second(3)&&y_for_merge_second(3)==y_for_merge_second(4)&&y_for_merge_second(4)==y_for_merge_second(5)
        m=(n*D-A*B)/(n*C-A*A);
       e=(B-m*A)/n;
       m_second=0;
       e_second=(B_second-m_second*A_second)/n;
       x_cross=(e_second-e)/(m-m_second);
       y_cross=(m*x_cross)+e;  
       else
       m=(n*D-A*B)/(n*C-A*A);
       e=(B-m*A)/n;
       m_second=(n*D_second-A_second*B_second)/(n*C_second-A_second*A_second);
       e_second=(B_second-m_second*A_second)/n;
       x_cross=(e_second-e)/(m-m_second);
       y_cross=(m*x_cross)+e;    
       end
       
end
      
      







