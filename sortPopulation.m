function sorted = sortPopulation(unsorted,V,M)

if (M==1) % Single Obbjective
	sorted=sortrows(unsorted,V+M,'ascend');
	
else % Multi-objective case : non-domination sorting
    
    %% Ranking
    PopulationSize=size(unsorted,1);
    sorted=zeros(PopulationSize,V+M);
    rank=zeros(PopulationSize,1);
    idx=[1:1:PopulationSize];
    rankidx = 1;
    sortidx = 1;
    while(1)
%         idx2=idx;
          for i = 1:length(idx)
              comp_row = unsorted(idx(i),V+1:V+M);
              comparison_objective = comp_row >= unsorted(idx(setdiff(1:end,i)),V+1:V+M);
             comparison_result_eq=comp_row==unsorted(idx(setdiff(1:end,i)),V+1:V+M);
              dominated_by=sum(comparison_objective,2)==M;
            same=sum(comparison_result_eq,2)==M;      
          %  C=sum(same);
              dominated_by_total=sum(dominated_by)-sum(same);
              %dominant = sum(comparison_objective,2)== M;
              if(dominated_by_total==0)
                  rank(idx(i))=rankidx;
                  sorted(sortidx,:) = unsorted(idx(i),:);
                  sortidx = sortidx+1;
              end
%               idx2=find(rank==0);
          end
         idx=find(rank==0);
         rankidx = rankidx+1;
         if sum(rank==0)==0
             break
         end
    end 

    sorted=[sorted sort(rank)];
    %% Crowding Distance
    crowding_distance = zeros(PopulationSize,1);
    sorted = [sorted crowding_distance];
    [~,~,X]= unique(sorted(:,V+M+1));
    Tempsort = [];
    SplittedbyRank=accumarray(X,1:PopulationSize,[],@(r){sorted(r,:)});
    cellsz = cellfun(@size,SplittedbyRank,'uni',false);
  for i = 1:max(rank) 
        l = cellsz{i,1}(1);
    for j = 1:M
        SplittedbyRank{i} = sortrows(SplittedbyRank{i},V+j);
        SplittedbyRank{i}(1,V+M+2) = inf;
        SplittedbyRank{i}(l,V+M+2) = inf;
        fmin = SplittedbyRank{i}(1,V+j);
        fmax = SplittedbyRank{i}(l,V+j);
        for k = 2:l-2
            SplittedbyRank{i}(k,M+V+2) = SplittedbyRank{i}(k,M+V+2) + (SplittedbyRank{i}(k+1,j+V)-SplittedbyRank{i}(k-1,j+V))/(fmax-fmin);
        end
    end
    SplittedbyRank{i} = sortrows(SplittedbyRank{i},M+V+2,'descend');
    Tempsort = [Tempsort ;SplittedbyRank{i}];
  end
   sorted=Tempsort;
    
end
