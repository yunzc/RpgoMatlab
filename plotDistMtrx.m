function plotDistMtrx(distMatrxFile, numOutliers, binwidth)
distMatrx = [];
dof = 3;
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
    histogram(inliers, 'BinWidth', binwidth);
    hold on 
    histogram(outliers, 'BinWidth', binwidth);
    legend('inliers distances','outliers distances')
    title(titlestring)
    hold off 
    figure();
    data = [inliers outliers];
    h = histogram(data, 'BinWidth', binwidth,'Normalization','pdf');
    h_centers = h.BinEdges(1:length(h.BinEdges)-1) + binwidth/2.0;
    hold on
    [phat, pci] = mle(data,'distribution','gamma','beta',2);
    gamma_x = h_centers(1):binwidth/10.0:h_centers(length(h_centers));
    plot(gamma_x, gampdf(gamma_x, phat(1), phat(2)), 'LineWidth',5);
    plot(gamma_x, chi2pdf(gamma_x, dof), '--', 'LineWidth',3);
    disp("gamma fit result with corresponding chi squared for degree of freedom")
    legend('distances','gamma fit', 'chi squared with app dof')
    phat
    pci
    title("distribution")
end

