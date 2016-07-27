rng('default');
rng(1);
X = [bsxfun(@plus,rand(5,2),[1,0]); rand(5,2)]; % data matrix
[n,p] = size(X);

% Setting the initial value
alpha = X;
L = make_combination_matrix(n);
%L = make_delaunay_matrix(X);
Z = L*alpha;
U = zeros(size(Z));
lambda = norm(std(X));
rho = 2;

% plotting the data
figure(1); plot(X(:,1), X(:,2), 'bo');

for ite=1:60
    
obj = 1/2 * norm(alpha-X,'fro') + lambda*norm(L*X,1);
fprintf('Iteration %d: %f\n', ite, obj);

% ADMM
alpha = (eye(n) + rho*(L'*L)) \ (X + rho*L'*(Z-U));
T = L*alpha + U;
[U_,D,V] = svd(T, 'econ');
D = sign(D) .* max(0, abs(D)-lambda/rho); % shrinkage
Z = U_*D*V';
U = T - Z;

% plotting the position of alpha
figure(1);
hold on;
plot(alpha(:,1), alpha(:,2), 'r+');
hold off;
drawnow;

end

% plotting the last iterated position of alpha
figure(1);
hold on
plot(alpha(:,1), alpha(:,2), 'go', 'MarkerSize', 10, 'LineWidth', 2);
hold off;
