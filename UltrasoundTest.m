clear all;
a = arduino('Com7', 'Nano3');
u = ultrasonic(a, 'D4', 'D3');

x = [];
y = [];

%Collects 100 samples from sensor
for i = 1:100
    x = [x seconds(readEchoTime(u))]; %Time it takes for sound to leave and bounce back
    y = [y (seconds(readEchoTime(u)/2) * 344)];% Distance calculation (344 m/s speed of sound)
end

%Plot Graph
plot(x,y)
xlabel('Echo time (s)')
ylabel('Distance (m)')
title('Distance vs echo time')

% while true
%     if readDigitalPin(a,'D6')
%     fprintf('The recorded time is %f seconds.', seconds(readEchoTime(u)))
%     fprintf('The distance is %f m.', (seconds(readEchoTime(u)/2)) * 344)
%     end
% end

%Live graph code from James Andrew Smith, Lab H, 2023
figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';
ax.YLim = [-0.1 3];
title('Distance vs time');
ylabel('Distance (m)');
xlabel('Time [HH:MM:SS]');
startTime = datetime('now');

while ~readDigitalPin(a ,'D6')
    disp(readDistance(u))
    t = datetime('now') - startTime;
    % Add points to animation
    addpoints(h,datenum(t),readDistance(u))
    % Update axes
    ax.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimits')
    drawnow
end


% beforeUpdate = readDistance(u);
% while true
%     if readDistance(u) < (beforeUpdate * 0.25) | readDistance(u) > (beforeUpdate * 1.75)
% 
%     end
%     beforeUpdate = readDistance(u);
% end