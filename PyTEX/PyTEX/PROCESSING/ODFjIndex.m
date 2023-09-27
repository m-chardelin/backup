function [odf, value, ori, J] = ODFjIndex(ebsd, grains)

        odf = calcDensity(ebsd.orientations)
        %odf = calcDensity(grains.meanOrientation)
        [value,ori] = max(odf)
        J = textureindex(odf)

end
