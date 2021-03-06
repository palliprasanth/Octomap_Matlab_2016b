classdef SingleRay  
    properties (GetAccess = 'public', SetAccess = 'public')
        % Constructor for the class
        origin = zeros(3,1);
        endpoint = zeros(3,1);
        direction = zeros(3,1);
        inv_direction = zeros(3,1);
        sign = zeros(3,1); %Boolean vector, 1 is positive, 0 is negative
        distance = 0;
        is_in_range = true;
    end
    
    methods
        function object = calc_inv_direction(object)
            object.inv_direction = ones(3,1)./object.direction;
        end
        
        function object = calc_sign(object)
            object.sign = (object.inv_direction<0);
        end
        
    end
end