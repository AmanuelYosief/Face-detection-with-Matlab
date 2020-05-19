function testSURFClassifier(var)
% The trained model from surfClassifier.m (script) is loaded to be used here
% Detecting Multiples Boxes and Extracting boundingBox is from Lecture 7 Labs. 
load('surfModel.mat')
%%
% Retrieves the image file to classify using the model
I = imread(var);
imshow(I);
FaceDetector = vision.CascadeObjectDetector();
shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[0 255 255]);
bbox = step(FaceDetector, I);

% Checks if the Bounding Box has detected any faces
if ~isempty(bbox)
    %Bounding box isn't empty, retrieves the amount of bounding boxes, this
    %is suggested to be equal to the amount of faces detected
    N = size(bbox, 1);
    P = [];
    for i=1:N
        % Extract ith face
        a = bbox(i, 1);
        b = bbox(i, 2);
        c = a+bbox(i, 3);
        d = b+bbox(i, 4);
        F = I(b:d, a:c, :);
        J=imcrop(I,bbox(i,:));
        newImageSize = imresize(J, [227, 227]);
        [labelIdx, ~] = predict(categoryClassifier, newImageSize);
        
        RBG = insertText(F,[0,50],char(categoryClassifier.Labels(labelIdx)),'FontSize', 30, 'BoxColor', 'white','AnchorPoint','LeftBottom');
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
        values = [str2double(categoryClassifier.Labels(labelIdx)), xCenter, yCenter];
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