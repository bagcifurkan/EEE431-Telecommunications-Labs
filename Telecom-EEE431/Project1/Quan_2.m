%Quantization function for Image
function Q = Quan_2(X,N)
    delta = (255/N);
    Xhat = [];
    for i=1:1:N
        Xhat(i) =uint8((i-1/2)*delta);
    end
    
    m = size(X,1);
    n = size(X,2);
    XQ = uint8(rand(m,n));
    
    for i = 1:1:m
        for k = 1:1:n
            for j = 1:1:N
                if(X(i,k)<Xhat(j))
                    break;
                end
            end
            
            if(j == 1)
                XQ(i,k) =  Xhat(1);
            
            elseif (j >1)
                if( ( Xhat(j) - X(i,k) ) >  ( X(i,k)-Xhat(j-1) ) )
                    XQ(i,k) =  Xhat(j-1);
                else
                    XQ(i,k) =  Xhat(j);
                end
            end
            
            if( (X(i,k) > Xhat(N)) )
                XQ(i,k) =  Xhat(N);
            end
             
        end
    end
    Q=uint8(XQ);
    %disp(Xhat);
end