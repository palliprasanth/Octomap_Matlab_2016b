function value = max_likelihood_query(Node,Point,Depth_Level)
global a
Kids = Node.get_children;
Cur_depth = Node.depth + 1;
if (isempty(Kids))
    value = 0;
    return
end

if (Cur_depth > Depth_Level)
    if exist('value','var')==0
        value = 0;
    end
    if (Cur_depth == OctomapConstants.max_depth_level)
        for iter = 1:8
            value = max([value,Kids(iter).log_likelihood]);
        end
    else
        for iter = 1:8
            value = max([value, max_likelihood_query(Kids(iter),Point,Depth_Level)]);
        end
    end
else
    for iter = 1:8
        test = is_point_in_node(Kids(iter),Point);
        if test == 1
            if Cur_depth == Depth_Level
                node_center = Node.center;
                hx=OctomapConstants.x_dim_limits/2^(Node.depth);
                hy=OctomapConstants.y_dim_limits/2^(Node.depth);
                hz=OctomapConstants.z_dim_limits/2^(Node.depth);
                
                hold on;
                
                vert = [node_center(1)-hx node_center(2)-hy node_center(3)-hz;....
                    node_center(1)+hx node_center(2)-hy node_center(3)-hz;....
                    node_center(1)+hx node_center(2)+hy node_center(3)-hz;....
                    node_center(1)-hx node_center(2)+hy node_center(3)-hz;....
                    node_center(1)-hx node_center(2)-hy node_center(3)+hz;....
                    node_center(1)+hx node_center(2)-hy node_center(3)+hz;....
                    node_center(1)+hx node_center(2)+hy node_center(3)+hz;....
                    node_center(1)-hx node_center(2)+hy node_center(3)+hz];
                fac = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
                patch('Vertices',vert,'Faces',fac,...
                    'FaceVertexCData',hsv(6),'FaceColor','red','FaceAlpha',0.2);
            end
            value = max_likelihood_query(Kids(iter),Point,Depth_Level);
            break;
        end
    end
end
end