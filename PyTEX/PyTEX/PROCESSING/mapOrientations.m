function mapOrientations(OUTPUT, thinSection, phase, ebsd, grains, grainsall, color, size)

            close all

            ipfKey = ipfColorKey(ebsd);
            ipfKey.inversePoleFigureDirection = vector3d.X;
            
            plot(ipfKey)
            hold on 
            plotIPDF(grains.meanOrientation,  xvector, 'MarkerColor', color, 'MarkerSize', size)
            hold off 
            
            task = strcat(phase, "_ipf");
            saveMAP(OUTPUT, thinSection, phase, task);


            close all
            legend('off')
            hold on
            colors = ipfKey.orientation2color(ebsd.orientations);
            plot(ebsd,colors)
            hold on
            plot(grainsall.boundary,'linewidth', size, 'lineColor', color)
            hold off

            task = "ORIENTATIONS"
            saveMAP(OUTPUT, thinSection, phase, task);


end
