
%Script for the HOG-SVM
% External Reference for HOG method: 
%https://www.mathworks.com/matlabcentral/fileexchange/68985-real-time-facial-recognition-using-hog-features

%Provide directory of the dataset and save into ImageSet
%Replace this with the new directory
imageDatabase = imageSet('C:\Users\amenu\Desktop\Projects\Face-detection-with-Matlab\grayFaces','recursive');

% ImageDatastore is broken into two dataset, 80% is training and the
% remaining 20% is testing. This is a randomized split
[training,test] = partition(imageDatabase,[0.8, 0.2]);

%% Extract HOG Features for training set
trainingFeatures = zeros(size(training,2)*training(1).Count,34596);
featureCount = 1;
for i=1:size(training,2)
    for j = 1:training(i).Count
        trainingFeatures(featureCount,:) = extractHOGFeatures(read(training(i),j));
        trainingLabel{featureCount} = training(i).Description;
        featureCount = featureCount + 1;
    end
    personIndex{i} = training(i).Description;
end

%% Create a classifier using fitcecoc using training features and the training labels
hogClassifier = fitcecoc(trainingFeatures,trainingLabel);
%%
%Save the classifer model for later usuage
save hogClassifier


%% Testing the HOG-SVM Model against the test set
figure;
figureNum = 1;
%The dataset has 48 students and each student has 20% of the 100 images
%saved for testing. This is used for testing the model and gaining the
%accuracy
for person=1:48
    for j = 1:test(person).Count
        queryImage = read(test(person),j);
        queryFeatures = extractHOGFeatures(queryImage);
        personLabel = predict(hogClassifier,queryFeatures);
        % Map back to training set to find identity
        booleanIndex = strcmp(personLabel, personIndex);
        integerIndex = find(booleanIndex);
        %This will cause the model to output 20 images per individual (48)
        %and match them to the trainned model. If the figure is empty,
        %then the matching has failed and is considered incorrect. 
        figure;
        subplot(1,2,1);imshow(queryImage);title('Query Face');
        subplot(1,2,2);imshow(read(training(integerIndex),1));title('Matched Class');
        figureNum = figureNum+2;
    end
    figure;
    figureNum = 1;
end


