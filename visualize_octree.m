function [] = visualize_octree(Node)
%This node is used to visualize the octree. In this function, the tree is
%traversed till the final depth level is reached and these nodes are
%visualized.

%Node is an octonode object

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