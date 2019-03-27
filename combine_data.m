compile_data_minute = {};
for i = 1:116
    N = size(cell_data{i},1);
    temp = [];
    avg = [];
    diff = [];
    diff = cell_meteodata{i}(:,1)-repmat(cell_data{i}(1,1),1440,1);
    [closest(i),index] = min(abs(diff));
    for j = 1:floor(N/3)
        if index+j-1 >= size(cell_meteodata{i},1)
            continue;
        end
        avg = mean(cell_data{i}(3*j-2:3*j,:));
        temp = [temp;[avg(:,[1,2,3,4,12,15,39]),cell_meteodata{i}(index+j-1,1:8)]];
    end
    compile_data_minute{i} = temp;
end

% cell_data(Radiation) missing April 26th and 27th
for i = 117:364
    N = size(cell_data{i},1);
    
    temp = [];
    avg = [];
    diff = [];
    diff = cell_meteodata{i+2}(:,1)-repmat(cell_data{i}(1,1),1440,1);
    [closest(i),index] = min(abs(diff));
    for j = 1:floor(N/3)
        if index+j-1 >= size(cell_meteodata{i},1)
            continue;
        end
        avg = mean(cell_data{i}(3*j-2:3*j,:));
        temp = [temp;[avg(:,[1,2,3,4,12,15,39]),cell_meteodata{i+2}(index+j-1,1:8)]];
    end
    compile_data_minute{i} = temp;
end

