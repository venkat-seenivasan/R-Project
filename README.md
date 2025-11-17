
# 🧬 Thyroid Cancer Prediction using Regression & Random Forest

A machine learning project built in R for predicting the risk of thyroid cancer using health indicators such as hormone levels, nodule size, and lifestyle factors.  
This project uses **Linear Regression** and **Random Forest** models and includes data preprocessing, feature selection, train-test split, model evaluation, and visualization.

---

## 📂 Project Structure
```
📁 Thyroid-Cancer-Prediction
│── thyroid_cancer_risk_data.csv
│── prediction.R
│── README.md
```

---

## 📌 Features of This Project
✔ Data preprocessing (Yes/No → 1/0 conversion)  
✔ Feature selection  
✔ Train-test split (70–30)  
✔ Linear Regression model  
✔ Random Forest model  
✔ Accuracy comparison  
✔ Confusion Matrices  
✔ Visualization of Safe vs Patient Health Indicators  

---

## 📊 Dataset Description

| Feature | Description |
|--------|-------------|
| Age | Patient age |
| TSH_Level | Thyroid Stimulating Hormone level |
| T3_Level | Triiodothyronine level |
| T4_Level | Thyroxine level |
| Nodule_Size | Thyroid nodule size |
| Smoking | Yes/No |
| Family_History | Yes/No |
| Radiation_Exposure | Yes/No |
| Iodine_Deficiency | Yes/No |
| Obesity | Yes/No |
| Diabetes | Yes/No |
| Diagnosis | Malignant / Benign |

---

## 🛠️ Technologies Used
- **R Programming**
- tidyverse  
- caret  
- randomForest  
- ggplot2  

---

## 🚀 How to Run the Project

### 1️⃣ Install Required Packages
```r
packages <- c("tidyverse", "randomForest", "caret", "ggplot2")
installed <- packages %in% installed.packages()
if(any(!installed)) {
  install.packages(packages[!installed], repos = "https://cloud.r-project.org", dependencies = TRUE)
}
```

### 2️⃣ Load the Dataset
```r
setwd("C:/Users/HP/Desktop/Mini")
data <- read.csv("thyroid_cancer_risk_data.csv")
```

### 3️⃣ Run the Script
```r
source("prediction.R")
```

---

## 📈 Model Performance (Output Example)
```
===== Final Results =====
Regression Accuracy : 83.45 %
Random Forest Accuracy : 91.87 %

=== Regression Confusion Matrix ===
TP | FP
FN | TN

=== Random Forest Confusion Matrix ===
TP | FP
FN | TN
```

---

## 📉 Visualization
The code generates a bar graph comparing:

- **Safe Value**
- **Patient Value**

For each health indicator (Age, TSH, T3, T4, etc.).  
Useful for understanding deviation from medically safe ranges.

---

## 🧠 Conclusion
Random Forest outperforms Linear Regression in predicting thyroid cancer risk.  
This project demonstrates:

- Effective preprocessing  
- Feature engineering  
- Model comparison  
- Health indicator analysis  

