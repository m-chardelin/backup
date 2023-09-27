function [] = areaWEGD(grains, thinSection, mineral, comment, res, meanGROD)

        g_equivalentdiameter = 2*equivalentRadius(grains);
        g_shapefactor = grains.shapeFactor
        g_area = grains.area;
        nbins = 40;


        %**************************************************************************
        % Plot frequency versus equivalent grain diameter
        %**************************************************************************
        % get counts per bin and bin centres (in microns)
        [g_diameter_counts,g_diameter_bin_centres] = hist(g_equivalentdiameter,nbins);
        % define bin lo and hi ranges in Equivalent diameter (microns)
        % avoid 2 - 1 sometimes gives slight error
        Bin_width = g_diameter_bin_centres(3)-g_diameter_bin_centres(2);
        Half_bin_width = Bin_width/2.0;
        Bin_lo=zeros(nbins);
        Bin_hi=zeros(nbins);
        for i=1:nbins
            Bin_lo(i) = g_diameter_bin_centres(i)-Half_bin_width;
            Bin_hi(i) = g_diameter_bin_centres(i)+Half_bin_width;
        end
        % ensure all diameters of data in bin window
        Bin_lo(1)=min(g_equivalentdiameter);
        Bin_hi(nbins)=max(g_equivalentdiameter);
        % Percent counts per bin
        g_diameter_percent = (100*g_diameter_counts)/sum(g_diameter_counts);
        % plot
        figure('DefaultAxesFontSize',14, 'DefaultAxesFontName', 'serif')
        bar(g_diameter_bin_centres,g_diameter_percent, 'FaceColor', 'black')
        % plot labels
        xlabel('EGD (microns)')
        ylabel('Frequency (%)')
        task = "EGD";
        PNGname = strcat(res, thinSection, '_', mineral, task, comment, '.png')
        EPSname = strcat(res, thinSection, '_', mineral, task, comment, '.eps')
        saveas(gcf, PNGname, 'png');
        saveas(gcf, EPSname, 'epsc');

        %%

        % Total surface area
        Total_surface_area = sum(g_area);
        % accumulate in bins
        n_sample=length(g_equivalentdiameter);
        area_per_bin = zeros(nbins);
        area_counts_per_bin = zeros(nbins);
        for n=1:n_sample
        % search bins
              for i=1:nbins
                   if (g_equivalentdiameter(n) >= Bin_lo(i)) && ...
                      (g_equivalentdiameter(n) <= Bin_hi(i))
                      area_per_bin(i)=area_per_bin(i)+g_area(n);
                      area_counts_per_bin(i)=area_counts_per_bin(i)+1;
                   end
              end
        end
        % Percent surace area per bin
        g_counts_percent_wt_area = zeros(nbins);
        for i=1:nbins
            g_counts_percent_wt_area(i) = 100.0*area_per_bin(i,1)/Total_surface_area;
        end
        % get array into format (1 x ibin)
        g_counts_percent_wt_area2 = g_counts_percent_wt_area(:,1);
        % transpose
        g_counts_percent_wt_area3 = g_counts_percent_wt_area2';
        
        
        % vertically concatenates and transposed
        Combined_count_wt_area = [g_diameter_percent; g_counts_percent_wt_area3]';

        % plot
        figure('DefaultAxesFontSize',14, 'DefaultAxesFontName', 'serif')
        %bar(g_diameter_bin_centres,Combined_count_wt_area,'histc', 'FaceColor', 'black')
        bar(g_diameter_bin_centres,g_counts_percent_wt_area2, 'FaceColor', 'black')
        xlabel('EGD area weighted(microns)')
        ylabel('Frequency (%)')
        task = "EGDaw";
        PNGname = strcat(res, thinSection, '_', mineral, task, comment, '.png')
        EPSname = strcat(res, thinSection, '_', mineral, task, comment, '.eps')
        saveas(gca, PNGname, 'png');
        saveas(gca, EPSname, 'epsc');
        
        
        %meanEGD = meanPond(g_diameter_bin_centres, g_counts_percent_wt_area2);

        EDG = grains.equivalentRadius
        EDG = EDG*2
        meanEGD = mean(EDG)

        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %**************************************************************************
        % Plot frequency versus shape factor
        %**************************************************************************
        % get counts per bin and bin centres (in microns)
        [g_diametersf_counts,g_diametersf_bin_centres] = hist(g_shapefactor,nbins);
        % define bin lo and hi ranges in Equivalent diameter (microns)
        % avoid 2 - 1 sometimes gives slight error
        Bin_width = g_diametersf_bin_centres(3)-g_diametersf_bin_centres(2);
        Half_bin_width = Bin_width/2.0;
        Bin_lo=zeros(nbins);
        Bin_hi=zeros(nbins);
        for i=1:nbins
            Bin_lo(i) = g_diametersf_bin_centres(i)-Half_bin_width;
            Bin_hi(i) = g_diametersf_bin_centres(i)+Half_bin_width;
        end
        % ensure all diameters of data in bin window
        Bin_lo(1)=min(g_shapefactor);
        Bin_hi(nbins)=max(g_shapefactor);
        % Percent counts per bin
        g_diametersf_percent = (100*g_diametersf_counts)/sum(g_diametersf_counts);
        % plot
        figure('DefaultAxesFontSize',14, 'DefaultAxesFontName', 'serif')
        bar(g_diametersf_bin_centres,g_diametersf_percent, 'FaceColor', 'white')
        % plot labels
        xlabel('Shape factor')
        ylabel('Frequency (%)')
        task = "SF";
        PNGname = strcat(res, thinSection, '_', mineral, task, comment, '.png')
        EPSname = strcat(res, thinSection, '_', mineral, task, comment, '.eps')
        saveas(gcf, PNGname, 'png');
        saveas(gcf, EPSname, 'epsc');

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Total surface area
        Total_surface_area = sum(g_area);
        % accumulate in bins
        n_sample=length(g_shapefactor);
        area_per_bin = zeros(nbins);
        area_counts_per_bin = zeros(nbins);
        for n=1:n_sample
        % search bins
              for i=1:nbins
                   if (g_shapefactor(n) >= Bin_lo(i)) && ...
                      (g_shapefactor(n) <= Bin_hi(i))
                      area_per_bin(i)=area_per_bin(i)+g_area(n);
                      area_counts_per_bin(i)=area_counts_per_bin(i)+1;
                   end
              end
        end
        % Percent surace area per bin
        g_counts_percent_wt_area = zeros(nbins);
        for i=1:nbins
            g_counts_percent_wt_area(i) = 100.0*area_per_bin(i,1)/Total_surface_area;
        end
        % get array into format (1 x ibin)
        g_counts_percent_wt_area2 = g_counts_percent_wt_area(:,1);
        % transpose
        g_counts_percent_wt_area3 = g_counts_percent_wt_area2';
        % plot
        figure('DefaultAxesFontSize',14, 'DefaultAxesFontName', 'serif')
        bar(g_diametersf_bin_centres,g_counts_percent_wt_area2, 'FaceColor', "white")
        xlabel('Shape factor area weighted')
        ylabel('Frequency (%)')
        task = "SFaw";
        PNGname = strcat(res, thinSection, '_', mineral, task, comment, '.png')
        EPSname = strcat(res, thinSection, '_', mineral, task, comment, '.eps')
        saveas(gca, PNGname, 'png');
        saveas(gca, EPSname, 'epsc');
        
        %meanSF = meanPond(g_diametersf_bin_centres, g_counts_percent_wt_area2);
        
        meanSF = mean(grains.shapeFactor)
    
        [egdsf] = fopen(strcat(res, 'EGDSF.txt'), 'a+')
        fprintf([egdsf], strcat(thinSection, ';', mineral, ';', string(meanEGD), ';', string(meanSF), ';', string(meanGROD),'\n'))
end