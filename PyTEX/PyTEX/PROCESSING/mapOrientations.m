function mapOrientations(OUTPUT, thinSection, phase, ebsd, grains, grainsall, color, size, ebsdall, phases, minerals, colors)

            close all

            ipfKey = ipfColorKey(ebsd);
            ipfKey.inversePoleFigureDirection = vector3d.X;
            
            plot(ipfKey)
            hold on 
            plotIPDF(grains.meanOrientation,  xvector, 'MarkerColor', color, 'MarkerSize', size)
            hold off 
            
            task = "IPF";
            saveMAP(OUTPUT, thinSection, phase, task);


            close all
            legend('off')
            hold on

            phases = string(phases);
            for i=1:length(minerals)
                ind = find(phases==minerals(i));
                if ind>0
                    indPhase = ebsdall.mineralList(ind);
                    if length(ebsdall(indPhase))>0
                        plot(grainsall(indPhase),'FaceColor',str2rgb(colors(i)))
                        hold on
                    else
                        hold on
                    end
                end
            end
            colors = ipfKey.orientation2color(ebsd.orientations);
            plot(ebsd,colors)
            hold on
            plot(grainsall.boundary,'linewidth', size, 'lineColor', color)
            hold off

            task = "ORIENTATIONS"
            saveMAP(OUTPUT, thinSection, phase, task);


end
