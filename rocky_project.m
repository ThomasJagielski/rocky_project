% Rocky project
% @author: Carlos and Thomas
% Date: March 2021

%% Base System
% A)
angle_rad_normalized = angle_rad - angle_rad(end);

[peak_angle, peak_index] = findpeaks(angle_rad_normalized);

% Fitting Data
t_fit = t(peak_index);

zeta_omegan = 0.2021; % From curve fitting session

damping_fit_time = mean(diff(t(peak_index)));

% Wd = Wn * sqrt(1 - zeta^2)
% Wd = (2 * pi) / T

Wd = (2 * pi) / damping_fit_time; % Hz

% Plot Data and Peaks
figure
plot(t, angle_rad_normalized)
hold on
plot(t(peak_index), peak_angle, '.')
hold off

% Much like the rocky robot my total height is 6' 5" but my effective 
% length is slightly shorter at 5' 8".
