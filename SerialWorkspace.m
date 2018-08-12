clear all
clc
syms q1 q2 q3 q4 q5;
s1=sin(q1*pi/180);
s2=sin(q2*pi/180);
s3=sin(q3*pi/180);
s4=sin(q4*pi/180);
s5=sin(q5*pi/180);
c1=cos(q1*pi/180);
c2=cos(q2*pi/180);
c3=cos(q3*pi/180);
c4=cos(q4*pi/180);
c5=cos(q5*pi/180);
T01=[c1,-s1,0,0;
    s1,c1,0,0;
    0,0,1,63;
    0,0,0,1];
T12=[c2,-s2,0,0;
    0,0,-1,0;
    s2,c2,0,0;
    0,0,0,1];
T23=[c3,-s3,0,153;
    s3,c3,0,0;
    0,0,1,0;
    0,0,0,1];
T34=[c4,-s4,0,153;
    s4,c4,0,0;
    0,0,1,0;
    0,0,0,1];
T45=[c5,-s5,0,0;
    0,0,-1,-68;
    s5,c5,0,0;
    0,0,0,1];
T56=[1,0,0,0;
    0,1,0,0;
    0,0,1,30;
    0,0,0,1];
T06=T01*T12*T23*T34*T45*T56;
result=[T06(1,4);T06(2,4);T06(3,4)];
xwork = zeros;
ywork = zeros;
zwork = zeros;

k=1;
for q1=-90:10:90
    for q2=0:10:150
        for q3=-170:10:0
            for q4=0:20:180
                xwork(1,k)= 98*cos((pi*q4)/180)*(cos((pi*q1)/180)*cos((pi*q2)/180)*sin((pi*q3)/180) + cos((pi*q1)/180)*cos((pi*q3)/180)*sin((pi*q2)/180)) - 98*sin((pi*q4)/180)*(cos((pi*q1)/180)*sin((pi*q2)/180)*sin((pi*q3)/180) - cos((pi*q1)/180)*cos((pi*q2)/180)*cos((pi*q3)/180)) + 153*cos((pi*q1)/180)*cos((pi*q2)/180) - 153*cos((pi*q1)/180)*sin((pi*q2)/180)*sin((pi*q3)/180) + 153*cos((pi*q1)/180)*cos((pi*q2)/180)*cos((pi*q3)/180);
                ywork(1,k) = 98*cos((pi*q4)/180)*(cos((pi*q2)/180)*sin((pi*q1)/180)*sin((pi*q3)/180) + cos((pi*q3)/180)*sin((pi*q1)/180)*sin((pi*q2)/180)) - 98*sin((pi*q4)/180)*(sin((pi*q1)/180)*sin((pi*q2)/180)*sin((pi*q3)/180) - cos((pi*q2)/180)*cos((pi*q3)/180)*sin((pi*q1)/180)) + 153*cos((pi*q2)/180)*sin((pi*q1)/180) - 153*sin((pi*q1)/180)*sin((pi*q2)/180)*sin((pi*q3)/180) + 153*cos((pi*q2)/180)*cos((pi*q3)/180)*sin((pi*q1)/180);
                zwork(1,k) = 153*sin((pi*q2)/180) - 98*cos((pi*q4)/180)*(cos((pi*q2)/180)*cos((pi*q3)/180) - sin((pi*q2)/180)*sin((pi*q3)/180)) + 98*sin((pi*q4)/180)*(cos((pi*q2)/180)*sin((pi*q3)/180) + cos((pi*q3)/180)*sin((pi*q2)/180)) + 153*cos((pi*q2)/180)*sin((pi*q3)/180) + 153*cos((pi*q3)/180)*sin((pi*q2)/180) + 63;
                k=k+1;
            end
        end
    end
end
plot3(xwork,ywork,zwork,'.');

