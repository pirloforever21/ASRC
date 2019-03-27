function [train_days,test_days,N] = seperate_train_test(norm_data)

N = randi(276,1,10);
for i = 1:276
    if ismember(i,N) == 1 
        test_days{i} = norm_data{i};
    else
        train_days{i} = norm_data{i};
    end
end
empty = cellfun('isempty',test_days);
test_days(empty) = [];
empty = cellfun('isempty',train_days);
train_days(empty) = [];

for i = 1:10
    s = size(test_days{i},1);
    t = linspace(1,s,s);
    scatter(t,test_days{i}(:,4))
    pause
end 

