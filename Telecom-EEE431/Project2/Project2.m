close all, clear all, clc;

%Part1--------------------------------

N = 10000;
X = randi( [0 1], 1, N);
T = 20;
a = (12/T^3)^(1/2);

t = T/20:T/20:T;
%Generating p(t)
for t = 1:1:20
    t_ = t*(T/20);
    if t <= 10
        pt(t) = a*t_;
    else
        pt(t) = a*(T-t_);
    end
end

%power of pt  = 1 unit
%disp(trapz([1/20:1/20:1],pt.^2)) 

figure(1);
subplot(1,2,1);
plot([20/20:20/20:20],pt);
title('p(t)');
subplot(1,2,2);
plot([20/20:20/20:20],-pt);
title('-p(t)');

%Generating s(t)
for i = 1:1:N
    for j = 1:1:20
        if X(i) == 1.0
            st((i-1)*20 + j) = pt(j);
        else
            st((i-1)*20 + j) = -pt(j);
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
    nt = sqrt(sigma(j)) * randn(1, 20*N);
    %nt = (N0/2)^1/2 * randn(1, 20*N);

    %generating rt
    rt = st + nt;
    %figure(2);
    %plot(rt);
    %title('rt');
    
%Correlation type receiver
    for i = 1:1:N
        r(i) =trapz([20/20:20/20:20],rt( ((i-1)*20+1):((i-1)*20+20)).* pt);
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
title('Error rate for different N0s');

%Part2--------------------------------

%Part3--------------------------------
pulse = sqrt(1/20)* ones(1,20);

count_p3 = zeros(1,10);
for j = 1:1:10
    SNR_p3(j) = 1/(2*sigma(j)); %Eb/No
    nt = sqrt(sigma(j)) * randn(1, 20*N);
    %nt = (N0/2)^1/2 * randn(1, 20*N);

    %generating rt
    rt = st + nt;

%Correlation type receiver
    for i = 1:1:N
        r(i) =trapz([20/20:20/20:20],rt( ((i-1)*20+1):((i-1)*20+20)).* pulse);
        % ML Decision rule
        if r(i)<=0
            r_ML(i) = 0;
        else
            r_ML(i) = 1;
        end
        if (r_ML(i) == X(i))
            count_p3(j) = count_p3(j) + 1;
        end
    end
end

error_rate_p3 = 1-(count_p3./N);
SNR_db_p3 = 10*log10(SNR_p3.*0.8617);
figure(4);
semilogy(SNR_db_p3, error_rate_p3);
xlabel('SNR(dB)');
ylabel('Error Rate');
title('Error rate for different N0s with rectangular pulse in receiver');

%Part4--------------------------------
a = 1;
for deltaT = [5,8] % 5/20 = T/4 and 8/20 = 2T/5
    count_p4 = zeros(1,10);
    sigma = 1:1:10;
    for j = 1:1:10
        SNR_p4(j) = 1/(2*sigma(j)); %Eb/No
        nt = sqrt(sigma(j)) * randn(1, 20*N);
        %nt = (N0/2)^1/2 * randn(1, 20*N);

        %generating rt
        rt = st + nt;

    %Correlation type receiver
        for i = 1:1:N-1
            r(i) =trapz([20/20:20/20:20],rt( ((i-1)*20+1+deltaT):((i-1)*20+20+deltaT)).* pt);
            % ML Decision rule
            if r(i)<=0
                r_ML(i) = 0;
            else
                r_ML(i) = 1;
            end
            if (r_ML(i) == X(i))
                count_p4(j) = count_p4(j) + 1;
            end
        end
    end

    error_rate_p4(a,:) = 1-(count_p4./N);
    %sa = @(x) triangularPulse(0, 1/2, 1, x) .* sqrt(12);
    %fplot(sa)
    SNR_db_p4(a,:) = 10*log10(SNR_p4);
    figure(5);
    subplot(1,2,a);
    semilogy(SNR_db_p4(a,:), error_rate_p4(a,:));
    xlabel('SNR(dB)');
    ylabel('Error Rate');
    if a ==1
        title('Error rate for different N0s for timing error T/4');
    else
        title('Error rate for different N0s for timing error 2T/5');
    end
    
    
    a = a+1
end







