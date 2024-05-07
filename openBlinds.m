%Opens or closes blinds based on the passed open argument
%1 meaning open the blinds 0 meaning close them
function blindsOpened = openBlinds(a,s, open)
    global neutral
    global closeStrength
    global openStrength
    global tightenTime
    writePosition(s, neutral);
    if ~open
        %Closes blinds with servo
        writePosition(s, closeStrength)
        pause(tightenTime)
        writePosition(s, neutral)
        blindsOpened = 0;
    elseif open
        %opens blinds with servo
        writePosition(s, openStrength)
        pause(tightenTime)
        writePosition(s, neutral)
        blindsOpened = 1;
    end
end
