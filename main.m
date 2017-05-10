%This is the root node of the tree
% data_acquisition
% global i
% i = 0;
RootNode = OctoNode;
RootNode.center = [75;-60;12]; %For pose 4
% set(RootNode,'index',i);

 load pointclouds.mat
 gridstep = 0.5;
 Points = pointCloud(map_points_laser_data,'Normal',map_points_sensor_pos);
 Points = pcdownsample(Points,'gridAverage',gridstep);
 tic
for iteration = 1:size(Points.Location,1)
    ray = SingleRay;
    ray.origin=[Points.Normal(iteration,1) Points.Normal(iteration,2) Points.Normal(iteration,3)]';
    ray.endpoint=[Points.Location(iteration,1) Points.Location(iteration,2) Points.Location(iteration,3)]';
    ray.distance=norm(ray.endpoint-ray.origin);
    ray.direction=(ray.endpoint-ray.origin)/ray.distance;
    ray = ray.calc_inv_direction();
    ray = ray.calc_sign();
    explore_octree(RootNode, ray);
    if mod(iteration,1000)==0
    iteration
    end
end
toc
disp('OctoMap is Generated. Visualization Started ...')
figure
global a
a = colormap;
visualize_octree(RootNode)
colorbar
view(3)
axis([RootNode.center(1)-OctomapConstants.x_dim_limits,RootNode.center(1)+OctomapConstants.x_dim_limits, RootNode.center(2)-OctomapConstants.y_dim_limits, RootNode.center(2)+OctomapConstants.y_dim_limits, RootNode.center(3)-OctomapConstants.z_dim_limits, RootNode.center(3)+OctomapConstants.z_dim_limits]);