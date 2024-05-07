%Detects if the user has entered the bed using the ultrasonic sensor
function output = sensorCheck(a,u)
    roundedDistance = round(readDistance(u),2)
    %The sensor sometimes doesn't detect anything and returns Inf
    %which means the sound went beyond the range of the sensor,
    %and so this just rounds the distance to 3.5, the sensor's max range
    if roundedDistance == Inf
        roundedDistance = 3.5;
    end
    %Checks if distance detected is less than 2 metres.
    if (roundedDistance < 2)
        disp("Sensor tripped! Goodnight, Closing blinds")
        output = 1;
    else
        output = 0;
    end
end
