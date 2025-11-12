# ================================================================
# Thyroid Cancer Prediction (Regression + Random Forest)
# ================================================================

# 1️⃣ Install required packages (only first time)
packages <- c("tidyverse", "randomForest", "caret", "ggplot2")
installed <- packages %in% installed.packages()
if(any(!installed)) {
  install.packages(packages[!installed], repos = "https://cloud.r-project.org", dependencies = TRUE)
}

# 2️⃣ Load libraries
library(tidyverse)
library(randomForest)
library(caret)
library(ggplot2)

# 3️⃣ Load dataset
# ⚠️ Make sure the file 'thyroid_cancer_risk_data.csv' is in your working directory
setwd("C:/Users/HP/Desktop/Mini")
data <- read.csv("thyroid_cancer_risk_data.csv")

# 4️⃣ Data Preprocessing
# Convert Diagnosis to numeric
data$Diagnosis <- ifelse(data$Diagnosis == "Malignant", 1, 0)

# Convert Yes/No categorical columns to 1/0
binary_cols <- c("Family_History","Radiation_Exposure","Iodine_Deficiency",
                 "Smoking","Obesity","Diabetes")
for (col in binary_cols) {
  data[[col]] <- ifelse(data[[col]] == "Yes", 1, 0)
}

# 5️⃣ Feature Selection
features <- c("Age","TSH_Level","T3_Level","T4_Level","Nodule_Size","Smoking","Family_History")

# 6️⃣ Split Dataset (70% Train / 30% Test)
set.seed(42)
train_index <- createDataPartition(data$Diagnosis, p = 0.7, list = FALSE)
train_data <- data[train_index, ]
test_data  <- data[-train_index, ]

# ================================================================
# 7️⃣ Linear Regression
# ================================================================
reg_model <- lm(Diagnosis ~ ., data = train_data[, c(features, "Diagnosis")])
reg_pred  <- predict(reg_model, newdata = test_data)
reg_pred_class <- ifelse(reg_pred > 0.5, 1, 0)
reg_accuracy <- mean(reg_pred_class == test_data$Diagnosis) * 100

reg_conf <- confusionMatrix(as.factor(reg_pred_class),
                            as.factor(test_data$Diagnosis),
                            positive = "1")

# ================================================================
# 8️⃣ Random Forest
# ================================================================
rf_model <- randomForest(as.factor(Diagnosis) ~ ., 
                         data = train_data[, c(features, "Diagnosis")],
                         ntree = 100)

rf_pred <- predict(rf_model, newdata = test_data)
rf_accuracy <- mean(rf_pred == test_data$Diagnosis) * 100

rf_conf <- confusionMatrix(rf_pred,
                           as.factor(test_data$Diagnosis),
                           positive = "1")

# ================================================================
# 9️⃣ Display Results
# ================================================================
cat("===== Final Results =====\n")
cat("Regression Accuracy :", round(reg_accuracy,2), "%\n")
cat("Random Forest Accuracy :", round(rf_accuracy,2), "%\n\n")

cat("=== Regression Confusion Matrix ===\n")
print(reg_conf$table)

cat("\n=== Random Forest Confusion Matrix ===\n")
print(rf_conf$table)
# ================================================================
# 🔟 Visualization — Safe vs Patient Health Indicators
# ================================================================
safe_values <- data.frame(
  Category = features,
  Safe_Value = c(50, 4.0, 2.0, 6.0, 1.5, 0, 0)
)

patient <- test_data[1, features]
patient_values <- as.numeric(patient)

plot_data <- data.frame(
  Category = features,
  Safe_Value = safe_values$Safe_Value,
  Patient_Value = patient_values
) %>%
  pivot_longer(cols = c(Safe_Value, Patient_Value),
               names_to = "Type",
               values_to = "Value")

# ✅ Add print() so it shows when using source()
print(
  ggplot(plot_data, aes(x = Category, y = Value, fill = Type)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = "Safe vs Patient Health Indicators",
         y = "Values", x = "Indicators") +
    theme_minimal() +
    scale_fill_manual(values = c("green", "red"))
)
