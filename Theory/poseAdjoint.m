function adj = poseAdjoint(pose)
rot = pose(1:3,1:3);
trans = pose(1:3,4);
adj = zeros(6,6);
adj(1:3,1:3) = rot; 
adj(4:6,4:6) = rot;
r_wedge = [0 -trans(3,1) trans(2,1); trans(3,1) 0 -trans(1,1); -trans(2,1) trans(1,1) 0];
adj(1:3,4:6) = r_wedge * rot; 
end

