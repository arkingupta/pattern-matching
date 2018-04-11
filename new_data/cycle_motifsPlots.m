function cycle_motifsPlots(temporalMotifs,plotTitle,outputNodes)

DistanceAdjacencyMatrix = zeros(3);

neuronPosition = [];
saveFig = 0;
saveAnim = 0;
plotAdjMat = 0;
plotMotif = 1;
plotFancy = 0;
plotFancyWAnimation = 0;
createSimpleVideo = 0;
createVideo = 0;

%% input file parameters
gluNrnPol = [1];
unknownNrnPol = [1];
sigSpeed = [0.2];
refPers = [1.6]; 

% outputNodeSet1 = [85:106]; % the 3 sets of neurons
% outputNodeSet2 = [236:277];
% outputNodeSet1 = [94:100]; % VB or DB forgot which
% outputNodeSet2 = [248:258]; % VB or DB forgot which
% outputNodeSet1 = [17:23];
% outputNodeSet2 = [31:41];
 outputNodeSet1 = outputNodes;
 outputNodeSet2 = [];


endNode = [outputNodeSet1, outputNodeSet2];

motifsList = {};

motifsList = temporalMotifs;

i = 1;
j = 1;
k = 1;

%analytics_motifsPhasePortrait(motifsList)

if ((plotAdjMat==1) | (plotMotif == 1) | (plotFancy == 1) | (plotFancyWAnimation == 1) | (createSimpleVideo == 1) | (createVideo == 1))
  analytics_plotCycleMotifs(plotAdjMat,plotMotif,plotFancy,plotFancyWAnimation,createSimpleVideo,createVideo,endNode,DistanceAdjacencyMatrix,neuronPosition, motifsList,saveFig,saveAnim,refPers(k),sigSpeed(j),gluNrnPol(i),plotTitle);
end % end the if statement which looks for path that traverse only both the terminal nodes
