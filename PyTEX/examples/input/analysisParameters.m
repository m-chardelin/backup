% Segmentation and small grains filter parameters

segAngle = 15;
subSegAngle = 2;

madSeuil = 0.75;

smallGrainsOption = 0;
nonIndexedOption = 0;
iter = 2;

transformationClean = ''
transformationExtraction = 'convertSpatial2EulerReferenceFrame'
formatClean = 'ctf';
formatExtraction = 'ctf';

inputName = 'inputThinSections'
inputNameExtract = 'inputThinSectionsExtract'

nbThinSections = 59;
nbThinSectionsExtract = 59;

lim = [0, segAngle];
