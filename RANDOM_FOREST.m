% Importing CSV File
data = csvread('sensor_data.csv');
humidity = data(:, 4);
air_quality = data(:, 3);

% Spliting data into training and testing 
rng(123); 
split_ratio = 0.8;
split_index = round(split_ratio * length(humidity));
train_humidity = humidity(1:split_index);
train_air_quality = air_quality(1:split_index);
test_humidity = humidity(split_index+1:end);
test_air_quality = air_quality(split_index+1:end);

% Training the data
num_trees = 100; % Number of trees in the forest (you can adjust this)
model = TreeBagger(num_trees, train_humidity, train_air_quality, 'Method', 'regression');

% Precition on the testing data
predicted_air_quality = predict(model, test_humidity);

% Evaluating the model
mae = mean(abs(predicted_air_quality - test_air_quality));
rmse = sqrt(mean((predicted_air_quality - test_air_quality).^2));

fprintf('Mean Absolute Error (MAE): %.2f\n', mae);
fprintf('Root Mean Squared Error (RMSE): %.2f\n', rmse);
figure;
plot(test_humidity, test_air_quality, 'bo', 'MarkerSize', 8, 'DisplayName', 'Actual');
hold on;
plot(test_humidity, predicted_air_quality, 'rx', 'MarkerSize', 8, 'DisplayName', 'Predicted');
xlabel('Humidity');
ylabel('Air Quality');
legend('show');
title('Actual vs. Predicted Air Quality');
grid on;
