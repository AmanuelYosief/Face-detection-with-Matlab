function  toGray(foldername,var)
% Used to convert a folder of photoes, into grayscale and save them in a
% new directory 
[filepath,name,ext] = fileparts(var);
 disp(char([name,ext]));
if ext == ".jpg"
     I = imread(var);
    J = rgb2gray(I);
    % grayFaces is the new directory
    imwrite(J,['grayFaces\',char(foldername), '\', char([name,ext])]);
    imshow(J);
    disp("Images converted to gray")
end
    
    
    
    
    