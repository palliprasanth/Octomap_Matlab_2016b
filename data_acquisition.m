clc
clearvars
close all

count = 0;
map_points_sensor_pos= [];
map_points_laser_data= [];
for iteration = 1:77
    iteration
    if (iteration <= 9)
        temp_str = 'data/scan_00';
    else
        temp_str = 'data/scan_0';
    end
    data_file_pose = strcat([temp_str num2str(iteration) '_robotPoses.dat']) ;
    data_file_points = strcat([temp_str num2str(iteration) '_points.dat']) ;
    %     data_file_far = strcat([temp_str num2str(iteration) '_farRanges.dat']) ;
    
    A = importdata(data_file_pose);
    B = importdata(data_file_points);
    %     C= importdata(data_file_far);
    
    iter=size(B,1);
    map_points_sensor_pos = [map_points_sensor_pos;zeros(iter,3)];
    map_points_laser_data = [map_points_laser_data;zeros(iter,3)];
    %     iter1=size(C,1);
    
    % FOR POSE AND TRANSFORMATION MATRIX
    Transformation_matrix=[eul2rotm([A(2,6) A(2,5) A(2,4)]) A(2,1:3)';0 0 0 1];
    % FOR OBSERVED POINTS IN WORLD COORDINATES
    for j=1:iter
        count = count + 1;
        W_observed_points=Transformation_matrix*[B(j,4:6) 1]';
        W_sensor_points=Transformation_matrix*[B(j,1:3) 1]';
        origin=[W_sensor_points(1) W_sensor_points(2) W_sensor_points(3)];
        endpoint=[W_observed_points(1) W_observed_points(2) W_observed_points(3)];
        distance=norm(endpoint-origin);
        direction=(endpoint-origin)/distance;
        map_points_sensor_pos(count,:) = origin;
        map_points_laser_data(count,:) = endpoint;
    end   
end
Points = pointCloud(map_points_laser_data,'Normal',map_points_sensor_pos);