function [a b] = getAngle(angle1,angle2)
    if(abs(angle1(1)-angle2(1))<30)
        a=1;
        b=1;
    elseif(abs(angle1(1)-angle2(2))<30)
        a=1;
        b=2;
    elseif(abs(angle1(2)-angle2(1))<30)
        a=2;
        b=1;
    elseif(abs(angle1(2)-angle2(2))<30)
        a=2;
        b=2;
    else
        disp('Angle error')
        a=0;
        b=0;
end