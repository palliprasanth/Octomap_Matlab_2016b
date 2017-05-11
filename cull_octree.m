function [] = cull_octree(Node)
Kids = Node.get_children;

if (isempty(Kids))
    Node.is_culled = true;
    return
end

if (Node.depth < OctomapConstants.max_depth_level)
    cull_check = Kids(1).is_culled;
    if cull_check == false
        for iter = 1:8
            cull_octree(Kids(iter));
        end
        cull_octree(Node)
    else
        val = true;
        for iter = 1:8
            val1 = logical(val & (Kids(iter).log_likelihood > OctomapConstants.culling_threshold));
            val2 = logical(val & (Kids(iter).log_likelihood < OctomapConstants.culling_threshold));
        end
        if val1 == true
            Node.is_culled = true;
            Node.log_likelihood = OctomapConstants.l_max;
            for iter = 1:8
                delete(Kids(iter));
            end
            return
        elseif val2 == true
            Node.is_culled = true;
            Node.log_likelihood = OctomapConstants.l_min;
            for iter = 1:8
                delete(Kids(iter));
            end
            return
        else
            Node.is_culled = true;
            return
        end
    end
end
end