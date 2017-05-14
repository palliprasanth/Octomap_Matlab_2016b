function [] = explore_octree(Node, Ray)
% This function is used for initializing the OctoNodes of the Octree which
% are passing through the measurement ray and update the likelihoods at the
% specified depth level

% Node is an OctoNode object
% Ray is a SingleRay object

value = is_ray_intersecting(Node,Ray);
if value == 1
    Node.is_visited = true;
    if (Node.depth < OctomapConstants.max_depth_level)
        Kids = Node.get_children;
        if(isempty(Kids))
            for iter = 1:8
                Temp_Node = OctoNode;
                Temp_Node.parent = Node;
                Temp_Node.set_depth_levels();
                Kids = [Kids; Temp_Node];
            end
            Node.children=Kids;
            Node.set_children_centers();
            for iter = 1:8
                explore_octree(Kids(iter), Ray);
            end
        else
            for iter = 1:8
                explore_octree(Kids(iter), Ray);
            end
        end
    else
        update_likelihood(Node,Ray);
    end
end
end