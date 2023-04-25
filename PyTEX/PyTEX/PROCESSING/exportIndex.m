function exportIndex(OUTPUT, thinSection, phase, comment, J, BA, BC, AC, nb)

                [oindex] = fopen(strcat(OUTPUT, 'index.txt'), 'a+');

                txt = strcat(thinSection, ';', phase, ';', comment, ';', string(J), ';', string(BA), ';', string(BC), ';', string(AC), ';', string(nb), '\n');

                fprintf([oindex], txt);

end