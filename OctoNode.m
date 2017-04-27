classdef OctoNode
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % Constructor for the class
        center = zeros(3,1); %Center of the node
        depth = 0;
        log_likelihood = 0;
        parent = libpointer('voidPtr',[]);
        children = repmat([libpointer('voidPtr',[]);libpointer('voidPtr',[])],[4,1]);
    end
     
    methods
        function xlim = getxlimits(object)
            xlim = [object.center(1)-OctomapConstants.dim_limits/2^object.depth object.center(1)+OctomapConstants.dim_limits/2^object.depth];
        end
        
        function ylim = getylimits(object)
            ylim = [object.center(2)-OctomapConstants.dim_limits/2^object.depth object.center(2)+OctomapConstants.dim_limits/2^object.depth];
        end
        
        function zlim = getzlimits(object)
            zlim = [object.center(3)-OctomapConstants.dim_limits/2^object.depth object.center(3)+OctomapConstants.dim_limits/2^object.depth];
        end
    end 
    
end