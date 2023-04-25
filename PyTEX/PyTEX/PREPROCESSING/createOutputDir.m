function [INPUT, DATA, OUTPUT, thinSectionsList, thinSectionsFiles, thinSectionsData]=createOutputDir(MAIN_FOLDER, nbThinSections, data, input, output, format, inputThinSections)
    
        %%
        if strcmp(data, '')
            DATA=strcat(MAIN_FOLDER, '/DATA/');
        else
            DATA=data;
        end

        if strcmp(input, '')
            INPUT=strcat(MAIN_FOLDER, '/INPUT/');
        else
            INPUT=input;
        end
        
        if strcmp(output, '')
            OUTPUT=strcat(MAIN_FOLDER, '/OUTPUT/total/');
        else 
            OUTPUT=output;
        end

        %%
        LISTTS=strcat(INPUT, inputThinSections, '.txt');

        fileTS=fopen(LISTTS, 'r');

        %%
        thinSectionsList=[];
        thinSectionsFiles=[];
        thinSectionsData=[];
        
        %%
        for ifile=1:nbThinSections
            TS=fgets(fileTS);
            TS=strtrim(string(TS));
            thinSectionsList=[thinSectionsList,TS];  
            thinSectionsFiles=[thinSectionsFiles,strcat(OUTPUT, TS, '.txt')];
            thinSectionsData=[thinSectionsData,strcat(DATA, TS, '.', format)];
            TSfolder=thinSectionsFiles(ifile);
        end

end