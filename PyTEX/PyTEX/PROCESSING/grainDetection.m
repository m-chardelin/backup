function [ebsd, grains, ES, SG] = grainDetection(ebsd, segAngle, subGrainsAngle, smallGrainsOption, nonIndexedOption, iter)

        % keep non-indexed in is default in MTEX4
        if(nonIndexedOption == 0)
            [grains, ebsd.grainId, ebsd.mis2mean] = calcGrains(ebsd,'threshold',[subGrainsAngle*degree, segAngle*degree], 'boundary','tight');
        end
        
        if(nonIndexedOption == 1)
            [grains, ebsd.grainId, ebsd.mis2mean] = calcGrains(ebsd('Indexed'),'threshold',[subGrainsAngle*degree, segAngle*degree], 'boundary','tight');
        end
       
        % remove grain boundary stair-case effect
        grains = smooth(grains, iter);

        % remove grains containing less than critical number of indexed points, 
        SG = grains(grains.grainSize > smallGrainsOption);
        % Definition of ebsd for selected grains (ES)
        ES = ebsd(SG);

end





