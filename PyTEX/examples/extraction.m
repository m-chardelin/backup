%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%       MTEX SCRIPT FOR PROCESSING SAPATS PERIDOTITES EBSD DATA (OLIVINE, ORTHO- & CLINOPYROXENE, CHROMITE)     %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Plotting convention 
% Can be SEM dependent for EBSD in Montpellier it is plot X-axis to East
%
%              NORTH
%                Y
%                |       
%         --------------
%         |            |
%   WEST  |  SPECIMEN  |--> X  EAST (X-axis is parallel to stage tilt axis)
%         |            |
%         --------------
%              SOUTH
%

%% **************************************INITIALISATION**************************************
    % clear memory, close all open plots and import file directories
    clear all
    close all
    clc
    
    % plotting preferences
    %startup_mtex
    set(groot,'defaultFigureVisible','off')
    setMTEXpref('xAxisDirection','east');
    setMTEXpref('zAxisDirection','outOfPlane');
    setMTEXpref('FontSize',18);
    setMTEXpref('FontName', 'serif');
    
    % Default MTEX colormap - jet colormap begin with white
    setMTEXpref('defaultColorMap',WhiteJetColorMap);

%% *************************************LOAD PARAMETERS**************************************
    analysisParameters
    colorScale
    poleFigureAnnotation


    %% precise working directories
    MAIN_FOLDER = '/Users/marialinechardelin/scripts/PyTEX/examples';
    DATA = '/Users/marialinechardelin/scripts/PyTEX/examples/dataClean/';
    INPUT = '';
    OUTPUT = '';

    %% create output folders and output files 
    [INPUT, DATA, OUTPUT, thinSectionsList, thinSectionsFiles, thinSectionsData] = createOutputDir(MAIN_FOLDER, nbThinSectionsExtract, DATA, INPUT, OUTPUT, formatExtraction, inputNameExtract);
    [index, egdsf, area] = createOutputTable(OUTPUT, 'index', 'egdsf', 'area', segAngle, subSegAngle, nonIndexedOption, smallGrainsOption);
   
%% **********************************THIN SECTION ITERATION***********************************

for i = 1:length(thinSectionsList)    
    try
    
    thinSection = thinSectionsList(i);

    %% loading ctf file
    [ebsd, TXTfile, DATAfile] = loadVarFiles(i, thinSectionsFiles, thinSectionsData, formatExtraction, transformationExtraction);
    
    %%  putting the right colors for maps, checking phases names
    [ebsd, phaseList] = mineralColors(ebsd);

    %% grain reconstruction
    [ebsd, grains, ES, SG] = grainDetection(ebsd, segAngle, subSegAngle, smallGrainsOption, nonIndexedOption, iter);
    
    %%
    %createMap(OUTPUT, thinSection, 'all', ebsd, grains, 0.1, 'black')

    %% export grain boundaries coordinates
    exportBoundaries(OUTPUT, thinSection, grains)
    exportNeighbors(OUTPUT, thinSection, grains)
    %%
    exportArea(OUTPUT, ebsd, grains, SG, thinSection, phaseList)

%% *************************************MINERAL ITERATION**************************************

    for j= 1:length(ebsd.mineralList)
    %%   
        %% making the subset for the wanted mineral
        mineral = ebsd.mineralList(j);
        mineralEBSD = ES(mineral);
        mineralGrains = SG(mineral);
       
        %% choosing a denomination for the plot
        phase = string(phaseList(j));
        
        %% flag for non indexed grains
        tf = strcmp(phase,'notIndexed');

        %% ignore non indexed phase
        if (length(mineralEBSD) > 100) && (tf == false)      

            %% make a color scale for mineral
            [mineralCS, mineralColor] = mineralColorScale(phase);

            %% calculate GROD and KAM, exporting in a map
            [maxGROD, meanGROD, grod] = mapGROD(OUTPUT, thinSection, phase, mineralEBSD, mineralGrains, grains, 0.01, 'black', corange, lim);
            [maxKAM, meanKAM, kam] = mapKAM(OUTPUT, thinSection, phase, mineralEBSD, grains, 0.01, 'black', cpurple, lim);
            
            %% export grains and ebsd tables for each mineral for Python data treatment
            exportGrains(OUTPUT, thinSection, phase, mineralGrains);
            exportEBSD(OUTPUT, thinSection, phase, mineralEBSD, grod, kam)

            %% export small table with mean values of grains parameters
            exportParam(OUTPUT, thinSection, phase, 'all', mineralGrains, meanGROD, meanKAM)
           
%             %% map orientation
%             tf = strcmp(phase,'Amphibole');
%             if tf == false
%                 mapOrientations(OUTPUT, thinSection, phase, mineralEBSD, mineralGrains, SG, 'black', 0.8)
%             end
% 
%             %% ODF and CPO
%             [odf, value, ori, Jindex] = ODFjIndex(mineralEBSD);
% 
%             if (contains(phase, 'Olivine')) || (contains(phase, 'Orthopyroxene')) || (contains(phase, 'Clinopyroxene')) || (contains(phase, 'Spinelle')) || (contains(phase, 'Amphibole')) || (contains(phase, 'Plagioclase'))
%                 [phasePFs, CS] = selectPFs(mineralEBSD, phase);
%                 CPO(mineralGrains, odf, phasePFs, phase, OUTPUT, thinSection, 'all', mineralCS, mineralColor, pfXY)    
%             end
%             
%             %% export indexes for the relevant minerals 
%             if (contains(phase, 'Olivine')) || (contains(phase, 'Orthopyroxene')) || (contains(phase, 'Clinopyroxene'))
%                 [BA, BC, AC] = indexMineral(mineralGrains, phasePFs);
%                 exportIndex(OUTPUT, thinSection, phase, 'all', Jindex, BA, BC, AC, mineralGrains.length)
%             end


        end


    end


    catch
    end

end
fprintf('END')

