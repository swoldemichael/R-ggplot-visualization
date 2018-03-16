library(tidyverse)
tidyverse::tidyverse_update()

# quick exploration
help(ggplot2::mpg)
glimpse(ggplot2::mpg)
head(ggplot2::mpg)
any(is.na(mpg))
summary(mpg)
data(mpg)

# ggplots


################################################## 1) data and 2) aesthetics mapping ######

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))


ggplot(data = mpg, aes(x = cyl, y = hwy)) +
  geom_point()

###################################### testing hypothesis about hybrid cars ###############

mpg$class <- as.factor(mpg$class)
levels(mpg$class)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, col = class))

### mapping data variable to visual attributes ##########

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), alpha = 0.2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, col = cyl), alpha = 0.5)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, col = cyl))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = cyl), col = "blue")

ggplot(data = mpg) +
  geom_point(mapping = aes(
    x = displ,
    y = hwy,
    shape = class,
    col = cyl
  ))


ggplot(data = mpg) +
  geom_point(mapping = aes(
    x = displ,
    y = hwy,
    shape = class,
    col = class,
    size = cyl
  ))

? geom_point

#################### stroke  ########################################################
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy),
             stroke = 2,
             alpha = 0.2)


####################### using logical expressions in aes visual attributes###########
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, col = displ < 5))

ggplot(data = mpg) +
  geom_point(mapping = aes(
    x = displ,
    y = hwy,
    col = class %in% c("subcompact", "compact")
  ))

############################## 3) Facets ##############################################
# split plots into facets - subplots that each display one subset of the data
# facet_wrap

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap( ~ manufacturer)

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~ class)

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~ class, nrow = 3, ncol = 3)

# Looks better
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~ cyl)

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~ drv)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap( ~ cyl, nrow = 2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap( ~ cyl, ncol = 2)

# facet_grid

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

# facet by rows
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ drv)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

################################################### 4 geoms ########################
# geom_smooth - a smooth line fitted to the data
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv)) # group

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, col = drv)) # col

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, col = drv),
              show.legend = FALSE) # legend

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, col = drv),
    se = FALSE,
    show.legend = FALSE
  ) # standard error

############################## mapping multiple geoms ##########################
# aesthetic mappings in ggplot are global to all geoms
# each individual geom can also have aesthetic mappings - this are local mappings
# local mappings extend or overite the global mappings for the layer

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(aes(group = drv), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(aes(group = drv), se = FALSE)

########################## filter data in geom_smoot() ########################
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(col = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

##### Excercise ############################################################$$

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(stroke = 2) +
  geom_smooth(se = FALSE, color = "skyblue", lwd = 2)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(stroke = 2) +
  geom_smooth(
    mapping = aes(group = drv),
    se = FALSE,
    color = "skyblue",
    lwd = 2
  )

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, col = drv)) +
  geom_point(stroke = 2) +
  geom_smooth(se = FALSE, lwd = 2)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv), stroke = 3) +
  geom_smooth(se = FALSE, color = "skyblue", lwd = 2)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv), stroke = 3) +
  geom_smooth(
    mapping = aes(linetype = drv),
    se = FALSE,
    color = "skyblue",
    lwd = 2
  )

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv), stroke = 3)

###################################### 5 Statistical Transformations ######################

# The algorithm to calculate new values for a graph is called a stat, short for statistical
# transformation

help(diamonds)
glimpse(diamonds)
head(diamonds, 2)
any(is.na(diamonds))
dim(diamonds)
summary(diamonds)

### every geom has a default stat

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

### or

### every stat has a default geom

ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))


ggplot(data = diamonds) +
  geom_freqpoly(mapping = aes(x = carat))

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat))

ggplot(data = diamonds) +
  geom_density((mapping = aes(x = carat)))

### From help

ggplot(diamonds, aes(carat)) +
  geom_histogram()

ggplot(diamonds, aes(carat)) +
  geom_histogram(binwidth = 0.01)


ggplot(diamonds, aes(carat)) +
  geom_histogram(bins = 200)


###### multiple stats combined
### 

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat, y = ..density..), bins = 200) +
  geom_density(mapping = aes(x = carat), col = "red", linetype = 3)

#### 3) stat_summary
### draw great attention to the statistical transformation.
### stat_summarr(), summarizes the y values for each x value, to draw
# attention to the summary I am computing

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

ggplot(data = diamonds) +
  geom_boxplot(mapping = aes(x = cut, y = depth))


################################### Position adjustments###############################

ggplot(data = diamonds) +
  geom_bar(mapping =  aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), stroke = 2, position = "jitter")

ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = displ, y = hwy), stroke = 2)

ggplot(data = mtcars, mapping = aes(x = cyl, y = wt)) +
  geom_point()
    
ggplot(data = mtcars, mapping = aes(x = cyl, y = wt)) +
  geom_jitter()

mtcars$cyl <- as.factor(mtcars$cyl)

posn.j <- position_jitter(width = 0.1)

ggplot(data = mtcars, mapping = aes(x = cyl, y = wt)) +
  geom_point(position = posn.j)

ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_point(position = posn.j)

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter()


posn.j <- position_jitter(width = 0.5)

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point(position = posn.j)


# line bars
economics <- economics %>%
  mutate(unemploy_rate = unemploy/pop)

ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y = unemploy_rate))

################################ Coordinate Systems #############################
#
#
# The most complicated part of ggplot2

# coord_flip()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

# coord_quickmap()
# sets aspect ratios correctly for maps

usa <- map_data("usa")

ggplot(usa, mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

ggplot(usa, mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()


# coord_polar()
# uses polar coordinates
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()