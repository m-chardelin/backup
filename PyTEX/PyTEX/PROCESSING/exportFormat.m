function exportFormat(ebsd, OUTPUT, thinSection, format, clean)

    ebsd.export(strcat(OUTPUT, thinSection, clean, '.', format))

end