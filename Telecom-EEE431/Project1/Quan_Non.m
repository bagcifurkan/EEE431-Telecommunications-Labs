%Quantization function
function Q = Quan_Non(X,N,Xhat)
    n = 500000;
    XQ = rand(1,n);
    for i = 1:1:n
        for j = 1:1:N
            if(X(1,i)<Xhat(j))
                break;
            end
        end
        if (j==1)
            XQ(1,i) =  Xhat(1);
        else
            if (abs(X(1,i)-Xhat(j))>abs(X(1,i)-Xhat(j-1)))
                XQ(1,i) =  Xhat(j-1);
            else
                XQ(1,i) =  Xhat(j);
            end
        end
        if((X(1,i)>Xhat(N)))
            XQ(1,i) =  Xhat(N);
        end
    end
    Q=XQ;
end