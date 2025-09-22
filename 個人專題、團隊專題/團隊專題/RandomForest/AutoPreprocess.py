import pandas as pd
import numpy as np
import pickle
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.preprocessing import MinMaxScaler
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import RobustScaler

class AutoPreprocess(BaseEstimator, TransformerMixin):
    def __init__(self):         
        self.scaler = {}
        self.fillna_value = {}
        self.onehotencode_value = {}
        self.field_names = []
        self.final_field_names = []
        
    def fit(self, X, y = None, field_names=None):
        self.__init__()
        if field_names is None:
            self.field_names = X.columns.tolist()
        else:
            self.field_names = field_names       
        
        for fname in self.field_names:
            #自動補空值
            if (X[fname].dtype == object) or (X[fname].dtype == str): #字串型態欄位
                self.fillna_value[fname] = X[fname].mode()[0] #補眾數
                # self.fillna_value[fname] = 'np.nan'
                # self.fillna_value[fname] = np.nan # 維持空值
            elif X[fname].dtype == bool: #布林型態
                self.fillna_value[fname] = X[fname].mode()[0] #補眾數
            else: # 數字型態
                self.fillna_value[fname] = X[fname].median()  #補中位數
            
            #自動尺度轉換(scaling)
            if (X[fname].dtype == object) or (X[fname].dtype == str): #字串型態欄位
                pass #不用轉換
            elif X[fname].dtype == bool: #布林型態
                pass #不用轉換
            else: # 數字型態
                vc = X[fname].value_counts()
                if X[fname].isin([0, 1]).all(): #當數值只有0跟1
                    pass #不用轉換
                elif pd.api.types.is_integer_dtype(X[fname]) and X[fname].nunique() <= 10: #是否簡單的整數型類別且數量小於10
                    self.scaler[fname] = MinMaxScaler()    
                    self.scaler[fname].fit(X[[fname]])
                else: #其他的數字型態
                    self.scaler[fname] = RobustScaler()    
                    self.scaler[fname].fit(X[[fname]])

            
            #自動編碼
            if (X[fname].dtype == object) or (X[fname].dtype == str): #字串型態欄位, onehotencode
                field_value = X[fname].value_counts().index
                self.onehotencode_value[fname] = field_value
                for value in field_value:
                    fn = fname+"_"+value
                    # data[fn] = (data[fname] == value).astype('int8')
                    self.final_field_names.append(fn)                    
            elif X[fname].dtype == bool: #布林型態 轉成0跟1
                # data[fname] = data[fname].astype(int)
                self.final_field_names.append(fname)
            else: # 數字型態 不用重新編碼
                self.final_field_names.append(fname)
                
        return self

    def transform(self, X):
        #如果輸入的data是dict，要先轉成dataframe
        if isinstance(X, dict):
            for fname in self.field_names:
                if fname in X:
                    X[fname] = [X[fname]]
                else:
                    X[fname] = [np.nan]
            data = pd.DataFrame(X)
        else: #將資料複製一份，不修改原本的資料
            data = X.copy()
        
        for fname in self.field_names:
            #自動補空值
            if data[fname].isnull().any(): #有空值
                # if fname in self.fillna_value:
                    data[fname] = data[fname].fillna(self.fillna_value[fname])


            #自動尺度轉換(scaling)
            if fname in self.scaler:
                data[fname] = self.scaler[fname].transform(data[[fname]])
            
            #自動編碼
            if (data[fname].dtype == object) or (data[fname].dtype == str): #字串型態欄位, onehotencode
                if fname in self.onehotencode_value:                   
                    field_value = self.onehotencode_value[fname]
                for value in field_value:
                    fn = fname+"_"+value
                    data[fn] = (data[fname] == value).astype('int8')
            elif data[fname].dtype == bool: #布林型態 轉成0跟1
                data[fname] = data[fname].astype(int)
            else: # 數字型態 不用重新編碼
                pass                
        return data[self.final_field_names]

    def save(self, file_name):
        with open(file_name, "wb") as f:
            pickle.dump(self, f)

    @staticmethod
    def load(file_name):
        with open(file_name, "rb") as f:
            return pickle.load(f)          
        

# import pandas as pd
# mydata = pd.read_csv('C:/DATA/class/2025-07 AI數據應用人才養成班三期/data/Automobile_Train.csv')
# ap = AutoPreprocess()
# # ap.fit(mydata, field_names=['symboling', 'Normalized-losses', 'make', 'Fuel-type', 'aspiration',
# #        'Num-of-doors', 'Body-style', 'Drive-wheels', 'Engine-location',
# #        'Wheel-base', 'length', 'width', 'height', 'Curb-weight', 'Engine-type',
# #        'Num-of-cylinders', 'Engine-size', 'Fuel-system', 'bore', 'stroke',
# #        'Compression-ratio', 'horsepower', 'Peak-rpm', 'City-mpg',
# #        'Highway-mpg'])
# ap.fit(mydata)

# # 轉換 panddas dataframe
# t = ap.transform(mydata)
# print(t.head())


