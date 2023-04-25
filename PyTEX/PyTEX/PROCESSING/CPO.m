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
    %       c = colorbar;
            %hold on;
            annotation('textbox',[0.90 0.0212756264236902 0.0988967691095347 0.05], 'String', strcat(string(length(grains)), ' grains'), 'FontName','Serif', 'HorizontalAlignment','center', 'FontSize', 18, 'FitBoxToText', 'on', 'EdgeColor', 'white');
            hold off
            %title(strcat('Nb grains :', string(length(grains))))
    
            task = strcat('CPO_', comment);
            saveMAP(OUTPUT, thinSection, mineral, task)

        else

            col = color
            plotPDF(grains.meanOrientation, indMiller, 'lower', 'antipodal', 'MarkerSize', 4, 'MarkerColor', col)
            annotation('textbox',[0.90 0.0212756264236902 0.0988967691095347 0.05], 'String', strcat(string(length(grains)), ' grains'), 'FontName','Serif', 'HorizontalAlignment','center', 'FontSize', 18, 'FitBoxToText', 'on', 'EdgeColor', 'white');
            task = strcat('CPOoppg_', comment)
            saveMAP(OUTPUT, thinSection, mineral, task)

        end
end

