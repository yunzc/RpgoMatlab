function [pose cov] = poseBetween(pose1, cov1, pose2, cov2)
pose = inv(pose1) * pose2; 
t2 = poseAdjoint(pose);

cov = cov2 - t2 * cov1 * t2';
end