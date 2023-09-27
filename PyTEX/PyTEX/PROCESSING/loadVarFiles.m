function [ebsd, TXTfile, DATAfile] = loadVarFiles(i, thinSectionsFiles, thinSectionsData, format, transformation)

        TXTfile = thinSectionsFiles(i);
        DATAfile = thinSectionsData(i);
        
%%
        if contains(format, 'cpr')
            ebsd = EBSD.load(DATAfile, transformation);
        end

        if contains(format, 'crc')
            ebsd = EBSD.load(DATAfile, 'interface', 'crc', transformation);
        end

        if contains(format, 'ctf')
            ebsd = EBSD.load(DATAfile, 'interface', 'ctf', transformation);
        end


end