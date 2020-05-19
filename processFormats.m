%This is for pre-processing the dataset to be used, 

%External reference: 
%https://stackoverflow.com/questions/39115155/read-images-from-sub-folders-and-save-into-another-folder

%Requirement are that:
%The main folder is to be selected /photos, 
%The sub folder of photos, must include folders of images for each student
%e.g. /photos/student1

%Another requirement is another main folder which is where the processed
%photos will be in. /processedFaces,

%The folder inside /processedFaces, must include folders of the each
%student but must be empty. This is the same for grayscale images to be
%processed in folder /grayFaces



% Start with a folder and get a list of all subfolders.
% Finds and prints names of all PNG, JPG, and TIF images in
% that folder and all of its subfolders.
clc;    % Clear the command window.
workspace;  % Make sure the workspace panel is showing.
format longg;
format compact;

% Defining a starting folder.
start_path = fullfile(matlabroot, '\photos');
disp(start_path);
% Ask user to confirm or change.
topLevelFolder = uigetdir(start_path);
disp(topLevelFolder);
disp(start_path);
if topLevelFolder == 0
    return;
end
% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
    [singleSubFolder, remain] = strtok(remain, ';');
    if isempty(singleSubFolder)
        break;
    end
    listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames)

% Process all image files in those folders.
for k = 1 : numberOfFolders
    % Get this folder and print it out.
    thisFolder = listOfFolderNames{k};
    
    [filepath,name,ext] = fileparts(thisFolder);
    foldername=char([name]);
    fprintf('Processing folder %s\n', thisFolder);
    
    %File formats that this script will support, including Videos (so that
    %it can get more photos from videoframes
    
    % Get PNG files.
    filePattern = sprintf('%s/*.mp4', thisFolder);
    baseFileNames = dir(filePattern);
    
    % Add on TIF files.
    filePattern = sprintf('%s/*.tif', thisFolder);
    baseFileNames = [baseFileNames; dir(filePattern)];
    
    %Add on mp4 files.
    filePattern = sprintf('%s/*.mp4', thisFolder);
    baseFileNames = [baseFileNames; dir(filePattern)];
    %
    % 	Add on JPG files.
    filePattern = sprintf('%s/*.jpg', thisFolder);
    baseFileNames = [baseFileNames; dir(filePattern)];
    numberOfImageFiles = length(baseFileNames);
    disp(baseFileNames);
    % 	% Now we have a list of all files in this folder.

    if numberOfImageFiles >= 1
        % Go through all those image files.
        for f = 1 : numberOfImageFiles
            fullFileName = fullfile(thisFolder, baseFileNames(f).name);
            fprintf('     Processing image file %s\n', fullFileName);

            %Depending on what you want
            
            %fixRotation(fullFileName);
            
            %crops face and video frames
            %cropFace(foldername,fullFileName);

            %uses cropped photos to convert them gray and save them for
            % hog classification
            %toGray(foldername,fullFileName);
        end
    else
        fprintf('Folder %s has no image files in it.\n', thisFolder);
    end
end

