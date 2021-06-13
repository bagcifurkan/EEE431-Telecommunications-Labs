close all, clear all, clc;

%Part5--------------------------------

N = 10000;
X = randi( [0 1], 1, N*4);
V = 1:1:4; % M = 2,4,8,16

for V = 4:1:4 % chosing the V that wanted to run
    M = 2^V;
%Generating s(t)
    for i = 1:1:N
        decimal(i) = 0;
        for j = 1:1:V
            decimal(i) = decimal(i) + 2^(V-j)* X((i-1)*V+j);
            st(i) = (2*decimal(i)-M+1);
        end
    end


    count = zeros(1,10);
    sigma = 1:1:10;
    Ms = -(M-1):2:(M-1);
    for j = 1:1:10
        SNR(j) = 1/(2*sigma(j)); %Eb/No
        nt = sqrt(sigma(j)) * randn(1, 1*N);
        rt = st + nt;
        
        for i = 1:1:N
            
            for m = 2:1:M
                if Ms(m)>= rt(i)
                    break;
                end
            end
            if abs(Ms(m)-rt(i)) < abs(Ms(m-1)-rt(i))
                r_ML(i) = Ms(m);
            else
                r_ML(i) = Ms(m-1);
            end
            % ML Decision rule
            if (r_ML(i) == st(i))
                count(j) = count(j) + 1;
            end
        end
    end
    SNR = [42.50 21.25 14.16 10.62 8.500 7.0833 6.0714 5.312 4.7222 4.2500]
    error_rate = 1-(count./N);
    SNR_db = 10*log10(SNR);
    figure(3);
    semilogy(SNR_db, error_rate);
    xlabel('SNR(dB)');
    ylabel('Error Rate');
    title('Error rate for M = 16');

end
