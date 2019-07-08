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
    
    edges = (data(1:length(data)-1,1) + data(2:length(data),1))/2.0;
    edges = [data(1,1) - (edges(1,1) - data(1,1)); edges];
    edges = [edges; data(length(data),1) + (data(length(data),1) - edges(length(edges),1))];
    
    figure();
    h = histogram(histdata, edges);
    xlabel("threshold")
    ylabel("clique size")
    hold on
    height = max(h.Values);
    plot(data(:,1), height * chi2cdf(data(:,1),1), 'r','LineWidth',3)
    legend('# iniers','chi squared cdf','Location','northwest')
end

