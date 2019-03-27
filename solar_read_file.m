format long
files = dir('C:\Users\zy572688\Desktop\Experiments\solar\data\mfrsr_retrieval\*.77');
data = [];
cell_data = cell(1,366);
index = 1;
for file =files'
    filepath=strcat('C:\Users\zy572688\Desktop\Experiments\solar\data\mfrsr_retrieval\',file.name);
    data_i = dlmread(filepath);
    data = [data ; data_i];
    cell_data{index} = data_i;
    index = index + 1;
end
