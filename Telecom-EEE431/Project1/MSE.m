%Finding the analytically MSE for Uniform Quantization
function output = MSE(N)
    delta = (4/N);
    Xhat = [];
    Ai = [];
    for i=1:1:N
        Xhat(i) = -2 + (i-1/2)*delta;
        Ai(i) = -2 + i*delta;
    end
    D = 0;
    for i=N/2+1:1:N
        D = D+ (Ai(i)^6/48-Ai(i)^5/20*Xhat(i)+Ai(i)^4/32*Xhat(i)^2)-(Ai(i-1)^6/48-Ai(i-1)^5/20*Xhat(i)+Ai(i-1)^4/32*Xhat(i)^2);
    end
    output = D*2;
end
