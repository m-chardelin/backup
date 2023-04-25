function exportArea(OUTPUT, ebsd, grains, SG, thinSection, phaseList)

        [oarea] = fopen(strcat(OUTPUT, 'area.txt'), 'a+');

        a = ebsd.mineralList;
        
        for p = 1:length(a)
            mineral = a(p);
            phase = string(phaseList(p));
            if (string(mineral) == 'notIndexed')
                data = strcat(thinSection, ';' , phase, ';', string(ebsd(mineral).length),';', string(ebsd(mineral).length/ebsd.length), ';0;', string(grains(mineral).length), ';', string(length(grains(mineral))-length(SG(mineral))),'\n');
            else
                data = strcat(thinSection, ';' , phase, ';', string(ebsd(mineral).length),';', string(ebsd(mineral).length/ebsd.length), ';', string(ebsd(mineral).length/ebsd('Indexed').length), ';', string(grains(mineral).length), ';', string(length(grains(mineral))-length(SG(mineral))),'\n');
            end
            fprintf([oarea], data);
        end

end