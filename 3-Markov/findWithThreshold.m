function [region, regionArea] = findWithThreshold(image, threshold, doPlot, nbFigure)

	% Show the original image and its histogram
	if doPlot
		figure(nbFigure)
		subplot(2, 2, 1)
		imshow(image)

		subplot(2, 2, 2)
		imhist(image)
	end

	% Binarise the image according to a threshold between 0 and 1
	imageBW = im2bw(image, threshold);

	
	% Show the binarised image and its histogram
	if doPlot
		subplot(2, 2, 3)
		imshow(imageBW)

		subplot(2, 2, 4)
		imhist(imageBW)
	end

	[region, regionArea] = largestArea(imageBW);