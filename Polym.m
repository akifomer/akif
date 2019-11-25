function [child] = Polym(Parent,sigma)
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here
u=rand();
u=ones(size(Parent,2),1)'*u;

UL=0.5*(erf((0-Parent)/(sqrt(2)*sigma))+1);
UR=0.5*(erf((1-Parent)/(sqrt(2)*sigma))+1);
u_1= 2*UL.*(1-2*u).*(u<=0.5);
u_2=2*UR.*(2*u-1).*(u>0.5);
u_t=u_1+u_2;
if(u_t >= 1)
    u_t=rand();
end
child=Parent+sqrt(2)*sigma*erfinv(u_t);
end

