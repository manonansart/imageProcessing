function [tumor, tumorArea] = findTumorFcm(irm, fuzziness, epsilon, init, doPlot, nbFigure)

	% Initialization
	if strcmp(init,'random')
		muC1 = round(rand(size(irm)));
		muC2 = round(rand(size(irm)));
		muC3 = round(rand(size(irm)));

	else
		% We initialize the FCM using the first method: threshold
		threshold = 0.1;
		[brain, tmp] = findWithThreshold(irm, threshold, false, 0);
		threshold = 0.4;
		[tumor, tmp] = findWithThreshold(irm, threshold, false, 0);

		% Initialization of the memberships
		muC1 = double(tumor);
		muC2 = double(brain - tumor);
		muC3 = double(ones(size(brain)) - brain);
	end 

	if doPlot
		% Plot the initial memberships for the 3 classes
		figure(nbFigure)
		subplot(3, 2, 1)
		imshow(muC1 * 255)
		title('Initialisations')
		subplot(3, 2, 3)
		imshow(muC2 * 255)
		subplot(3, 2, 5)
		imshow(muC3 * 255)
	end

	% Apply the fcm algorithm
	mu = {muC1 muC2 muC3};
	[classes, v] = fcm(double(irm), mu, fuzziness, epsilon);

	muC1 = classes{1};
	muC2 = classes{2};
	muC3 = classes{3};

	% Plot the final memberships
	if doPlot
		subplot(3, 2, 2)
		imshow(round(muC1 * 255), colormap('gray'))
		title('Degré d''appartenance finaux')
		subplot(3, 2, 4)
		imshow(round(muC2 * 255), colormap('gray'))
		subplot(3, 2, 6)
		imshow(round(muC3 * 255), colormap('gray'))
	end


	%% Find the tumor class
	
	% Find the class corresponding to the tumor
	[tmp nTumorClass] = max(cell2mat(v));

	% Find the maximum membership class for each pixel
	maxClass = zeros(size(muC1));
	maxMembership = zeros(size(muC1));
	for i = 1:size(muC1, 1)
		for j = 1:size(muC1, 2)
			allClasses = [muC1(i, j) muC2(i, j) muC3(i, j)];
			[maxMembership(i,j) , maxClass(i, j)] = max(allClasses);
		end
	end

	% Find the tumor
	tumorClass = reshape((maxClass == nTumorClass), size(muC1));
	[tumor, tumorArea] = largestArea(tumorClass);

	% Display the irm with the boundary around the tumor
	if doPlot
		figure(nbFigure + 1)
		imshow(uint8(irm))
		hold on
		boundary = cell2mat(bwboundaries(tumor));
		plot(boundary(:,2), boundary(:,1),'g','LineWidth',2);
		title('Tumor')
	end