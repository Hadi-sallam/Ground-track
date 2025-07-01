clearvars
clc
close all
%inputs
a=7000;
e=0;
i=70*pi/180;
w=45*pi/180;
raan=45*pi/180;
nu_0=0;
n_orbits=3;
%%%%%%%%%%%%%%%%%%%%%%
w_e=2*pi/24/3600;%rotational velocity of earth
mu=3.986*1e5; %earth garvitational constant
p=2*pi*sqrt(a^3/mu);%orbit's period
E_0=2*atan(tan(nu_0/2)*sqrt((1-e)/(1+e)));%initial eccentric anomaly
M_0=E_0-e*sin(E_0);% initial mean anomaly
t_0=M_0*p/2/pi;%initial time
t_f=n_orbits*p+t_0;%final time
Q=transformation(w,i,raan);%transformation matrix to change the position vector from the plane of the orbit to the frame of refrence of the earth
t=linspace(t_0,t_f,350);
%matrices initialization
M=zeros(1,350);
E=zeros(1,350);
nu=zeros(1,350);
R=zeros(1,350);
x_orbit=zeros(1,350);
y_orbit=zeros(1,350);
z_orbit=zeros(1,350);
R_orbit2=zeros(3,350);
lat=zeros(1,350);
lon=zeros(1,350);
%%%%%%%%%%%%%%%%%%%%%
for h=1:350 %computing orbital elements for every instance of t

M(h)=2*pi/p*t(h);
E(h)=kepler_E(e,M(h));
nu(h)=2*atan(tan(E(h)/2)*sqrt((1+e)/(1-e)));%true anomaly using the orbital equations
R(h)=a*(1-e^2)/(1+e*cos(nu(h))); %distance between the center of the earth and the spacecraft
x_orbit(h)=R(h)*cos(nu(h)); %x-component of the position vector with respect to the plane of the orbit
y_orbit(h)=R(h)*sin(nu(h));%y-component of the position vector with respect to the plane of the orbit
z_orbit(h)=0; 
theta=w_e*(t(h)-t_0); %refrence angle for rotating earth
% defining an array of the position vector in the frame of refrence of earth at different t
R_orbit2(1,h)=x_orbit(h); 
R_orbit2(2,h)=y_orbit(h);
R_orbit2(3,h)=z_orbit(h);
R_orbit3=Q*R_orbit2(:,h);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rotz_theta=[cos(theta) sin(theta) 0;-sin(theta) cos(theta) 0;0 0 1]; %a rotation matrix to account for earth rotation around it's z_axis for the ground track
R_ground=rotz_theta*R_orbit3;
%calculating the longitude and latitude
l=R_ground(1,:)./sqrt((R_ground(1,:)).^2+(R_ground(2,:)).^2+(R_ground(3,:)).^2);
m=R_ground(2,:)./sqrt((R_ground(1,:)).^2+(R_ground(2,:)).^2+(R_ground(3,:)).^2);
n=R_ground(3,:)./sqrt((R_ground(1,:)).^2+(R_ground(2,:)).^2+(R_orbit3(3,:)).^2);

lat(h)=asin(n);
    if m>0
        lon(h)=acos(l/cos(lat(h)));
    else
        lon(h)=2*pi-acos(l/cos(lat(h)));
    end    
    while lon(h)<-pi
        lon(h)=lon(h)+2*pi;
    end
    while lon(h)>pi
        lon(h)=lon(h)-2*pi;
    end
end
%%%%%%%%%%%%%%%%%%%%%
R_orbit3d=Q*R_orbit2; %an array of the position vector in the frame of refrence of earth at different t
%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2) %plotting the orbit in the frame of refrence of the earth
earth_sphere()
hold on
for time=1:350
fig_2=plot3(R_orbit3d(1,1:time),R_orbit3d(2,1:time),R_orbit3d(3,1:time));
set(fig_2,'color','k')
grid on
pause(0.001)
hold on
end
figure(1) %ploting the orbit in 2 dimensions (in the plane of the orbit)
fig_1=plot(R_orbit2(1,:),R_orbit2(2,:));
set(fig_1,'color','k')
hold on
axis equal

figure(3) %plotting the ground track 
for time=1:5:350
back_ground=imread('background.png');
background = image([-180 180], [180 -180], back_ground);
uistack(background, 'bottom');
hold on
fig_3=plot(lon(1:time)*180/pi,lat(1:time)*180/pi,'.');
set(gca, 'YDir', 'normal');
set(fig_3,'color','k','MarkerSize',20);
hold on
axis tight
pause(0.00001)
end
