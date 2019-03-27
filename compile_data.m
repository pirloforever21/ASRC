compile_data_minute = {};
for i = 1:116
    N(i) = size(cell_data{i},1);
    temp = [];
    avg = [];
    diff{i} = cell_meteodata{i}(:,1)-repmat(cell_data{i}(1,1),1440,1);
    [closest(i),index(i)] = min(abs(diff{i}));
    
    for j = 1:min(floor(N(i)/3),1440-index(i)+1)
        avg = mean(cell_data{i}(3*j-2:3*j,:));
        temp = [temp;[avg(:,[1,2,3,4,39]),cell_meteodata{i}(index(i)+j-1,1:8)]];
    end
    compile_data_minute{i} = temp;
end
for i = 119:366
    N(i) = size(cell_data{i},1);
    temp = [];
    avg = [];
    diff{i} = cell_meteodata{i}(:,1)-repmat(cell_data{i}(1,1),1440,1);
    [closest(i),index(i)] = min(abs(diff{i}));
    
    for j = 1:min(floor(N(i)/3),1440-index(i)+1)
        avg = mean(cell_data{i}(3*j-2:3*j,:));
        temp = [temp;[avg(:,[1,2,3,4,39]),cell_meteodata{i}(index(i)+j-1,1:8)]];
    end
    compile_data_minute{i} = temp;
end
