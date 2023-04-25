function [maxA, maxAxB] = maxODF(ebsd, mineral, res)
        ebsd = ebsd('Forsterite')
        %%
        %pf_grid=S2Grid('EQUISPACED','HEMISPHERE','lower', 'resolution',res*degree);
        pf_grid = equispacedS2Grid('resolution', res*degree);
        %%
        odf_olivine = calcDensity(ebsd.orientations);

        %%
        pf_100 = calcPDF(odf_olivine,Miller(1,0,0,ebsd.CS,'hkl'),pf_grid);
        pf_010 = calcPDF(odf_olivine,Miller(0,1,0,ebsd.CS,'hkl'),pf_grid);
        pf_001 = calcPDF(odf_olivine,Miller(0,0,1,ebsd.CS,'hkl'),pf_grid);

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
        AxB = cross(pf_max_vector_100,pf_max_vector_010);
        AxB_to_B = angle(AxB,pf_max_vector_010)/degree;
        AxB_to_C = angle(AxB,pf_max_vector_001)/degree;
        % Structural directions Xs and Zs in SEM frame based on proxy (001)max x (010)max and (010)max
        maxA = pf_max_vector_100;
        maxB = pf_max_vector_010;
        maxC = pf_max_vector_001;
        maxAxB = AxB;

end