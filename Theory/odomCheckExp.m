poseA = eye(4);
covA = zeros(6,6);
poseOdom = eye(4);
poseOdom(1:3,4) = [1;0;0];
poseOdom(1:3,1:3) = [0 -1 0; 1 0 0; 0 0 1];
covOdom = 0.1*eye(6);

poseB = poseA;
covB = covA;
for i = 1:3
    [poseB, covB] = poseCompose(poseB, covB, poseOdom, covOdom);
end

poseLc1 = eye(4);
poseLc1(1:3,4) = [0.8;0;0];
poseLc1(1:3,1:3) = eul2rotm([1.51 0 0]);
covLc1 = 0.1 * eye(6);

[poseRes, covRes] = poseCompose(poseB, covB, poseLc1, covLc1)

mahDist1 = sqrt(logmap(poseRes)' * inv(covRes) * logmap(poseRes))

poseLc2 = eye(4);
poseLc2(1:3,4) = [0.8;0;0];
poseLc2(1:3,1:3) = eul2rotm([1.51 0 0]);
covLc2 = 0.05 * eye(6);

[poseRes2, covRes2] = poseCompose(poseB, covB, poseLc2, covLc2);

mahDist2 = sqrt(logmap(poseRes2)' * inv(covRes2) * logmap(poseRes2))