################################################################################
##
##                  챗GPT 데이터 사이언스 로고
##                      이광춘, 2024-01-21
##
################################################################################

# 1. AI 배경 이미지 ------------------------------------------------------------

library(tidyverse)
library(openai)
library(cropcircles)
library(magick)
library(showtext)
library(ggpath)
library(ggtext)
library(glue)

extrafont::loadfonts()

Sys.setenv(OPENAI_API_KEY = Sys.getenv("OPENAI_API_KEY"))

# x <- create_image("a amazing newspaper as the sun is rising behind many news full of fake and misinformation")
# x <- create_image("multicolor sparkly glitter bursting from the tip of an tomato as it touches the paper, bright, realism")
x <- create_image("draw Korean ink painting style landscape image with data, green tone, minimalism")
# from https://jehyunlee.github.io/2023/12/25/General-33-ChatGPT_DataAnalysis/



## 원본이미지 다운로드
download.file(url = x$data$url, destfile = "images/logo-data-science.png",
              mode = "wb")


# 2. 뉴스토마토 로고 ------------------------------------------------------------
## 2.1. 소스 이미지
book_bg <- magick::image_read("images/logo_gpt_ds.jpg")

# book_bg <- book_bg %>%
#   image_resize(geometry = c(300, 300))
#   image_resize('25%x25%')

## 2.2. 로고 추가작업
# bitTomato_logo <- image_composite(tomato_bg,
#                                   # newstomato_logo %>% image_resize(geometry = c(130, 130)) %>%
#                                   newstomato_logo |> image_resize('10%x10%') |>
#                                     image_transparent(color = 'white'),
#                                   offset = "+80+140", operator = "atop")


# 3. 텍스트 ------------------------------------------------------------

font_add_google('inconsolata', 'Inconsolata')
font_add_google('Dokdo', 'dokdo')
# 글꼴 다운로드 : https://fontawesome.com/download
font_add('fa-brands', 'data-raw/fonts/Font Awesome 6 Brands-Regular-400.otf')
showtext_auto()
ft <- "dokdo"
ft_github <- "inconsolata"
txt <- "#996515"

pkg_name <- "챗GPT 데이터 과학"

img_cropped <- hex_crop(
  images = book_bg,
  border_colour = "#FFED00",
  border_size = 5
)
"#996515"
"#B8860B"
"#CD7F32"

book_gg <- ggplot() +
  geom_from_path(aes(0.5, 0.5, path = img_cropped)) +
  annotate("text", x = 0.39, y = 0.08, label = pkg_name,
           family = ft, size = 25, colour = txt,
           angle = 30, hjust = 0, fontface = "bold") +
  # add github
  annotate("richtext", x=0.50, y = 0.03, family = ft_github,
           size = 12, angle = 30,
           colour = txt, hjust = 0,
           label = glue("<span style='font-family:fa-brands; color:{txt}'>&#xf09b;&nbsp;</span> bit2r/gpt-ds"),
           label.color = NA, fill = NA, fontface = "bold")   +
  xlim(0, 1) +
  ylim(0, 1) +
  theme_void() +
  coord_fixed()

book_gg

ragg::agg_png("images/logo.png",
              width = 4.39, height = 5.08, units = "cm", res = 600)
book_gg
dev.off()

