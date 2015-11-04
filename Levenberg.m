% ?算函?f的雅克比矩?，是解析式
syms a b y x real;
f=a*exp(-b*x);
Jsym=jacobian(f,[a b])


% ?合用?据。??《????》，p190，例2
data_1=[0.25 0.5 1 1.5 2 3 4 6 8];
obs_1=[19.21 18.15 15.36 14.10 12.89 9.32 7.45 5.24 3.01];

% 2. LM算法
% 初始猜?s
a0=10; b0=0.5;
y_init = a0*exp(-b0*data_1);
% ?据??
Ndata=length(obs_1);
% ????
Nparams=2;
% 迭代最大次?
n_iters=50;
% LM算法的阻尼系?初值
lamda=0.01;

% step1: ?量?值
updateJ=1;
a_est=a0;
b_est=b0;

% step2: 迭代
for it=1:n_iters
    if updateJ==1
        % 根据?前估?值，?算雅克比矩?
        J=zeros(Ndata,Nparams);
        for i=1:length(data_1)
            J(i,:)=[exp(-b_est*data_1(i)) -a_est*data_1(i)*exp(-b_est*data_1(i))];
        end
        % 根据?前??，得到函?值
        y_est = a_est*exp(-b_est*data_1);
        % ?算?差
        d=obs_1-y_est;
        % ?算（?）海塞矩?
        H=J'*J;
        % 若是第一次迭代，?算?差
        if it==1
            e=dot(d,d);
        end
    end

    % 根据阻尼系?lamda混合得到H矩?
    H_lm=H+(lamda*eye(Nparams,Nparams));
    % ?算步?dp，并根据步??算新的可能的\??估?值
    dp=inv(H_lm)*(J'*d(:));
    g = J'*d(:);
    a_lm=a_est+dp(1);
    b_lm=b_est+dp(2);
    % ?算新的可能估?值??的y和?算?差e
    y_est_lm = a_lm*exp(-b_lm*data_1);
    d_lm=obs_1-y_est_lm;
    e_lm=dot(d_lm,d_lm);
    % 根据?差，?定如何更新??和阻尼系?
    if e_lm<e
        lamda=lamda/10;
        a_est=a_lm;
        b_est=b_lm;
        e=e_lm;
        disp(e);
        updateJ=1;
    else
        updateJ=0;
        lamda=lamda*10;
    end
end
%?示优化的?果
a_est
b_est