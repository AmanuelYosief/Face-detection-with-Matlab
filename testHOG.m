function testHOG(var)
% The trained model from CNN.m (script) is loaded to be used here
% Detecting Multiples Boxes and Extracting boundingBox is from Lecture 7 Labs. 
load('hogModel.mat');
%%
% Retrieves the image file to classify using the model
I = imread(var);
FaceDetector = vision.CascadeObjectDetector();
shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[0 255 255]);
bbox = step(FaceDetector, I);
% Checks if the Bounding Box has detected any faces
if ~isempty(bbox)
    
    %Bounding box isn't empty, retrieves the amount of bounding boxes, this
    %is suggested to be equal to the amount of faces detected
    N = size(bbox, 1);
    P = [];
    %% If the test image detects more than one face
    for i=1:N
        %For every Face detected, this script takes in the dimensions of
        %the bounding box
        % Extract ith face
        a = bbox(i, 1);
        b = bbox(i, 2);
        c = a+bbox(i, 3);
        d = b+bbox(i, 4);
        F = I(b:d, a:c, :);
        % For every face, crop the face out
        J=imcrop(I,bbox(i,:));
        % Resize the iamge to the default, that has been decided
        newImageSize = imresize(J, [256, 256]);
        queryImage = newImageSize;
        % Extract hog feature for the image that will be queried/tested
        featureVector = extractHOGFeatures(rgb2gray(queryImage));
        % Use saved model to predict classify the image to a specific student
        personLabel = predict(hogClassifier,featureVector);
        RBG = insertText(F,[0,50],str2double(personLabel),'FontSize', 30, 'BoxColor', 'white','AnchorPoint','LeftBottom');
        I(b:d, a:c, :) = RBG;
        
        % Calculating the center of the face, X and Y values of each
        % bounding box from the TOP X and Left Y value of the image
        xValue = bbox(i,1);
        yValue = bbox(i,2);
        
        % The width of each bounding box and height
        width = bbox(i,3);
        height = bbox(i,4);
        
        %Calculation to find the center of the bounding box from the image.
        xCenter = xValue+(width/2);
        yCenter = yValue+(height/2);
        
        %Stores the classified/predicted value of the student, and the
        %center of their bounding box into a matrix
        values = [str2double(personLabel), xCenter, yCenter];
        P(end+1,:) = values;
        
    end
    P
    I_faces = step(shapeInserter, I, int32(bbox));
    figure
    imshow(I_faces);
else
    % No Face detected
    disp("No face detected");
end

end
