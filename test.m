function [mae,rmse] = test(net,tein,tetar)

for d = 2 : 10
    x = tein{d};
    t = tetar{d};
    n = length(t);
    y = net(x);
    
     mae(d) = sum(abs(y-t))/n;
    
    rmse(d) = sqrt(sum((y-t).^2)/n);
    
%{
    axis = linspace(1,n,n);
    figure, hold on
    plot(axis,t,'b');
    plot(axis,y,'r');
%}

end


   
