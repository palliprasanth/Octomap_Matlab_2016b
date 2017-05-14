function value = is_ray_intersecting(Node,Ray)
% This function is used for checking if a Ray is intersecting an Octonode.

% Node is an OctoNode object
% Ray is a SingleRay object

xlim = Node.getxlimits();
ylim = Node.getylimits();
zlim = Node.getzlimits();

tx0 = (xlim(1+Ray.sign(1)) - Ray.origin(1)) * Ray.inv_direction(1);
tx1 = (xlim(2-Ray.sign(1)) - Ray.origin(1)) * Ray.inv_direction(1);

ty0 = (ylim(1+Ray.sign(2)) - Ray.origin(2)) * Ray.inv_direction(2);
ty1 = (ylim(2-Ray.sign(2)) - Ray.origin(2)) * Ray.inv_direction(2);

tz0 = (zlim(1+Ray.sign(3)) - Ray.origin(3)) * Ray.inv_direction(3);
tz1 = (zlim(2-Ray.sign(3)) - Ray.origin(3)) * Ray.inv_direction(3);

t0 = max([tx0 ty0 tz0]);
t1 = min([tx1 ty1 tz1]);

dist_check = ~((t0>Ray.distance & t1>Ray.distance)|(t0<0 & t1<0));
value = (t0<t1) & (dist_check);
end