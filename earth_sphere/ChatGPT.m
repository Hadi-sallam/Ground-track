% % Load TLE data
% tle_url = 'http://www.celestrak.com/NORAD/elements/stations.txt'; % URL for ISS TLE data
% tle_data = webread(tle_url); % Download TLE data
% tle_lines = split(tle_data, newline); % Split TLE data into lines
% iss_tle = tle_lines(1:3); % Extract TLE data for ISS

% Initialize variables
mu = 398600.4418; % Earth's gravitational parameter (km^3/s^2)
n = sqrt(mu/(iss_tle(3)^2)); % Mean motion (rad/s)
a = (mu/n^2)^(1/3); % Semi-major axis (km)
e = str2double(iss_tle(2)); % Eccentricity
i = deg2rad(str2double(iss_tle(3))); % Inclination (rad)
raan = deg2rad(str2double(iss_tle(4))); % Right ascension of the ascending node (rad)
w = deg2rad(str2double(iss_tle(5))); % Argument of perigee (rad)
M0 = deg2rad(str2double(iss_tle(6))); % Mean anomaly at epoch (rad)
t0 = str2double(iss_tle(1)); % Epoch time (Julian date)

% Compute ground track
tspan = 0:60:90*60*2; % Time span (s)
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8); % ODE solver options
[t, y] = ode45(@(t, y) ode_func(t, y, mu), tspan, coe2rv(a, e, i, raan, w, M0, mu), options); % Solve ODE
lat = rad2deg(asin(y(:, 3)./sqrt(y(:, 1).^2 + y(:, 2).^2 + y(:, 3).^2))); % Latitude (deg)
lon = rad2deg(atan2(y(:, 2), y(:, 1))); % Longitude (deg)

% Plot ground track
figure;
plot(lon, lat, 'b', 'LineWidth', 1.5);
xlabel('Longitude (deg)');
ylabel('Latitude (deg)');
title('ISS Ground Track');
grid on;

function dydt = ode_func(t, y, mu)
% ODE function for numerical integration
r = y(1:3);
v = y(4:6);
a = -mu*r/norm(r)^3;
dydt = [v; a];
end

function rv = coe2rv(a, e, i, raan, w, M0, mu)
% Convert COEs to position and velocity vectors
E0 = kepler(M0, e);
M = M0 + sqrt(mu/a^3)*(t - t0);
E = kepler(M, e);
nu = 2*atan2(sqrt(1 + e)*tan(E/2), sqrt(1 - e));
r = a*(1 - e*cos(E));
h = sqrt(mu*a*(1 - e^2));
p = a*(1 - e^2);
v = h/r*[cos(nu); sin(nu); 0];
QXx = [cos(raan) cos(i)*sin(raan) sin(i)*sin(raan);
       -sin(raan) cos(i)*cos(raan) sin(i)*cos(raan);
       0 sin(i) cos(i)];
QxW = [cos(w) sin(w) 0;
       -sin(w) cos(w) 0;
       0 0 1];
QWxI = [1 0 0;
        0 cos(i) sin(i);
        0 -sin(i) cos(i)];
QXxW = QXx*QxW;
QXxWxI = QXxW*QWxI;
rv = QXxWxI*[r*cos(nu); r*sin(nu); 0];
rv = [rv; QXxWxI*v];
end

function E = kepler(M, e)
% Solve Kepler's equation for eccentric anomaly
tol = 1e-12;
E = M;
dE = 1;
while abs(dE) > tol
    dE = (E - e*sin(E) - M)/(1 - e*cos(E));
    E = E - dE;
end
end