clc
clear all
close all

%This is the root node of the tree
global i
i = 0;
RootNode = OctoNode;
set(RootNode,'index',i);
% RootNode.children = OctoNode; % This converts the data type to Octonode

% First ray comes here
ray = SingleRay;
ray.origin = [-200;70;1];
ray.direction = [1;0;0];
ray.distance = 250;
ray.endpoint = ray.origin+ray.distance.*(ray.direction);

explore_octree(RootNode, ray);

figure
visualize_octree(RootNode)
view(138,60)