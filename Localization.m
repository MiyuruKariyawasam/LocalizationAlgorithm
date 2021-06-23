% Sensors are assumed to be at 0,0 location
% x,y is considered as the source location distance in meters from sensors
% Speed of seismic waves are assumed to be constant
% 2 geophones are assumed to be located at (0,0) 3m apart symmetrically

function [predicted_angle] = Localization(distance,angle)
    angle = angle*(pi/180);
    x = distance*cos(angle);
    y = distance*sin(angle);

    v = 330; %Speed of seismic waves

    [data,Fs] = audioread('greeting.wav');

    %Calculate delay for each sensor in seconds
    delay1 = sqrt((x+1)^2+y^2)/v; % x = -1.5
    delay2 = sqrt((x-1)^2+y^2)/v; % x = 1.5

    data_rec1 = data(round(1+(delay1*Fs)):round(10*Fs+(delay1*Fs)));
    data_rec2 = data(round(1+(delay2*Fs)):round(10*Fs+(delay2*Fs)));

    [r,lags] = xcorr(data_rec1,data_rec2);
    sample = -10+1/Fs:1/Fs:10-1/Fs;

    %plot(lags,r);
    [m,index] = max(r);
    delay_calc = -lags(index)*1/Fs;  %Calculated Delay
    
    predicted_angle = acos(delay_calc*v/2)*(180/pi);
end