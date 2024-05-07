clear all;
a = arduino('COM7', 'Nano3'); 
s = servo(a,'D10');
neutral = 0.48;
tighten = 0.52;
deTighten = 0.45;
writePosition(s, neutral);
tightenTime = 2.8;
open = 1;

if ~open
    writePosition(s, tighten)
    pause(tightenTime)
    writePosition(s, neutral)
elseif open
    writePosition(s, deTighten)
    pause(tightenTime)
    writePosition(s, neutral)
end


% tic;
% writePosition(s,0.45);
% while true 
%     if readDigitalPin(a,'D6')
%         toc
%         writePosition(s, 0.48);
%         break
%     end
% end

% while true
%     if readDigitalPin(a,'D6') & readDigitalPin(a,'A0') == 1 
%         tic;
%         writePosition(s,0.52);
%     elseif readDigitalPin(a,'D6') & readDigitalPin(a,'A0') == 0
%         writePosition(s,0.44);
%     else
%         writePosition(s,0.48);
%     end
%     toc;
% end