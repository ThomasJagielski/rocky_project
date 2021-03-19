% Rocky project

% @author: Carlos and Thomas
% Date: March 2021

%% Base System
% A)
%steptest_data = load('steptest.mat');
%sinetest150_data = load('sinetest150.mat');
%sinetest200_data = load('sinetest200.mat');

steptest_data = csvread('motordata-thomas.csv',0,0);
steptest_left = [0; steptest_data(:,1)]% - steptest_data(1,1);
steptest_right = [0; steptest_data(:,2)]% - steptest_data(2,1);
steptest_time = (0:20e-3:20e-3*(max(size(steptest_data))));

VinK_R = mean(steptest_left(80:160));
VinK_L = mean(steptest_right(80:160));
Vin = 300;

%%% Parameters!!!! %%%
Kr = VinK_R / Vin;
Kl = VinK_L / Vin;

tauR = 0.0794;
tauL = 0.08451;

%aR = tauR / Kr;
%aL = tauL / Kl;

tau = mean([tauR, tauL])
%a = mean([aR, aL])

%a = 12.2018;
a = 11.83;
b = 0.06338;

K = (a*b)*tau



%%
figure
plot(steptest_time, steptest_left,'b.')
hold on
plot(steptest_time(80:160) ,steptest_right(80:160),'*')
plot(steptest_time, steptest_right,'r.')
hold off

%%
% B)
load('gyrotest.mat')
angle_rad_normalized = angle_rad - angle_rad(end);

[peak_angle, peak_index] = findpeaks(angle_rad_normalized);

% Fitting Data
t_fit = t(peak_index);

zeta_omegan = 0.2021; % From curve fitting session

damping_fit_time = mean(diff(t(peak_index)));

% Wd = Wn * sqrt(1 - zeta^2)
% Wd = (2 * pi) / T

Wd = (2 * pi) / damping_fit_time; % Hz
zeta = 0.0457;
wn = 4.4188;

% wn = sqrt(g / l_eff)
g = 9.8;
l_eff = g / wn^2;

% Plot Data and Peaks
figure
plot(t, angle_rad_normalized)
hold on
plot(t(peak_index), peak_angle, '.')
hold off

% Much like the rocky robot my total height is 6' 5" but my effective 
% length is slightly shorter at 5' 8".
%%
% C)

%Want to set osicallation freq = to natural freq of the pendulumn sytstem
%Set disturbacne to be small square wave osciallation, criticially damped
%response will reach equilibrium as fast as possible 



% D)




