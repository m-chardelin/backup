function phasesEBSD(OUTPUT, thinSection, ebsd, phaseList)

        [phases]=fopen(strcat(OUTPUT, 'phasesEBSD.txt'), 'a+');

        listMineral = '';
        listPhase = '';

        stop=length(ebsd.mineralList)-1;

        for p=1:stop
            listMineral=strcat(listMineral, ebsd.mineralList(p), ';');
            listPhase=strcat(listPhase, phaseList(p), ';');
        end

        listMineral=strcat(listMineral, ebsd.mineralList(stop+1));
        listPhase=strcat(listPhase, phaseList(stop+1));


        txt=strcat(thinSection, ';ebsd;', listMineral, '\n');
        fprintf([phases], txt);
        txt=strcat(thinSection, ';legend;', listPhase, '\n');
        fprintf([phases], txt);
end