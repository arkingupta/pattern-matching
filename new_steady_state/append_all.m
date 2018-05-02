function [] = append_all(pattern_list, size, number)

load(pattern_list{1});

newShortestCycleFinal = steadyStateSeq;

for i = 2:size
    load(pattern_list{i});
    newShortestCycle2 = steadyStateSeq;

    for j = 1:length(newShortestCycle2)
        newShortestCycleFinal{end+1} = newShortestCycle2{j};
    end

end

dict_name = strcat('dict_', number);
fileName = char(dict_name);
steadyStateSeq = newShortestCycleFinal;
save(fileName,'steadyStateSeq');

end