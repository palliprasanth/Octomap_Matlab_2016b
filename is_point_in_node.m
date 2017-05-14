function value = is_point_in_node(Node,Point)
% This function isused for checking if a Point lies within an OctoNode

% Node is an OctoNode object
% Point is a 3-Dimensional point in space.

xlim = Node.getxlimits();
ylim = Node.getylimits();
zlim = Node.getzlimits();

value = (Point(1)>=xlim(1)) & (Point(1)<=xlim(2)) & (Point(2)>=ylim(1)) & (Point(2)<=ylim(2)) & (Point(3)>=zlim(1))& (Point(3)<=zlim(2)) ;
end