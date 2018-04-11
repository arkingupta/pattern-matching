nulist = dir;
A = {list.name};

for i=17:64
    disp(A{i});
    load(A{i});
    
    str = A{i};
    newStr = extractAfter(str,15);
    newStr = 'ss' + newStr;
    
    [finalStats,temporalMotifsVar] = seqAnalysis(overallGlobalPaths,810);
    outputNodes= [810:810];                                                                                                                                                                                             
    [newShortestCycle,seqPlot]=analytics_cycleAnalysis(finalStats,temporalMotifsVar,outputNodes);
    fileName = char(newStr);
    save(fileName,'newShortestCycle');
end