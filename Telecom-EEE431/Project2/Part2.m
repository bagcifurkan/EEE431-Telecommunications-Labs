close all, clear all, clc;

%Part2--------------------------------

N = 10000;
X = randi( [0 1], 1, N);
T = 20;
a = (12/T^3)^(1/2);

t = T/30:T/30:T;
%Generating p(t)
for t = 1:1:30
    t_ = t*(T/30);
    if t <= 15
        pt(t) = a*t_;
    else
        pt(t) = a*(T-t_);
    end
end

%power of pt  = 1 unit
%disp(trapz([1/20:1/20:1],pt.^2)) 

figure(1);
subplot(1,2,1);
plot([20/30:20/30:20],pt);
title('p(t)');
subplot(1,2,2);
plot([20/30:20/30:1],-pt);
title('-p(t)');

%Generating s(t)
for i = 1:1:N
    for j = 1:1:30
        if X(i) == 1.0
            st((i-1)*30 + j) = pt(j);
        else
            st((i-1)*30 + j) = -pt(j);
        end
    end
end

figure(2);
plot(st);
title('st');

%Generating nt
k = 1.38*(10^-23);
%N0 = k*300; %k = boltzman constant , 300 kelvin
%SNR = 1;
%N0 = 1/SNR; 
count = zeros(1,10);
sigma = 1:1:10;
for j = 1:1:10
    SNR(j) = 1/(2*sigma(j)); %Eb/No
    nt = sqrt(sigma(j)) * randn(1, 30*N);
    %nt = (N0/2)^1/2 * randn(1, 20*N);

    %generating rt
    rt = st + nt;

%Correlation type receiver
    for i = 1:1:N
        r(i) =trapz([20/30:20/30:1],rt( ((i-1)*30+1):((i-1)*30+30)).* pt);
        % ML Decision rule
        if r(i)<=0
            r_ML(i) = 0;
        else
            r_ML(i) = 1;
        end
        if (r_ML(i) == X(i))
            count(j) = count(j) + 1;
        end
    end
end

error_rate = 1-(count./N);
%sa = @(x) triangularPulse(0, 1/2, 1, x) .* sqrt(12);
%fplot(sa)
SNR_db = 10*log10(SNR);
figure(3);
semilogy(SNR_db, error_rate);
xlabel('SNR(dB)');
ylabel('Error Rate');
title('Error rate for different N0s with sampling at T/30');