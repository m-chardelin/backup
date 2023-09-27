import numpy as np
import pandas as pd
import os

class Creep():
    def __init__(self, **kwargs):
        
        self.__dict__.update(kwargs)
        
                    
#####################################################################################################
                    
    def Hirth2003(self, kwargs['Min']):
        '''
        Creep law associated to the review of G. Hirth and D. Kohlstedt, 2003. 
        
        Arguments : 
            s      stress                    [MPa]
            var    variable value (d)        [μm]
            T      temperature               [Kelvin]
                   
        Output : 
            S      strain rate               [s-1]
        '''

        self.S = self.A * self.s**self.n * (1/self.d)**self.p  * self.fH2O**self.r * np.exp(self.alpha*self.phi) * np.exp( -self.Q /(self.R * self.T))
        self.Formula = "\dot{\epsilon} = A.\sigma ^{n}.\left ( \frac{1}{d} \right )^{p}.f_{H_20}.\exp \left ( \alpha *\varphi \right ).\exp\left ( -\frac{Q}{R*T} \right )"
        
        return self.S
    
    
    def Gouriet2018(self): 
        '''
        Creep law associated to disocation creep. 
        
        Arguments : 
            s      stress                    [MPa]
            var    variable value (d)        [μm]
            T      temperature               [Kelvin]
                   
        Output : 
            S      strain rate               [s-1]
        '''       
        
        self.S =  self.A * ( self.s*1e6/self.mu )**self.n * np.exp((-self.Q/(self.R*self.T)) * ( 1 - ( self.s*1e6/self.s_P )**self.p )**self.q)   
        self.Formula = ""
            
                
                
                
                
                
                
        
