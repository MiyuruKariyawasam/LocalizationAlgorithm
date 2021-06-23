function [x y] = getIntersect(point1,point2,m1,m2)
    x = (point2(2)-point1(2)+m1*point1(1)-m2*point2(1))/(m1-m2);
    y = m1*x+point1(2)-m1*point1(1);
end