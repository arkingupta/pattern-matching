load('./steady_state/label_1_sample_15.mat');
newShortestCycle1 = newShortestCycle;

load('./steady_state/label_1_sample_4.mat');
newShortestCycle2 = newShortestCycle;

newShortestCycleFinal = newShortestCycle1;
for i = 1:length(newShortestCycle2)
    newShortestCycleFinal{length(newShortestCycle1)+i} = newShortestCycle2{i};
end

newShortestCycle = newShortestCycleFinal;
fileName = ['ss_1_15_4'];
save(fileName,'newShortestCycle');