% External Reference for AlexNet CNN method: 
%https://www.mathworks.com/help/deeplearning/ug/transfer-learning-using-alexnet.html
%https://www.mathworks.com/help/deeplearning/ref/trainnetwork.html

% Script for the Pretrained AlexNet CNN

%Provide directory of the dataset
digitDatasetPath = fullfile('C:\Users\amenu\Desktop\Projects\Face-detection-with-Matlab\processedFaces');

%Load the data as an ImageDataStore object
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');

%The amount of unique students are 48
 n = 48;
 imds.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
% ImageDatastore is broken into two dataset, 80% is training and the
% remaining is testing. This is a randomized split
 [Train ,Test] = splitEachLabel(imds,0.8,'randomized');
 
 %%
 %Setting up the Alex CNN
 fc = fullyConnectedLayer(n);
 net = alexnet;
 ly = net.Layers;
 ly(23) = fc;
 cl = classificationLayer;
 ly(25) = cl; 

 % the learning_rate
 learning_rate = 0.00001;
 % the properties set up to train the CNN
 opts = trainingOptions("rmsprop","InitialLearnRate",learning_rate,'MaxEpochs',20,'MiniBatchSize',64,'Plots','training-progress');
 % training the CNN using the training set
 alexCNNModel = trainNetwork(Train, ly, opts);

 %%
 % using the trained AlexNet CNN classifier to predict and see accuracy
 % against test set
 predict = classify(alexCNNModel,Test);
 names = Test.Labels;
 pred = (predict==names);
 s = size(pred);
 acc = sum(pred)/s(1);
 fprintf('The accuracy of the test set is %f %% \n',acc*100);

%%
% Once the CNN model is produced, it is stored for later usage
 save alexCNNModel
