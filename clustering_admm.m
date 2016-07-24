rng('default');
rng(1);
X = rand(10,2); % data matrix
[n,p] = size(X);

% Setting the initial value
alpha = X;
L = make_combination_matrix(n);
Z = L*alpha;
U = zeros(size(Z));
lambda = 0.05;
rho = 1;

% plotting the data
figure(1); plot(X(:,1), X(:,2), 'bo');

for i=1:30
    
obj = 1/2 * norm(alpha-X,2) + lambda*norm(L*X,1);
fprintf('Iteration %d: %f\n', i, obj);

% ADMM
alpha = inv(eye(n) + rho*(L'*L)) * (X + rho*L'*(Z-U));
T = L*alpha + U;
Z = sign(T) .* max(0, abs(L*alpha+U) - lambda/rho);
U = T - Z;

% plot the position of alpha
figure(1);
hold on;
plot(alpha(:,1), alpha(:,2), 'r+');
hold off;
drawnow;

end