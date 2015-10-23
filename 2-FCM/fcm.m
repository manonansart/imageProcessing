% Two IRM have been taken for a same patient, before a treatment and after.
% The goal here is to measure the change in size of the tumor, based on the two images.
% In this file we tryu a second method : fuzzy c-means of fcm.

close all;
clear all;

irm1 = imread('../images/IRMcoupe17-t1.jpg');
% We consider the tumor as C1 and the rest as C2

% We initialize the FCM using the first method: threshold
threshold = 0.1;
[brain, tmp] = findTumor(irm1, threshold, false, 0);
threshold = 0.4;
[tumor, tmp] = findTumor(irm1, threshold, false, 0);

% Initialization of the memberships
muC1 = double(tumor);
muC2 = double(brain - tumor);
muC3 = double(ones(size(brain)) - brain);
irm1 = double(irm1);
mu = {muC1, muC2, muC3};


% Fuzziness index
m = 3;
% Precision
epsilon = 10^-8;

% Plot the initial memberships for the 3 classes
figure(1)
subplot(3, 2, 1)
imshow(muC1 * 255)
subplot(3, 2, 3)
imshow(muC2 * 255)
subplot(3, 2, 5)
imshow(muC3 * 255)

allJ = [];
print length(all)
firstStep = true;
i = 1;

while (doNextStep(allJ, epsilon))
	if firstStep
		firstStep = false;
	else
		% New memberships
		muC1 = 1 ./ (ones(size(d1)) + (d1 ./ d2).^(2/(m-1)) + (d1 ./ d3).^(2/(m-1))); 
		muC2 = 1 ./ ((d2 ./ d1).^(2/(m-1)) + ones(size(d2)) + (d2 ./ d3).^(2/(m-1)));
		muC3 = 1 ./ ((d3 ./ d1).^(2/(m-1)) + (d3 ./ d2).^(2/(m-1)) + ones(size(d3)));
	end

	v1 = sum(sum(muC1.^m .* irm1)) / sum(sum(muC1.^m));
	v2 = sum(sum(muC2.^m .* irm1)) / sum(sum(muC2.^m));
	v3 = sum(sum(muC3.^m .* irm1)) / sum(sum(muC3.^m));

	% Distances between the points and the mean
	d1 = abs(irm1 - v1);
	d2 = abs(irm1 - v2);
	d3 = abs(irm1 - v3);

	J = sum(sum(muC1.^m .* d1.^2)) + sum(sum(muC2.^m .* d2.^2)) + sum(sum(muC3.^m .* d3.^2));
	allJ = [allJ; J];
	
	% To know how many step we did
	if(mod(i, 50) == 0)
		i
	end
	i = i + 1;
end

% Plot the final states
subplot(3, 2, 2)
imshow(round(muC1 * 255), colormap('gray'))
subplot(3, 2, 4)
imshow(round(muC2 * 255), colormap('gray'))
subplot(3, 2, 6)
imshow(round(muC3 * 255), colormap('gray'))