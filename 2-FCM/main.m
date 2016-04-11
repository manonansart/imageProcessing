% Two IRM have been taken for a same patient, before a treatment and after.
% The goal here is to measure the change in size of the tumor, based on the two images.
% In this file we tryu a second method : fuzzy c-means of fcm.

close all;
clear all;

irm1 = imread('../images/IRMcoupe17-t1.jpg');
irm2 = imread('../images/IRMcoupe17-t2.jpg');

fuzzinessIndex = 2;
% [tumor1, area1] = findTumorFcm(irm1, fuzzinessIndex, 10^-8, 'threshold',false, 1);
% [tumor2, area2] = findTumorFcm(irm2, fuzzinessIndex, 10^-8, 'threshold', false, 1);

% disp(strcat(strcat('Increase in area of the tumor between the two IRM, with threshold initialization : ', num2str((area2 - area1)/area1 * 100)), ' %'))

tic
[tumor1, area1] = findTumorFcm(irm1, fuzzinessIndex, 10^-1, 'random',false, 1);
toc
[tumor2, area2] = findTumorFcm(irm2, fuzzinessIndex, 10^-1, 'random', false, 1);

disp(strcat(strcat('Increase in area of the tumor between the two IRM, with random initialization : ', num2str((area2 - area1)/area1 * 100)), ' %'))


% %% Let's try different fuzziness indexes to see if the method is stable

% tries = round(logspace(0, 3, 10))
% ratios = [];
% for k = 1:length(tries)
% 	fuzzinessIndex = tries(k);
% 	[tumor1, area1] = findTumorFcm(irm1, fuzzinessIndex, 10^-8, 'threshold', false, 1);
% 	[tumor2, area2] = findTumorFcm(irm2, fuzzinessIndex, 10^-8, 'threshold', false, 1);
% 	ratios = [ratios; (area2 - area1)/area1 * 100];
% end

% figure(4)
% plot(tries, ratios, '*-')


%% Let's try with a random initalisation:

% ratios = [];
% for k = 1:length(tries)
% 	fuzzinessIndex = tries(k);
% 	[tumor1, area1] = findTumorFcm(irm1, fuzzinessIndex, 10^-8, 'random', false, 1);
% 	[tumor2, area2] = findTumorFcm(irm2, fuzzinessIndex, 10^-8, 'random', false, 1);
% 	ratios = [ratios; (area2 - area1)/area1 * 100];
% end
% plot(tries, ratios, '*-r')
% title('Evolution of the ratios for different fuzziness indexes with a random initialization')
% xlabel('fuzziness indexes')
% ylabel('ratios')
