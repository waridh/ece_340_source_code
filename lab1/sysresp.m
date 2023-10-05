function y=sysresp(x, a)
%
% computes the output in response to an arbitrary input x[n], n=0, N-1
% assume that the system has 0 initial conditions
% input:
% x: the input signal,
% a: the system parameter
% output:
% y: the output signal
N = length(x); % length of the vector
% initialization of the output signal

% the first element in y is y[0], the second is y[1], ...
% note that in Matlab, the vector index starts from 1 and must be a pos. integer
% so the output at time n (y[n]) is the (n+1)th element in the vector y
% we are interested in the output for 0<=n<=N-1
% assume that y[n]=0 for n<0, first calculate y[0]

% finding the output y[1] to y[N-1]

% Since it is not memoryless, I have to use a for loop for the solution.
y = zeros(1, N);
y_last = 0; % This is the k < 0 case since we start from k = 0

% By assigning y_last, we can keep the code understandable
for i= 1:N
    y(i) = x(i) + (a * y_last);
    y_last = y(i);
end


return