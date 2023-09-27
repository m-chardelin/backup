function meshGrains(OUTPUT, thinSection, grains, ebsd)

   
        setMTEXpref('generatingHelpMode',true);

        [grains, ebsd('indexed').grainId]=calcGrains(ebsd('indexed'));
        ebsd(grains(grains.grainSize<3))=[];	% Remove small grains
        grains=calcGrains(ebsd('indexed'));

        G=gmshGeo(grains);

        mesh(G, strcat(OUTPUT, thinSection, '_MeshConstantElementSize.msh'), 'ElementSize', 50, 'Thickness', 20)
        mesh(G, strcat(OUTPUT, thinSection, '_MeshSizeGradient.msh'), 'ElementSize', 50, 'gradient', 0.5, 'Thickness', 20);
        mesh(G, strcat(OUTPUT, thinSection, '_MeshCurvature.msh'), 'Curvature', 5, 'Thickness', 20);
        mesh(G, strcat(OUTPUT, thinSection, '_MeshCurvatureMedium.msh'), 'Curvature', 5, 'medium',[4000 4000 20], 'mediumElementSize',180);
        %mesh(G, strcat(OUTPUT, thinSection, '_MeshBrick.msh'), 'ElementType','Hex', 'Thickness', 20);
        savegeo(G, strcat(OUTPUT, thinSection, '_MeshGeometry.geo'))
        exportGrainProps(G, strcat(OUTPUT, thinSection, 'MeshProperties.csv'));

end