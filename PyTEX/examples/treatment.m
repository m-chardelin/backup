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
    DATA = '/Users/marialinechardelin/scripts/PyTEX/data/';
    INPUT = '';
    OUTPUT = '/Users/marialinechardelin/scripts/PyTEX/examples/dataClean/';

    %% create output folders and output files 
    [INPUT, DATA, OUTPUT, thinSectionsList, thinSectionsFiles, thinSectionsData] = createOutputDir(MAIN_FOLDER, nbThinSections, DATA, INPUT, OUTPUT, formatClean, inputName);

%% **********************************THIN SECTION ITERATION***********************************

for i = 1:length(thinSectionsList)
    
    try
        thinSection = thinSectionsList(i);

        %% loading ctf file
        [ebsd, TXTfile, DATAfile] = loadVarFiles(i, thinSectionsFiles, thinSectionsData, formatClean, transformationClean);
        
        exportFormat(ebsd, OUTPUT, thinSection, 'ctf', 'r')

        %%  putting the right colors for maps, checking phases names
        [ebsd, phaseList] = mineralColors(ebsd);
        phasesEBSD(OUTPUT, thinSection, ebsd, phaseList);
    
        %% cleaning data, calculating grains and subgrains boundaries with no stair effect
        ebsd = dataCleaning(ebsd, madSeuil, segAngle, smallGrainsOption);
        exportFormat(ebsd, OUTPUT, thinSection, 'ctf', 'c')

    catch
        filesError(OUTPUT, thinSection)

    end

end

fprintf('END')

