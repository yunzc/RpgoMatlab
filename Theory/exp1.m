%% Long loop test
first_cov = zeros(6,6);
first_pose = eye(4);
first_pose(1:3,4) = ones(3,1);

A_cov = first_cov;
A_pose = first_pose;

for i = 1:100
    AB_pose = eye(4);
    AB_pose(1:3,4) = ones(3,1);
    AB_cov = 0.1*zeros(6,6);
    AB_cov(1:3,1:3) = 0.1*eye(3);
    [A_pose, A_cov] = poseCompose(A_pose, A_cov, AB_pose, AB_cov);
end

[posecheck, covcheck] = poseBetween(first_pose, first_cov, A_pose, A_cov);

