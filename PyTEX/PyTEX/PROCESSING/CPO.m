function CPO(grains, odf, indMiller, mineral, OUTPUT, thinSection, comment, colorScale, color, pfXY)    

        setMTEXpref('pfAnnotations',pfXY);

        if length(grains) > 150

            plotPDF(odf,indMiller,'lower','resolution',2*degree, 'minmax');
            hold on
            plot(odf,indMiller,'antipodal','lower','resolution',2*degree,'contour','LevelList',[0:1:10],'ShowText','off','linecolor','k','Linewidth',1,'add2all');
            hold on
            CLim(gcm,'equal');
            hold on
            mycolormap = colorScale;
            hold on
            drawNow(gcm,'figSize','medium');
            hold on
            colormap(mycolormap);
            hold on
            %c = colorbar;
            %hold on;
            annotation('textbox',[0.89245474241126 0.0 0.113987284287012 0.101123744132535], 'String', strcat(string(length(grains)), ' grains'), 'FontName','Serif', 'HorizontalAlignment','center', 'FontSize', 10,  'LineStyle','none', 'FitBoxToText', 'off', 'EdgeColor', 'white');
            hold off
            %title(strcat('Nb grains :', string(length(grains))))
    
            task = strcat('CPO', comment);
            saveMAP(OUTPUT, thinSection, mineral, task)

        else

            col = color
            plotPDF(grains.meanOrientation, indMiller, 'lower', 'antipodal', 'MarkerSize', 4, 'MarkerColor', col)
            annotation('textbox',[0.89245474241126 0.0 0.113987284287012 0.101123744132535], 'String', strcat(string(length(grains)), ' grains'), 'FontName','Serif', 'HorizontalAlignment','center', 'FontSize', 10, 'LineStyle','none', 'FitBoxToText', 'off', 'EdgeColor', [1 1 1]);
            task = strcat('CPOoppg', comment)
            saveMAP(OUTPUT, thinSection, mineral, task)

        end
end

