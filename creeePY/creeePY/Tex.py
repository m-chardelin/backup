import os
import sys
import pandas as pd
import numpy as np
import PIL
from PIL import Image
from PyPDF2 import PdfMerger
    
class Tex():
    def __init__(self, files, **kwargs):
                        
        self.__dict__.update(kwargs)

        self.area = pd.read_csv(f'{files.stats}/resume.txt', sep = ',')

        #### Functions
    
    def Load(self, table, sort = False):
        self.df = pd.read_csv(table, sep = ',')
        
        if sort == True:
            self.subcat = set(self.df[self.sort])


    def SetParam(self, **kwargs):
        self.__dict__.update(kwargs)

    
    def GetTxt(self, files, file):
        with open(f'{files.input}/{file}.tex', 'r') as file:
            self.txt = file.read()
        return self.txt

    
    def Save(self, files, file):
        with open(f'{files.tex}/{file}.tex', 'w') as file:
            file.write(self.text)
            
    
    def Iteration(self, files, func, iterMineral = False):
        for c in files.cat:
            if iterMineral == False:
                func(files, c)

            if iterMineral == True:
                for ssc in files.sscat:
                    if os.path.exists(f'{files.input}/{c}_{ssc}_{self.task}.txt'):
                        func(files, c, ssc)

    def Area(self, files):
        text = self.GetTxt(files, 'areaType')
        txt = ''
        for c in files.cat:
            add = self.GetTxt(files, 'areaAdd')
        
            img = PIL.Image.open(f'{files.texFigures}/{c}_Area.eps')
            width, height = img.size
            
            if width / height > 1:
                PARAM = 'width = \\linewidth'
            elif width / height < 1:
                PARAM = 'width = \\linewidth, angle = 90'
            elif width / height == 1:
                PARAM = 'height = 0.45\\paperheight'
                    
            text = text.replace('textAdd', self.textAdd)
            add = add.replace('CAT', c)
            add = add.replace('PARAM', PARAM)
            
            txt = txt + add
            
        text = text.replace('includeFIELD', txt)
        self.text = text.replace('FIGURESDIR', files.texFigures)

        self.Save(files, 'area')
            
        os.system(f'cd {files.tex}')
        os.chdir(f'{files.tex}')
        os.system('pwd')
        os.system(f'latex area.tex')
        os.system(f'dvipdf area.dvi')
        
        #text = self.GetTxt(files, 'plotType')
        #text = text.replace('textAdd', self.textAdd)
        #self.text = text
        #self.Save(files, 'plot')
        #os.system(f'latex plot.tex')
        
        #text = self.GetTxt(files, 'title')
        #text = text.replace('textAdd', self.textAdd)
        #self.text = text
        #self.Save(files, 'title')
        #os.system(f'pdflatex title.tex')

        

    def Merge(self, files):

        pdfs = [f'{c}.pdf' for c in files.cat]
        
        merger = PdfMerger()

        for pdf in pdfs:
            merger.append(pdf)
        merger.write("lames.pdf")
        merger.close()
        
        merger = PdfMerger()
        for c in files.cat:
            #os.system(f'cd {files.output}')
            #os.system(f'cd /Users/marialinechardelin/Zabargad/figures')
            #os.system(f'pdflatex {files.output}/{c}.tex')
            #os.system(f'dvipdf {files.output}/{file}.dvi')
            merger.append(f'{c}.pdf')
        self.merger.write("areaZabargad.pdf")
        merger.close()


    def ThinSection(self, files):
        
        
        for c in files.cat:
            text = self.GetTxt(files, 'lameType')
            img = PIL.Image.open(f'{files.texFigures}/{c}__PHASES.eps')
            width, height = img.size
            
            if width / height > 1:
                PARAM = 'width = \\linewidth'
            elif width / height < 1:
                PARAM = 'width = \\linewidth, angle = 90'
            elif width / height == 1:
                PARAM = 'height = 0.45\\paperheight'
            
            text = text.replace('CAT', c)
            text = text.replace('PARAM', PARAM)
            text = text.replace('FIGURESDIR', files.texFigures)
            
            self.ts = self.area[self.area['cat'] == c]
            self.ts = self.ts[self.ts['subcat'] == 'all']
            self.ts = self.ts.sort_values(by = ['%Area_total'])
            self.ts.index = np.arange(0, len(self.ts['sscat']), 1)
            for i in self.ts.index:
                text = text.replace(f'mineral{i}', self.ts.loc[i, 'sscat'])
  

            self.text = text
            self.Save(files, 'ts')
            
            os.system(f'cd {files.tex}')
            os.chdir(f'{files.tex}')
            os.system('pwd')
            os.system(f'latex -jobname={c} ts.tex')
            os.system(f'dvipdf {c}.dvi')

        #self.Merge(files)
        


    def CPO(self, files, cat):
        self.Load(f'{files.meanTables}/areas_um2.txt')
        subcat = self.df[self.df['cat'] == cat]
        txt = ''
        for ssc in subcat.sscat:
            txt = txt + f'\n \includegraphics[width = 0.75\linewidth]{{{cat}_{ssc}_CPO.eps}} \n \includegraphics[width = 0.25\linewidth]{{{cat}_{ssc}_{ssc}_ipf.eps}} \n \n'
        self.txt = self.txt.replace('includeCPO', txt)

   
    def HIST(self, files, cat):
        self.Load(f'{files.meanTables}/areas_um2.txt')
        subcat = self.df[self.df['cat'] == cat]
        txt = ''
        for ssc in subcat.sscat:
            txt = txt + f'\n \includegraphics[width = 0.5\linewidth]{{{cat}_{ssc}_subcat_histequivalentRadius_weightarea.eps}} \n \includegraphics[width = 0.5\linewidth]{{{cat}_{ssc}_subcat_histshapeFactor_weightarea.eps}} \n \n'
        self.txt = self.txt.replace('includeHIST', txt)
