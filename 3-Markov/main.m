% Two IRM have been taken for a same patient, before a treatment and after.
% The goal here is to measure the change in size of the tumor, based on the two images.
% In this file we tryu a second method : fuzzy c-means of fcm.

close all;
clear all;

irm1 = imread('../images/IRMcoupe17-t1.jpg');
irm2 = imread('../images/IRMcoupe17-t2.jpg');

% Initialize manually for U1 :
fprintf('Select the brain\n')
brain = roipoly(irm1);
fprintf('Select the tumor\n')
tumor = 2 * roipoly(irm1);

mean0 = mean(irm1(find(brain + tumor == 0)))
mean1 = mean(irm1(brain));
mean2 = mean(irm1(tumor));

classes = brain;
classes(tumor) = 2

nbClasses = 3
classMeans = [];
classVars = [];
for nClass = 0:nbClasses-1
	classMeans = [classMeans mean(irm(find(classes == i)))]
	classVars = [classVars var(irm(find(classes == i)))]
end

% On choisit une zone pour connaitre la moyenne et l'écart type des intensités de cette classe.
% Cela nous permet de calculer u1 : proba gaussienne (exp)

% Pour U2:
% On initialise avec les fcm. 
% Cela nous permet de connaitre des classes initiales pour chaque pixels. 
% Pour chaque pixel on calcule donc U2 en regardant le nombre de voisins différents

% On minimise U1 + U2 avec ICM