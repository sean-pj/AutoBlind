%Manual override using board potentiometer
function manualControl(a,s)
    global neutral
    global closeStrength
    global openStrength
    global tightenTime
    if readVoltage(a, 'A0') == 5
        writePosition(s, closeStrength)
    elseif readVoltage(a, 'A0') == 0
        writePosition(s, openStrength)
    else
        writePosition(s, neutral)
    end
end