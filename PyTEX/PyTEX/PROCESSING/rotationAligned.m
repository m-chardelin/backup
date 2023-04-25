%%
%pf_grid=S2Grid('EQUISPACED','HEMISPHERE','lower', 'resolution',res*degree);
pf_grid = equispacedS2Grid('resolution',1*degree);
%%
odf_olivine = calcDensity(ebsd('Olivine').orientations);

%%
pf_100 = calcPDF(odf_olivine,Miller(1,0,0,Olivine_CS,'hkl'),pf_grid);
pf_010 = calcPDF(odf_olivine,Miller(0,1,0,Olivine_CS,'hkl'),pf_grid);
pf_001 = calcPDF(odf_olivine,Miller(0,0,1,Olivine_CS,'hkl'),pf_grid);

%%
% get PF maximum densities and associated index position in pfs
[pf_100_maxvalue,index_100_max] = max(pf_100);
[pf_010_maxvalue,index_010_max] = max(pf_010);
[pf_001_maxvalue,index_001_max] = max(pf_001);
% get pfs maximum specimen 3dvectors
pf_max_vector_100 = pf_grid(index_100_max);
pf_max_vector_010 = pf_grid(index_010_max);
pf_max_vector_001 = pf_grid(index_001_max);
% angles
A_to_B = angle(pf_max_vector_100,pf_max_vector_010)/degree;
A_to_C = angle(pf_max_vector_100,pf_max_vector_001)/degree;
B_to_C = angle(pf_max_vector_010,pf_max_vector_001)/degree;
% use cross product of the 2 vectors with an angle closest to 90 degrees
% in this case (001)max and (010)max
% (001)max x (010)max = proxy for max(100) normal to (001)max and (010)max
CxB = cross(pf_max_vector_100,pf_max_vector_010);
CxB_to_B = angle(CxB,pf_max_vector_010)/degree;
CxB_to_C = angle(CxB,pf_max_vector_001)/degree;
% Structural directions Xs and Zs in SEM frame based on proxy (001)max x (010)max and (010)max
Ys_in_SEM = pf_max_vector_100;
Xs_in_SEM = CxB;
% New structural frame based on Xs = East and Zs = North in SEM frame
Xs_in_Structural = vector3d(1,0,0);
Ys_in_Structural = vector3d(0,0,1);
% use map option to define rotation SEM to Structural frame
rot = rotation('map',Xs_in_SEM,Xs_in_Structural,Ys_in_SEM,Ys_in_Structural);
% rotate Euler angles in ebsd object

ebsdAligned = rotate(ebsd,rot,'keepXY');


