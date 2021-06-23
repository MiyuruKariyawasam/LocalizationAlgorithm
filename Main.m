clear all;
close all;
clc;

distance = 500;
ang = 60;

pred = Localization(distance,ang)

index = 1;
for ang = 1:1/10:180
    pred = Localization(distance,ang);
    Error(index) = abs(ang-pred);
    x(index) = ang;
    index = index + 1
end

figure;
plot(x,Error);
ylabel('Error(degrees)');
xlabel('Angle');
grid on;