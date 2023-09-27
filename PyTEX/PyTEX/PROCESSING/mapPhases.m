function createMap(OUTPUT, thinSectionsList, i, ebsd, grains, linewidth, lineColor)

        close all
        hold on 
        plot(grains,'linewidth', linewidth, 'lineColor', lineColor)
        legend off
        hold off

        task = 'PHASES'
        plotMap(OUTPUT, thinSectionsList, i, task)
        

        close all
        plot(grains.boundary,'linewidth', linewidth, 'lineColor', lineColor)
        hold on
        plot(grains.innerBoundary,'linewidth', 0.8, 'lineColor','blue');
        hold on
        legend off
        hold off
        
        task = 'BOUNDARY'
        plotMap(OUTPUT, thinSectionsList, i, task)
        
        
        close all
        plot(ebsd)
        legend off
        hold off
        
        task = 'EBSD'
        plotMap(OUTPUT, thinSectionsList, i, task)

end