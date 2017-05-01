iteration = 1;

data_file_pose = strcat(['scan_00' num2str(iteration) '_robotPoses.dat']) ;
data_file_points = strcat(['scan_00' num2str(iteration) '_points.dat']) ;
data_file_far = strcat(['scan_00' num2str(iteration) '_farRanges.dat']) ;

A = importdata(data_file_pose);
B = importdata(data_file_points);
C= importdata(data_file_far);

iter=size(B,1);
iter1=size(C,1);

% FOR POSE AND TRANSFORMATION MATRIX
Transformation_matrix=[eul2rotm([A(2,4:6)]) A(2,1:3)';0 0 0 1];
% FOR OBSERVED POINTS IN WORLD COORDINATES
for j=1:iter
    W_observed_points=Transformation_matrix*[B(j,4:6) 1]';
    W_sensor_points=Transformation_matrix*[B(j,1:3) 1]';
    origin=[W_sensor_points(1) W_sensor_points(2) W_sensor_points(3)];
    endpoint=[W_observed_points(1) W_observed_points(2) W_observed_points(3)];
    distance=norm(endpoint-origin);
    direction=(endpoint-origin)/distance;
end

% FOR  NON OBSERVED POINTS IN WORLD COORDINATES
for k=1:iter1
    W_non_observed_points=Transformation_matrix*[C(k,4:6) 1]';
    W_non_sensor_points=Transformation_matrix*[C(k,1:3) 1]';
    origin=[W_non_sensor_points(1) W_non_sensor_points(2) W_non_sensor_points(3)] ;
    endpoint=[W_non_observed_points(1) W_non_observed_points(2) W_non_observed_points(3)];
    distance=norm(endpoint-origin);
    direction=(endpoint-origin)/distance;
end
