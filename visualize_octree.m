function [] = visualize_octree(Node)
if (Node.depth < OctomapConstants.max_depth_level)
    Kids = Node.get_children;
    if(~isempty(Kids))
        for iter = 1:8
            visualize_octree(Kids(iter));
        end
    end
else
    if (Node.is_visited)
        if (Node.log_likelihood >=OctomapConstants.occ_threshold)
            cube_visualization(Node);
        end
    end
end