% Importing CSV File
data = csvread('sensor_data.csv');

% Normalizing the data
data = zscore(data);

% elbow method
elbow_data = [];
for k = 1:10  % Try different values of K (e.g., from 1 to 10)
    % Apply K-means clustering
    [~, ~, sumd] = kmeans(data, k, 'Distance', 'sqeuclidean');
    elbow_data = [elbow_data; sum(sumd)];
end

figure;
plot(1:10, elbow_data, 'bx-');
xlabel('Number of Clusters (K)');
ylabel('Sum of Squared Distances');
title('Elbow Method for Optimal K');
grid on;

optimal_K = 3; 
[idx, centroids] = kmeans(data, optimal_K);

figure;
scatter(data(:, 1), data(:, 2), 50, idx, 'filled');
hold on;
scatter(centroids(:, 1), centroids(:, 2), 200, (1:optimal_K)', 'k', 'filled');
xlabel('Normalized Velocity');
ylabel('Normalized Acceleration');
title(['K-Means Clustering with K = ' num2str(optimal_K)]);
grid on;

for i = 1:optimal_K
    cluster_i = data(idx == i, :);
    fprintf('Cluster %d: %d drivers\n', i, size(cluster_i, 1));
end

