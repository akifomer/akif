function new = cropPopulation(old,nb,V,M)
new=old(1:nb,:);

end
% function new=cropPopulation(old,nb,V,M)
%     pop_to_leave=size(old,1)-nb;
%     
%     while pop_to_leave>=1
%         
%         max_rank=max(old(:,V+M+1));
%         max_rank_indices=find(old(:,V+M+1)==max_rank);
%         
%         if pop_to_leave-length(max_rank_indices) >=0
%             old(max_rank_indices,:)=[];
%             pop_to_leave=pop_to_leave-length(max_rank_indices);
%         else
%  
%             index_to_leave=find(old(max_rank_indices,V+M+2)==min(old(max_rank_indices,V+M+2)));
%             index_to_leave=max_rank_indices(index_to_leave(1));
%             old(index_to_leave,:)=[];
%             pop_to_leave=pop_to_leave-1;
%             max_rank_indices=find(old(:,V+M+1)==max_rank);  %following statement safe even if empty
%             
%             %old(max_rank_indices,:)=CD_nsga2_light2(old(max_rank_indices,1:V+M+2),V,M);    
%             
%             %%\integrated function
%             current_rank=old(max_rank_indices,1:V+M+2);
%             current_rank(:,V+M+2)=0;    %init CD
%             l=size(current_rank,1);
%             for m=1:M
%                 current_rank=sortrows(current_rank,V+m);    %sort for one of the M columns
%                 current_rank(1,V+M+2)=inf;
%                 current_rank(l,V+M+2)=inf;
%                 fmax_m=current_rank(l,V+m);
%                 fmin_m=current_rank(1,V+m);
%                 for j=2:l-1
%                     current_rank(j,V+M+2)=current_rank(j,V+M+2)+((current_rank(j+1,V+m)-current_rank(j-1,V+m))/(fmax_m-fmin_m));
%                 end
%             end
%             current_rank=sortrows(current_rank,V+M+2,'descend');
%             old(max_rank_indices,:)=current_rank;
%             %%\end of integrated function
%         end
%         
%     end
%     
%     new=old(1:nb,:);

% end
