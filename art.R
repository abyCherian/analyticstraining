library(magick)
library(ggplot2)
library(dplyr)

imge = image_read('image1.jpeg') %>% 
  image_convert(colorspace = 'gray')

#  Get dimnensions

imge_w = image_info(imge)$width
imge_h = image_info(imge)$height

#  Resize the longest dimension to 80 pixels

if(imge_w > = img_h){
  img = image_resize(imge,geometry = '80')
}else{
  img = image_resize(imge,("X80"))
}

# Create array and number rows and columns

img_array <- drop(as.integer(img[[1]]))
rownames(img_array) <- 1:nrow(img_array)
colnames(img_array) <- 1:ncol(img_array)

# Create data frame from array and rename columns
img_df <- as.data.frame.table(img_array) %>% 
  `colnames<-`(c("y", "x", "b")) %>% 
  mutate(
    across(everything(), as.numeric),
    # convert b (0-255) to bf (1-0), so that "brighter" values become smaller bars
    bf = 1 - b / 255
  )

# Colors, fill and background

col_fill <- "black"
col_bg <- "#F1E34C"

image = ggplot(img_df) +
  geom_rect(aes(xmin = x, xmax = x + bf * 0.9, ymin = y, ymax = y + 0.85), fill = col_fill, color = NA) +
  scale_y_reverse() +
  coord_fixed(expand = FALSE) +
  theme_void() +
  theme(legend.position = "none", plot.background = element_rect(fill = col_bg, color = NA))


ggsave('image.png')
