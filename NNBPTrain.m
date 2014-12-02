%% Training Multi-Layered Neural Networks in MATLAB
% See
% <http://www.mathworks.com/help/nnet/ug/multilayer-neural-networks-and-bac
% kpropagation-training.html?searchHighlight=backpropagation Multilayer
% Neural Networks and Backpropagation Training>.
%
% Multi-layer neural networks are designed and applied in 7 steps
%
% # Collect data
% # Create the network
% # Configure the network
% # Initialize the weights and biases
% # Train the network
% # Validate the network (post-training analysis)
% # Use the network
%
% Let us show it on little example.
%% Collecting data
% Here we can use various preprocessing functions (e.g. normalization).
% Input and target (desired output) vectors are column vectors.
p = [-10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10
      -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 1 1 1 1 1 1 1 1 1  1];
t = [10   9  8  7  6  5  4  3  2  1 0 1 2 3 4 5 6 7 8 9 10];
%% Creating and configuring the network
% At first we create a feedforward network. Feedforward network is an
% alternative name  for multi-layer neural networks without recurrent
% synapses.
net = feedforwardnet;
% The function |feedforwardnet| has two optional parameters
%
%   feedforwardnet(hiddenSizes,trainFcn)
% where
% 
% * |hiddenSizes| is either an iteger - a size (the nunber of neurons; (default = 10) of a 
%   single hidden layer, or a vector |[i1,i2,...,ik]| of sizes of hidden layers 
% * |trainFcn| is a string - the name of a training fuction (default =
% 'trainlm')
%
% Next, we configure the network by providing the training patterns |p| 
% and target vectors |t|. 
net = configure(net,p,t);
% The command |configure| configures the network object and also 
% initializes the weights and biases of the network. The number of inputs 
% to the network is determinid from the number of rows of |p|. Similarly,
% the size of the output layer is derived from the number of rows of |t|.
% Therefore the network
% is ready for training. 
%% Initializing weights and biases
% During the search for proper network we might
% want to reinitialize the network. For this we can call function |init|
net = init(net);
%% Training
% Actual training perform two different functions
% 
% * |train| performs batch training, where the weights and biases are only 
%   updated after all the inputs are presented
% * |adapt| performs incremental learning, where the weights and biases 
%   of the network are updated each time an input is presented to 
%   the network.
%
% We will use batch training, i.e. the function |train|. Batch training is
% more efficient than incremental learning. Actually, when using |train|,
% it is not necessary to use |configure| for configuring the network, as
% the function |train| calls |configure| when the network is not
% initialized.
[net,tr]=train(net,p,t);
% The function |train| returns adapted network in the first returned value
% and a log of the training in the secong returned structure.
% During training, a training window will appear. If you do not want to
% have this window displayed during training, you can set the parameter
% net.trainParam.showWindow to false. If you want training information 
% displayed in the command line and not in the window,you can set the 
% parameter |net.trainParam.showCommandLine| to |true|.
% 
% There are several parameters which can be used to stop network training. 
% * |net.trainParam.min_grad| minimum gradient magnitude - if reached, the
% training stops,
% * |net.trainParam.max_fail| the number of successive iterations that the 
%   validation performance fails to decrease - if reached, the training
%   stops and the returned network is that obtained before the validation
%   performance started to increase (this should prevent overfitting),
% * |net.trainParam.time| is the maximum allowed training time
% * |net.trainParam.goal| is the target performance value; the default 
%   performace function of a network is |mse| - mean square error; the
%   default value fdor the |goal| is 1.0e-5.
% * |net.trainParam.epoch| is the maximum number of sweeps through the
% whole trainng set.
% 
% For instance, we can set
net.trainParam.epochs = 300;
net.trainParam.goal = 1e-6;
% and continue training of the network
[net,tr]=train(net,p,t);

%% Post training analysis of the network
% A lot of information about the training is stored in the returned
% structure |tr|
tr
% This structure contains information collected during the training of
% the network. We can see indices of input patterns which were used 
% for training set - |tr.trainInd|, for the validation set - |tr.valInd| 
% and for the trsting set |tr.testInd|. For additional training of the 
% network with the same division of data between trainig, validation and 
% we can set |net.divideFcn| to |'divideInd'|,
% |net.divideParam.trainInd| to |tr.trainInd|, |net.divideParam.valInd| to
% |tr.valInd|, |net.divideParam.testInd| to |tr.testInd|. 

% The |tr| conains alsoa log of several variables during the course of
% training, such as the value of the performance function, the magnitude of
% the gradient, etc. We can use the training record to plot the
% performance progress by using the |plotperf| command: 

plotperf(tr)

% However, we can call |train| without storing information on training.
net=train(net,p,t);
% During the trainig or after the training it is possible to inspect 
% the training process. During training we can watch the error function
% (the button |Performance|), training state (the button |Training State|).

     
     
%% Applying the trained network
% This window shows that the data has been divided using the |dividerand|
% function, and the Levenberg-Marquardt (|trainlm|) training method has been
% used with the mean square error performance function (|mse|). Recall that these
% are the default settings for feedforwardnet.

% During training, the progress is constantly updated in the training
% window. Of most interest are the performance, the magnitude of the
% gradient of performance and the number of validation checks. The
% magnitude of the gradient and the number of validation checks are used to
% terminate the training. The gradient will become very small as the
% training reaches a minimum of the performance. If the magnitude of the
% gradient is less than 1e-5, the training will stop. This limit can be
% adjusted by setting the parameter |net.trainParam.min_grad|. The number of
% validation checks represents the number of successive iterations that the
% validation performance fails to decrease. If this number reaches 6 (the
% default value), the training will stop. In this run, you can see that the
% training did stop because of the number of validation checks. You can
% change this criterion by setting the parameter |net.trainParam.max_fail|.
% (Note that your results may be different than those shown in the
% following figure, because of the random setting of the initial weights
% and biases.)

% The next step in validating the network is to create a regression plot,
% which shows the relationship between the outputs of the network and the
% targets. 
% After training we can plot regression graphs (the button |Regression|).

%     \includegraphics[width=10.5cm]{regres}

% If the training were perfect, the network outputs and the
% targets would be exactly equal, but the relationship is rarely perfect in
% practice.

%% Data Transformations
%
% Neural network training can be more efficient if we preprocess input and 
% Various normalization functions are already implemented within the Neural 
% Network Toolbox. Moreover, many typrs of neural networks peerform such
% preprocessing and postprodcessing automatically. E.g. the feed-forward 
% neural networks 
%
% # replaces missing values |NaN| in the input patterns
% by the average values for the respective attributes,
% # leaves out constant rows, and
% # normalizes the input values using min-max normalization to the interval 
% $\angle -1,1 \rangle$.
%
% This is stored in the network object

net.inputs{1}.processFcns
     
% where the index 1 refers to the first input vector. (There is only one input vector for the feedforward network.).
% The |i|-th input processing function can have parameters 
%  net.inputs{1}.processParams{i}

%Similarly, outputs of the network are processed with the functions

net.outputs{2}.processFcns

% where the index 2 refers to the output vector coming from the second
% layer. For the feedforward network, there is only one output vector, and
% it comes from the final layer.

% Note that the same transformations must be dobne also on new data.

%% Min-max normalization to the interval $\langle -1,1 \rangle$
% can be applied on input and also for output data

[pn,ps] = mapminmax(p);
[tn,ts] = mapminmax(t);
net = train(net,pn,tn);

% |pn| and |tn| are the transformed input and target patterns, respective. 
% The returned |ps| and |ts| are the parameters of the respective 
% transformations, which will be used for transformations on new data and 
% for the inverse transformation of outputs. After using the trained network,
% we must transform the outputs of the network back into the original range 
% of the outputs.
 
an = sim(net,pn);
a = mapminmax('reverse',an,ts);

% On a new data, we must use the same transformation as on the training
% patterns.
 
pnewn = mapminmax('apply',pnew,ps);
anewn = sim(net,pnewn);
anew = mapminmax('reverse',anewn,ts);

%% |mapstd| - normalization
% Normalize inputs/targets to have zero mean and unity
% variance\subsection{?k?lovanie pod?a priemeru a ?tandardnej odch?lky}
[pn,ps] = mapstd(p);
[tn,ts] = mapstd(t);


an = sim(net,pn);
a = mapstd('reverse',an,ts);

pnewn = mapstd('apply',pnew,ps);
anewn = sim(net,pnewn);
anew = mapstd('reverse',anewn,ts);

%% Principal Component Analysis}
%
% Najprv je treba d?ta normalizova? tak, aby mali stredn? hodnotu 0 a
% rozptyl 1. Potom m??eme urobi? PCA anal?zu.

[pn,ps1] = mapstd(p);
[ptrans,ps2] = processpca(pn,0.02);

% Pri vy??ie uvedenej transform?cii sa vynechaj? zlo?ky, ktor?
% prispievaj? menej ne? 2\% k celkov?mu rozptylu. Ak chceme t?to
% transform?ciu pou?i? na nov?ch ?dajoch


pnewn = mapstd('apply',pnew,ps1);
pnewtrans = processpca('apply',pnewn,ps2);
a = sim(net,pnewtrans);
