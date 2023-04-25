function createMap(OUTPUT, thinSection, mineral, ebsd, grains, linewidth, lineColor)

        close all
        hold on 
        plot(grains,'linewidth', linewidth, 'lineColor', lineColor)
        legend off
        hold off

        task = 'PHASES'
        saveMAP(OUTPUT, thinSection, '', task);


        close all
        plot(grains.boundary,'linewidth', linewidth, 'lineColor', lineColor)
        hold on
        plot(grains.innerBoundary,'linewidth', 0.8, 'lineColor','blue');
        hold on
        legend off
        hold off
        
        task = 'BOUNDARY'
        saveMAP(OUTPUT, thinSection, '', task);

        close all
        plot(ebsd)
        legend off
        hold off
        
        task = 'EBSD'
        saveMAP(OUTPUT, thinSection, '', task);


        close all
        plot(ebsd, ebsd.bc)
        colormap gray
        hold on
        for e=2:length(ebsd.mineralList)
            plot(grains(ebsd.mineralList(e)).boundary, 'linewidth', linewidth, 'lineColor', ebsd(ebsd.mineralList(e)).color)
            hold on
        end
        hold off
        task = 'BANDCONTRAST'
        saveMAP(OUTPUT, thinSection, '', task);
end