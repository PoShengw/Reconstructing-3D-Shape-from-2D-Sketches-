clc;    clear;  close all;

%% Load data
% data_struct=load(['data_24.mat']);
% data=data_struct.points;
% Cla = size(unique(data(:,4)),1);
%% Draw original strokes
%Draw original strokes
%  for i=1:Cla
%           [ind,not]=find(data(:,4)==i);
%           for j=ind(1):ind(end)-1
%               figure(4)
%               plot( [data(j,1) data(j+1,1)] , [data(j,2) data(j+1,2)] )
%               %plot(0.6716,0.2518,'ro','markerfacecolor','r','markersize',12)
%               hold on
%           end
% end
%Getting Edje, connection and adjancy matrix from raw data


%% shape% (5 angle shape )
Edg = [0 0;2 0;2 2;0 2;1 1; 3 1; 3 3; 1 3; 1 3; 2 4];
Con = [2 4 5 ; 1 3 6 ; 2 7 9 ; 1 8 9 ; 1 6 8 ; 2 5 7 ; 3 6 10 ; 4 5 10 ; 3 4 10 ; 7 8 9 ];
%%










% [Edg, Con, Adj] = StrucConnect (data);
%perfect cube
% Edg = [0 0;2 0;2 2;0 2;1 1; 3 1; 3 3; 1 3];
% Con = [2 4 5;1 3 6; 2 4 7; 1 3 8; 1 6 8; 2 5 7; 3 6 8; 4 5 7];

%% GOOD
% % shape_1% (5 angle shape )
% Edg = [0 0;2 0;2 2;0 2;1 1; 3 1; 3 3; 1 3; 1 3; 2 4];
% Con = [2 4 5 ; 1 3 6 ; 2 7 9 ; 1 8 9 ; 1 6 8 ; 2 5 7 ; 3 6 10 ; 4 5 10 ; 3 4 10 ; 7 8 9 ];
%%
% shape_1 ---with noise (5 angle shape )
% Edg = [0 0 ; 2 0 ; 2.1 2.3 ; 0.2 2.2 ; 1.3 1.1 ; 3.2 1.3 ; 3.2 3.1 ; 1.2 3.3 ; 1.2 3.1 ; 2.2 4.1 ];
% Con = [2 4 5 ; 1 3 6 ; 2 7 9 ; 1 8 9 ; 1 6 8 ; 2 5 7 ; 3 6 10 ; 4 5 10 ; 3 4 10 ; 7 8 9 ];
%% GOOd
% shape_1% --- with noise (5 angle shape) GOOD
% Edg = [0 0 ; 2 0 ; 2.1 2.2 ; 0.2 2.1 ; 1.1 1.2 ; 3.2 1.1 ; 3.1 3.2 ; 1.2 3.1 ; 1.2 3.1 ; 2.1 4.2 ];
% Con = [2 4 5 ; 1 3 6 ; 2 7 9 ; 1 8 9 ; 1 6 8 ; 2 5 7 ; 3 6 10 ; 4 5 10 ; 3 4 10 ; 7 8 9 ];
%%

% shape_2%
% Edg = [0 0;2 0;2 2;0 2;1 1; 3 1; 3 3; 1 3; 1 3.5; 2 4.5];
% Con = [2 4 5 ; 1 3 6 ; 2 7 9 ; 1 8 9 ; 1 6 8 ; 2 5 7 ; 3 6 10 ; 4 5 10 ; 3 4 10 ; 7 8 9 ];


% shape_2---with noise
% Edg = [0 0;2 0;  2.1 2.2;0.2 2.3;1.2 1.3; 3.2 1.3; 3.1 3.2; 1.2 3.3; 1.3 3.6; 2.2 4.6];
% Con = [2 4 5 ; 1 3 6 ; 2 7 9 ; 1 8 9 ; 1 6 8 ; 2 5 7 ; 3 6 10 ; 4 5 10 ; 3 4 10 ; 7 8 9 ];
%



% shape_3
% Edg = [0 0;2 0;2 2;0 2;1 1; 3 1; 3 3; 1 3; 1 3; 2 4 ; 2 0; 1 -1];
% Con = [ 4 5 12 ; 3 6 12 ; 2 7 9 ; 1 8 9 ; 1 8 11 ; 2 7 11 ; 3 6 10 ; 4 5 10 ; 3 4 10 ; 7 8 9; 5 6 12; 1 2 11 ];

% shape_4   OP=8
% Edg = [0 0;2 0;2 2;0 2;1 1; 3 1; 3 3; 1 3; 1 2.5; 2 3.5 ; 2 0.5; 1 -0.5];
% Con = [ 4 5 12 ; 3 6 12 ; 2 7 9 ; 1 8 9 ; 1 8 11 ; 2 7 11 ; 3 6 10 ; 4 5 10 ; 3 4 10 ; 7 8 9; 5 6 12; 1 2 11 ];


% % shape_5
% Edg = [0 0;2 0;2 2;0 2;1 1; 3 1; 3 3; 1 3; 1 2.5; 2 3.5 ; 2 0.5; 1 -0.5; 2.5 1; 3.5 2; -0.5 1; 0.5 2 ];
% Con = [ 5 12 15 ; 6 12 13 ; 7 9 13 ; 8 9 15 ; 1 11 16 ; 2 11 14 ;  3 10 14 ; 4 10 16 ; 3 4 10 ; 7 8 9; 5 6 12; 1 2 11;  2 3 14 ; 6 7 13;  1 4 16; 5 8 15];


% % shape_6
% Edg = [0 2 ; 1 1 ; 2 1 ; 3 2 ; 1.5 3 ; 0 1 ; 1 0 ; 2 0 ; 3 1 ; 1.5 2];
% Con = [2 5 6 ; 1 3 7 ; 2 4 8 ; 3 5 9; 1 4 10 ; 1 7 10; 2 6 8 ; 3 7 9; 4 10 8; 5 6 9 ];

% % shape_7
% Edg = [0 0 ; 3 0 ; 3 2; 2 2; 2 1; 1 1; 1 2; 0 2 ; 1 5 ; 4 5 ; 4 7; 3 7; 3 6; 2 6; 2 7; 1 7 ];
% Con = [2 8 9; 1 3 10; 2 4 11; 3 5 12; 4 6 13; 5 7 14; 6 8 15;1 7 16; 1 10 16; 9 2 11; 3 10 12; 4 11 13; 5 12 14; 6 13 15; 7 14 16; 8 9 15];





% Calculating the Origin and main axis
%[OP, V] = FindMainAxis(Edg, Con);

run=2;
time=1;
number=0;
while (run==2)
    number=number+1;
    number
    if time == 1
        [global_theta,theta] = FindThetaFirst(Edg, Con);
    else
        [global_theta] = FindThetaSecond(Edg,Old_ST_Con);
    end
    
    [ gaussian_global, local_assem_angle ] = Gaussian(theta,global_theta);
    [ OP,V] = OPandMainAxis(gaussian_global,local_assem_angle,Con,Edg,theta );
  
    
    
    %%% Claculating the weight of each line and its sparce matrix
    DDG = LineWeight(Edg, Con, V);
    
    %%% Calculatinf Maximum Spanning Tree (we used negetive weight in DDG
    [ST,pred] = graphminspantree(DDG,'Method','Kruskal');
    [fa,fb] = find(ST<0);
    
    ST_Con = [fb,fa];
    ST_Con
    if time ==2
        if isequal(ST_Con,Old_ST_Con)==1
            run=1;
        else
            run=2;
        end
    end
    Old_ST_Con = ST_Con;
    time=2;
    Old_ST_Con
    OP
end




% Calculating the depth of three main axis
Z_three_axis = AxisDepth(Edg, Con, OP, V);

% Calculating the depth of all point
main_axis=Con(OP,:);
Z_depth_each_point = AllPointDepth(Edg,ST_Con, OP,V,fa,fb,main_axis,Z_three_axis);

% Calculating the final depth of all the point
Edg = FianlDepth(Edg,ST_Con, OP, Con,fb,fa,Z_three_axis,Z_depth_each_point);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Plotting
%figure(1)
% for i=1:size(fa,1)
%     plot([Edg(fa(i),1) Edg(fb(i),1)],[Edg(fa(i),2) Edg(fb(i),2)],'k','LineWidth',6)   % draw minium span tree
%     hold on
% end
% plot(Edg(OP,1),Edg(OP,2),'ro','markerfacecolor','r','markersize',12)  % draw origin point

%draw separately of three axis
% plot([Edg(OP,1) Edg(Con(OP,1),1)], [Edg(OP,2) Edg(Con(OP,1),2)],'m','LineWidth',3) %V1    draw three main_axis
% plot([Edg(OP,1) Edg(Con(OP,2),1)], [Edg(OP,2) Edg(Con(OP,2),2)],'c','LineWidth',3) %V2    draw three main_axis
% plot([Edg(OP,1) Edg(Con(OP,3),1)], [Edg(OP,2) Edg(Con(OP,3),2)],'g','LineWidth',3) %V3    draw three main_axis

for i=1:size(Edg,1)
    for j=1:3
        figure(11)
        plot3([Edg(i,1) Edg(Con(i,j),1)],[Edg(i,2) Edg(Con(i,j),2)],[Edg(i,3) Edg(Con(i,j),3)],'-')
        % plot3([Edg(OP,1) Edg(Con(OP,j),1)] , [Edg(OP,2) Edg(Con(OP,j),2)] , [Edg(OP,3) Edg(Con(OP,j),3)],'g','LineWidth',5);
        % axis(-inf,inf,-inf,inf,0,0);
        grid on
        hold on
    end
end

plot3([Edg(OP,1) Edg(Con(OP,1),1)] , [Edg(OP,2) Edg(Con(OP,1),2)] , [Edg(OP,3) Edg(Con(OP,1),3)],'m','LineWidth',5); %V!
plot3([Edg(OP,1) Edg(Con(OP,2),1)] , [Edg(OP,2) Edg(Con(OP,2),2)] , [Edg(OP,3) Edg(Con(OP,2),3)],'c','LineWidth',5); %V2
plot3([Edg(OP,1) Edg(Con(OP,3),1)] , [Edg(OP,2) Edg(Con(OP,3),2)] , [Edg(OP,3) Edg(Con(OP,3),3)],'g','LineWidth',5); %V3
plot3(Edg(OP,1),Edg(OP,2), Edg(OP,3),'ro','markerfacecolor','r','markersize',12)  % draw origin point


for i=1:size(Edg,1)
    for j=1:3
        figure(20)
        plot([Edg(i,1) Edg(Con(i,j),1)],[Edg(i,2) Edg(Con(i,j),2)])
        hold on
    end
end
plot(Edg(OP,1),Edg(OP,2),'ro','markerfacecolor','r','markersize',12)  % draw origin point

%draw separately of three axis
plot([Edg(OP,1) Edg(Con(OP,1),1)], [Edg(OP,2) Edg(Con(OP,1),2)],'m','LineWidth',3) %V!    draw three main_axis
plot([Edg(OP,1) Edg(Con(OP,2),1)], [Edg(OP,2) Edg(Con(OP,2),2)],'c','LineWidth',3) %V2    draw three main_axis
plot([Edg(OP,1) Edg(Con(OP,3),1)], [Edg(OP,2) Edg(Con(OP,3),2)],'g','LineWidth',3) %V3    draw three main_axis



