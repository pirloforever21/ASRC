function [trin,trtar,tein,tetar] = prep_bin(train_days,test_days)
%%
% Prepare the Training Series
train_series = [];

for i = 1:size(train_days,2)
    
    N = size(train_days{i},1);
    for j = 1:N

        train_series = [train_series;train_days{i}(j,[2,4])];
    
    end
end

fprintf('training series prepared\n');

M = size(train_series,1);

% Create bins for sza
train_bin = [];

for i = 1:M
    
    switch floor(train_series(i,1)) % convert into integer
        case num2cell(1:10)
            train_bin(i,:) = [1,0,0,0,0,0,0,0,0];
        case num2cell(11:20)
            train_bin(i,:) = [0,1,0,0,0,0,0,0,0];
        case num2cell(21:30)
            train_bin(i,:) = [0,0,1,0,0,0,0,0,0];
        case num2cell(31:40)
            train_bin(i,:) = [0,0,0,1,0,0,0,0,0];
        case num2cell(41:50)
            train_bin(i,:) = [0,0,0,0,1,0,0,0,0];
        case num2cell(51:60)
            train_bin(i,:) = [0,0,0,0,0,1,0,0,0];
        case num2cell(61:70)
            train_bin(i,:) = [0,0,0,0,0,0,1,0,0];
        case num2cell(71:80)
            train_bin(i,:) = [0,0,0,0,0,0,0,1,0];
        case num2cell(81:90)
            train_bin(i,:) = [0,0,0,0,0,0,0,0,1];
        otherwise
            train_bin(i,:) = [0,0,0,0,0,0,0,0,0];
    end
end
    
% Prepare Training inputs and targets
trin = [];
trtar = [];

for k = 1:M-9
    trin = [trin;[train_series(k,2),train_bin(k,:)]];
    trtar = [trtar;train_series(k+9,2)];
    if mod(k,10000) == 0 
        disp(k);
    end
end

trin = trin';
trtar = trtar';

fprintf('training inputs and targets prepared\n')

%%
% Prepare the test series
test_series = {};

% Prepare the test input and output
tein = {};
tetar = {};
test_bin = {};

for i = 1:10
    
    NN = size(test_days{i},1);
        
    test_series{i} = [];
    
    for j = 1:NN
        test_series{i} = [test_series{i};test_days{i}(j,[2,4])];
    end
    
    fprintf('test day series prepared\n',i)
    
    % Create bin for test data
    test_bin{i} = [];
    
    for ll = 1:NN
    
        switch floor(test_series{i}(ll,1)) % convert into integer
            case num2cell(1:10)
                test_bin{i}(ll,:) = [1,0,0,0,0,0,0,0,0];
            case num2cell(11:20)
                test_bin{i}(ll,:) = [0,1,0,0,0,0,0,0,0];
            case num2cell(21:30)
                test_bin{i}(ll,:) = [0,0,1,0,0,0,0,0,0];
            case num2cell(31:40)
                test_bin{i}(ll,:) = [0,0,0,1,0,0,0,0,0];
            case num2cell(41:50)
                test_bin{i}(ll,:) = [0,0,0,0,1,0,0,0,0];
            case num2cell(51:60)
                test_bin{i}(ll,:) = [0,0,0,0,0,1,0,0,0];
            case num2cell(61:70)
                test_bin{i}(ll,:) = [0,0,0,0,0,0,1,0,0];
            case num2cell(71:80)
                test_bin{i}(ll,:) = [0,0,0,0,0,0,0,1,0];
            case num2cell(81:90)
                test_bin{i}(ll,:) = [0,0,0,0,0,0,0,0,1];
            otherwise
                test_bin{i}(ll,:) = [0,0,0,0,0,0,0,0,0];
        end
    end
    
    tein{i} = [];
    tetar{i} = [];
    
    for k = 1:NN-9
        
        tein{i} = [tein{i};[test_series{i}(k,2),test_bin{i}(k,:)]];
        tetar{i} = [tetar{i};test_series{i}(k+9,2)];

    end
    
    tein{i} = tein{i}';
    tetar{i} = tetar{i}';
    
    fprintf('test day %d inputs targets prepared\n',i)
    
end
