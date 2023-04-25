function [ebsd, phaseList, colorScale] = mineralColors(ebsd)

        phaseList = [];

        for mineral = ebsd.mineralList

            if (string(mineral) == 'notIndexed') && (length(ebsd(mineral)) > 0)
                phaseList = [phaseList, 'notIndexed '];
            end

            if string(mineral) == 'Forsterite'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('red');
                end
                phaseList = [phaseList, 'Olivine '];
            end

            if string(mineral) == 'Enstatite  Opx AV77'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('blue');
                end
                phaseList = [phaseList, 'Orthopyroxene '];
            end

            if string(mineral) == 'Diopside   CaMgSi2O6'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('lime');
                end
                phaseList = [phaseList, 'Clinopyroxene '];
            end

            if string(mineral) == 'Chromite'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('magenta');
                end
                phaseList = [phaseList, 'Spinelle '];
            end

            if string(mineral) == 'Antigorite SG Pm'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('red');
                end
                phaseList = [phaseList, 'Antigorite '];
            end

            if string(mineral) == 'Antigorite SG C2/m  m=16'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('orange');
                end
                phaseList = [phaseList, 'Antigorite2 '];
            end

            if string(mineral) == 'Antigorite SG Pm  m=17'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('orange');
                end
                phaseList = [phaseList, 'Antigorite3 '];
            end

            if string(mineral) == 'Pargasite'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('teal');
                end
                phaseList = [phaseList, 'Pargasite '];
            end

            if string(mineral) == 'Pargasite C2/m'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('purple');
                end
                phaseList = [phaseList, 'Pargasite2 '];
            end

            if string(mineral) == 'Phlogopite'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('crimson');
                end
                phaseList = [phaseList, 'Phlogopite '];
            end

            if string(mineral) == 'Chlorite Mg12(Si,Al)8O20OH16 triclinic (C-1)'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('orange');
                end
                phaseList = [phaseList, 'Chlorite '];
            end

            if string(mineral) == 'Anorthite'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('yellow');
                end
                phaseList = [phaseList, 'Anorthite '];
            end

            if string(mineral) == 'Bytownite'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('pink');
                end
                phaseList = [phaseList, 'Bytownite '];
            end

            if string(mineral) == 'Talc 2M'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('gray');
                end
                phaseList = [phaseList, 'Talc '];
            end

            if string(mineral) == 'Tremolite'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('gray');
                end
                phaseList = [phaseList, 'Tremolite '];
            end


            if string(mineral) == 'Magnetite'
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('crimson');
                end
                phaseList = [phaseList, 'Magnetite '];
            end


            if (string(mineral) == 'Calcite') && (length(ebsd(mineral)) > 0)
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('cornflowerblue');
                end
                phaseList = [phaseList, 'Calcite '];
            end

            if (string(mineral) == 'Hornblende') && (length(ebsd(mineral)) > 0)
                if length(ebsd(mineral)) > 0
                    ebsd(mineral).color = str2rgb('gray');
                end
                phaseList = [phaseList, 'Hornblende '];
            end



        end

        phaseList = split(phaseList, ' ');
end
