function exportBoundaries(OUTPUT, thinSection, grains)

        name = strcat(OUTPUT, thinSection, '_', 'Boundaries.csv');
        name = char(name);

        header = {'x', 'y'};
        
        data = [grains.boundary.x, grains.boundary.y];
     
        csvwrite_with_headers(name,data,header);

        name = strcat(OUTPUT, thinSection, '_', 'InnerBoundaries.csv');
        name = char(name);

        header = {'x', 'y'};
        data = [grains.innerBoundary.x, grains.innerBoundary.y];
        
        csvwrite_with_headers(name,data,header);

end


