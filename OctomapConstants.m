classdef OctomapConstants
    % This class has all the global constants which the user can specify
    properties (Constant)
        x_dim_limits = 175; % limits of the dimensions in metres
        y_dim_limits = 100; % limits of the dimensions in metres
        z_dim_limits = 10; % limits of the dimensions in metres
        l_free = -0.4; % Corresponds to probability of 0.4
        l_occupied = 0.85; % Corresponds to probability of 0.7
        l_min = -2; % Corresponds to probability of 0.12
        l_max = 3.5; % Corresponds to probability of 0.97
        max_depth_level = 8; % Depth_Level chosen for resolution
        occ_threshold = prob_to_log_likely(0.5);
        culling_threshold = prob_to_log_likely(0.5); 
    end
end