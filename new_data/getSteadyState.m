
load ('./raw_data/sequences_mnist_ex_22_label_0.mat');
[finalStats,temporalMotifsVar] = seqAnalysis(overallGlobalPaths,810);                                                                                                                                             
                                                                                                                                                                         
outputNodes= [810:810];                                                                                                                                                                                             
[newShortestCycle,seqPlot1]=analytics_cycleAnalysis(finalStats,temporalMotifsVar,outputNodes);
fileName = ['trans_label_0_sample_22.mat'];


save(fileName,'seqPlot');