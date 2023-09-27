function [maxKAM, meanKAM, kam] = mapKAM(OUTPUT, thinSection, phase, ebsd, grainsall, linewidth, lineColor, color, lim, ebsdall, phases, minerals, colors)


        kam = ebsd.KAM / degree;
        meanKAM = mean(rmmissing(kam));
        maxKAM = max(rmmissing(kam));

        close all
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
        plot(ebsd,kam,'micronbar','off')
        hold on
        mycolormap = customcolormap([0 .25 .5 .75 1], color);
        hold on
        plot(grainsall.boundary,'linewidth', linewidth, 'lineColor', lineColor)
        hold on
        colormap(mycolormap);
        hold on
        caxis(lim)
        hold on
        c = colorbar;
        hold on
        c.Location = 'southoutside';
        hold on
        c.Label.String = 'KAM (degree)'
        hold on
        c.FontName = 'Serif';
        hold off

        task = "KAM";
        saveMAP(OUTPUT, thinSection, phase, task);

end