function f = plotG2oDataset3D(input_file_g2o, orderEdgesFlag)
[measurements, edges_id, poses] = readG2oDataset3D(input_file_g2o, orderEdgesFlag);
f = figure();
plotPose3Graph(poses, edges_id, 'r', "FactorGraph", 1, f);
