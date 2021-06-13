%Quantization function
function [Ai,Q] = Quan(X,N)
    delta = (4/N);
    Xhat = [];
    Ai = [];
    for i=1:1:N
        Xhat(i) = -2 + (i-1/2)*delta;
    end
    for i=1:1:N+1
        Ai(i) = -2 + (i-1)*delta;
    end
    n = 500000;
    XQ = rand(1,n);
    
    for i = 1:1:n
        for j = 1:1:N+1
            if(X(1,i)<Ai(j))
                break;
            end
        end
         XQ(1,i) =  Xhat(j-1);
    end
    Q=XQ;
    Ai = Ai;
    %disp(Xhat);
end
