%% first task

% at first we reset the random number generator; in this
% way we obtain in each run the same training data
stream = RandStream.getGlobalStream; reset(stream)

% generate random training samples
In = randn(2,600);

% generate random desired outputs for the training samples
c = In(1,: )-3*In(2,: ) >= 0.5

% set the learning parameters for the perceptron learning
% algorithm:
%     an extended weight vector,
%     a learning rate, and
%     a maximal number of epochs
Par1 = {[1 1 -1], 1, 10}
Par2 = {[1 1 -1], 1, 100}

%run 5-fold cross-validationa
[d,s] = CrossVal('PLearn', 'PRecall',Par1, 'PLearn', 'PRecall',Par2,In,c,5);
display('Comparing perception learning with at most 10 epochs and at most 100 epochs');

%compute 95% confidence intervals
N = 95;
k = 5;
t = tinv((N + 100)/200,k-1);
fprintf('mean: %f, sd: %f\n', d, s);
fprintf('95%% confidence interval: [%f, %f]\n',  d - t*s, d + t*s);

%% second task

% at first we reset the random number generator; in this
% way we obtain in each run the same training data
stream = RandStream.getGlobalStream; reset(stream)

% generate random desired outputs for the training samples
In = randi(20,4,300);
c = In(1,: )-3*In(2,: )+2*In(3,: )-In(4,: )>= 0;

% set the learning parameters for the perceptron learning
% algorithm:
%     an extended weight vector,
%     a learning rate, and
%     a maximal number of epochs
Par1 = {[1 1 1 1 -1], 1, 50}
Par2 = {}

%run 5-fold cross-validationa
[d,s] = CrossVal('PLearn', 'PRecall',Par1, 'Memorizer', 'MemorizerRecall',Par2,In,c,6);
display('Comparing perception learning with at most 50 epochs and memorizer algorithm');

%compute 95% confidence intervals
N = 95;
k = 6;
t = tinv((N + 100)/200,k-1);
fprintf('mean: %f, sd: %f\n', d, s);
fprintf('95%% confidence interval: [%f, %f]\n',  d - t*s, d + t*s);
