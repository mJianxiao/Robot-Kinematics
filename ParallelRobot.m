clear all
close all
clc

%% IK
PB1=pi/2;
PB2=(pi+pi)/6;
PB3=(2*pi-pi)/6;
PP1=pi/2;
PP2=(pi+pi)/6;
pp3=(2*pi-pi)/6;
SA=170;
L=130;
rp=130;
Rb=290;

xc=-20;
yc=40; %%platform center
a=pi/9;
ca=cos(a);
sa=sin(a);
rota=[ca,-sa,0;sa,ca,0;0,0,1];
CPP1=[-rp*cos(pi/6);-rp*sin(pi/6);0];
CPP2=[0;rp;0];
CPP3=[rp*cos(pi/6);-rp*sin(pi/6);0];

BC=[xc yc 0];

BPP1=rota*CPP1+BC';
BPP2=rota*CPP2+BC';
BPP3=rota*CPP3+BC';

BPB1=[-Rb*cos(pi/6);-Rb*sin(pi/6);0];
BPB2=[0;Rb;0];
BPB3=[Rb*cos(pi/6);-Rb*sin(pi/6);0];

PBPP1=BPP1-BPB1;
PBPP2=BPP2-BPB2;
PBPP3=BPP3-BPB3;

xpp1=PBPP1(1,1);
ypp1=PBPP1(2,1);
xpp2=PBPP2(1,1);
ypp2=PBPP2(2,1);
xpp3=PBPP3(1,1);
ypp3=PBPP3(2,1);

e11=-2*ypp1*SA;
e12=-2*xpp1*SA;
e13=xpp1^2+ypp1^2+SA^2-L^2;

e21=-2*ypp2*SA;
e22=-2*xpp2*SA;
e23=xpp2^2+ypp2^2+SA^2-L^2;

e31=-2*ypp3*SA;
e32=-2*xpp3*SA;
e33=xpp3^2+ypp3^2+SA^2-L^2;

t11=(-e11+sqrt(e11^2+e12^2-e13^2))/(e13-e12);
t12=(-e11-sqrt(e11^2+e12^2-e13^2))/(e13-e12);
t21=(-e21+sqrt(e21^2+e22^2-e23^2))/(e23-e22);
t22=(-e21-sqrt(e21^2+e22^2-e23^2))/(e23-e22); 
t31=(-e31+sqrt(e31^2+e32^2-e33^2))/(e33-e32);
t32=(-e31-sqrt(e31^2+e32^2-e33^2))/(e33-e32);

theta11=2*atan(t11);
theta12=2*atan(t12);

theta21=2*atan(t21);
theta22=2*atan(t22);

theta31=2*atan(t31);
theta32=2*atan(t32);
%%Point M
M11x=SA*cos(theta11)-290*cos(pi/6);
M11y=SA*sin(theta11)-290*sin(pi/6);
M12x=SA*cos(theta12)-290*cos(pi/6); 
M12y=SA*sin(theta12)-290*sin(pi/6);
M21x=SA*(cos(theta21)); 
M21y=SA*(sin(theta21))+290;
M22x=SA*(cos(theta22)); 
M22y=SA*(sin(theta22))+290;
M31x=SA*(cos(theta31))+290*cos(pi/6); 
M31y=SA*(sin(theta31))-290*sin(pi/6);
M32x=SA*(cos(theta32))+290*cos(pi/6);
M32y=SA*(sin(theta32))-290*sin(pi/6);%% two solutions

b1x=-290*cos(pi/6);
b1y=-290*sin(pi/6);
b2x=0; 
b2y=290;
b3x=290*cos(pi/6);
b3y=-290*sin(pi/6);

B=[b1x,b2x,b3x,b1x;b1y,b2y,b3y,b1y];
plot(B(1,:),B(2,:)); %%base
hold on

Leg1=[b1x,M11x,BPP1(1,1);b1y,M11y,BPP1(2,1)];
plot(Leg1(1,:),Leg1(2,:),'g');
hold on 

Leg2=[b2x,M21x,BPP2(1,1);b2y,M21y,BPP2(2,1)];
plot(Leg2(1,:),Leg2(2,:),'g');
hold on 

Leg3=[b3x,M31x,BPP3(1,1);b3y,M31y,BPP3(2,1)];
plot(Leg3(1,:),Leg3(2,:),'g');

C=[BPP1(1,1),BPP2(1,1),BPP3(1,1),BPP1(1,1);BPP1(2,1),BPP2(2,1),BPP3(2,1),BPP1(2,1)];
plot(C(1,:),C(2,:),'r');
figure(2)

%% FK
B=[b1x,b2x,b3x,b1x;b1y,b2y,b3y,b1y];
plot(B(1,:),B(2,:));

hold on
CPP=[CPP1 CPP2 CPP3];
BPB=[BPB1 BPB2 BPB3];

k=1;
xworkspace=zeros;
yworkspace=zeros;

for xc=-300:3:300 %%traverse all the xc and yc
    for yc=-300:3:300
        RBC=[xc xc xc; yc yc yc; 0 0 0];
        PBPP=rota*CPP+RBC-BPB;          
        if(sqrt((PBPP(1,1))^2+(PBPP(2,1))^2)>40&&sqrt((PBPP(1,1))^2+(PBPP(2,1))^2)<300)
            if(sqrt((PBPP(1,2))^2+(PBPP(2,2))^2)>40&&sqrt((PBPP(1,2))^2+(PBPP(2,2))^2)<300)
                if(sqrt((PBPP(1,3))^2+(PBPP(2,3))^2)>40&&sqrt((PBPP(1,3))^2+(PBPP(2,3))^2)<300)
                    xworkspace(1,k)=[xc];
                    yworkspace(2,k)=[yc];
                    k=k+1;
                end
            end
        end
    end
end   
plot( xworkspace, yworkspace,'r.');
hold on
figure(2)
                       






