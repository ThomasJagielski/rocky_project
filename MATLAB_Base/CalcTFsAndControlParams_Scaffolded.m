syms s a b l g Kp Ki Jp Ji Ci  % define symbolic variables

Hvtheta = -s/l/(s^2-g/l); % TF from velocity to angle of pendulum
K = Kp + Ki/s;  % TF of the angle controller
J = Jp + Ji/s + Ci/s^2; % TF of the controller around the motor
M = a*b/(s+a)  % TF of motor
Md = M/(1+M*J)  % TF of motor + feedback controller around it 
                % J is applied on the feedback path

pretty(collect(Md)) % display Md(s)

Htot = 1/(1-Hvtheta*Md*K)  % this is the total transfer function from disturbance d(t) to \theta(t)

pretty(simplify(Htot)) % display the total transfer function

%% Substitute parameters and solve

% system parameters
g = 9.85; % gravitational acceleration
l = 0.5019;
a = 11.83;
%a = 12.58;
b = 1/400; % motor time constant

Htot_subbed = subs(Htot); % substitutes parameters defined above into Htot

% define the target poles

zeta = 0.0457;
wn = 4.4188;

p1 = -wn + wn * 1j
p2 = -wn - wn * 1j
p3 = -1
p4 = -1
p5 = -14

% this is the target characteristic polynomial
tgt_char_poly = (s-p1)*(s-p2)*(s-p3)*(s-p4)*(s-p5);

% get the denominator from Htot_subbed
[n d] = numden(Htot_subbed);

% find the coefficients of the denominator polynomial TF
coeffs_denom = coeffs(d, s);

% divide out the coefficient of the highest power term
coeffs_denom = coeffs(d, s)/(coeffs_denom(end));

% find coefficients of the target charecteristic polynomial
coeffs_tgt = coeffs(tgt_char_poly, s);

% solve the system of equations setting the coefficients of the
% polynomial in the target to the actual polynomials
solutions = solve(coeffs_denom == coeffs_tgt, Jp, Ji, Kp, Ki, Ci);

% display the solutions as double precision numbers

Jp = double(solutions.Jp);
Ji = double(solutions.Ji);
Kp = double(solutions.Kp);
Ki = double(solutions.Ki);
Ci = double(solutions.Ci);

disp(['float Jp = ',num2str(real(Jp)),';'])
disp(['float Ji = ',num2str(real(Ji)),';'])
disp(['float Kp = ',num2str(real(Kp)),';'])
disp(['float Ki = ',num2str(real(Ki)),';'])
disp(['float Ci = ',num2str(real(Ci)),';'])

impulse_response_from_sym_expression(subs(Htot))