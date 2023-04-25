function [phasePFs, CS] = selectPFs(ebsd, phase)

            if (contains(string(phase), 'Olivine'))
                CS = ebsd.CS
                PF1ol_100 = Miller(1,0,0,CS,'uvw');
                PF2ol_010 = Miller(0,1,0,CS,'uvw');
                PF3ol_001 = Miller(0,0,1,CS,'uvw');
                phasePFs = {PF1ol_100, PF2ol_010, PF3ol_001};
            end

            if (contains(string(phase), 'Orthopyroxene'))
                CS = ebsd.CS
                PF1opx_100 = Miller(1,0,0,CS,'uvw');
                PF2opx_010 = Miller(0,1,0,CS,'uvw');
                PF3opx_001 = Miller(0,0,1,CS,'uvw');
                phasePFs = {PF1opx_100,PF2opx_010,PF3opx_001};
            end

            if (contains(string(phase), 'Clinopyroxene'))
                CS = ebsd.CS
                PF1cpx_100 = Miller(1,0,0,CS,'hkl');
                PF2cpx_010 = Miller(0,1,0,CS,'hkl');
                PF3cpx_001 = Miller(0,0,1,CS,'uvw');
                phasePFs = {PF1cpx_100,PF2cpx_010,PF3cpx_001};
            end

            if (contains(string(phase), 'Spinelle'))
                CS = ebsd.CS
                PF1Chromite_100 = Miller(1,0,0,CS,'hkl');
                PF2Chromite_110 = Miller(1,1,0,CS,'hkl');
                PF3Chromite_111 = Miller(1,1,1,CS,'uvw');
                phasePFs = {PF1Chromite_100,PF2Chromite_110,PF3Chromite_111}
            end

            if (contains(string(phase), 'Amphibole'))
                CS = ebsd.CS
                PF1amph_100 = Miller(1,0,0,CS,'uvw');
                PF2amph_010 = Miller(0,1,0,CS,'hkl');
                PF3amph_001 = Miller(0,0,1,CS,'hkl');
                phasePFs = {PF1amph_100,PF2amph_010,PF3amph_001}
            end

            if (contains(string(phase), 'Plagioclase'))
                CS = ebsd.CS
                PF1plag_100 = Miller(1,0,0,CS,'uvw');
                PF2plag_010 = Miller(0,1,0,CS,'hkl');
                PF3plag_001 = Miller(0,0,1,CS,'hkl');
                phasePFs = {PF1plag_100,PF2plag_010,PF3plag_001}
            end

end