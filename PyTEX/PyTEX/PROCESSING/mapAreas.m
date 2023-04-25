function mapAreas(OUTPUT, thinSection, phase, grains, grainsall, linewidth, lineColor, color)

        close all
        plot(grains, grains.area);
        hold on
        mycolormap = customcolormap([0 .25 .5 .75 1], color);
        hold on
        plot(grainsall.boundary,'linewidth', linewidth, 'lineColor', lineColor)
        hold on
        colormap(mycolormap); 
        hold on
        c = colorbar;
        hold on
        c.Location = 'southoutside';
        hold on 
        c.FontName = 'Serif';
        hold off
        
        task = 'AREAS';

        saveMAP(OUTPUT, thinSection, phase, task);

end