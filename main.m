clc
clearvars
close all

%This is the root node of the tree
global i
i = 0;
RootNode = OctoNode;
set(RootNode,'index',i);
% RootNode.children = OctoNode; % This converts the data type to Octonode

% First ray comes here
ray = SingleRay;
ray.origin = [100;1;1];
ray.direction = [-1;1;0];
ray.direction = ray.direction/norm(ray.direction);
ray.distance = 75;
ray.endpoint = ray.origin+ray.distance.*(ray.direction);
ray = ray.calc_inv_direction();
ray = ray.calc_sign();

explore_octree(RootNode, ray);

figure
global a
a = colormap;
visualize_octree(RootNode)
colorbar
view(3)