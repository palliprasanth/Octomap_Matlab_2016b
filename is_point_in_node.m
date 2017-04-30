function value = is_point_in_node(Node,Point)
% Node is an OctoNode object

xlim = Node.getxlimits();
ylim = Node.getylimits();
zlim = Node.getzlimits();

value = (Point(1)>=xlim(1)) & (Point(1)<=xlim(2)) & (Point(2)>=ylim(1)) & (Point(2)<=ylim(2)) & (Point(3)>=zlim(1))& (Point(3)<=zlim(2)) ;
end