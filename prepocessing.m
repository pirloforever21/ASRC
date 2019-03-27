cleaned_data = {};

% Remove missing values
for i = 1:364
    index = find(compile_data_minute{i}(:,5) >= -100 & compile_data_minute{i}(:,6) >= -100 & compile_data_minute{i}(:,11) >= -100 & compile_data_minute{i}(:,12) >= -100 & compile_data_minute{i}(:,13) >= -100 & compile_data_minute{i}(:,14) >= -100 & compile_data_minute{i}(:,15) >= -100 );
    cleaned_data{i} = compile_data_minute{i}(index,:);
end

empty = cellfun('isempty',cleaned_data);
cleaned_data(empty) = [];

% Compile into big matrix
matrix = [];
for i = 1:276
    matrix = [matrix;cleaned_data{i}];
end

% Normalize the data from 0 to 1
m = min(matrix);
M = max(matrix);
norm_matrix = (matrix - repmat(m,76380,1))./ (repmat(M,76380,1) - repmat(m,76380,1));

% Go back to cell format separated by days
norm_data = {};
n(1) = 0;
for i = 1:276
    n(i+1) = size(cleaned_data{i},1); % the observation at ith day
    norm_data{i} = norm_matrix(n(i)+1:n(i) + n(i+1),:);
end