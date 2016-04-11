%% fcm: function description
function [classes, v] = fcm(img, classes, fuzziness, epsilon)
    allJ = [];

    distances = classes;
    v = classes;

    step = 1;
    while (doNextStep(allJ, epsilon))
        % New memberships
        if step > 1
            for i=1:length(classes)
                denom = 0;
                for j=1:length(classes)
                    denom = denom + (distances{i} ./ distances{j}).^(2/(fuzziness-1));
                end
                classes{i} = 1 ./ denom;
            end
        end

        J = 0;
        for i=1:length(classes)
            % Distances between the points and the mean
            v{i} = sum(sum(classes{i}.^fuzziness .* img)) / sum(sum(classes{i}.^fuzziness));
            distances{i} = abs(img - v{i});
            % Cost
            J = J + sum(sum(classes{i}.^fuzziness .* distances{i}.^2));
        end

        allJ = [allJ; J];
        step = step + 1;
    end