function [] = cull_octree(Node)
Kids = Node.get_children;
Cur_depth = Node.depth + 1;
end