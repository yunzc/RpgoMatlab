function desiredOrder = orderingEdges(edgesOriginal)
% Arrange edges in the order [odometry; loop closures] and sort the
% odometric in increasing order, e.g., [1 2], [2 3], etc.
% Author: Luca Carlone
% Date: 2014-1-27

m = size(edgesOriginal,1);
n = max ( max(edgesOriginal(:,1)), max(edgesOriginal(:,2)) ) - 1;
odometricOrder = zeros(n,1); 
for i=1:n
  ind_edge_i = find(edgesOriginal(:,1)==i & edgesOriginal(:,2)==i+1);
  if length(ind_edge_i)~=1
    error('sortEdges: missing, inverted, or multiple edge!')
  end
  odometricOrder(i) = ind_edge_i;
end
loopOrder = setdiff([1:m],odometricOrder); % loop closures
odometricOrder = odometricOrder(:); loopOrder = loopOrder(:);

desiredOrder = [odometricOrder; loopOrder];