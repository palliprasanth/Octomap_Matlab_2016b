function value = likelihood_query(Point,Depth_Level,RootNode)
% This function returns the likelihood at a Point, given the specified
% depth level

% Point is a 3D vector in space where the likelihood query is required.
% Depth_Level is the required depth level at which query is to be made.
% RootNode is an Octonode object of the root of the Octree.

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