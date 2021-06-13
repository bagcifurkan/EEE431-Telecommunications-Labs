%Funtion for G funtcion
function X = G(U) 
    if(U>=1/2)
        X = (32*U - 16)^(1/4);
    elseif(U<1/2)
        X = -(- 32*U + 16)^(1/4);
    else
        X = 0;
    end
end