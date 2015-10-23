function [tumor, tumorArea] = findTumor(image, threshold, doPlot, nbFigure)

	if doPlot
		figure(nbFigure)
		% Show the original image and its histogram
		subplot(2, 2, 1)
		imshow(image)

		subplot(2, 2, 2)
		imhist(image)
	end

	% Binarise the image according to a threshold between 0 and 1
	imageBW = im2bw(image, threshold);

	if doPlot
		% Show the binarised image and its histogram
		subplot(2, 2, 3)
		imshow(imageBW)

		subplot(2, 2, 4)
		imhist(imageBW)
	end

	% Label the regions in the binary image
	[labels, nbRegions] = bwlabel(imageBW, 8);

	% Compute the area of all regions
	regions = regionprops(labels, 'basic');

	% The region representing the tumor the the biggest one, so its area is the max
	tumorArea = max([regions.Area]);

	% We identify the region we are looking for
	labelTumor = find([regions.Area] == tumorArea);

	tumor = zeros(size(imageBW));
	tumor(find(labels == labelTumor)) = 1;