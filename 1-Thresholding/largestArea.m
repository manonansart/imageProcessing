function [region, area] = largestArea(image)

	% Label the regions in the binary image
	[labels, nbRegions] = bwlabel(image, 8);

	% Compute the area of all regions
	regions = regionprops(labels, 'basic');

	% Look for the maximum area
	[area label] = max([regions.Area]);

	region = zeros(size(image));
	region(find(labels == label)) = 1;