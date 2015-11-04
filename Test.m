global Edg;
global Con;
te=zeros();
for i=1:size(Edg,1)
    for j=1:3
        if j==3
           te(i,j)= dot([[Edg(i,1) Edg(i,2) Edg(i,3)]-[Edg(Con(i,1),1) Edg(Con(i,1),2) Edg(Con(i,1),3)]],[[Edg(i,1) Edg(i,2) Edg(i,3)]-[Edg(Con(i,3),1) Edg(Con(i,3),2) Edg(Con(i,3),3)]]');
        else
     te(i,j)= dot([[Edg(i,1) Edg(i,2) Edg(i,3)]-[Edg(Con(i,j),1) Edg(Con(i,j),2) Edg(Con(i,j),3)]]  ,  [[Edg(i,1) Edg(i,2) Edg(i,3)]-[Edg(Con(i,j+1),1) Edg(Con(i,j+1),2) Edg(Con(i,j+1),3)]]');
        end
        end
end
  

  
  
  % dot([[Edg(2,1) Edg(2,2) Edg(2,3)]-[Edg(1,1) Edg(1,2) Edg(1,3)]], [[Edg(2,1) Edg(2,2) Edg(2,3)]-[Edg(6,1) Edg(6,2) Edg(6,3)]]' )