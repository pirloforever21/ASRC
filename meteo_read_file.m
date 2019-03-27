format long
files = dir('C:\Users\zy572688\Desktop\Experiments\solar\data\Surface meteo Data\*.66');
meteodata = [];
cell_meteodata = cell(1,366);
index = 1;
for file =files'
    filepath=strcat('C:\Users\zy572688\Desktop\Experiments\solar\data\Surface meteo Data\',file.name);
    meteodata_i = dlmread(filepath);
    meteodata = [meteodata ; meteodata_i];
    cell_meteodata{index} = meteodata_i;
    index = index + 1;
end