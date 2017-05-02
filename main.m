clc
clearvars
close all

%This is the root node of the tree
global i
i = 0;
RootNode = OctoNode;
set(RootNode,'index',i);

for iteration = 77:77
    iteration
    if (iteration <= 9)
        temp_str = 'data/scan_00';
    else
        temp_str = 'data/scan_0';
    end
    data_file_pose = strcat([temp_str num2str(iteration) '_robotPoses.dat']) ;
    data_file_points = strcat([temp_str num2str(iteration) '_points.dat']) ;
    data_file_far = strcat([temp_str num2str(iteration) '_farRanges.dat']) ;
    
    A = importdata(data_file_pose);
    B = importdata(data_file_points);
    C= importdata(data_file_far);
    
    iter=size(B,1);
    iter1=size(C,1);
    
    ray = SingleRay;
    % FOR POSE AND TRANSFORMATION MATRIX
    Transformation_matrix=[eul2rotm([A(2,4:6)]) A(2,1:3)';0 0 0 1];
    % FOR OBSERVED POINTS IN WORLD COORDINATES
    for j=1:50:iter
        W_observed_points=Transformation_matrix*[B(j,4:6) 1]';
        W_sensor_points=Transformation_matrix*[B(j,1:3) 1]';
        ray.origin=[W_sensor_points(1) W_sensor_points(2) W_sensor_points(3)]';
        ray.endpoint=[W_observed_points(1) W_observed_points(2) W_observed_points(3)]';
        ray.distance=norm(ray.endpoint-ray.origin);
        ray.direction=(ray.endpoint-ray.origin)/ray.distance;
        ray = ray.calc_inv_direction();
        ray = ray.calc_sign();
        explore_octree(RootNode, ray);
        
        if mod(j,1000)<5
            j
        end
    end
    % FOR  NON OBSERVED POINTS IN WORLD COORDINATES
%     for k=1:iter1
%         W_non_observed_points=Transformation_matrix*[C(k,4:6) 1]';
%         W_non_sensor_points=Transformation_matrix*[C(k,1:3) 1]';
%         ray.origin=[W_non_sensor_points(1) W_non_sensor_points(2) W_non_sensor_points(3)]' ;
%         ray.endpoint=[W_non_observed_points(1) W_non_observed_points(2) W_non_observed_points(3)]';
%         ray.distance=norm(ray.endpoint-ray.origin);
%         ray.direction=(ray.endpoint-ray.origin)/ray.distance;
%         ray = ray.calc_inv_direction();
%         ray = ray.calc_sign();
%         ray.is_in_range = false;
%         explore_octree(RootNode, ray);
%     end
end
disp('OctoMap is Generated. Visualization Started ...')
figure
global a
a = colormap;
visualize_octree(RootNode)
colorbar
view(3)
axis([-OctomapConstants.x_dim_limits,OctomapConstants.x_dim_limits, -OctomapConstants.y_dim_limits, OctomapConstants.y_dim_limits, -OctomapConstants.z_dim_limits, OctomapConstants.z_dim_limits]);
% % First ray comes here
% ray = SingleRay;
% ray.origin = [100;1;1];
% ray.direction = [-1;1;0];
% ray.direction = ray.direction/norm(ray.direction);
% ray.distance = 75;
% ray.endpoint = ray.origin+ray.distance.*(ray.direction);
% ray = ray.calc_inv_direction();
% ray = ray.calc_sign();

