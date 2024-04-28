 
    
function enhancedFrame=processVideo(desiredTime, i)    
   
    videoFile = 'video12.mp4'; 
    vidObj = VideoReader(videoFile);
    
     vidObj.CurrentTime = desiredTime;
    
    % Read the frame at the specified time
    frame = readFrame(vidObj);
    
    % Convert the frame to grayscale if it's not already in grayscale
    if size(frame, 3) == 3
        frameGray = rgb2gray(frame);
    else
        frameGray = frame;
    end
    
    % Perform noise reduction (median filtering)
    enhancedFrame = medfilt2(frameGray,[20 20]);
     subplot(2,2,i);
    imshow(enhancedFrame);
    title('Enhanced Frame');
end
Image1 = processVideo(9,1); % Sample fram at a particular time
Image2 = processVideo(16,2); % Reference frame of an empty road
Image2 = imresize(Image2, size(Image1));

% Perform edge detection (using Canny edge detection)
edges1 = edge(Image1, 'Canny');
edges2 = edge(Image2, 'Canny');

subplot(2,2,3);
imshow(edges1);
title('Sample frame');
subplot(2,2,4);
imshow(edges2);
title('Reference frame');
% Compute the percentage match between the two edge-detected images
edgesof1 = sum(edges1(:)==1);
edgesof2=sum(edges2(:)==1);
totalPixels = numel(edges1);
percentageMatch = (edgesof2 / edgesof1) * 100;

% Determine density based on the percentage match
if percentageMatch >= 90
    density = 'Low';
elseif percentageMatch >= 80
    density = 'Medium';
else
    density = 'High';
end

disp(['Percentage Match: ', num2str(percentageMatch), '%']);
disp(['Density: ', density]);

