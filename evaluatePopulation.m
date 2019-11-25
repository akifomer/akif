function newpopulation = evaluatePopulation(population,f,V,M,lb,ub)
	% Take only the variables from old population and append to
	% newpopulation, while appending evalueted values at the end
    npopulation=population(:,1:V).*(ub(:,1:V)-lb(:,1:V))+lb(:,1:V);
    newpopulation=[population, f(npopulation)];
end
