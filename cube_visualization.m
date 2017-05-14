function [] = cube_visualization(Node)
% This function plots a colored cube for the OctoNode passed as an
% argument. The color chosen depends on the likelihood value of the node
% being plotted.

% Node is an OctoNode object

global a
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
    'FaceVertexCData',hsv(6),'FaceColor',a(ceil(log_likely_to_prob(Node.log_likelihood)*64),:));
end