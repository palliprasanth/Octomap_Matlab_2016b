function value = likelihood_query(Point,Depth_Level,RootNode)

if (Depth_Level > OctomapConstants.max_depth_level )
    value = 0;
    disp('Query depth is greater than the tree depth');
    return;
else
    p_check = is_point_in_node(RootNode,Point);
    if p_check == 1 && RootNode.is_visited == true
            value = max_likelihood_query(RootNode,Point,Depth_Level);
            sprintf('Likelihood value at the Point is %0.4f',value)
    else
        disp('The point is not within the mapping region');
    end
end

end