function [index, egdsf, area] = createOutputTable(OUTPUT, index, egdsf, area, segAngle, subGrainsAngle, non_indexed_option, small_grains_option)

        [oindex] = fopen(strcat(OUTPUT, [index, '.txt']), 'a+');
        fprintf([oindex],'cat;sscat;subcat;J;BA;BC;AC;nb\n');
        
        [oegdsf] = fopen(strcat(OUTPUT, [egdsf, '.txt']), 'a+');
        fprintf([oegdsf], 'cat;sscat;subcat;SF;GROD;KAM;NB\n');
        
        [oarea] = fopen(strcat(OUTPUT, [area, '.txt']), 'a+');
        fprintf([oarea], 'cat;sscat;Pixels;A.Frac(all);A.Frac(Ind);nbGrains;nbGrainsRemoved\n');
        
        [oparam] = fopen(strcat(OUTPUT, ['param', '.txt']), 'a+');
        
        fprintf([oparam], 'PROCESSING ZABARGAD PERIDOTITES EBSD DATA (OLIVINE, ORTHO- & CLINOPYROXENE, SPINELLE, AMPHIBOLES, PLAGIOCLASES)');
        fprintf([oparam],'\n\n');
        fprintf([oparam], strcat('\nSegmentation angle for grain detection : ', string(segAngle)));
        fprintf([oparam], strcat('\nSegmentation angle for subgrain detection : ', string(subGrainsAngle)));
        fprintf([oparam], strcat('\n Keep non-indexed points option : ' , string(non_indexed_option)));
        fprintf([oparam], strcat('\n Removed small grains option : ', string(small_grains_option)));
        fprintf([oparam],'\n\n');

        index = [index, '.txt'];
        egdsf = [egdsf, '.txt'];
        area = [area, '.txt'];

end