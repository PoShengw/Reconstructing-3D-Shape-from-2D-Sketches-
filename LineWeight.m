function DDG = LineWeight(Edg, Con, V)

disp('Entering LineWeight<<')

A = repmat(1:size(Con,1),3,1);      B = Con';
pc = [A(:) B(:)];   % Point Conncetion for each line

N = size(pc,1);     % Number of line

LW = zeros(length(pc),1);

for i=1:size(pc,1)                 
    Vn = [Edg(pc(i,1),1)-Edg(pc(i,2),1) , Edg(pc(i,1),2)-Edg(pc(i,2),2)];   
    NN = sqrt(sum(V.^2))*norm(Vn);
    LW(i) = max(abs(Vn*V)./NN);    
end

DDG = sparse(pc(:,1)',pc(:,2)',-LW);

disp('Exiting LineWeight>>')