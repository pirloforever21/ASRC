function [trin,trtar,tein,tetar] = prep_meteo(train_days,test_days)

trin = []; trtar = [];
for i = 1:266
    n = size(train_days{i},1);
    for j = 1:n-10
        trin = [trin;train_days{i}(j,[2:7,9:15])];
        trtar = [trtar;train_days{i}(j+10,4)];
    end
end
trin = trin';
trtar = trtar';

fprintf('training ios prepared\n');

tein = {}; tetar = {};
for d = 2:10
    
    tein{d} = []; tetar{d} = [];
    m = size(test_days{d},1);
    
    for j = 1:m-10
        tein{d} = [tein{d};test_days{d}(j,[2:7,9:15])];
        tetar{d} = [tetar{d};test_days{d}(j+10,4)];
    end
    
    tein{d} = tein{d}';
    tetar{d} = tetar{d}';
end
        