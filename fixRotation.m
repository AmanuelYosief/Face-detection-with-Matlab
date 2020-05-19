function  fixRotation(var)
IM = imread(var);
info = imfinfo(var);
if isfield(info,'Orientation')
    orient = info(1).Orientation;
    switch orient
        case 1
            %normal
            disp('No rotation is required');
        case 2
            IM = IM(:,end:-1:1,:);         %right to left
            imwrite(IM,var);
            disp('Image is correctly rotated and overwritten');
        case 3
            IM = IM(end:-1:1,end:-1:1,:);  %180 degree rotation
            imwrite(IM,var);
            disp('Image is correctly rotated and overwritten');
        case 4
            IM = IM(end:-1:1,:,:);         %bottom to top
            imwrite(IM,var);
            disp('Image is correctly rotated and overwritten');
        case 5
            IM = permute(IM, [2 1 3]);     %counterclockwise and upside down
            imwrite(IM,var);
            disp('Image is correctly rotated and overwritten');
        case 6
            IM = rot90(IM,3);              %undo 90 degree by rotating 270
            imwrite(IM,var);
            disp('Image is correctly rotated and overwritten');
        case 7
            IM = rot90(IM(end:-1:1,:,:));  %undo counterclockwise and left/right
            imwrite(IM,var);
            disp('Image is correctly rotated and overwritten');
            
        case 8
            IM = rot90(IM);                %undo 270 rotation by rotating 90
            imwrite(IM,var);
            disp('Image is correctly rotated and overwritten');
        otherwise
            disp('unknown orientation %g ignored\n', orient);
    end
    
    
else
    
    disp('No need to rotate image');
end
end












