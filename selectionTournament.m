function selection = selectionTournament(population,NP,V,M)
%selection = population(1:2*NP/4,:);
 if M==1
        selection=zeros(NP,V+M);
        selected_indices=zeros(NP);
        i=0;
        while(i<NP)
            %in case of discarding parent add extra check to ensure that you
            %don't check with self. Or just add it anyway...
            index1=1+round(rand*(size(population,1)-1));
            index2=1+round(rand*(size(population,1)-1));
            %underrepresentation of 0 and max index (rounding function)
            next_index=min(index1,index2);
            if size(find(selected_indices==next_index),1)==0
                selected_indices=next_index;
                selection(i+1,:)=population(next_index,:);
                i=i+1;
            end
        end
    else
        selection=zeros(NP,V+M+2);
        selected_indices=zeros(NP);
        i=0;
        while(i<NP)
            %in case of discarding parent add extra check to ensure that you
            %don't check with self. Or just add it anyway...
            index1=1+round(rand*(size(population,1)-1));
            index2=1+round(rand*(size(population,1)-1));
            %underrepresentation of 0 and max index (rounding function)
            next_index=min(index1,index2);
            if size(find(selected_indices==next_index),1)==0
                selected_indices=next_index;
                selection(i+1,:)=population(next_index,:);
                i=i+1;
            end
        end
    end
end
