clc
clear all
close all

%This is the root node of the tree%
i = 0;
RootNode = OctoNode;
father = RootNode;
set(RootNode,'index',i);
% RootNode.children = OctoNode; % This converts the data type to Octonode

% First ray comes here
ray = SingleRay;
ray.origin = [-200;0;0];
ray.direction = [1;0;0];
ray.distance = 150;
value = is_ray_intersecting(RootNode,ray);

if value == 1
    father.is_visited = true;
    Kids = [];
    for iter = 1:8
        i = i+1;
        v = matlab.lang.makeUniqueStrings(strcat('Node',num2str(i)));
        eval([v '= OctoNode;']);
        Temp_Node = eval(v);
        Temp_Node.index = i;
        Temp_Node.parent = father;
        Temp_Node.set_depth_levels();
        Kids = [Kids; Temp_Node];
    end
    set(RootNode,'children',Kids);
    RootNode.set_children_centers();
end