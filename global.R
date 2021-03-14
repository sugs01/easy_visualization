# 设置utf-8
# Sys.setlocale('LC_ALL', 'en_US.UTF-8')
# en_US.UTF-8
Sys.setenv(TZ = "Asia/Shanghai")

# Cairo包的PNG设备似乎无法显示中文字符，强制使用R自身的png()设备
options(shiny.usecairo = FALSE)


# Upload package
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinylogs)
#library(ctmm)
library(data.table)
#library(magrittr)
#library(ctmmweb)
library(echarts4r)
library(echarts4r.maps)
library(tidyverse)
#library(readxl)
library(shinymanager)
library(keyring)
library(ggthemes)
# library(googleAuthR)
# library(googleAnalyticsR)



# font_home <- function(path = '') file.path('~', '.fonts', path)
# if (Sys.info()[['sysname']] == 'Linux') {
#    dir.create(font_home())
#    file.copy('wqy-zenhei.ttc', font_home())
#    system2('fc-cache', paste('-f', font_home()))
# }

#############################################################################################################
# setwd('C:/Users/sugs0/Documents/shiny')
# 颜色
chart_color <- read_csv("data/chart_color.csv")

# 哪个地方的地图
map_adcode <- read_csv("data/map_adcode.csv")
map_adcode$adcode <- as.integer(map_adcode$adcode)

# 哪种货币
y_currency <- read_csv("data/currency.csv")

# 主题
chart_theme <- read_csv("data/chart_theme.csv")

# 词云的形状
word_shape <- read_csv("data/word_shape.csv")

# 商务风数据
ggthemes <- read_csv("data/ggthemes.csv")
color_fill <- read_csv("data/color_fill.csv")
## 示例数据
dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
#############################################################################################################
# 账号数据
credentials <- read_csv("data/credentials.csv")
# key_set('144.202.80.189', 'shiny')
# # Init the database
# create_db(
#    credentials_data = credentials,
#    sqlite_path = "path/to/database.sqlite", # will be created
#    passphrase = key_get("144.202.80.189", "shiny")
#    # passphrase = "passphrase_wihtout_keyring"
# )

#############################################################################################################
# read data of different format 
read_files <- function(input_file_chart) {
   ext <- tools::file_ext(input_file_chart)
   ext = switch(
      ext, 
      xlsx = readxl::read_xlsx(input_file_chart), 
      xls = readxl::read_xls(input_file_chart), 
      csv = readr::read_csv(input_file_chart),
      tsv = readr::read_delim(input_file_chart, delim = '\t'),
      validate("Invalid file; Please upload a .xlsx, .xls, .csv or .tsv file")
   )
   return(ext)
}

# 下载数据
download_file <- function(dataset) {
   downloadHandler(
      filename = function() {
         paste("dataset", ".csv", sep = "")
      },
      content = function(file) {
         write.csv(dataset(), file, row.names = FALSE)
      }
   )
}

# 下载图片
download_plot <- function(result_plot) {
   downloadHandler(
      filename = function() {paste("result_plot", ".png", sep = "")},
      content = function(file) {ggsave(file, plot = result_plot(), dpi = 1000, width = 12.1, height = 5.1)}
   )
}

# 商务风主题

theme_my <- function(themes = 'gdocs') {
   switch(
      themes, 
      "calc" = theme_calc(),
      "economist" = theme_economist(),
      "economist_white" = theme_economist_white(),
      "excel_new" = theme_excel_new(),
      "few" = theme_few(),
      "fivethirtyeight" = theme_fivethirtyeight(),
      "gdocs" = theme_gdocs(),
      "hc" = theme_hc(),
      "igray" = theme_igray(),
      "pander" = theme_pander(),
      "solarized" = theme_solarized(),
      "solarized_2" = theme_solarized_2(),
      "solid" = theme_solid(),
      "stata" = theme_stata(),
      "tufte" = theme_tufte(),
      "wsj" = theme_wsj()
   )
}

scale_color_my <- function(colors = 'gdocs') {
   switch(
      colors, 
      "calc" = scale_color_calc(),
      "economist" = scale_color_economist(),
      "economist_white" = scale_color_economist(),
      "excel_new" = scale_color_excel_new(),
      "few" = scale_color_few(),
      "fivethirtyeight" = scale_color_fivethirtyeight(),
      "gdocs" = scale_color_gdocs(),
      "hc" = scale_color_hc(),
      "pander" = scale_color_pander(),
      "solarized" = scale_color_solarized(),
      "solarized_2" = scale_color_solarized(),
      "stata" = scale_color_stata(),
      "wsj" = scale_color_wsj()
   )
}

scale_fill_my <- function(fill = 'gdocs') {
   switch(
      fill, 
      "calc" = scale_fill_calc(),
      "economist" = scale_fill_economist(),
      "economist_white" = scale_fill_economist(),
      "excel_new" = scale_fill_excel_new(),
      "few" = scale_fill_few(),
      "fivethirtyeight" = scale_fill_fivethirtyeight(),
      "gdocs" = scale_fill_gdocs(),
      "hc" = scale_fill_hc(),
      "pander" = scale_fill_pander(),
      "solarized" = scale_fill_solarized(),
      "solarized_2" = scale_fill_solarized(),
      "stata" = scale_fill_stata(),
      "wsj" = scale_fill_wsj()
   )
}





