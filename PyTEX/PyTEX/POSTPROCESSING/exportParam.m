function exportParam(OUTPUT, thinSection, phase, comment, grains, meanGROD, meanKAM)

                [oegdsf]=fopen(strcat(OUTPUT, 'egdsf.csv'), 'a+');


                sf=mean(rmmissing(grains.shapeFactor));
                egd=mean(rmmissing(grains.equivalentRadius*2));
                nb=grains.length;

                try
                    txt=strcat(thinSection, ';', phase, ';',  comment, ';', string(egd), ';', string(sf), ';', string(meanGROD), ';', string(meanKAM), ';', string(nb), '\n');
                    fprintf([oegdsf], txt);
                catch
                    meanKAM='NaN';
                    txt=strcat(thinSection, ';', phase, ';',  comment, ';', string(egd), ';', string(sf), ';', string(meanGROD), ';', string(meanKAM), ';', string(nb), '\n');
                    fprintf([oegdsf], txt);
                end


end