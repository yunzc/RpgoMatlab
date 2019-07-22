function plotCliqueSize(dataFile)
    % Read from datafile 
    fid = fopen(dataFile);
    line = fgetl(fid);
    row = str2num(line);
    data = row;
    while ~feof(fid)
        line = fgetl(fid);
        row = str2num(line);
        row(1,1) = row(1,1)^2;
        exists = false;
        for i = 1:size(data,1)
            if row(1,1) == data(i,1)
                exists = true;
                break
            end
        end
        if ~exists
            data = [data; row];
        end
    end
    data(:,1) = data(:,1);
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
%     binwidth = min(data(2:length(data),1) - data(1:length(data)-1,1));
    
    figure();
    h = histogram(histdata, edges);

    xlabel("threshold^2")
    ylabel("clique size")
    hold on
    height = max(h.Values);
    plot(data(:,1), height * chi2cdf(data(:,1),6), 'r','LineWidth',3)
    legend('# iniers','chi2 cdf 6','Location','northwest')
    
    % calculate sum of squares error
    gof = 0;
    for i = 1: size(data,1)
        gof = gof + (data(i,2)/height - chi2cdf(data(i,1),6))^2 / chi2cdf(data(i,1),6);
    end
    gof

end

