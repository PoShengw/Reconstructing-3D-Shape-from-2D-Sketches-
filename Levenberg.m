% ?���?f�����J��x?�A�O�ѪR��
syms a b y x real;
f=a*exp(-b*x);
Jsym=jacobian(f,[a b])


% ?�X��?�u�C??�m????�n�Ap190�A��2
data_1=[0.25 0.5 1 1.5 2 3 4 6 8];
obs_1=[19.21 18.15 15.36 14.10 12.89 9.32 7.45 5.24 3.01];

% 2. LM��k
% ��l�q?s
a0=10; b0=0.5;
y_init = a0*exp(-b0*data_1);
% ?�u??
Ndata=length(obs_1);
% ????
Nparams=2;
% ���N�̤j��?
n_iters=50;
% LM��k�������t?���
lamda=0.01;

% step1: ?�q?��
updateJ=1;
a_est=a0;
b_est=b0;

% step2: ���N
for it=1:n_iters
    if updateJ==1
        % ���u?�e��?�ȡA?�ⶮ�J��x?
        J=zeros(Ndata,Nparams);
        for i=1:length(data_1)
            J(i,:)=[exp(-b_est*data_1(i)) -a_est*data_1(i)*exp(-b_est*data_1(i))];
        end
        % ���u?�e??�A�o���?��
        y_est = a_est*exp(-b_est*data_1);
        % ?��?�t
        d=obs_1-y_est;
        % ?��]?�^����x?
        H=J'*J;
        % �Y�O�Ĥ@�����N�A?��?�t
        if it==1
            e=dot(d,d);
        end
    end

    % ���u�����t?lamda�V�X�o��H�x?
    H_lm=H+(lamda*eye(Nparams,Nparams));
    % ?��B?dp�A�}���u�B??��s���i�઺\??��?��
    dp=inv(H_lm)*(J'*d(:));
    g = J'*d(:);
    a_lm=a_est+dp(1);
    b_lm=b_est+dp(2);
    % ?��s���i���?��??��y�M?��?�te
    y_est_lm = a_lm*exp(-b_lm*data_1);
    d_lm=obs_1-y_est_lm;
    e_lm=dot(d_lm,d_lm);
    % ���u?�t�A?�w�p���s??�M�����t?
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
%?��ɬ�ƪ�?�G
a_est
b_est