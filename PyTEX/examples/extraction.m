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
    startup_mtex
    set(groot,'defaultFigureVisible','off')
    setMTEXpref('xAxisDirection','east');
    setMTEXpref('zAxisDirection','outOfPlane');
    setMTEXpref('FontSize',12);
    setMTEXpref('FontName', 'serif');
    
    % Default MTEX colormap - jet colormap begin with white
    setMTEXpref('defaultColorMap',WhiteJetColorMap);

%% *************************************LOAD PARAMETERS**************************************
    analysisParameters
    colorScale
    poleFigureAnnotation


    %% precise working directories
    MAIN_FOLDER = '/home/desktop/current/EBSD';
    DATA = '/home/desktop/current/EBSD/dataClean/';
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
    createMap(OUTPUT, thinSection, 'all', ebsd, grains, 0.1, 'black')

    %% export grain boundaries coordinates
    exportBoundaries(OUTPUT, thinSection, grains)

    [ebsdN, grainsN, ESN, SGN] = grainDetection(ebsd, segAngle, subSegAngle, smallGrainsOption, 1, iter);
    exportNeighbors(OUTPUT, thinSection, grainsN)
    %%
    %meshGrains(OUTPUT, thinSection, grainsN, ebsdN)

    %% Area export
    exportArea(OUTPUT, ebsd, grains, SG, thinSection, phaseList)

    ebsdAligned = rotationAligned(ebsd)
    [ebsdAligned, grainsAligned, ESAligned, SGAligned] = grainDetection(ebsdAligned, segAngle, subSegAngle, smallGrainsOption, nonIndexedOption, iter);
    
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

        if (length(mineralEBSD) > 0) && (string(mineral) == 'notIndexed')   
            exportGrains(OUTPUT, thinSection, phase, mineralGrains);
            exportEBSD(OUTPUT, thinSection, phase, mineralEBSD, 0, 0)
        end
     
        %% ignore non indexed phase
        if (length(mineralEBSD) > 0) && (string(mineral) ~= 'notIndexed')      


            %% make a color scale for mineral
            [mineralCS, mineralColor] = mineralColorScale(phase);

            %% calculate GROD and KAM, exporting in a map
            [maxGROD, meanGROD, grod] = mapGROD(OUTPUT, thinSection, phase, mineralEBSD, mineralGrains, grains, 0.01, 'black', corange, lim);
            [maxKAM, meanKAM, kam] = mapKAM(OUTPUT, thinSection, phase, mineralEBSD, grains, 0.01, 'black', cpurple, lim);

            %% export grains and ebsd tables for each mineral for Python data treatment
            exportGrains(OUTPUT, thinSection, phase, mineralGrains);
            exportEBSD(OUTPUT, thinSection, phase, mineralEBSD, grod, kam)

            mineralGrainsSmall = mineralGrains(mineralGrains.grainSize > 3);
            mineralEBSDSmall = mineralEBSD(mineralGrainsSmall);

            %% export small table with mean values of grains parameters
            exportParam(OUTPUT, thinSection, phase, 'all', mineralGrains, meanGROD, meanKAM)

            %% map orientation
            % tf = strcmp(phase,'Amphibole');
            % if tf == false
            %     mapOrientations(OUTPUT, thinSection, phase, mineralEBSD, mineralGrains, SG, 'black', 0.8)
            % end

                        %% ODF and CPO
            [odf, value, ori, Jindex] = ODFjIndex(mineralEBSDSmall);
            [phasePFs, CS] = selectPFs(mineralEBSDSmall, phase);
            CPO(mineralGrainsSmall, odf, phasePFs, phase, OUTPUT, thinSection, 'all', mineralCS, mineralColor, pfXY)    


            %% export indexes for the relevant minerals 
            if (contains(phase, 'Olivine')) || (contains(phase, 'Orthopyroxene')) || (contains(phase, 'Clinopyroxene'))
                 [BA, BC, AC] = indexMineral(mineralGrainsSmall, phasePFs);
                 exportIndex(OUTPUT, thinSection, phase, 'all', Jindex, BA, BC, AC, mineralGrainsSmall.length);
            end


            %% ODF and CPO
            neo = mineralGrains(mineralGrains.GOS./degree < 1);
            neo = neo(neo.equivalentRadius*2 < 400);
            neo = neo(neo.grainSize > 3);
            neoebsd = mineralEBSD(neo);
            [odfNeo, value, ori, Jindex] = ODFjIndex(neoebsd);
            [phasePFs, CS] = selectPFs(neoebsd, phase);
            CPO(neo, odfNeo, phasePFs, phase, OUTPUT, thinSection, 'neo', mineralCS, mineralColor, pfXY)    
            % export indexes for the relevant minerals 
            if (contains(phase, 'Olivine')) || (contains(phase, 'Orthopyroxene')) || (contains(phase, 'Clinopyroxene'))
                 [BA, BC, AC] = indexMineral(neo, phasePFs);
                 exportIndex(OUTPUT, thinSection, phase, 'neo', Jindex, BA, BC, AC, neo.length);
            end

            %% ODF and CPO
            p = mineralGrains(mineralGrains.GOS./degree > 1) ;
            n = mineralGrains(mineralGrains.GOS./degree < 1 & mineralGrains.equivalentRadius*2 > 400);
            porph = [p, n];
            porph = porph(porph.grainSize > 3);
            porphEBSD = mineralEBSD(porph);
            [odfPorph, value, ori, Jindex] = ODFjIndex(porphEBSD);
            [phasePFs, CS] = selectPFs(porphEBSD, phase);
            CPO(porph, odfPorph, phasePFs, phase, OUTPUT, thinSection, 'porph', mineralCS, mineralColor, pfXY)    
            % export indexes for the relevant minerals 
            if (contains(phase, 'Olivine')) || (contains(phase, 'Orthopyroxene')) || (contains(phase, 'Clinopyroxene'))
                 [BA, BC, AC] = indexMineral(porph, phasePFs);
                 exportIndex(OUTPUT, thinSection, phase, 'porph', Jindex, BA, BC, AC, porph.length);
            end

            %%
            CPOcombined(porph, neo, odfNeo, phasePFs, phase, OUTPUT, thinSection, 'combined', mineralCS, mineralColor, pfXY) 

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            %% ODF and CPO

            mineralEBSDAligned = ebsdAligned(mineral);
            mineralGrainsAligned = SGAligned(mineral)

            neo = mineralGrainsAligned(mineralGrainsAligned.GOS./degree < 1);
            neo = neo(neo.equivalentRadius*2 < 400);
            neo = neo(neo.grainSize > 3);
            neoebsd =mineralEBSDAligned(neo);
            [odfNeo, value, ori, Jindex] = ODFjIndex(neoebsd);
            [phasePFs, CS] = selectPFs(neoebsd, phase);
            CPO(neo, odfNeo, phasePFs, phase, OUTPUT, thinSection, 'neoAligned', mineralCS, mineralColor, pfXY)    
            
            p = mineralGrainsAligned(mineralGrainsAligned.GOS./degree > 1) ;
            n = mineralGrainsAligned(mineralGrainsAligned.GOS./degree < 1 & mineralGrainsAligned.equivalentRadius*2 > 400);
            porph = [p, n];
            porph = porph(porph.grainSize > 3);
            porphEBSD = mineralEBSDAligned(porph);
            [odfPorph, value, ori, Jindex] = ODFjIndex(porphEBSD);
            [phasePFs, CS] = selectPFs(porphEBSD, phase);
            CPO(porph, odfPorph, phasePFs, phase, OUTPUT, thinSection, 'porphAligned', mineralCS, mineralColor, pfXY)    


            CPOcombined(porph, neo, odfNeo, phasePFs, phase, OUTPUT, thinSection, 'combinedAligned', mineralCS, mineralColor, pfXY)

        end


    end


    catch
    end

end
fprintf('END')

