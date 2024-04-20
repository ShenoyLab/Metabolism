%Matlab script file used to generate conoturs of metabolic potential for MDA MB-231 cells on 2D PA gels
%Input data files required: i)2d10.xlsx,  ii)2d30extended.xlsx  and iii)2dglass.xlsx
%Ouput generated:           i)Metabolic potential contours with minimum identified, ii) Contractility and iii) Stress corresponding to optimum shape
clear;
volume=8e-15;               %cellular volume
%FOR 10KPA (SOFT)
arxy=0.1:0.05:1;
aryz=1:0.3:2.8;
gammac=9e-5;
gammacm = 3.0e-5;
%m=xlsread("2d10.xlsx");
%FOR 30KPA(INTERMEDIATE)
% arxy=0.1:0.01:1;
% aryz=1:0.3:2.8;
% gammac=9e-5;
% gammacm = 3.5e-5;
%m=xlsread("2d30extended.xlsx");
%FOR GLASS(STIFF)
%arxy=0.5:0.05:1;
%aryz=1:0.2:5;
%gammac=9e-5;
%gammacm =6e-5;
%m=xlsread("2dglass.xlsx");

for i=1:length(arxy)
    abrat(i)=1/arxy(i);
end
for i=1:length(aryz)
    carat(i)=1/aryz(i);
end

for i=1:length(arxy)
   k=i+(i-1)*(length(aryz)-1);
    for j=1:length(aryz)
       b = (volume*arxy(i)*aryz(j)/(4*pi/3))^(1/3);
       a = b /arxy(i);
       c = b/aryz(j);
       S = 2*pi*(((a*b)^1.6075+(a*c)^1.6075+(b*c)^1.6075)/3)^(1/1.6075);
       InterfacialEnergy(i,j) = (S * gammac)+(gammacm*pi*b*a);
        
        utot(i,j)=m(k,3)+InterfacialEnergy(i,j);
        umech(i,j)=4*m(k,6);
        % uchem(i,j)=4*m(k,5)+InterfacialEnergy(i,j);
       % umotor(i,j)=4*m(k,13);
      %  ubinding(i,j)=4*m(k,7);
        %+InterfacialEnergy(i,j);
       %  uatp(i,j)=4*m(k,8);
         %+InterfacialEnergy(i,j);
%         umechcell(i,j)=4*m(k,16);
           sigkk(i,j)=m(k,11);
         contrac(i,j)=m(k,12);
         % sigp1(i,j)=m(k,13);
         % sigp2(i,j)=m(k,14);
         % sigp3(i,j)=m(k,15);
        %+InterfacialEnergy(i,j);
       
        k=k+1;
    end
end
%FOR 10KPA (SOFT)
Refinedarxy=0.1:0.01:1;
Refinedaryz=1:0.01:2.8;
%FOR 30KPA (INTERMEDIATE)
%Refinedarxy=0.1:0.01:1;
%Refinedaryz=1:0.01:2.8;
%FOR GLASS
%Refinedarxy=0.5:0.01:1;
%Refinedaryz=1:0.01:5;
for i=1:length(Refinedaryz)
    rec(i)=1/Refinedaryz(i);
end
for i=1:length(Refinedarxy)
    rec2(i)=1/Refinedarxy(i);
end

[AM, DM] = meshgrid(carat,abrat);
[RAM, RDM] = meshgrid(rec, rec2);
RefinedTotalEnergy = interp2(AM, DM, utot, RAM, RDM, 'linear');
% RefinedIntEnergy = interp2(AM, DM, InterfacialEnergy, RAM, RDM, 'linear');
% RefinedChemEnergy = interp2(AM, DM,uchem, RAM, RDM, 'spline');
% Refinedatpenergy = interp2(AM, DM,uatp, RAM, RDM, 'spline');
% Refinedbindingener = interp2(AM, DM,ubinding, RAM, RDM, 'spline');
%Refinedmotor = interp2(AM, DM,umotor, RAM, RDM, 'linear');
Refinedmech = interp2(AM, DM,umech, RAM, RDM, 'linear');
 Refinedcontrac = interp2(AM, DM,contrac, RAM, RDM, 'linear');
% %Refinedint2 = interp2(AM, DM,Int2, RAM, RDM, 'linear');
Refinedstress=interp2(AM, DM,sigkk, RAM, RDM, 'linear');
% Refinedsigp1=interp2(AM, DM,sigp1, RAM, RDM, 'linear');
% Refinedsigp2=interp2(AM, DM,sigp2, RAM, RDM, 'linear');
% Refinedsigp3=interp2(AM, DM,sigp3, RAM, RDM, 'linear');
%Refinedcell= interp2(AM, DM,umechcell, RAM, RDM, 'linear');
curmin=100;
for i=1:length(rec2)
    for j=1:length(rec)
        if(RefinedTotalEnergy(i,j)<curmin)
            curmin=RefinedTotalEnergy(i,j);
            minposx=rec(j);
            minposy=rec2(i);
            posx=j;
            posy=i;
        end
    end
end
%stresses, contractility, strain energy and metabolic potential
%corresponding to optimum cell shape
optcontrac=Refinedcontrac(posy,posx);
optstress=Refinedstress(posy,posx);
optstrainen=Refinedmech(posy,posx);
optmetpot=RefinedTotalEnergy(posy,posx);

figure(2);
contourf(rec, rec2, RefinedTotalEnergy, 15, '--k','LineWidth',1);
colorbar;
hold on;
plot(minposx,minposy,'rx',"MarkerSize",15,"LineWidth",5);
xlabel("c/b")
ylabel("a/b")
ax = gca; 
ax.FontSize = 20; 
box on;

%ax.Linewidth=5;
% figure(3);
% contourf(rec, rec2, Refinedatpenergy, 16, 'k','LineWidth',2);
% colorbar;
% xlabel("c/b")
% ylabel("a/b")
% ax = gca; 
% ax.FontSize = 40; 
% box on;
% figure(4);
% contourf(rec, rec2, Refinedstress, 16, 'k','LineWidth',2);
% colorbar;
% xlabel("c/b")
% ylabel("a/b")
% ax = gca; 
% ax.FontSize = 40; 
% box on;
% figure(5);
% contourf(rec, rec2, Refinedstress, 16, 'k','LineWidth',2);
% colorbar;
% xlabel("c/b")
% ylabel("a/b")
% ax = gca; 
% ax.FontSize = 30; 
% box on;
%ax.Linewidth=5;
%ylim([1.05,1.27])