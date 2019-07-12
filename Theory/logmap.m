function logvect = logmap(pose)
% Compute logmap of a pose
C = pose(1:3,1:3);
% compute rotation part first
% rotation axis a 
[V,D] = eig(C);
eigenvals = diag(D);
for i = 1:length(eigenvals)
    if abs(i - 1) < 0.001
        a = V(:,i);
    end
end
% then find angle 
phi = acos((trace(C) - 1)/2.0);
% log map of SO3 part
eps = phi * a; 
% translation part
if phi == 0
    rho = pose(1:3,4);
else
    Jinv = phi/2 * cot(phi/2) * eye(3) + (1 - phi/2 * cot(phi/2)) * a * a' - phi/2 * [0 -a(3,1) a(2,1); a(3,1) 0 -a(1,1); -a(2,1) a(1,1) 0];
    rho = Jinv * pose(1:3,4);
end
logvect = real([rho ; eps]);
end

