%%

n = 100;

p = zeros(1,n);
for i = 1:n
    a = rand() * 9 - 3;
    p(i) = a;
end

t = sin(p); % + randn()*0.01;

%%

net = feedforwardnet;
net = configure(net,p,t);

%% 

net = init(net);

%% 

net.trainParam.epochs = 300;
net.trainParam.goal = 1e-6;

[net,tr]=train(net,p,t);

%%

x = -3:0.1:6;
plot(x, sim(net,x));
hold on;
plot(x, sin(x));
hold off;

% fixunkowns
