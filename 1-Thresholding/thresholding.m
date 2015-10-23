% Two IRM have been taken for a same patient, before a treatment and after.
% The goal here is to measure the change in size of the tumor, based on the two images.
% The first method we try is thresholding.

close all;
clear all;


%% We visualize the images and histograms to see the binarisation
irm1 = imread('../images/IRMcoupe17-t1.jpg');
threshold = 0.36;
[tumor1, area1] = findTumor(irm1, threshold, true, 1);

irm2 = imread('../images/IRMcoupe17-t2.jpg');
[tumor2, area2] = findTumor(irm2, threshold, true, 2);

disp(strcat(strcat('Increase in area of the tumor between the two IRM : ', num2str((area2 - area1)/area1 * 100)), ' %'))


%% We can show that the method is not stable but trying different threshold

ratios = [];
for threshold = 0.35:0.005:0.45
	[tumor1, area1] = findTumor(irm1, threshold, false, 1);
	[tumor2, area2] = findTumor(irm2, threshold, false, 2);
	ratios = [ratios; (area2 - area1)/area1 * 100];
end

figure(3)
plot(0.35:0.005:0.45, ratios, '*-')
title('Evolution of the ratios for different thresholds')
xlabel('thresholds')
ylabel('ratios')
