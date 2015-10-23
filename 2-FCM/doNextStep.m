function res = doNextStep(J, epsilon)
	if length(J) < 2
		res = true;
	else
		res = (J(end) - J(end - 1) > epsilon);
	end
end