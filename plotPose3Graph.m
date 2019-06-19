function f = plotPose3Graph(poses, edges_id, colorName, titleName, prinfFig, f)

if nargin < 5
  prinfFig = 0;
end

nrNodes = length(poses);
for(i=1:nrNodes) 
  poseMat(i,:) = poses(i).t'; 
end

if nargin < 6 
  f = figure;
end
plot3(poseMat(:,1),poseMat(:,2),poseMat(:,3),'-','color',colorName,'LineWidth',1.5)
hold on
for k=1:size(edges_id,1)
  id1 = edges_id(k,1); id2 = edges_id(k,2); 
  if norm(id1-id2)~=1 % only loop closures
    patchline(poseMat([id1 id2],1),poseMat([id1 id2],2),poseMat([id1 id2],3),'linestyle','-','edgecolor',colorName,'linewidth',1,'edgealpha',0.3);
  end
end
axis equal
axis off
view(3)
drawnow

if(prinfFig == 1)
  disp('Saving figure')
  filename = 'Figures/'+titleName+'.fig';
  saveas(f, filename);
end

title(titleName)