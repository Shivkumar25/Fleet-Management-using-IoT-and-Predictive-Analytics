concentrations = zeros(1, 200);
humidity_data = zeros(1, 200);
for i = 1:6288
    value = sensorData(i).INSMeasurements{:}
    value.Velocity(1)
    value.Acceleration(1)
    pause(20)
    thingSpeakWrite(2252762 , 'Fields', 1, 'Values', value.Velocity(1),'WriteKey','UWJCSFKQ06S8TDYY')
    pause(20)
    thingSpeakWrite(2252762 , 'Fields', 2, 'Values', value.Acceleration(1),'WriteKey','UWJCSFKQ06S8TDYY')
    min_concentration = 0; % Minimum concentration percentage
    max_concentration = 100; % Maximum concentration percentage
    concentrations(i) = randi([min_concentration, max_concentration]); 
    pause(20)
    thingSpeakWrite(2252762 , 'Fields', 3, 'Values', concentrations(i),'WriteKey','UWJCSFKQ06S8TDYY')
    min_humidity = 30; % Minimum humidity percentage
    max_humidity = 70; % Maximum humidity percentage
    humidity_data(i) = randi([min_humidity, max_humidity]);  
    pause(20)
    thingSpeakWrite(2252762 , 'Fields', 4, 'Values', humidity_data(i),'WriteKey','UWJCSFKQ06S8TDYY')
    pause(20)
    if ~isempty(sensorData(i).ObjectDetections)
        %value = sensorData(i).ObjectDetections{1}.MeasurementParameters;
        value = 1
        thingSpeakWrite(2252762 , 'Fields', 5, 'Values', value(1),'WriteKey','UWJCSFKQ06S8TDYY')
    else
        thingSpeakWrite(2252762 , 'Fields', 5, 'Values', -1, 'WriteKey','UWJCSFKQ06S8TDYY')
    end    
end