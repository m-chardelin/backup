function exportEBSD(OUTPUT, thinSection, phase, ebsd, grod, kam)

%         [thinSectionParam] = fopen(strcat(OUTPUT, thinSection, '_', phase, 'EBSD.txt'), 'w');
% 
%         fprintf(thinSectionParam, 'id;x;y;phase;grod;kam;grain\n');
% 
%         ID = ebsd.id;
% 
%         for e = 1:length(ID)
% 
%             try
% 
%                 data = strcat(string(ebsd.id(e)), ';', string(ebsd.x(e)), ';', string(ebsd.y(e)), ';', phase, ';', string(grod(e)), ';', string(kam(e)), ';', string(ebsd.grainId(e)), '\n');
%                 fprintf(thinSectionParam, data);
%             catch
% 
%             end
%             
%         end

        format long
        
        name = strcat(OUTPUT, thinSection, '_', phase, '_EBSD.csv');
        name = char(name);

        if grod == 0
            grod = ones(length(ebsd), 1);
        end

        if kam == 0
            kam = ones(length(ebsd), 1);
        end
        
        if phase == 'notIndexed'
            header = {'id', 'x', 'y', 'grain'};
            data = [ebsd.id, ebsd.x, ebsd.y, ebsd.grainId];
        else
            header = {'id', 'x', 'y', 'grain', 'grod', 'kam', 'orientations_i', 'orientations_phi1', 'orientations_Phi', 'orientations_phi2', 'orientations_a', 'orientations_b', 'orientations_c', 'orientations_d'};
            data = [ebsd.id, ebsd.x, ebsd.y, ebsd.grainId, grod, kam, ebsd.orientations.i, ebsd.orientations.phi1, ebsd.orientations.Phi, ebsd.orientations.phi2, ebsd.orientations.a, ebsd.orientations.b, ebsd.orientations.c, ebsd.orientations.d];
        
        end

        csvwrite_with_headers(name,data,header);
                
end


