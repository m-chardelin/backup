function CPOcombined(porphGrains, neoGrains, odfNeo, odfPorph, indMiller, mineral, OUTPUT, thinSection, comment, colorScale, color, pfXY)    

        setMTEXpref('pfAnnotations',pfXY);


        col = color
        close all
        %plotPDF(odfNeo,indMiller,'antipodal','lower','resolution',2*degree,'contour','LevelList',[0:1:10],'ShowText','off','linecolor',col,'Linewidth',1,'add2all');
        %plotPDF(odfNeo,indMiller,'lower','resolution',2*degree, 'minmax');
        plotPDF(porphGrains.meanOrientation, indMiller, 'lower', 'antipodal', 'MarkerSize', 2, 'MarkerColor', 'white')
        hold on
        plotPDF(odfPorph,indMiller,'antipodal','lower','resolution',2*degree,'contour','ShowText','off','linecolor','grey','Linewidth',2,'add2all');
        hold on
        plotPDF(odfNeo,indMiller,'antipodal','lower','resolution',2*degree,'contour', 'ShowText','off','linecolor','grey','Linewidth',3,'add2all');
        hold on
        plotPDF(odfNeo,indMiller,'antipodal','lower','resolution',2*degree,'contour', 'ShowText','off','linecolor',col,'Linewidth',2,'add2all');
        hold on
        
        %hold on
        %CLim(gcm,'equal');
        hold on
        drawNow(gcm,'figSize','medium');
        hold on
        %c = colorbar;
        %hold on;
        annotation('textbox',[0.89245474241126 0.0 0.113987284287012 0.101123744132535], 'String', strcat(string(length(porphGrains)), ' / ', string(length(neoGrains))), 'FontName','Serif', 'HorizontalAlignment','center', 'FontSize', 10,  'LineStyle','none', 'FitBoxToText', 'off', 'EdgeColor', 'white');
        hold off
        %title(strcat('Nb grains :', string(length(grains))))
    
        task = strcat('CPO', comment);
        saveMAP(OUTPUT, thinSection, mineral, task)

end

