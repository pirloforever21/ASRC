function [trin,trtar,tein,tetar] = prep_arima10(train_days,test_days)

trin = []; trtar = [];
for i = 1:266
    n = size(train_days{i},1);
    for j = 11:n-10
        trin = [trin,train_days{i}(j-10:j,4)];
        trtar = [trtar,train_days{i}(j+10,4)];
    end
end
% Add the first difference as feature
trdiff1 = [];
for i = 1:10
    trdiff1(i,:) = trin(i+1,:) - trin(i,:);
end
trin = [trin;trdiff1];

fprintf('training ios prepared\n');

tein = {}; tetar = {}; tediff1 = {};
for d = 2:10
    
    tein{d} = []; tetar{d} = [];
    m = size(test_days{d},1);
    
    for j = 11:m-10
        tein{d} = [tein{d},test_days{d}(j-10:j,4)];
        tetar{d} = [tetar{d},test_days{d}(j+10,4)];
    end

    tediff1{d} = [];
    for i = 1:10
        
        tediff1{d}(i,:) = tein{d}(i+1,:) - tein{d}(i,:);
    end
    tein{d} = [tein{d};tediff1{d}];
    
end
