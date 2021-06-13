%Funtion for evaluating the MSE theoratically
function output = MSE(N,p)
    delta = (255/N);
    Xhat = [];
    Ai = [];
    for i=1:1:N
        Xhat(i) = (i-1/2)*delta;
    end
    for i=1:1:N+1
        Ai(i) = (i-1)*delta;
    end
    D = 0;
    syms x
    for i=1:1:N
        fun =  ((x-Xhat(i))^2 ) * (polyval(p,x)) ;
        D = D + integral( fun, Ai(i), Ai(i+1));
    end
    output = D;
end
