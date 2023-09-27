# -*- coding: utf-8 -*-

import os
import numpy as np
import pandas as pd
import copy
from itertools import product, combinations, chain


class Param():
    def __init__(self, config, files):
        
        for param in listParam:
            if config.param[0] == 'pm':
                A = np.arange(config.param[1] - config.param[2], config.param[1] + config.param[2] + config.param[2], config.param[2])
            if config.param[0] == 'range':
                A = np.arange(config.param[1], config.param[2], config.param[3])
            if config.param[0] == 'value':
                A = config.param[1]
            setattr(self, param, A)
        
        
        # Param for elastic behaviour
        
        self.Young = [2e11]
        self.Poisson = [0.25]
        self.rho0 = [3.0e3]
        self.R = 8.3145
        self.e = 2.718281828459045
        ################################################################################################################################################

        self.table = list(product(self.A, self.Q, self.mu, self.n, self.p, self.q, self.s_dev, self.s_peierls_fix, self.T_cut, self.Young, self.Poisson, self.rho0, self.T_fix))
        self.iter = pd.DataFrame(self.table, columns = ['A', 'Q', 'mu', 'n', 'p', 'q', 's_dev', 's_Peierls_fix', 'T_cut', 'Young', 'Poisson', 'Rho0', 'T_fix'])
        self.iter = self.iter.drop_duplicates()
        self.iter.index = range(0, self.iter.shape[0])
        self.iter.to_csv(f'{files.config}/iterations.csv', sep = ";")
