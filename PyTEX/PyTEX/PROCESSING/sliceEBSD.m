function [eb] = sliceEBSD(ebsd, number, x, y)

    xx = (max(ebsd.x) - min(ebsd.x)) / number;
    yy = (max(ebsd.y) - min(ebsd.y)) / number;


    region = [xx*(x-1) yy*(y-1) xx*x yy*y];
    cond = inpolygon(ebsd, region);

    eb = ebsd(cond)

end
