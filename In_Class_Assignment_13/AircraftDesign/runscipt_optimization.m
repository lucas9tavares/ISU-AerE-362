%%%%%%%%Here we get the full path of the currently running script
scriptPath = mfilename('fullpath');
scriptDir = fileparts(scriptPath);

%%%%%%%%Construct the path to the 'functions' directory
functionsDir = fullfile(scriptDir, 'functions');
addpath(functionsDir);
[aircraft, wing, fuselage, hTail, vTail, payload, initialValues] = initializeAircraft;
designprob = optimproblem('ObjectiveSense','maximize');
[aircraft, wing, fuselage, hTail, vTail, designprob] = ...
    addAerodynamics(aircraft, wing, fuselage, hTail, vTail, designprob);
[aircraft, wing, fuselage, hTail, vTail, payload, designprob] = ...
    addWeightAndSizing(aircraft, wing, fuselage, hTail, vTail, payload, designprob);
[myAircraft, CruiseState] = createFixedWing(aircraft.Mass, wing, hTail, initialValues);
[aircraft, wing, vTail, designprob] = ...
    addStability(aircraft, wing, fuselage, hTail, vTail, payload, designprob, myAircraft, CruiseState);
[aircraft,designprob] = addPerformance(aircraft, wing.PlanformArea, wing.MeanChord, designprob);
designprob.Objective = 3*(2+2.2*payload.Boxed.Mass)/((2*wing.HalfSpan+payload.Length));
options = optimoptions(designprob);
options.MaxFunctionEvaluations = Inf;
options.MaxIterations = Inf;
options.StepTolerance = 1e-4;
options.PlotFcn = {'optimplotconstrviolation', 'optimplotfvalconstr'};
options.UseParallel = true;
options.Display = 'off';
[finalValues, maxScore] = solve(designprob, initialValues, 'Options', options);
maxScore
% After the solve function completes and the plots are shown
fig = gcf;
saveas(fig, 'optimizationPlot.png');

%%%%%%%%Output finalValues to a text file
fileID = fopen('FinalDesign.txt', 'w');
fields = fieldnames(finalValues);
for i = 1:numel(fields)
    field = fields{i};
    value = finalValues.(field);
    if isnumeric(value) && isscalar(value)
        fprintf(fileID, '%s: %g\n', field, value);
    elseif isnumeric(value)
        fprintf(fileID, '%s: %s\n', field, mat2str(value));
    elseif isstruct(value)
        subfields = fieldnames(value);
        for j = 1:numel(subfields)
            subfield = subfields{j};
            subvalue = value.(subfield);
            if isnumeric(subvalue) && isscalar(subvalue)
                fprintf(fileID, '%s.%s: %g\n', field, subfield, subvalue);
            elseif isnumeric(subvalue)
                fprintf(fileID, '%s.%s: %s\n', field, subfield, mat2str(subvalue));
            else
                % Handle other data types if necessary
            end
        end
    else
        % Handle other data types if necessary
    end
end

fclose(fileID);
