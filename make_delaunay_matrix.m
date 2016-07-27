function L = make_delaunay_matrix(X)

[sy,sx] = size(X);

tri = delaunayTriangulation(X(:,1), X(:,2));
cl = vertcat([tri.ConnectivityList(:,1) tri.ConnectivityList(:,2)], ...
    [tri.ConnectivityList(:,2) tri.ConnectivityList(:,3)], ...
    [tri.ConnectivityList(:,3) tri.ConnectivityList(:,1)]);
cl = sort(cl,2);
cl = unique(cl, 'rows');

[cy,cx] = size(cl);
L = sparse(zeros(cy, sy));
for i=1:cy
    j = cl(i,:);
    L(i,j(1)) = -1;
    L(i,j(2)) = 1;
end

end