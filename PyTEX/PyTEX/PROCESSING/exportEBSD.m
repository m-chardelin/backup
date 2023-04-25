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

        name = strcat(OUTPUT, thinSection, '_', phase, '_EBSD.txt');
        name = char(name);

        header = {'id', 'x', 'y', 'grain', 'grod', 'kam'};
        data = [ebsd.id, ebsd.x, ebsd.y, ebsd.grainId, grod, kam];
        
        csvwrite_with_headers(name,data,header);
                
end


