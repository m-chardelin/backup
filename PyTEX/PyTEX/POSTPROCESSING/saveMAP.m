function saveMAP(OUTPUT, thinSection, phase, task)

        PNGname = strcat(OUTPUT, thinSection, '_', phase, '_', task, '.png');  
        EPSname = strcat(OUTPUT,thinSection, '_', phase, '_', task, '.eps');
        saveas(gcf, PNGname, 'png')
        saveas(gcf, EPSname, 'epsc')

end