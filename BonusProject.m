clear all;
%Install servo and ultrasonic libraries using {'Servo','Ultrasonic'}
a = arduino('COM7', 'Nano3', 'Libraries', {'Servo', 'Ultrasonic'});
u = ultrasonic(a, 'D4', 'D3');
s = servo(a, 'D10');

%Global variables for strength control of servo
global neutral
global closeStrength
global openStrength
global tightenTime
neutral = 0.48;
writePosition(s, neutral)
closeStrength = 0.52;
openStrength = 0.44;
tightenTime = 2.2;


%Code from James Andrew Smith, Lab H, 2023
figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';
ax.YLim = [-0.1 5];
title('Distance vs time');
ylabel('Distance (m)');
xlabel('Time [HH:MM:SS]');
startTime = datetime('now');
%End of referenced code


%User inputs and conversion to datetime datatype
wakeInput = input('When do you wake up? ', "s");
sleepInput = input('When do you go to bed? ', "s");
wakeTime = datetime(wakeInput, 'InputFormat', 'HH:mm') + days(1);
bedTime = datetime(sleepInput, 'InputFormat', 'HH:mm');
blindsOpened = input("Please enter the current state of the blinds (1 for opened 0 for closed) ");

%Main statemachine for the program
while ~readDigitalPin(a, 'D6')
    %Manual control function call
    manualControl(a,s);
    %Only draws graph during bedtime to avoid using it for too long
    if datetime('now') >= bedTime & datetime('now') < wakeTime
     %Code from James Andrew Smith, Lab H, 2023
     t = datetime('now') - startTime;
     % Add points to animation
     addpoints(h,datenum(t),readDistance(u))
     % Update axes
     ax.XLim = datenum([t-seconds(15) t]);
     datetick('x','keeplimits')
     drawnow
    %End of referenced code
    end
    %Checks whether or not its time to wake up or sleep
    if  datetime('now') > (wakeTime - minutes(15)) & datetime('now') <= wakeTime & ~blindsOpened
        %Opens blinds, also resets the times based on the users input
        disp("Wakey wakey! Opening blinds")
        blindsOpened = openBlinds(a, s, 1);
        wakeTime = datetime(wakeInput, 'InputFormat', 'HH:mm')+ days(1); 
        bedTime = datetime(sleepInput, 'InputFormat', 'HH:mm');
    elseif datetime('now') >= bedTime & datetime('now') < wakeTime & blindsOpened
        %Closes blinds if sensor is activated
        if sensorCheck(a,u)
            blindsOpened = openBlinds(a,s, 0);
        end
    end
end
close all;

        
            
            
