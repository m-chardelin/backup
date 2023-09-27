function [BA, BC, AC] = indexMineral(grains, phasePFs)
                

                Nb = grains.length;
                %
              
                mineralOPPG = grains.meanOrientation;
                %
                % vectors of [100] directions in specimen co-ordinates
                v_100_mineralOPPG = mineralOPPG * phasePFs{1};
                % orientation tensor ansd eigenvalue analysis
                [OT,value,vec1,vec2,vec3] = Func_Orientation_Tensor(v_100_mineralOPPG);
                % [100] Eigen-values
                EV1_100_mineralOPPG = value(1);
                EV2_100_mineralOPPG= value(2);
                EV3_100_mineralOPPG= value(3);
                % convert to eigen-vector to MTEX vector3d
                E1_100_mineralOPPG= vector3d(vec1(1),vec1(2),vec1(3));
                E2_100_mineralOPPG= vector3d(vec2(1),vec2(2),vec2(3));
                E3_100_mineralOPPG= vector3d(vec3(1),vec3(2),vec3(3));
                % Vollmer, F.W., 1990. Eigen-Analysis
                NORM=value(1)+value(2)+value(3);
                % Point maximum
                P100_mineralOPPG=(value(1)-value(2))/NORM;
                % Girdle
                G100_mineralOPPG=(2.0*(value(2)-value(3)))/NORM;
                % Random
                R100_mineralOPPG=(3.0*value(3))/NORM;
                
                %%
                
                % vectors of [010] poles in specimen co-ordinates
                v_010_mineralOPPG= mineralOPPG * phasePFs{2};
                % orientation tensor and eigen-analysis
                [OT,value,vec1,vec2,vec3] = Func_Orientation_Tensor(v_010_mineralOPPG);
                % (010) Eigen-values
                EV1_010_mineralOPPG= value(1);
                EV2_010_mineralOPPG= value(2);
                EV3_010_mineralOPPG= value(3);
                % convert to eigen-vector to MTEX vector3d
                E1_010_mineralOPPG= vector3d(vec1(1),vec1(2),vec1(3));
                E2_010_mineralOPPG= vector3d(vec2(1),vec2(2),vec2(3));
                E3_010_mineralOPPG= vector3d(vec3(1),vec3(2),vec3(3));
                % Vollmer, F.W., 1990. Eigen-Analysis
                NORM=value(1)+value(2)+value(3);
                % Point maximum
                P010_mineralOPPG=(value(1)-value(2))/NORM;
                % Girdle
                G010_mineralOPPG=(2.0*(value(2)-value(3)))/NORM;
                % Random
                R010_mineralOPPG=(3.0*value(3))/NORM;
                %
                % vectors of [001] directions in specimen co-ordinates
                v_001_mineralOPPG= mineralOPPG * phasePFs{3};
                % orientation tensor and eigenvalue analysis
                [OT,value,vec1,vec2,vec3] = Func_Orientation_Tensor(v_001_mineralOPPG);
                % [001] Eigen-values
                EV1_001_mineralOPPG= value(1);
                EV2_001_mineralOPPG= value(2);
                EV3_001_mineralOPPG= value(3);
                % convert to eigen-vector to MTEX vector3d
                E1_001_mineralOPPG= vector3d(vec1(1),vec1(2),vec1(3));
                E2_001_mineralOPPG= vector3d(vec2(1),vec2(2),vec2(3));
                E3_001_mineralOPPG= vector3d(vec3(1),vec3(2),vec3(3));
                % Vollmer, F.W., 1990. Eigen-Analysis
                NORM=value(1)+value(2)+value(3);
                % Point maximum
                P001_mineralOPPG=(value(1)-value(2))/NORM;
                % Girdle
                G001_mineralOPPG=(2.0*(value(2)-value(3)))/NORM;
                % Random
                R001_mineralOPPG=(3.0*value(3))/NORM;
                
                % BA_index 0=axial 010 1=axial 100 
                BA = 0.5*(2.0-(P010_mineralOPPG/(G010_mineralOPPG+P010_mineralOPPG))-(G100_mineralOPPG/(G100_mineralOPPG+P100_mineralOPPG)));
                % BC_index 0=axial 010 1=axial 001 
                BC = 0.5*(2.0-(P010_mineralOPPG/(G010_mineralOPPG+P010_mineralOPPG))-(G001_mineralOPPG/(G001_mineralOPPG+P001_mineralOPPG)));
                % AC_index 0=axial 100 1=axial 001 
                AC = 0.5*(2.0-(P100_mineralOPPG/(G100_mineralOPPG+P100_mineralOPPG))-(G001_mineralOPPG/(G001_mineralOPPG+P001_mineralOPPG)));


end