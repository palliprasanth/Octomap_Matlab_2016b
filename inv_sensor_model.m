function [log_likelihood] = inv_sensor_model(Node,Ray)
% This function returns the log-likelihood value given a Node and a
% measurement ray. Depends if the Node is occupied or free.

% Node is an OctoNode object
% Ray is a SingleRay object

if (Ray.is_in_range == true)
    if is_point_in_node(Node,Ray.endpoint)
        log_likelihood = OctomapConstants.l_occupied;
    else
        log_likelihood = OctomapConstants.l_free;
    end
else
    log_likelihood = OctomapConstants.l_free;
end
end