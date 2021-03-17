% Rocky project

% @author: Carlos and Thomas
% Date: March 2021

%% Base System
% A)
steptest_data = load('steptest.mat');
sinetest150_data = load('sinetest150.mat');
sinetest200_data = load('sinetest200.mat');

fit_t = steptest_data.t(1:150);
fit_R = abs(steptest_data.outputR(1:150));
fit_L = abs(steptest_data.outputL(1:150));

VinK_R = mean(steptest_data.outputR(82:150));
VinK_L = mean(steptest_data.outputL(82:150));
Vin = -200;

%%% Parameters!!!! %%%
Kr = VinK_R / Vin;
Kl = VinK_L / Vin;

tau_R = 1 / 17.35; % found through cftool fitting
tau_L = 1 / 15.68; % found through cftool fitting

%%% End Parameters!!!! %%%

figure
plot(steptest_data.t,steptest_data.outputL)
hold on
plot(steptest_data.t,steptest_data.outputR)
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




