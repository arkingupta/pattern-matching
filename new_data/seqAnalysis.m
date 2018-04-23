function [finalStats,temporalMotifsVar] =  seqAnalysis(overallGlobalPaths,N)

%% Sequences
%v1 = [5, 5, 5, 5, 5, 5];
%v2 = [2, 3, 1, 2, 3, 2, 3, 2, 3, 1, 2, 3, 2, 3, 2];
%v3 = [2, 4, 3, 1, 2, 3, 2, 3, 2, 3, 2, 3, 2, 1, 2, 3, 2, 3, 2, 3, 2, 3, 2, 1];
%v4 = [2, 4, 3, 1, 2, 3, 2, 3, 2, 3, 2, 3, 2, 1, 2, 3, 2];
%v5 = [4, 2, 3, 1, 2, 3, 2, 3, 2, 3, 2, 3, 2, 1, 2, 3, 2, 1, 4];
%v6 = [4, 5, 6, 7, 8];
%v7 = [2, 3, 2, 3, 2, 3, 2];
%v8 = [2, 3, 1, 2, 3, 1, 2];
%
% loadFileName = ['full_motifs' '.mat'];
% load feed_motifs.mat;
% load full_motifs.mat;

 %% Analyze the sequence and pull cycles
outputStatistics = {};
cyc = {};
for i = 1:N
  cyc{end+1} = i;
end


% countSequences = {v1,v2,v3,v4,v5,v6,v7,v8};
% countSequences = {v6, v7};

countSequences = {};
% temporalMotifsVar = overallTerminalPaths;
temporalMotifsVar = overallGlobalPaths;

for iii=1:numel(temporalMotifsVar)
  countSequences{end+1} = [temporalMotifsVar{iii}(:,2);temporalMotifsVar{iii}(end,4)]';
end

for ii=1:numel(countSequences)
  %% Create the dictionary
  seq = cell2mat(countSequences(ii));
  seqL = numel(seq);
  sEnd = seqL;
  sStr = 1;
  match = 0;
  for i = 1:(seqL-1)
    for j = (i+1):seqL
      if(seq(i) == seq(j))
	for k = 1:numel(cyc)
	  match = 0;
	  if(isequal(cyc{k},seq(i:j)))
	    match = 1;
	    break
	  end
	end
	if(match == 0)
	  cyc{end+1} = seq(i:j);
	end
      end
    end
  end
end % end creating a dictionary

%% Analyze the sequences to compress
finalStats = {};
for ii=1:numel(countSequences)
  j = 1;
  k = 0;
  outputStatistics= {};
  cSeq = [];
  seq = cell2mat(countSequences(ii));
  seqL = numel(seq);
  for i = (N+1):numel(cyc) % the number of nodes including stimulus
    tarC = cyc{i};
    tarCn = numel(tarC);
    count = 0;
    cFlag = 0;
    seqMark = 0;
    while 1
      tarS = [seq(j:end)];
      tarSn = numel(tarS);
      if((tarCn <= tarSn))
	if(isequal(tarC,tarS(1:tarCn)))
	  cSeq = [cSeq, i];
	  j = j + tarCn - 2;
	  seqMark = j + 1;
	  count = 1 + count;
	  cFlag = 1;
	end % end if statement of finding an exact match for the cycle
      end % end if statement for checking if the remaining sequence is less than cycle
      if((cFlag == 0) & (j~=seqMark)) % & (j<=seqL))
	cSeq = [cSeq, seq(j)];
      elseif(cFlag == 1)
	cFlag = 0;
      end
      j = j + 1;
      if(j>seqL)
	j = 1;
	break
      end
    end % end the while loop which goes through all the elements in the sequence

    if(count>0)
      k = k + 1;
      outputStatistics{k,1} = i; % the cycle identifier
      outputStatistics{k,2} = tarC; % cycle definition
      outputStatistics{k,3} = count; % number of total repeats
      outputStatistics{k,4} = cSeq; % converted from sequence to cycles
      outputStatistics{k,5} = getOrderSeqCount(cSeq); % the first row outputs the compressed sequence, the second row outputs the repeats
      y = [];
    end
    cSeq = [];
  end % end the for loop for each cycle
  finalStats{ii,1} = ii; % the sequence number
  finalStats{ii,2} = countSequences(ii); % actual sequence to there is no ambiguity when looking back at this
  finalStats{ii,3} = outputStatistics; % % saves the statitics of the sequence to the overall output variable
  if(isempty(finalStats{ii,3})) % if we do not find any cycles, then we just put the initial sequence so we can do a comparison
    outputStatistics = {};
    outputStatistics{1,1} = 0; % the cycle identifier
    outputStatistics{1,2} = 0; % cycle definition
    outputStatistics{1,3} = 0; % number of total repeats
    outputStatistics{1,4} = seq; % converted from sequence to cycles
    outputStatistics{1,5} = getOrderSeqCount(seq); % the first row outputs the compressed sequence, the second row outputs the repeats
    finalStats{ii,3} = outputStatistics; % % saves the statitics of the sequence to the overall output variable
  end

  outputStatistics = {};
end % end collecting statistics on the sequences

h = datestr(now);
h = strrep(h,':','_');
h = strrep(h,'-','_');
h = strrep(h,' ','_');
fileName = ['out_full_global_seqCycleStats_' h '.mat'];
save(fileName,'finalStats','temporalMotifsVar')
