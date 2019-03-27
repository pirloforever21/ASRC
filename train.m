function net = train(trin,trtar)

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. NFTOOL falls back to this in low memory situations.
trainFcn = 'trainlm';

N = size(trin,2);
    
% Create a Fitting Network
hiddenLayerSize = 5;
net = feedforwardnet(hiddenLayerSize,trainFcn);
net.performParam.regularization = 0.001;
        
% Set up Division of Data for Training, Validation, Testing
RandStream.setGlobalStream(RandStream('mt19937ar','seed',1)); % to get constant result
net.divideFcn = 'divideblock'; % Divide targets into three sets using blocks of indices
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 10/100;
net.divideParam.testRatio = 10/100;

%TRAINING PARAMETERS
net.trainParam.show=50;  %# of ephocs in display
net.trainParam.lr=0.01;  %learning rate
net.trainParam.epochs=1000;  %max epochs
net.trainParam.goal=0.05^2;  %training goal
net.performFcn='mse';  %Name of a network performance function %type help nnperformance


%net.inputs{1}.range = [0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1];
%net.layers{1}.transferFcn = 'tansig';

% Train the Network
net.trainParam.showWindow = false;
net = train(net,trin,trtar);
fprintf('training finished......\n')

% View the Network
%view(binnet);