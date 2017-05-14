function Node = update_likelihood(Node,Ray)
% This function is used for updating the likelihood of a Node
% given the sensor measurement.
% A clamping policy is used for adapting to dynamic changes

% Node is an Octonode object
% Ray is a Single Ray object
temp = Node.log_likelihood + inv_sensor_model(Node,Ray);
value = max([min([temp OctomapConstants.l_max]) OctomapConstants.l_min]);
Node = Node.set_log_likelihood(value);
end