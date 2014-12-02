%%

minx = -3;
maxx = 6;
n = 100;

X = zeros(1,n);
for i = 1:n
    a = rand() * (maxx - minx) + minx;
    X(i) = a;
end

T = sin(X);

%%

eg = 0.02; % sum-squared error goal
sc = 1;    % spread constant
net = newrb(X,T,eg,sc);

%%

plot(X,T,'+');
xlabel('Input');

X = minx:.01:maxx;
Y = net(X);

hold on;
plot(X,Y);
hold off;
legend({'Target','Output'})