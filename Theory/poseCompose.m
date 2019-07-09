function [pose cov] = poseCompose(pose1, cov1, pose2, cov2)
pose = pose1 * pose2; 
t2 = poseAdjoint(pose2);

cov = t2 * cov1 * t2' + cov2;
end