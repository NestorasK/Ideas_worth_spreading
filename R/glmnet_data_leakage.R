rm(list = ls())
library(glmnet)
library(httpgd)
hgd()
hgd_browse()
mydata_all <- matrix(
    data = rnorm(n = 2000 * 20000),
    nrow = 2000, ncol = 20000
)
rownames(mydata_all) <- paste0("s", 1:nrow(mydata_all))
colnames(mydata_all) <- paste0("g", 1:ncol(mydata_all))
classes <- rep(c(0, 1), times = nrow(mydata_all) / 2)


test_data_external <- mydata_all[1501:2000, ]
test_y_external <- classes[1501:2000]


mydata_x <- mydata_all[1:1500, ]
mydata_y <- classes[1:1500]

# feature_selection
pvalues <- sapply(
    1:ncol(mydata_x), function(i) {
        t.test(
            x = mydata_x[mydata_y == 0, i],
            y = mydata_x[mydata_y == 1, i]
        )$p.value
    }
)
mydata_x <- mydata_x[, pvalues < 0.05]

# Split train - test
train_data <- mydata_x[1:1000, ]
train_y <- mydata_y[1:1000]
test_data <- mydata_x[1001:1500, ]
test_y <- mydata_y[1001:1500]


fit_glmnet <- cv.glmnet(
    x = train_data, y = train_y, family = "binomial",
    type.measure = "class"
)
plot(fit_glmnet)

# test
preds <- predict(
    object = fit_glmnet,
    newx = test_data, s = "lambda.min",
    type = "class"
)
mean(preds == test_y)

# test external
preds_external <- predict(
    object = fit_glmnet,
    newx = test_data_external[, pvalues < 0.05],
    s = "lambda.min",
    type = "class"
)
mean(preds_external == test_y_external)
