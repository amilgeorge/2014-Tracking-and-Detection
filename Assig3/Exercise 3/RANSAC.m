function [M, inliers] = RANSAC(x,s,t)
maxTrials = 1000;
maxDataTrials = 100;
[rows, npts] = size(x);
p = 0.99;
bestM = NaN;
trialcount = 0;
bestscore =  0;
N = 1;    
while N > trialcount        
    % select random s datapoints
    count = 1;
    if ~exist('randsample', 'file')
            ind = randomsample(npts, s);
        else
            ind = randsample(npts, s);
        end
    M = Fitting(x(:,ind));
    count = count + 1;
    if count > maxDataTrials
        break
    end
    [inliers,M] = Dist(M,x,t);
    ninliers = length(inliers);

    if ninliers > bestscore 
        bestscore = ninliers;
        bestinliers = inliers;
        bestM = M;
        fracinliers =  ninliers/npts;
        pNoOutliers = 1 -  fracinliers^s;
        pNoOutliers = max(eps, pNoOutliers);
        pNoOutliers = min(1-eps, pNoOutliers);
        N = log(1-p)/log(pNoOutliers);
    end

    trialcount = trialcount+1;
end
if ~isnan(bestM)
    M = bestM;
    inliers = bestinliers;
else
    M = [];
    inliers = [];
    error('No Optimal solution');
end
