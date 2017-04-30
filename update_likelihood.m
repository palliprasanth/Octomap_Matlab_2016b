function Node = update_likelihood(Node,Ray)
temp = Node.log_likelihood + inv_sensor_model(Node,Ray);
Node.log_likelihood = max([min([temp OctomapConstants.l_max]) OctomapConstants.l_min]);
end