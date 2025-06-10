import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.impute import SimpleImputer
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

# print(r'C:\pasta\pasta2\arquivo.txt')

dataset = pd.read_csv(r'04_dados_paises.csv')#r: raw

features = dataset.iloc[:, :-1].values
classe = dataset.iloc[:, -1].values
imputer = SimpleImputer(
  missing_values=np.nan,
  strategy="mean"
)

imputer.fit(features[:, 1:3])
features[:, 1:3] = imputer.transform(features[:, 1:3])

columnTransformer = ColumnTransformer(
  transformers=[('encoder', OneHotEncoder(), [0])],
  remainder="passthrough"
)
features = np.array(columnTransformer.fit_transform(features))
print(features)

labelEncoder = LabelEncoder()
classe = labelEncoder.fit_transform(classe)
print(classe)

features_treinamento, features_teste, classe_treinamento, classe_teste = train_test_split(features, classe, test_size=0.2, random_state=1)

standardScaler = StandardScaler()

features_treinamento[:, 3:] = standardScaler.fit_transform(features_treinamento[:, 3:])

features_teste[:, 3:] = standardScaler.transform(features_teste[:, 3:])







