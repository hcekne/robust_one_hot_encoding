import pandas as pd
from sklearn.preprocessing import OneHotEncoder

# Creating the training_data DataFrame in Python
training_data = pd.DataFrame({
    'numerical_1': [1, 2, 3, 4, 5, 6, 7, 8],
    'color_1_': ['black', 'black', 'red', 'green', 'green', 'black', 'red', 'blue'],
    'color_2_': ['black', 'blue', 'pink', 'purple', 'black', 'blue', 'pink', 'purple']
})

# Creating the inference_data DataFrame in Python
inference_data = pd.DataFrame({
    'numerical_1': [11, 12, 13, 14, 15, 16, 17, 18],
    'color_1_': ['black', 'blue', 'black', 'green', 'green', 'black', 'black', 'blue'],
    'color_2_': ['orange', 'orange', 'black', 'orange', 'black', 'orange', 'orange', 'orange']
})

# Converting categorical columns in training_data to dummy variables with integers
training_data_dummies = pd.get_dummies(training_data, columns=['color_1_', 'color_2_']).astype(int)

# Converting categorical columns in inference_data to dummy variables with integers
inference_data_dummies = pd.get_dummies(inference_data, columns=['color_1_', 'color_2_']).astype(int)

# Assuming training_data is defined as mentioned earlier
trans_columns = ['color_1_', 'color_2_']

# Initialize the encoder
enc = OneHotEncoder(handle_unknown='ignore')

# Fit and transform the data
enc_data = enc.fit_transform(training_data[trans_columns])

# Get feature names
feature_names = enc.get_feature_names_out(trans_columns)

# Convert to DataFrame
enc_df = pd.DataFrame(enc_data.toarray(), 
                          columns=feature_names)

# Concatenate with the numerical data
final_df = pd.concat([training_data[['numerical_1']], 
                      enc_df], axis=1)

# Transform inference data
inference_encoded = enc.transform(inference_data[trans_columns])
inference_feature_names = enc.get_feature_names_out(trans_columns)
inference_encoded_df = pd.DataFrame(inference_encoded.toarray(), 
                                    columns=inference_feature_names)
final_inference_df = pd.concat([inference_data[['numerical_1']], 
                                inference_encoded_df], axis=1)