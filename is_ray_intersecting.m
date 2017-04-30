function value = is_ray_intersecting(Node,Ray)

% Node is an OctoNode object
% Ray is a SingleRay object

xlim = Node.getxlimits();
ylim = Node.getylimits();
zlim = Node.getzlimits();
tx0 = (xlim(1)-Ray.origin(1))/Ray.direction(1);
tx1 = (xlim(2)-Ray.origin(1))/Ray.direction(1);

ty0 = (ylim(1)-Ray.origin(2))/Ray.direction(2);
ty1 = (ylim(2)-Ray.origin(2))/Ray.direction(2);

tz0 = (zlim(1)-Ray.origin(3))/Ray.direction(3);
tz1 = (zlim(2)-Ray.origin(3))/Ray.direction(3);

t0 = max([tx0 ty0 tz0]);
t1 = min([tx1 ty1 tz1]);

dist_check = ~(t0>Ray.distance & t1>Ray.distance);
value = (t0<t1) & (dist_check);
end