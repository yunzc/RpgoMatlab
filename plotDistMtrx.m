function plotDistMtrx(distMatrxFile, numOutliers, binwidth)
distMatrx = [];
% Assume outliers are on last few entries
    fid = fopen(distMatrxFile);
    line1 = fgetl(fid);
    row = str2num(line1);
    distMatrx = [distMatrx; row];
    [r, num_lc] = size(row);
    i = 1;
    while i < num_lc
        line1 = fgetl(fid);
        row = str2num(line1);
        distMatrx = [distMatrx; row];
        i = i + 1;
    end
    fclose(fid);
    inliers = [];
    outliers = [];
    for i = 1:num_lc
        for j = i+1:num_lc
            if (i ~= j)
                if (j < (num_lc - numOutliers + 1))
                    inliers = [inliers distMatrx(i,j)];
                else
                    outliers = [outliers distMatrx(i,j)];
                end
            end
        end
    end
    titlestring = string(numOutliers) + " outliers";
    histogram(inliers, 'BinWidth', binwidth)
    hold on 
    histogram(outliers, 'BinWidth', binwidth)
    legend('inliers distances','outliers distances')
    title(titlestring)
end

