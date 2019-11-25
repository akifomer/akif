function children = geneticOperators(parents,NC,P,V,M,f,lb,ub,eta)
%NRec=floor(NC*P);
%NMut= NC-NRec;
%  PS = size(parents,1);
%  B1=rand();
%  B2=rand();
% children= zeros(NC,V);
% idx=randperm(PS);
% idx2=randperm(2);
% idx3=randperm(2);
% for i= 1:NC
%         if(rand<P)
%       %for k=1:NRec
%          children(i,:)=[parents(idx(1),1:floor(V/2)),parents(idx(2),floor(V/2)+1:V)];
%          idx=randperm(PS,2);
%          %idx2=randperm(2);
%          %idx3=randperm(2);
%       %end
% 
%         else
%       
%             idx=randperm(PS,2);
% %             index1=randi(size(parents,1));
% %             r_vec=rand(1,V);
% %             delta_vec1=((2*r_vec).^(1/(eta+1))-1).*(r_vec<0.5);
% %             delta_vec2=(1-(2*(1-r_vec)).^(1/(eta+1))).*(r_vec>=0.5);
% %             delta_vec=delta_vec1+delta_vec2;
% %             children(i,1:V)=parents(index1,1:V)+(ub-lb).*delta_vec;
%         %  children(i,:)= Polym(parents(idx(1),1:V),eta);
%          %children(i,:)=parents(idx(1),1:V)-min(parents(idx(1),1:V))*rand();%([B1*parents(idx(1),1:floor(V/2)),parents(idx(1),floor(V/2)+1:V)*B2];
%         % (normrnd(0,0.01,[V,1])'
%          %children(i,:)=[B1*parents(idx(1),1:floor(V/2)),parents(idx(1),floor(V/2)+1:V)*B2];
%         end
%  end
% i=0;
% children=zeros(NC,V);
% while(i<NC)
%     
%     if(rand<=P)
%         %recombine
%         %pick parents
%         while(1)
%             index1=randi(size(parents,1));
%             index2=randi(size(parents,1));
%             if index1~=index2
%                 %valid parents for recombination found, (not self)
%                 i=i+1;
%                 %children(i,:)=crossover(parents(index1,1:V),parents(index2,1:V),V,M,5);
%                 alpha=rand; %or pick a const value if you want...
%                 parent1=parents(index1,1:V);
%                 parent2=parents(index2,1:V);
%                 
%                 %multiple gene arith crossover, random picking.
%                 while(1)
%                     inheritance_vector=round(rand(1,V));
%                     if sum(inheritance_vector,2)>0 && sum(inheritance_vector,2)<V
%                         break   %will get out of the loop only if it won't lead to parent cloning
%                     end
%                 end
%                 child=parent1;
%                 child(logical(inheritance_vector))=parent1(logical(inheritance_vector))*alpha+parent2(logical(inheritance_vector))*(1-alpha);
%             end
%             children(i,:)=child;
%             break   %correct parents used and no need to loop this again, go to next child
%         end
%         
%         
%     else
%         %mutate
%         
%         
%         index1=randi(size(parents,1));
%         
%         %%%%%%%%%polynomial mutation
%         r_vec=rand(1,V);
%         delta_vec1=((2*r_vec).^(1/(eta+1))-1).*(r_vec<0.5);
%         delta_vec2=(1-(2*(1-r_vec)).^(1/(eta+1))).*(r_vec>=0.5);
%         delta_vec=delta_vec1+delta_vec2;
%         children(i+1,1:V)=parents(index1,1:V)+(ub-lb).*delta_vec;
%         %%%%%%%%%end of polynomial mutation
%         
%         over_range_values=children(i+1,:)>1;    % if mutation sends it over range set it to one
%         under_range_values=children(i+1,:)<0;   %it won't happen with this mutation method but keep it just in case that we change it
%         children(i+1,over_range_values)=ones(size(over_range_values,1));
%         children(i+1,under_range_values)=zeros(size(over_range_values,1));
%         
%         i=i+1;
%         
%     end
% % end
% 
i=0;
children=zeros(NC,V);
    while(i<NC)
        
        if(rand<=P)
          %  recombine
          %  pick parents
            while(1)
                index1=randi(size(parents,1));
                index2=randi(size(parents,1));
                if index1~=index2
                    %valid parents for recombination found, (not self)
                    i=i+1;                
                    %children(i,:)=crossover(parents(index1,1:V),parents(index2,1:V),V,M,5);
                    
                    
                    crossovertype=5;
                    alpha=rand; %or pick a const value if you want...
                    parent1=parents(index1,1:V);
                    parent2=parents(index2,1:V);
                    switch crossovertype
                        case 1  
                           % case of single point crossover. Find a single point and swap genestring AFTER it
                            single_x_point=randi(V-1); %-1 to ensure no clones
                            child=[parent1(1:single_x_point) parent2(single_x_point+1:V)];
                        case 2  
                           % uniform crossover, random picking, ideally 50% chance for each parent
                            while(1)
                                inheritance_vector=round(rand(1,V));
                                if sum(inheritance_vector,2)>0 && sum(inheritance_vector,2)<V
                                    break   %will get out of the loop only if it won't lead to parent cloning
                                end
                            end
                           % here we have valid inheritance vector
                            child=inheritance_vector.*parent1+(~inheritance_vector).*parent2 ;
                        case 3 
                           % whole arithmetic crossover
                            child=parent1*alpha+parent2*(1-alpha);
                        case 4 
                           % single gene arithmetic crossover (random pick)
                            gene_selector=randi(V);   %gives uniform random 1 to V
                            child=parent1;
                            child(gene_selector)=parent1(gene_selector)*alpha+parent2(gene_selector)*(1-alpha);
                        case 5
                          %  multiple gene arith crossover, random picking.
                            while(1)
                                inheritance_vector=round(rand(1,V));
                                if sum(inheritance_vector,2)>0 && sum(inheritance_vector,2)<V
                                    break   %will get out of the loop only if it won't lead to parent cloning
                                end
                            end
                            child=parent1;
                            child(logical(inheritance_vector))=parent1(logical(inheritance_vector))*alpha+parent2(logical(inheritance_vector))*(1-alpha);
                        otherwise
                            sprintf('no crossover type for number %d',crossovertype)
                    end
                    children(i,:)=child;
   
                    
                    break   %correct parents used and no need to loop this again, go to next child
                end
                
            end
        else
                          index1=randi(size(parents,1));
            %  children(i+1,:)=[B1*parents(index1,1:floor(V/2)),parents(index1,floor(V/2)+1:V)*B2];
            %mutate
            



            %%%%%%%%%polynomial mutation
            r_vec=rand(1,V);
            delta_vec1=((2*r_vec).^(1/(eta+1))-1).*(r_vec<0.5);
            delta_vec2=(1-(2*(1-r_vec)).^(1/(eta+1))).*(r_vec>=0.5);
            delta_vec=delta_vec1+delta_vec2;
            children(i+1,1:V)=parents(index1,1:V)+(ub-lb).*delta_vec;
            %%%%%%%%%end of polynomial mutation
            
            over_range_values=children(i+1,:)>1;    % if mutation sends it over range set it to one
            under_range_values=children(i+1,:)<0;   %it won't happen with this mutation method but keep it just in case that we change it
            children(i+1,over_range_values)=ones(size(over_range_values,1));
            children(i+1,under_range_values)=zeros(size(over_range_values,1));

              i=i+1;
        end
% 
  end
    
denum=children(:,1:V).*(ub-lb)+lb;
ev=f(denum);
children=[children,ev,zeros(size(children,1),2)];
end
