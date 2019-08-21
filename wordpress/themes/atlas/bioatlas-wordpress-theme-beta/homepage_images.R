library(magick)

# local directory for image folder subdir of the contents from
# git clone git@github.com:bioatlas/bioatlas-wordpress-theme.git
base <- "~/repos/bioatlas/bioatlas-wordpress-theme/img/"

bird <-
  "https://dina-web.net/naturalist/media/get-stream/1be36952-9bf1-4a34-91dd-429aa23b6e9f.jpeg" %>%
  image_read() %>%
  image_convert("jpg") %>%
  image_resize("338x180^") %>%
  image_quantize(max = 256, colorspace = 'gray') %>%
  image_crop("338x180+0+50")

image_write(bird, paste0(base, "homepage-channel-image-bird.jpg"))

beetle <-
  "https://dina-web.net/naturalist/media/get-stream/2a6d0242-17b0-440c-a26d-ccdd60e99193.jpeg" %>%
  image_read() %>% image_convert("jpg") %>% image_resize("338x180^") %>%
  image_crop("338x180+0+50")

image_write(beetle, paste0(base, "homepage-channel-image-beetle.jpg"))

rainbow <-
  "https://dina-web.net/naturalist/media/get-stream/b812d172-3db6-414f-8fb4-0d04cf92f34b.jpeg" %>%
  image_read() %>% image_convert("jpg") %>% image_resize("338x180!")

image_write(rainbow, paste0(base, "homepage-channel-image-rainbow.jpg"))

raindeer <-
  "https://farm6.staticflickr.com/5533/9132792271_8ccb1d20f6_o_d.jpg" %>%
  image_read()

orthoptera <-
  "https://dina-web.net/naturalist/resources/img/orthoptera-banner.jpg" %>%
  image_read()

bear <-
  "https://dina-web.net/naturalist/media/get-stream/6e8b3e1b-581e-44c2-985f-a38270a43dc1.png" %>%
  image_read()

redfox <-
  "https://dina-web.net/naturalist/media/get-stream/e08b913e-d55a-4b3c-984b-8458b3054a68.jpeg" %>%
  image_read()

whitefox <-
  "https://dina-web.net/naturalist/media/get-stream/d2c469e5-e926-4f44-a557-1314e5c8f870.jpeg" %>%
  image_read()

wolf <-
  "https://dina-web.net/naturalist/media/get-stream/f45a0b44-abdd-4ee4-838c-453de4954951.jpeg" %>%
  image_read()

i1 <-
  redfox %>% image_convert("png") %>%
  image_scale("1270")  %>% image_crop("770x220+0+100")
  #%>% image_border("lightgray", "144") %>% image_transparent(color = "lightgray")

i2 <-
  whitefox %>% image_convert("png") %>%
  image_scale("1170x") %>% image_crop("770x220+0+330") #%>%
  #image_border("lightgray", "100") %>% image_transparent(color = "lightgray")

i3 <-
  bear %>% image_convert("png") %>%
  image_scale("870x") %>% image_crop("770x220+0+200") #%>%
  #image_border("lightgray", "100") %>% image_transparent(color = "lightgray")

i4 <-
  orthoptera %>% image_convert("png") %>%
  image_scale("770x") %>% image_crop("770x220")

i5 <-
  wolf %>% image_convert("png") %>%
  image_scale("870x") %>% image_crop("770x220+0+450")

i0 <-
  raindeer %>% image_convert("png") %>% image_scale("870x") %>% image_crop("770x220+0+290") #%>%
#  image_border("lightgray", "x18") %>% image_transparent(color = "lightgray")

img <- c(i0, i5, i1, i2, i3, i4)

anime <- image_animate(img, fps = 0.1, dispose = "previous")
image_write(anime, paste0(base, "jtron-bg-month-02-770px.gif"))

# logos

logos <- dir("~/repos/bioatlas/wordpress-docker/logos/", full.names = TRUE)

logo <- logos[1]

make_logo <- function(filename) {
  logo <- filename
  logo %>% image_read() %>% image_convert(format = "png", type = "grayscale") %>%
  image_scale("100x100")  %>% image_flip() %>% image_normalize()
}

library(purrr)
res <- map(logos, make_logo)


logo_vr <- res[[1]]
logo_ala <- res[[2]]
logo_ki <- res[[4]]
logo_kth <- res[[9]] %>% image_negate()
logo_linnaeus <- res[[10]]
logo_lund <- res[[13]]
logo_nrm <- res[[16]]
logo_sll <- res[[18]]
logo_su <- res[[19]]
logo_slw <- res[[21]]
logo_uppsala <- res[[22]]

logo_end <- image_append(c(
  logo_sll,
  logo_slw
), stack = TRUE)

logo_footer <- image_append(c(
  logo_su,
  logo_nrm,
  logo_uppsala,
  logo_ki,
  logo_lund,
  logo_linnaeus,
  logo_kth,
  logo_ala,
  logo_end,
  logo_vr
))

footer <-
  logo_footer %>% image_resize("770x") %>% image_flip() %>%
  image_transparent(color = "white")

image_write(footer, paste0(base, "logos.png"))

library(webshot)

webshot("https://wordpress.bioatlas.se")

theme_logo <-
#  "~/repos/bioatlas/bioatlas-wordpress-theme/screenshot.png" %>%
  "webshot.png" %>%
  image_read() %>%
  image_scale("600x417^") %>% image_crop("600x417")

image_write(theme_logo,
  path = "~/repos/bioatlas/bioatlas-wordpress-theme/screenshot.png")
