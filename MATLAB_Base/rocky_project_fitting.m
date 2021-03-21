% Rocky project

% @author: Carlos and Thomas
% Date: March 2021

%% Base System
% A)

steptest_data = csvread('motordata.csv',0,0);
steptest_left = [0; steptest_data(:,1)]% - steptest_data(1,1);
steptest_right = [0; steptest_data(:,2)]% - steptest_data(2,1);
steptest_time = (0:20e-3:20e-3*(max(size(steptest_data))));

VinK_R = mean(steptest_left(80:160));
VinK_L = mean(steptest_right(80:160));

tauR = 0.0794;
tauL = 0.08451;

tau = mean([tauR, tauL])

%a = 12.2018;
fit_a = 11.83;
fit_b = 0.06338;

b = (fit_a * fit_b)/300

K = (fit_a*b)*tau

figure
plot(steptest_time, steptest_left,'b.')
hold on
%plot(steptest_time(80:160) ,steptest_right(80:160),'*')
plot(steptest_time, steptest_right,'r.')
hold off
title('Motor Characteristics')
xlabel('Time [s]')
ylabel('Motor Speed [m/s]')
legend('Left Motor','Right Motor','Location','Southeast')

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
plot(t(peak_index), peak_angle, '*')
hold off
title('Natural Frequency Extraction')
xlabel('Time [s]')
ylabel('Measured Gyroscope Data')
legend('Measured Data','Extracted Peaks')