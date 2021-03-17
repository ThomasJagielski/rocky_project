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
l = 0.4217; % pendulum length [meters] 
a = 0.326086956521739;
b = 0.063775510204082
% a = 14; % motor control parameter
% b = 1/400; % motor time constant

Htot_subbed = subs(Htot); % substitutes parameters defined above into Htot

% define the target poles

p1 = -3 + 2*pi*i
p2 = -3 - 2*pi*i
p3 = -10
p4 = -2
p5 = -3

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

Jp = double(solutions.Jp)
Ji = double(solutions.Ji)
Kp = double(solutions.Kp)
Ki = double(solutions.Ki)
Ci = double(solutions.Ci)

impulse_response_from_sym_expression(subs(Htot))