# Code for models and diagrams to create size groups and estimates
# 2021-10-25
# Maria Shinoto
# Comments translated into English on 2024-12-09

# Data ----

vessel_size_data <- selectFile(caption = "Select file containing vessel data.",
                                          path = getActiveProject(), label = "Select File")
vessel_size_data <- read.csv2(vessel_size_data)

vecradius <- vessel_size_data$radius
vecvolume <- vessel_size_data$vessel_volumes

# Models ----

# Simple model based on vectors

vesmodel1 <- lm(vecvolume ~ vecradius)
summary(vesmodel1)

# Simple model based on dataframe

vesmodel2 <- lm(vessel_volumes ~ radius, data = vessel_size_data)
summary(vesmodel2)


# Polynomial model based on vectors

vesmodel3 <- lm(vecvolume ~ poly(vecradius, degree = 2, raw = TRUE))
summary(vesmodel3)


# Polynomial model based on dataframe

vesmodel4 <- lm(vessel_volumes ~ poly(radius, degree = 2, raw = TRUE),
                data = vessel_size_data)
summary(vesmodel4)

# Log distribution of volumes

vesmodel5 <- lm(log(vessel_volumes) ~ radius,
                data = vessel_size_data)
summary(vesmodel5)

# Plots ----

# Scatterplot with log distribution

p <- ggplot(data = vessel_size_data, aes(x = radius, y = log(vessel_volumes), label = vessel_ids)) +
  geom_point() + geom_rug() +
  theme_bw()
p

# Plot model square root

vesmodel6 <- lm(sqrt(vessel_volumes) ~ radius,
                data = vessel_size_data)
summary(vesmodel6)
p <- ggplot(data = vessel_size_data,
            aes(x = radius, y = vessel_volumes, label = vessel_ids)) +
  geom_point() + geom_rug() +
  geom_smooth(method = "lm",
              formula = y ~ poly(x, 2, raw=TRUE),
              se = TRUE) +
  theme_bw()
p

# Confidence interval, prediction interval

gf_lm(hwy ~ displ,
      data = mpg,
      formula = log(y) ~ poly(x, 3), backtrans = exp,
      interval = "prediction", fill = "skyblue"
)

pgf <- gf_lm(vessel_volumes ~ radius,
      data = vessel_size_data,
      formula = y ~ poly(x, 2, raw=TRUE),
      color = "black",
      interval = "prediction", fill = "grey") %>%
  gf_lm(vessel_volumes ~ radius,
        data = vessel_size_data,
        formula = y ~ poly(x, 2, raw=TRUE),
        color = "black",
        interval = "confidence", fill = "grey") %>%
  gf_rug() %>%
  gf_point(vessel_volumes ~ radius) %>%
  gf_theme(theme_bw())
pgf
