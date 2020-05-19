%Script for the SURF-SVM
% External Reference for SURF method: https://www.mathworks.com/help/vision/ref/imagecategoryclassifier.html

%Provide directory of the dataset
%Load the data as an ImageDataStore object
imds = imageSet('C:\Users\amenu\Desktop\Projects\Face-detection-with-Matlab\processedFaces','recursive');

% Splitting the imagedatastore into training and test set. 80% training and
% 20% testing
[trainingSets, testSets] = partition(imds, 0.8, 'randomize');
%%
bag = bagOfFeatures(trainingSets);
%%
surfModel = trainImageCategoryClassifier(trainingSets, bag);
%Keeps 80% of the strong features from each category and uses K-Means
%clustering to create a 500 word visual vocabulary
confMatrix = evaluate(surfModel, trainingSets);

%Store model for later usuage in testing of unseen data.
save surfModel
