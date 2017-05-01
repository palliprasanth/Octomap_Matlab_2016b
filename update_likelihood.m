function Node = update_likelihood(Node,Ray)
temp = Node.log_likelihood + inv_sensor_model(Node,Ray);
value = max([min([temp OctomapConstants.l_max]) OctomapConstants.l_min]);
Node = Node.set_log_likelihood(value)
end