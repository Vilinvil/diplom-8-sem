function [rotatedImages] = generate_array_rotated_image(...
    imageFileName, minAngleRotate, maxAngleRotate, stepAngleRotate)

    image = imread(imageFileName);
    
    rotatedImages = cell(1, (maxAngleRotate - minAngleRotate)/stepAngleRotate);
    
    for idxStep = 0:(maxAngleRotate - minAngleRotate)/stepAngleRotate
        curAngleRotate = minAngleRotate + idxStep*stepAngleRotate;
    
        curRotatedImage = imrotate(image, curAngleRotate, 'bicubic', 'crop');
        
        curCropImage = imcrop(curRotatedImage, [70 40 100 60]);
    
        rotatedImages{idxStep + 1} = curCropImage;
    end
end
