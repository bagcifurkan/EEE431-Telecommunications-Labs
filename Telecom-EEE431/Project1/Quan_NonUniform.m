%Non Uniform Quantization, Update the Xhat and Ai s
function [Ai,Xhat] = Quan_NonUniform(X,N,Ai)
    Xhat = 1:N;
    for i=N/2+2:1:N+1   
        integral1 = Ai(i)^5/40-Ai(i-1)^5/40;
        integral2 = Ai(i)^4/32-Ai(i-1)^4/32;
        Xhat(i-1) = integral1/integral2;  
    end
    for i = 1:1:N/2
        Xhat(i) = - Xhat(N+1-i) ;
    end
    %disp(Xhat);
    for i = 1:1:N-1
        Ai(i+1) =  (Xhat(i+1)+Xhat(i))/2;
    end
    %disp(Ai);
    Ai = Ai;
    Xhat = Xhat;
    
end