% Segmentation and small grains filter parameters

segAngle = 15;
subSegAngle = 2;

madSeuil = 0.9;

smallGrainsOption = 5;
nonIndexedOption = 0;
iter = 2;

transformationClean = ''
transformationExtraction = 'convertSpatial2EulerReferenceFrame'
formatClean = 'crc';
formatExtraction = 'ctf';

inputName = 'inputThinSections'
inputNameExtract = 'inputThinSectionsExtract'

nbThinSections = 3;
nbThinSectionsExtract = 3;

lim = [0, segAngle];
