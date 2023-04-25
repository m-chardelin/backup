function exportGrains(OUTPUT, thinSection, phase, grains)

        name = strcat(OUTPUT, thinSection, '_', phase, '_Grains.txt');
        name = char(name);


        id = grains.id;
        [x, y] = centroid(grains);
        perimeter = grains.perimeter;
        diam = grains.diameter;
        area = grains.area;
        aspectRatio = grains.aspectRatio;
        equivalentRadius = grains.equivalentRadius;
        shapeFactor = grains.shapeFactor;
        GOS = grains.GOS./degree;
        [Angle, a, b] = principalComponents(grains);
        feret = diameter(grains);
        numNeighbor = numNeighbors(grains);

        chGrains = grains.hull;
        deltaP = 100 * (grains.perimeter-chGrains.perimeter) ./ grains.perimeter;
        paris = 200 * (grains.perimeter - chGrains.perimeter) ./ chGrains.perimeter;
        deltaA = 100 * (chGrains.area - grains.area) ./ chGrains.area;
        radiusD = sqrt(deltaP.^2 + deltaA.^2);
        convexity = chGrains.perimeter ./ perimeter;
        tortuosity = perimeter ./ chGrains.perimeter;
        solidity = area ./ chGrains.area;

        header = {'id', 'centroidX', 'centroidY', 'perimeter', 'diameter', 'area', 'aspectRatio', 'equivalentRadius',...
            'shapeFactor', 'GOS', 'Angle', 'a', 'b', 'feret', 'numNeighbors', 'hullPerimeter', 'hullArea', 'deltaP', 'paris',...
            'deltaA', 'radiusD', 'convexity', 'tortuosity', 'solidity'};

        data = [id, x, y, perimeter, diam, area, aspectRatio, equivalentRadius,...
            shapeFactor, GOS, Angle, a, b, feret, numNeighbor, chGrains.perimeter, chGrains.area, deltaP, paris,...
            deltaA, radiusD, convexity, tortuosity, solidity];

        csvwrite_with_headers(name,data,header);
         
end


