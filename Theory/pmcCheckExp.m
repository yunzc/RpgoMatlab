poseA = eye(4);
covA = zeros(6,6);
poseOdom = eye(4);
poseOdom(1:3,4) = [1;0;0];
poseOdom(1:3,1:3) = [0 -1 0; 1 0 0; 0 0 1];
covOdom = 0.1*eye(6);

poseB = poseA;
covB = covA;
for i = 1:2
    [poseB, covB] = poseCompose(poseB, covB, poseOdom, covOdom);
end

poseOdom(1:3,1:3) = eye(3);
for i = 1:4
    [poseB, covB] = poseCompose(poseB, covB, poseOdom, covOdom);
    if i == 1
        pose1 = poseB;
        cov1 = covB;
    elseif i == 2
        pose2 = poseB;
        cov2 = covB;
    elseif i == 3
        pose3 = poseB;
        cov3 = covB;
    end
end

% to good loop closures as base
poseLc1 = eye(4);
poseLc1(1:3,4) = [0;0.9;0];
poseLc1(1:3,1:3) = eul2rotm([3.1416 0 0]);
covLc1 = 0.1 * eye(6);

poseLc2 = eye(4);
poseLc2(1:3,4) = [-1;0.8;0];
poseLc2(1:3,1:3) = eul2rotm([3.1416 0 0]);
covLc2 = 0.1 * eye(6);

% at this point the adj matrix should be something like 
% [0 1 ; 1 0]

% now add another one that's somewhat consistent with the last 2 
poseLc3 = eye(4);
poseLc3(1:3,4) = [-1.8;0.8;0];
poseLc3(1:3,1:3) = eul2rotm([0.99*3.1416 0 0]);
covLc3 = 0.1 * eye(6);

% check dist with lc1
[pose13, cov13] = poseBetween(pose1, cov1, pose3, cov3);
[poseRes, covRes] = poseCompose(pose13, cov13, poseLc3, covLc3);
[poseRes, covRes] = poseCompose(poseRes, covRes, inv(poseLc1), covLc3);

mahDist31 = sqrt(logmap(poseRes)' * inv(covRes) * logmap(poseRes))

% check dist with lc2
[pose23, cov23] = poseBetween(pose2, cov2, pose3, cov3);
[poseRes, covRes] = poseCompose(pose23, cov23, poseLc3, covLc3);
[poseRes, covRes] = poseCompose(poseRes, covRes, inv(poseLc2), covLc2);

mahDist32 = sqrt(logmap(poseRes)' * inv(covRes) * logmap(poseRes))

% if wee set threshold to be 0.18 the adj matrix should be 
% [0 1 1 ; 1 0 1; 0 0 1] 

% now add another one that's somewhat not consistent with all the last 2 
poseLc4 = eye(4);
poseLc4(1:3,4) = [-2.6;0.6;0];
poseLc4(1:3,1:3) = eul2rotm([0.98*3.1416 0 0]);
covLc4 = 0.1 * eye(6);

% check dist with lc1
[pose14, cov14] = poseBetween(pose1, cov1, poseB, covB);
[poseRes, covRes] = poseCompose(pose14, cov14, poseLc4, covLc4);
[poseRes, covRes] = poseCompose(poseRes, covRes, inv(poseLc1), covLc4);

mahDist41 = sqrt(logmap(poseRes)' * inv(covRes) * logmap(poseRes))

% check dist with lc2
[pose24, cov24] = poseBetween(pose2, cov2, poseB, covB);
[poseRes, covRes] = poseCompose(pose24, cov24, poseLc4, covLc4);
[poseRes, covRes] = poseCompose(poseRes, covRes, inv(poseLc2), covLc2);

mahDist42 = sqrt(logmap(poseRes)' * inv(covRes) * logmap(poseRes))

% check dist with lc3
[pose34, cov34] = poseBetween(pose3, cov3, poseB, covB);
[poseRes, covRes] = poseCompose(pose34, cov34, poseLc4, covLc4);
[poseRes, covRes] = poseCompose(poseRes, covRes, inv(poseLc3), covLc3);

mahDist43 = sqrt(logmap(poseRes)' * inv(covRes) * logmap(poseRes))

% if we set threshold as 0.15, will not take loop closure 4 as inlier
