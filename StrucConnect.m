% This fucntion recieve the 2D data (starting and end point of lines)
% Perform Beautification (simple version at this point) and 
% Extract information about the Edges and their Conncetion

% Input: data: [X Y time ID] size is Nx4
% Output:   Edg: Edge coordinate
%           Con: Connection of edges 

% Last update:
% 08-04-14 ET (It DOES¡@¢Ü¢Ý¢â¡@£@¢÷¢ú¢ó¡@¢î¢÷¢ú¡@¢ø¢í¢ú¢î¢í¢ë¢ü¡@¢û¢ð¢é¢ø¢í¡^

function [Edg, Con, Adj] = StrucConnect (data)

disp('Entering StrucConnect<<')
sketch_number=length(unique(data(:,4)));
SegPoint=zeros(2*sketch_number,2);

for i=1:sketch_number                       %Calculate segment point
      ID=find(data(:,4)==i);                % (Each line has two pont--head and back) 
      SegPoint(2*i-1,1:2)=data(ID(1),1:2);
    SegPoint(2*i,1:2)=data(ID(end),1:2);
end
SegPoint
length_each_seg=zeros();                    %calculate length of each line
for i=1:size(SegPoint,1)
    if mod(i,2)~=0
   %  length_each_seg(i) = sqrt((SegPoint(i,1)-SegPoint(i+1,1))^2+(SegPoint(i,2)-SegPoint(i+1,2))^2);
   length_each_seg(i) = norm( [SegPoint(i,1), SegPoint(i,2)] - [SegPoint(i+1,1), SegPoint(i+1,2)]   );
    end
end
total_length=sum(length_each_seg);          %total length of draw    
average_length=(total_length)/sketch_number;  % the average length


%%%%%%%%%%%%%%%%%%% Draw the original picture%%%%%%%%%%%%%%%%%%%%%
% for i=1:sketch_number                     
%           [ind,not]=find(data(:,4)==i);
%           for j=ind(1):ind(end)-1
%               figure(4)
%               plot( [data(j,1) data(j+1,1)] , [data(j,2) data(j+1,2)] )
%               hold on
%           end
% end
%%%%%%%%%%%%%%%%% Draw the original picture%%%%%%%%%%%%%%%%%%%%%



EPD_1= pdist2(SegPoint(:,1:2),SegPoint(:,1:2));   %calculate the distance between all segment point
EPD=EPD_1/average_length;                         % normalize

combine=zeros();

% TL=0.11;
% for i=1:size(EPD,1)
%     a=find(EPD(i,:)<TL);
%     combine(i,1:3)=a(1:3);        %find out the connection of the points               
% end

for i=1:size(EPD,1)
      for j=1:3
          a=min(EPD(i,:));
          b=find(EPD(i,:)==a);
          combine(i,j)=b;
          EPD(i,b)=10000; 
      end
    
end

for i=1:size(combine,1)
    combine(i,:)=sort(combine(i,:));
end

 %for i=1:size(combine,2)
[vertex,b,c]=unique(combine,'rows');    % Eight vertix was made up from what points
  
  
pntType = mod(vertex,2);        %1 for starting point, 0 for ending point
pntType(pntType==0) = -1;       %1 for starting point, -1 for ending point
conPnt = vertex + pntType;      %shows the index of the connected point

Con = zeros(size(vertex,1),3);               % connection matrix, the connected verteces
Adj = zeros(size(vertex,1));                 % Adjency matrix, 1 for conection

Edg = zeros(size(vertex,1),2);

for i=1:size(Edg,1)
        Edg(i,:) = mean(SegPoint(vertex(i,:),1:2));
    for j=1:3
        [rid cid] = find(vertex==conPnt(i,j));
        Con(i,j) = rid;                    % the connection of eight vertex
        Adj(i,rid) = 1;
    end
end
disp('Exiting StrucConnect>>')