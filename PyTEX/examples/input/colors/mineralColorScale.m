function [mineralCS, c1] = mineralmineralCS(phase)            
            
            if (contains(phase, 'Olivine')) 
                c1 = str2rgb('red');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
            end

            if (contains(phase, 'Orthopyroxene'))
                c1 = str2rgb('blue');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
            end

            if (contains(phase, 'Clinopyroxene'))
                c1 = str2rgb('lime');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
            end

            if (contains(phase, 'Plagioclase'))
                c1 = str2rgb('yellow');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
            end

            if (contains(phase, 'Anorthite'))
                c1 = str2rgb('yellow');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
            end

            if (contains(phase, 'Bytownite'))
                c1 = str2rgb('yellow');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
            end

            if (contains(phase, 'Spinelle'))
                c1 = str2rgb('magenta');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
            end

             if (contains(phase, 'Amphibole'))
                c1 = str2rgb('aquamarine');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
             end

             if (contains(phase, 'Antigorite'))
                c1 = str2rgb('aquamarine');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
             end

             if (contains(phase, 'Pargasite'))
                c1 = str2rgb('aquamarine');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
             end

              if (contains(phase, 'Calcite'))
                c1 = str2rgb('grey');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
              end
              
              if (contains(phase, 'Chlorite'))
                c1 = str2rgb('grey');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
              end

              if (contains(phase, 'Hornblende'))
                c1 = str2rgb('grey');
                c2 = str2rgb('white');
                mineralCS = colorGradient(c2, c1, 60)
              end
end