function f = plotG2oDataset2D(input_file_g2o, orderEdgesFlag)
[edges, poses, ~,~,~] = readG2oDataset2D(input_file_g2o, orderEdgesFlag);
f = figure();
plotPose2Graph(poses, edges, 'r', "FactorGraph", 1, f);