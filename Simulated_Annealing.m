clc; clear all;
tic
%% init theoretical data
nu = 120;
nu_unit = 'GHz';
omega = NuToOmega(nu, nu_unit);
Gammap = 23.88*10^-3;
Gammam = 26.06*10^-3;
j0p = 7.4*10^-3;
j0m = 8.3*10^-3;
alpha = 0:0.05:300;
U0_Ucr = [0 20 40 60]*10^-3;
l = 4;
jlc_res = zeros(length(alpha), length(U0_Ucr));
jls_res = zeros(length(alpha), length(U0_Ucr));
summ = zeros(length(alpha), length(U0_Ucr));
k1 = 1000;
for i = 1:length(U0_Ucr)
    U0_Ucr(i)
    parfor j = 1:length(alpha)
        jlc_res (j, i) = jlc(j0p, j0m, U0_Ucr(i), omega, Gammap, Gammam, alpha(j), l, k1);
        jls_res (j, i) = jls(j0p, j0m, U0_Ucr(i), omega, Gammap, Gammam, alpha(j), l, k1);
        summ(j,i) = jls_res(j,i).^2+jlc_res(j,i).^2;
    end
end
max_sum = max(max(summ));
summ = summ/max_sum;
figure;
plot(alpha, summ);
xlabel('\alpha')
ylabel('I^4/max(I^4_{60})')
title('Theoretical data')
legend('0 mW', '20 mW', '40mW', '60 mW')
%% init experimental data
PWs = getData('data/PW4l_s.dat');
PW20 = getData('data/PW4l_20.dat');
PW40 = getData('data/PW4l_40.dat');
PW60 = getData('data/PW4l_60.dat');
PW_x = PWs(:,1);
PW_y = [PWs(:, 2) PW20(:,2) PW40(:,2) PW60(:,2)]
max_PW = max(max(PW_y));
PW_y = PW_y/max_PW;
figure;
plot(PW_x, PW_y);
xlabel('P_{in}')
ylabel('P/max(P_{60})')
title('Experimental data')
legend('0 mW', '20 mW', '40mW', '60 mW')
%%
res_alpha = [];
error = [];
for i = 1:length(PW_y)
    J1 = PW_y(i, :)
    num_prew = 1;
    J_prew = summ(num_prew, :);
    dJ_prew = sum((J_prew-J1).^2);
    for j = 2:length(alpha)
        J_alpha = summ(j, :);
        dJ_cur = sum((J_alpha-J1).^2);
        dJ = dJ_cur-dJ_prew;
        
        if dJ < 0
            num_prew = j;
            J_prew = J_alpha;
            dJ_prew = dJ_cur;
        elseif exp(-dJ/(alpha(j).^2)) > rand(0,1)
            num_prew = j;
            J_prew = J_alpha;
            dJ_prew = dJ_cur;
        end
    end
    error = [error dJ_prew];
    res_alpha = [res_alpha alpha(num_prew)];
end
toc
figure;
plot(PW_x, res_alpha)
xlabel( 'P_{in}' );
ylabel( '\alpha' );
figure;
plot(PW_x, error);
xlabel( 'P_{in}' );
ylabel( 'sum((P-I^4(\alpha*))^2)' );
title('Sum of Squared Errors')