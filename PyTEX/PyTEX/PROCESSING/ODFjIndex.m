function [odf, value, ori, J] = ODFjIndex(ebsd)

        odf = calcDensity(ebsd.orientations)
        [value,ori] = max(odf)
        J = textureindex(odf)

end
