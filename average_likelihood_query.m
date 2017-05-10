function value = average_likelihood_query(Node,Point,Depth_Level)
Kids = Node.get_children;
Cur_depth = Node.depth + 1;
if (isempty(Kids))
    value = 0;
    return
end
if (Cur_depth >= Depth_Level)
    if exist('value','var')==0
        value = 0;
    end
    if (Cur_depth == OctomapConstants.max_depth_level)
        for iter = 1:8
            value = max([value,Kids(iter).log_likelihood]);
        end
    else
        for iter = 1:8
            value = max([value, average_likelihood_query(Kids(iter),Point,Depth_Level)]);
        end
    end
else
    for iter = 1:8
        test = is_point_in_node(Kids(iter),Point);
        if test == 1
            value = average_likelihood_query(Kids(iter),Point,Depth_Level);
            break;
        end
    end
end
end