classdef OctoNode < handle & matlab.mixin.SetGet
    properties (GetAccess = 'public', SetAccess = 'public')
        % Constructor for the class
%         index = 0;
        is_visited = false;
        center = zeros(3,1); %Center of the node
        depth = 0;
        log_likelihood = 0; % Prior probability is 0.5
        parent= []; %Will add an Octonode of the parent here%
        children = [] %Will add the Octonodes for the chidren here;
        is_culled = false;
    end
    
    methods
        function xlim = getxlimits(object)
            xlim = [object.center(1)-OctomapConstants.x_dim_limits/2^object.depth object.center(1)+OctomapConstants.x_dim_limits/2^object.depth];
        end
        
        function ylim = getylimits(object)
            ylim = [object.center(2)-OctomapConstants.y_dim_limits/2^object.depth object.center(2)+OctomapConstants.y_dim_limits/2^object.depth];
        end
        
        function zlim = getzlimits(object)
            zlim = [object.center(3)-OctomapConstants.z_dim_limits/2^object.depth object.center(3)+OctomapConstants.z_dim_limits/2^object.depth];
        end
        
        function parent_node = get_parent(object)
            parent_node = object.parent;
        end
        
        function children_nodes = get_children(object)
            children_nodes = object.children;
        end
        
        function object = set_log_likelihood(object,value)
            object.log_likelihood = value;
        end
        
        function object = set_depth_levels(object)
            object.depth = object.parent.depth + 1;
        end
        
        function object = set_children_centers(object)
            hx = OctomapConstants.x_dim_limits/2^object.depth/2;
            hy = OctomapConstants.y_dim_limits/2^object.depth/2;
            hz = OctomapConstants.z_dim_limits/2^object.depth/2;
            object.children(1).center = [object.center(1)+hx object.center(2)+hy object.center(3)+hz];
            object.children(2).center = [object.center(1)+hx object.center(2)+hy object.center(3)-hz];
            object.children(3).center = [object.center(1)-hx object.center(2)+hy object.center(3)-hz];
            object.children(4).center = [object.center(1)-hx object.center(2)+hy object.center(3)+hz];
            object.children(5).center = [object.center(1)+hx object.center(2)-hy object.center(3)+hz];
            object.children(6).center = [object.center(1)+hx object.center(2)-hy object.center(3)-hz];
            object.children(7).center = [object.center(1)-hx object.center(2)-hy object.center(3)-hz];
            object.children(8).center = [object.center(1)-hx object.center(2)-hy object.center(3)+hz];
        end
    end
end