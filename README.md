**Aircraft Damage Prediction (2020–2023): Classification Modeling in R**

_Objective:_

To predict the level of aircraft damage using features such as:

Whether the aircraft was amateur built

The weather condition during the incident

The number of engines

_1. Data Preparation:_
Data imported from: AviationData-2020-2023.csv

Selected relevant columns: AmateurBuilt, WeatherCondition, NumberOfEngines, AirCraftDamage

Removed rows with missing values using na.omit()

Converted categorical variables to factor type for modeling

Initial Summary:

Exploratory analysis using summary() and barplot() revealed class imbalance in AirCraftDamage..

_2. Logistic Regression Model:_

Used glm() with a binomial family to model aircraft damage as a function of the three predictors.

_3. Decision Tree Modeling:_

Split the dataset 80/20 for training/testing.

Trained a decision tree using the tree package

Saved the tree visualization to a JPEG file: flightTree.jpg

Evaluated complexity using 10-fold cross-validation (cv.tree())

_4. Random Forest Classification:_

Applied a Random Forest model to the training data

Evaluated performance using a confusion matrix

Visualized feature importance

