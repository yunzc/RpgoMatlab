function plotGofInliers(dataFile)
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
    data = sortrows(data, 2);
    % have a col vector of # inliers to thresh
    inliers2thresh = zeros(max(data(:,2)),1);
    i = 1;
    idx = 1;
    samples = 0;
    while (i < max(data(:,2)) + 1)
        i
        idx
        data(idx,2)
        
        if data(idx,2) == i
            inliers2thresh(i,1) = inliers2thresh(i,1) + data(idx,1);
            samples = samples + 1;
            idx = idx + 1;
            if idx > size(data,1)
                inliers2thresh(i,1) = inliers2thresh(i,1)/samples;
                break
            end
        else
            inliers2thresh(i,1) = inliers2thresh(i,1)/samples;
            i = i + 1;
            samples = 0;
        end
    end
    
    goflist = zeros(size(inliers2thresh));
    for i = 1:length(goflist)
        % scale 
        if i == 1 
            goflist(i) = inf;
            continue;
        elseif mod(i,2) == 0
            % even 
            scale = chi2inv(0.5,6)/inliers2thresh(i/2);
        else
            % odd 
            scale = chi2inv(0.5,6)/((inliers2thresh(ceil(i/2)) + inliers2thresh(floor(i/2)))/2);
        end
        
        scaled_data = data;
        scaled_data(:,1) = scaled_data(:,1) * scale;
        % calculate sum of squares error
        gof = 0;
        for j = 1:length(goflist)
            gof = gof + (scaled_data(j,2)/i - chi2cdf(scaled_data(j,1),6))^2 / chi2cdf(scaled_data(j,1),6);
        end
        goflist(i) = 0.5 * gof;
    end
    
    % second term 
    for i = 1:length(goflist)
        % scale 
        if i == 1 
            goflist(i) = inf;
            continue;
        elseif mod(i,2) == 0
            % even 
            scale = chi2inv(0.5,6)/inliers2thresh(i/2);
        else
            % odd 
            scale = chi2inv(0.5,6)/((inliers2thresh(ceil(i/2)) + inliers2thresh(floor(i/2)))/2);
        end
        
        scaled_data = data;
        scaled_data(:,1) = scaled_data(:,1) * scale;
        % calculate sum of squares error
        for j = 1:i%length(goflist)
            goflist(i) = 0.5 * goflist(i) + (scaled_data(j,2)/i - chi2cdf(scaled_data(j,1),6))^2 / chi2cdf(scaled_data(j,1),6);
        end
    end
    
    plot(goflist)
    title("Goodness of fit and number of inliers")
    xlabel("number of inliers")
    ylabel("goodness of fit")
    goflist
end

