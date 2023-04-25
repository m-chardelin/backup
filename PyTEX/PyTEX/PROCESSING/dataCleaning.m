function [ebsd] = dataCleaning(ebsd, madSeuil, segAngle, smallGrainsOption)
        
        %% set denoise filter features
        filter2apply = halfQuadraticFilter;     % define denoise algorithm to use
        filter2apply.threshold = 1.5*degree;    % only denoise data with misorientations below this threshold angle
        filter2apply.eps = 0.001;               % half-quadratic filter parameter eps
        filter2apply.alpha = 0.01;              % half-quadratic filter parameter alpha

        %% Remove poorly constrained EBSD measures (MAD >= mad_seuil and wild spikes)
        % Note that removing works like this: variable = variable(condition) 
        ebsd = ebsd(ebsd.mad < madSeuil);
        
        %% Calculate ebsd grains id and applying filters
        %[grains,ebsd.grainId] = calcGrains(ebsd)

        %%
        %ebsd = smooth(ebsd, filter2apply, 'fill', grains);
        ebsd = smooth(ebsd, filter2apply);

end
