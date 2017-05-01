classdef OctomapConstants
    properties (Constant)
        dim_limits = 100; % limits of the dimensions in metres
        l_free = -0.4; % Corresponds to probability of 0.4
        l_occupied = 0.85; % Corresponds to probability of 0.7
        l_min = -2; % Corresponds to probability of 0.12
        l_max = 3.5; % Corresponds to probability of 0.97
        max_depth_level = 5;
        occ_threshold = prob_to_log_likely(0.6);
    end
end