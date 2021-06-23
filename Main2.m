v = 330; %Speed of seismic waves
distance = 500;
sensor_dis = 3;     %Distance between 2 sensors

index = 1;


%angle = 60;

sensorA = [-sensor_dis/2 -sensor_dis*sin(pi/3)/3];
sensorB = [sensor_dis/2 -sensor_dis*sin(pi/3)/3];
sensorC = [0 sensor_dis*sin(pi/3)*2/3];

midAB = (sensorA+sensorB)./2;
midBC = (sensorB+sensorC)./2;
midCA = (sensorC+sensorA)./2;

for angle = 1:1/10:360

    delayAB = Localization2(distance,angle,sensorA,sensorB);
    delayBC = Localization2(distance,angle,sensorB,sensorC);
    delayCA = Localization2(distance,angle,sensorC,sensorA);

    angleAB = [acos(delayAB*v/sensor_dis)*(180/pi) 360-acos(delayAB*v/sensor_dis)*(180/pi)];
    angleBC = [120-acos(delayBC*v/sensor_dis)*(180/pi) 120+acos(delayBC*v/sensor_dis)*(180/pi)];
    angleCA = [240-acos(delayCA*v/sensor_dis)*(180/pi) 240+acos(delayCA*v/sensor_dis)*(180/pi)];

    %Adjust angles from 0 to 360
    if(angleBC(1)<0)
        angleBC(1) = 360+angleBC(1);
    end

    if(angleCA(2)>360)
        angleCA(2) = angleCA(2)-360;
    end

    if(abs(delayAB)<abs(delayCA) && abs(delayBC)<abs(delayCA))
        %disp('AB BC');
        [a b] = getAngle(angleAB, angleBC);
        predic_angle = (angleAB(a)+angleBC(b))/2;
        %angleAB, angleBC

    elseif(abs(delayAB)<abs(delayBC) && abs(delayCA)<abs(delayBC))
        %disp('AB CA');
        [a b] = getAngle(angleAB, angleCA);
        predic_angle = (angleAB(a)+angleCA(b))/2;
        %angleAB, angleCA
    else
        %disp('BC CA');
        [a b] = getAngle(angleBC, angleCA);
        predic_angle = (angleBC(a)+angleCA(b))/2;
        %angleBC, angleCA
    end
    
    Error(index) = abs(angle-predic_angle);
    x(index) = angle;
    index = index + 1

end

figure;
plot(x,Error);
ylabel('Error(degrees)');
xlabel('Angle');
xlim([0 360]);
ylim([0 1]);
grid on;

