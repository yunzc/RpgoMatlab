function plotCliqueSize(dataFile)
    % Read from datafile 
    fid = fopen(dataFile);
    line = fgetl(fid);
    row = str2num(line);
    data = row;
    while ~feof(fid)
        line = fgetl(fid);
        row = str2num(line);
        data = [data; row];
    end
    data = sortrows(data, 1);
    histdata = [];
    for i = 1:length(data)
        for j = 1:data(i,2)
            histdata = [histdata, data(i,1)];
        end
    end
    
    widths = data(2:length(data),1) - data(1:length(data)-1,1);
    widths = nonzeros(widths);
    binwidth = min(widths);
        
    
    figure();
    h = histogram(histdata, 'BinWidth', binwidth);
    xlabel("threshold")
    ylabel("clique size")
end

