function exportNeighbors(OUTPUT, thinSection, grains)

        name = strcat(OUTPUT, thinSection, '_', 'Neighbors.csv');
        name = char(name);

        header = {'grain1', 'grain2'};
        data = grains.neighbors('full');
        
        csvwrite_with_headers(name,data,header);

        name = strcat(OUTPUT, thinSection, '_', 'NeighborsPairs.csv');
        name = char(name);

        gr = grains.boundary;
        header = {'grain1', 'grain2', 'ebsd1', 'ebsd2', 'segLength', 'isIndexed',  'misrotation_i', 'misrotation_phi1', 'misrotation_Phi', 'misrotation_phi2', 'misrotation_a', 'misrotation_b', 'misrotation_c', 'misrotation_d'};
        data = [gr.grainId, gr.ebsdId, gr.segLength, gr.isIndexed, gr.misrotation.i, gr.misrotation.phi1, gr.misrotation.Phi, gr.misrotation.phi2, gr.misrotation.a, gr.misrotation.b, gr.misrotation.c, gr.misrotation.d];
        
        csvwrite_with_headers(name,data,header);

        plot(grains)
        task = 'grainsNeighbors'
        saveMAP(OUTPUT, thinSection, '', task);
        
end
