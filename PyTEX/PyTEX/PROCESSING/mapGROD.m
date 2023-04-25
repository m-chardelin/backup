function [maxGROD, meanGROD, grod] = mapGROD(OUTPUT, thinSection, phase, ebsd, grains, grainsall, linewidth, lineColor, color, lim)

        GROD = ebsd.calcGROD(grainsall);
        grod = GROD.angle./degree;
        meanGROD = mean(rmmissing(grod));
        maxGROD = max(rmmissing(grod));


%         close all
% 
%         txt = strcat("MAX ", phase, " : ", string(maxGROD))
% 
%         plot(ebsd, grod,'micronbar','off')        
%         hold on
%         mycolormap = customcolormap([0 .25 .5 .75 1], color);
%         hold on
%         plot(grainsall.boundary,'linewidth', linewidth, 'lineColor', lineColor)
%         hold on
%         colormap(mycolormap); 
%         hold on 
%         caxis(lim)
%         hold on
%         c = colorbar;
%         hold on
%         c.Location = 'southoutside';
%         hold on 
%         c.Label.String = 'Misorientation angle to mean orientation (degree)'
%         hold on 
%         c.FontName = 'Serif';
%         hold off
%         
%         task = "GROD";
%         saveMAP(OUTPUT, thinSection, phase, task);

end
