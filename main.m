%This is the root node of the tree
data_acquisition % This script is used for acquiring the data from the laser scans and generating a point cloud for origin and end points of the sensor rays
RootNode = OctoNode; %This is the rootNode for the Octree
RootNode.center = [75;-60;12]; %This is the center of the cuboid in 3D space.
%Currently mapping around the region for pose 4.

%  load pointclouds.mat
 gridstep = 1;
 Points = pointCloud(map_points_laser_data,'Normal',map_points_sensor_pos);
 Points = pcdownsample(Points,'gridAverage',gridstep);
 % The obtained point cloud is downsampled using the above function.
 
 % For all the sensor measurements, the raay objects are used and these are
 % used for updating the octree.
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
disp('OctoMap is Generated. Visualization Started ...')
figure
global a
a = colormap;
visualize_octree(RootNode)
colorbar
view(3)
axis([RootNode.center(1)-OctomapConstants.x_dim_limits,RootNode.center(1)+OctomapConstants.x_dim_limits, RootNode.center(2)-OctomapConstants.y_dim_limits, RootNode.center(2)+OctomapConstants.y_dim_limits, RootNode.center(3)-OctomapConstants.z_dim_limits, RootNode.center(3)+OctomapConstants.z_dim_limits]);

% This function returns the maximum likelihood of the nodes within the
% sub-tree at the specified depth level.
Query_Point = [100;15;8];
likelihood_query(Query_Point,4,RootNode);

% This function prunes the crrent octree. However, the other functions are
% not developed to work on the pruned octree. So, this is done at the last.
cull_octree(RootNode)
