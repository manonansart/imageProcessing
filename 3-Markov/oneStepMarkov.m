function tmp = oneStepMarkov(classes, image)
	nbClasses = length(unique(classes));
	classMeans = [];
	classVars = [];
	for nClass = 0:nbClasses-1
		classMeans = [classMeans mean(irm(find(classes == i)))]
		classVars = [classVars var(irm(find(classes == i)))]
	end

	% Calcul de U1 pour chaque classe = normpdf(valuePixel, classMeans(numClass), classVars(numClass))
	for 

	% Calcul de U2 pour chaque classe

	% On affecte à chaque point la classe donnant le plus petit U1 + U2