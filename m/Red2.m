% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by NPRTOOL
% Created Fri Feb 21 18:32:59 CLST 2014
%
%    C�digo generado para trabajo de memoria de t�tulo
%  "Clasificacion de Galaxias mediante Machine Learning"
%    por Gabriel Salazar Vergara <lsalazarv@udec.cl>
%
% This script assumes these variables are defined:
%
%   adptivemoments_u - input data.
%   salida - target data


%%%%%%%%%%%%%%%%Carga de datos%%%%%%%%%%%%%%%%%%
%% Initialize variables.
filename = 'adaptivemoments_u.csv';
delimiter = ',';

%% Format string for each line of text:
formatSpec = '%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Create output variable
adaptivemomentsu = [dataArray{1:end-1}];
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;

%% Initialize variables.
filename = 'salida.csv';
delimiter = ',';

%% Format string for each line of text:
formatSpec = '%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Create output variable
salida = [dataArray{1:end-1}];
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;


%%%%%%%%%%%%%%Red Neuronal%%%%%%%%%%%%%%%%

for i=1:10   %%Itereaciones de prueba
x = adaptivemomentsu';
t = salida';

% Create a Pattern Recognition Network
hiddenLayerSize = 24;
net = feedforwardnet([hiddenLayerSize hiddenLayerSize]);


% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.input.processFcns = {'removeconstantrows','mapstd'};
net.output.processFcns = {'removeconstantrows','mapstd'};


% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
net.divideFcn = 'divideint';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 85/100;
net.divideParam.valRatio = 10/100;
net.divideParam.testRatio = 5/100;


% For help on training function 'trainscg' type: help trainscgperf = perform(net,y,t)
% For a list of all training functions type: help nntrain
net.trainFcn = 'trainbfg';  % quasi-Newton
%net.trainParam.mc = 0.9;
%net.trainParam.epochs = 1000;
%net.trainParam.min_grad = 1e-6;
net.trainParam.max_fail = 10;
%net.trainParam.showWindow = 1;
net.trainParam.showWindow = true;
net.trainParam.showCommandLine = true;
net.trainParam.show= 1;



% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Cross-entropy

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression','plotroc','plotconfusion'};


net = init(net);
% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);
performance = perform(net,t,y)

% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t  .* tr.valMask{1};
testTargets = t  .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,y)
valPerformance = perform(net,valTargets,y)
testPerformance = perform(net,testTargets,y)

% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, plotconfusion(t,y)
figure, plotroc(t,y)
figure, ploterrhist(e)

% Deployment
% Change the (false) values to (true) to enable the following code blocks.
if (false)
  % Generate MATLAB function for neural network for application deployment
  % in MATLAB scripts or with MATLAB Compiler and Builder tools, or simply
  % to examine the calculations your trained neural network performs.
  genFunction(net,'myNeuralNetworkFunction');
  y = myNeuralNetworkFunction(x);
end
if (false)
  % Generate a matrix-only MATLAB function for neural network code
  % generation with MATLAB Coder tools.
  genFunction(net,'myNeuralNetworkFunction','MatrixOnly','yes');
  y = myNeuralNetworkFunction(x);
end
if (false)
  % Generate a Simulink diagram for simulation or deployment with.
  % Simulink Coder tools.
  gensim(net);
end
end