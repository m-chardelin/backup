function filesError(OUTPUT, thinSection)

        [error]=fopen(strcat(OUTPUT, 'filesError.txt'), 'a+');
        
        txt=strcat(thinSection, '\n');

        fprintf([error], txt);
end