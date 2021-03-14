# tags$h2("My secure application")
# verbatimTextOutput("auth_output")
# UI
use_tracking()




# header ----
header <- dashboardHeader(title = "Easy Visualization")

# sidebar ----
sidebar <- dashboardSidebar(
   sidebarMenu(
      menuItem(text = "Line Chart", tabName = "line_chart"),
      menuItem(text = "Bar Chart", tabName = "bar_chart"),
      menuItem(text = "Area Chart", tabName = "area_chart"),
      menuItem(text = "Scatter Chart", tabName = "point_chart"),
      menuItem(text = "Pie Phart", tabName = "pie_chart"),
      menuItem(text = "Boxplot Chart", tabName = "boxplot_chart"),
      menuItem(text = "Violin Chart", tabName = "violin_chart"),
      menuItem(text = "Candle Chart", tabName = "candle_chart"),
      menuItem(text = "Funnel Chart", tabName = "funnel_chart"),
      menuItem(text = "Sankey Chart", tabName = "sankey_chart"),
      menuItem(text = "Heatmap Chart", tabName = "heatmap_2d_chart"),
      menuItem(text = "Parallel Chart", tabName = "parallel_chart"),
      menuItem(text = "Rosetype Chart", tabName = "rosetype_chart"),
      menuItem(text = "River Chart", tabName = "river_chart"),
      menuItem(text = "Gauge Chart", tabName = "gauge_chart"),
      menuItem(text = "Wordcloud_ Chart", tabName = "wordcloud_chart"),
      menuItem(text = "Map Chart", tabName = "map_chart"),
      menuItem(text = "Public Statement", tabName = "public_statement")
   )
)

# 一、商务风图形
# 1.line_chart
line_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(
         2, fileInput("line_file", label = "", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv data")
      ),
      column(2, downloadButton('download_line', "Download the Example Data"))
   )
)

line_box_draw <- box(
   title = "line_chart：Time Trend",
   status = "info",
   solidHeader = TRUE, 
   width = 12, 
   fluidPage(
      tags$head(includeHTML(("google-analytics.html"))), 
      sidebarLayout(
         sidebarPanel(
            selectInput(inputId = "line_label", label = "X-axis", choices = NULL, multiple = FALSE),
            selectInput(inputId = "line_value", label = "Y-axis", choices = NULL, multiple = FALSE),
            selectInput(inputId = "line_group", label = "By Group", choices = NULL, multiple = TRUE),
            selectInput(inputId = "line_theme", label = "Themes Style", choices = ggthemes$ggthemes, selected = 'gdocs', multiple = FALSE),
            selectInput(inputId = "line_color", label = "Line Color", choices = color_fill$color_fill, selected = 'gdocs', multiple = FALSE),
            downloadButton(outputId = 'download_line_plot', label = "Download Chart")
         ),
         mainPanel(
            plotOutput("line_chart", width = "1000px", height = "500px")
            # tableOutput("line_table")
         )
      )
   )
)

line_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "line_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("line_data_selected")
)

line_box_beian <- box(
   fluidPage(
      column(12, h5(uiOutput("beian")))
))


# 2.bar_chart
bar_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(
         2, fileInput("bar_file", label = "", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv data")
      ),
      column(2, downloadButton('download_bar', "Download the Example Data"))
   )
)

bar_box_draw <- box(
   title = "bar_chart：Data Size Comparison",
   status = "info",
   solidHeader = TRUE, 
   width = 12, 
   fluidPage(
      sidebarLayout(
         sidebarPanel(
            selectInput(inputId = "bar_label", label = "X-axis", choices = NULL, multiple = FALSE),
            selectInput(inputId = "bar_value", label = "Y-axis", choices = NULL, multiple = FALSE),
            selectInput(inputId = "bar_group", label = "By Group", choices = NULL, multiple = TRUE),
            selectInput(inputId = "bar_theme", label = "Themes Style", choices = ggthemes$ggthemes, selected = 'gdocs', multiple = FALSE),
            selectInput(inputId = "bar_fill", label = "Themes Fill", choices = color_fill$color_fill, selected = 'gdocs', multiple = FALSE),
            selectInput(inputId = "bar_type", label = "bar_chart类型", choices = c('dodge', 'stack'), selected = 'dodge', multiple = FALSE),
            downloadButton(outputId = 'download_bar_plot', label = "Download Chart")
         ),
         mainPanel(
            plotOutput("bar_chart", width = "1000px", height = "500px")
            # tableOutput("bar_table")
         )
      )
   )
)

bar_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "bar_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("bar_data_selected")
)


# 3.area_chart
area_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(
         2, fileInput("area_file", label = "", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv data")
      ),
      column(2, downloadButton('download_area', "Download the Example Data"))
   )
)

area_box_draw <- box(
   title = "area_chart：Time Trend & Data Distribution",
   status = "info",
   solidHeader = TRUE, 
   width = 12, 
   fluidPage(
      sidebarLayout(
         sidebarPanel(
            selectInput(inputId = "area_label", label = "X-axis", choices = NULL, multiple = FALSE),
            selectInput(inputId = "area_value", label = "Y-axis", choices = NULL, multiple = FALSE),
            selectInput(inputId = "area_group", label = "By Group", choices = NULL, multiple = TRUE),
            selectInput(inputId = "area_theme", label = "Themes Style", choices = ggthemes$ggthemes, selected = 'gdocs', multiple = FALSE),
            selectInput(inputId = "area_fill", label = "Themes Fill", choices = color_fill$color_fill, selected = 'gdocs', multiple = FALSE),
            downloadButton(outputId = 'download_area_plot', label = "Download Chart")
         ),
         mainPanel(
            plotOutput("area_chart", width = "1000px", height = "500px")
         )
      )
   )
)

area_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "area_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("area_data_selected")
)

# 4.scatter_chart
point_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(
         2, fileInput("point_file", label = "", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv data")
      ),
      column(2, downloadButton('download_point', "Download the Example Data"))
   )
)

point_box_draw <- box(
   title = "scatter_chart：Data Distribution",
   status = "info",
   solidHeader = TRUE, 
   width = 12, 
   fluidPage(
      sidebarLayout(
         sidebarPanel(
            selectInput(inputId = "point_label", label = "X-axis", choices = NULL, multiple = FALSE),
            selectInput(inputId = "point_value", label = "Y-axis", choices = NULL, multiple = FALSE),
            selectInput(inputId = "point_group", label = "By Group", choices = NULL, multiple = TRUE),
            selectInput(inputId = "point_size", label = "Scatter Size", choices = NULL, multiple = TRUE),
            selectInput(inputId = "point_theme", label = "Themes Style", choices = ggthemes$ggthemes, selected = 'gdocs', multiple = FALSE),
            selectInput(inputId = "point_fill", label = "Themes Fill", choices = color_fill$color_fill, selected = 'gdocs', multiple = FALSE),
            downloadButton(outputId = 'download_point_plot', label = "Download Chart")
         ),
         mainPanel(
            plotOutput("point_chart", width = "1000px", height = "500px")
         )
      )
   )
)

point_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "point_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("point_data_selected")
)

# 5.pie_chart
pie_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(
         2, fileInput("pie_file", label = "", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv data")
      ),
      column(2, downloadButton('download_pie', "Download the Example Data"))
   )
)

pie_box_draw <- box(
   title = "pie_chart：Data Rate(It is not recommended to use in practical work.)",
   status = "info",
   solidHeader = TRUE, 
   width = 12, 
   fluidPage(
      sidebarLayout(
         sidebarPanel(
            selectInput(inputId = "pie_label", label = "Pie Label", choices = NULL, multiple = FALSE),
            selectInput(inputId = "pie_value", label = "Pie Size", choices = NULL, multiple = FALSE),
            selectInput(inputId = "pie_type", label = "Pie Type", choices = NULL, multiple = TRUE),
            selectInput(inputId = "pie_theme", label = "Themes Style", choices = ggthemes$ggthemes, selected = 'gdocs', multiple = FALSE),
            selectInput(inputId = "pie_fill", label = "Themes Fill", choices = color_fill$color_fill, selected = 'gdocs', multiple = FALSE),
            downloadButton(outputId = 'download_pie_plot', label = "Download Chart")
         ),
         mainPanel(
            plotOutput("pie_chart", width = "1000px", height = "500px")
         )
      )
   )
)

pie_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "pie_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("pie_data_selected")
)

# 6.Boxplot Chart
boxplot_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(
         2, fileInput("boxplot_file", label = "", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv data")
      ),
      column(2, downloadButton('download_boxplot', "Download the Example Data"))
   )
)

boxplot_box_draw <- box(
   title = "Boxplot Chart：Data Size Comparsion&Data Distribution",
   status = "info",
   solidHeader = TRUE, 
   width = 12, 
   fluidPage(
      sidebarLayout(
         sidebarPanel(
            selectInput(inputId = "boxplot_label", label = "X-axis", choices = c("cut", "color", "clarity"), selected = "color", multiple = FALSE),
            selectInput(inputId = "boxplot_value", label = "Y-axis", choices = c("carat", "depth", "table", "price", "x", "y", "z"), selected = "price", multiple = FALSE),
            selectInput(inputId = "boxplot_theme", label = "Themes Style", choices = ggthemes$ggthemes, selected = 'gdocs', multiple = FALSE),
            selectInput(inputId = "boxplot_fill", label = "Themes Fill", choices = color_fill$color_fill, selected = 'gdocs', multiple = FALSE),
            downloadButton(outputId = 'download_boxplot_plot', label = "Download Chart")
         ),
         mainPanel(
            plotOutput("boxplot_chart", width = "1000px", height = "500px")
         )
      )
   )
)

boxplot_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "boxplot_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("boxplot_data_selected")
)

# 7.Violin Box
violin_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(
         2, fileInput("violin_file", label = "", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv data")
      ),
      column(2, downloadButton('download_violin', "Download the Example Data"))
   )
)

violin_box_draw <- box(
   title = "Violin Box：Data Size comparsion&Data Distribution",
   status = "info",
   solidHeader = TRUE, 
   width = 12, 
   fluidPage(
      sidebarLayout(
         sidebarPanel(
            selectInput(inputId = "violin_label", label = "X-axis", choices = names(dsamp), selected = "color", multiple = FALSE),
            selectInput(inputId = "violin_value", label = "Y-axis", choices = names(dsamp), selected = "x", multiple = FALSE),
            selectInput(inputId = "violin_theme", label = "Themes Style", choices = ggthemes$ggthemes, selected = 'gdocs', multiple = FALSE),
            selectInput(inputId = "violin_fill", label = "Themes Fill", choices = color_fill$color_fill, selected = 'gdocs', multiple = FALSE),
            downloadButton(outputId = 'download_violin_plot', label = "Download Chart")
         ),
         mainPanel(
            plotOutput("violin_chart", width = "1000px", height = "500px")
         )
      )
   )
)

violin_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "violin_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("violin_data_selected")
)




# P1 Map Chart---------------------------------------------------------------------------------------------------

# p1.a chart:upload
map_box_upload <- box(
   title = "Upload Data(The example data is in bottom of this page)",
   status = "info", 
   solidHeader = TRUE, 
   width = 12,
   # fluidRow(
   #    column(2, h4(icon("upload"), "上传自己的数据")), 
   #    column(2, offset = 0, h4(uiOutput("map_tab"))),
   #    column(2, downloadButton("download_china", "Download the Example Data-中国")),
   #    column(2, downloadButton("download_province", "Download the Example Data-河南省")),
   #    column(2, downloadButton("download_town", "Download the Example Data-郑州市")),
   #    column(2, downloadButton("download_other_country", "Download the Example Data-日本"))
   # ),
   fluidRow(
      column(
         2, fileInput("map_file", label = '', multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv data")
      ), 
      column(2, offset = 0, h4(uiOutput("map_tab"))),
      column(2, downloadButton("download_china", "Download the Example Data-China")),
      column(2, downloadButton("download_province", "Download the Example Data-Henan")),
      column(2, downloadButton("download_town", "Download the Example Data-Zhengzhou")),
      column(2, downloadButton("download_other_country", "Download the Example Data-Japan"))
   ),
   fluidRow(
      fluidPage(includeMarkdown("help/map_help.md"))
   )
)


# p1.b chart:draw the map chart
map_box_draw <- box(
   # 本模块标题设置
   title = "Map：Geographic contrast & visual rendering", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   
   # 图形展示
   tabBox(
      width = 12, 
      # 中国地图
      tabPanel(# tab1
         title = "1.China Map, Provinces and Cities Map of China", 
         fluidRow(
            column(2, selectInput(inputId = "map_area", label = "Map of Area?",
                                  choices = c(Choose = '', map_adcode$name_cn), selectize = TRUE,  multiple = FALSE)),
            column(2, selectInput(inputId = "map_area_adress", label = "Province/Cities/Town", 
                                  choices = NULL, multiple = FALSE)),
            column(2, selectInput(inputId = "map_value", label = "Map Value", 
                                  choices = NULL, multiple = FALSE)),
            column(2, selectInput(inputId = "map_visual_type", label = "Data Category: Continuous / Discrete", 
                                  choices = c("continuous", "piecewise"), selected = "continuous", multiple = FALSE)),
            column(2, selectInput(inputId = "map_color_of_min_value", label = "Min value of Color",
                                  choices = chart_color$English, selected = 'White', selectize = TRUE,  multiple = FALSE)),
            column(2, selectInput(inputId = "map_color_of_max_value", label = "Max value of Color",
                                  choices = chart_color$English, selected = 'Red', selectize = TRUE,  multiple = FALSE))
         ),
         ## 第二排参数
         fluidRow(
            # column(3, textInput(inputId = "map_title", label = "图标题", value = NULL,
            #                     placeholder = "请输入图标题")),
            # column(3, textInput(inputId = "map_sub_title", label = "图副标题", value = NULL,
            #                     placeholder = "请输入图副标题")),
            # column(2, selectInput(inputId = "map_color_of_min_value", label = "颜色-最小值",
            #                       choices = chart_color$English, selected = 'White', selectize = TRUE,  multiple = FALSE)),
            # column(2, selectInput(inputId = "map_color_of_max_value", label = "颜色-最大值",
            #                       choices = chart_color$English, selected = 'Red', selectize = TRUE,  multiple = FALSE)),
            column(2, offset = 10, actionButton(inputId = "map_button", label = "Click to start plot map!", icon = icon("map")))
            
         ),
         echarts4rOutput("map_chart", width = "1200px", height = "1000px")
      ),
      # 所有国家地图
      tabPanel(# tab2
         title = "2.Map of Countries", 
         fluidRow(
            column(2, selectInput(inputId = "world_map_area", label = "Map of Countries?",
                                  choices = c(Choose = '', em_bank()[-40][-85]), selectize = TRUE, selected = 'world',  multiple = FALSE)),
            column(2, selectInput(inputId = "world_map_country", label = "Province", 
                                  choices = NULL, multiple = FALSE)),
            column(2, selectInput(inputId = "world_map_value", label = "Map Value", 
                                  choices = NULL, multiple = FALSE)),
            column(2, selectInput(inputId = "world_map_visual_type", label = "Data Category: Continuous / Discrete", 
                                  choices = c("continuous", "piecewise"), selected = "continuous", multiple = FALSE)),
            column(2, selectInput(inputId = "world_map_color_of_min_value", label = "Min value of Color",
                                  choices = chart_color$English, selected = 'White', selectize = TRUE,  multiple = FALSE)),
            column(2, selectInput(inputId = "world_map_color_of_max_value", label = "Max value of Color",
                                  choices = chart_color$English, selected = 'Red', selectize = TRUE,  multiple = FALSE))
            # ,
            # column(2, selectInput(inputId = "world_is_show_label", label = "Is Show Label",
            #                       choices = c('TRUE', 'FALSE'), selected = 'FALSE', selectize = TRUE,  multiple = FALSE)),
            # column(2, numericInput(inputId = "world_map_label_fontsize", label = "Map Label FontSize", 
            #                        min = 0, max = 100, value = 10))
         ),
         ## 第二排参数
         # fluidRow(
         #    column(3, textInput(inputId = "world_map_title", label = "图标题", value = NULL,
         #                        placeholder = "请输入图标题")),
         #    column(3, textInput(inputId = "world_map_sub_title", label = "图副标题", value = NULL,
         #                        placeholder = "请输入图副标题")),
         #    column(2, selectInput(inputId = "world_map_color_of_min_value", label = "颜色-最小值",
         #                          choices = chart_color$English, selected = 'White', selectize = TRUE,  multiple = FALSE)),
         #    column(2, selectInput(inputId = "world_map_color_of_max_value", label = "颜色-最大值",
         #                          choices = chart_color$English, selected = 'Red', selectize = TRUE,  multiple = FALSE))
         #    
         # ),
         fluidRow(
            echarts4rOutput("world_map_chart", width = "1000px", height = "900px")
         )
      )
      # ,
      # # Only World Map
      # tabPanel(# tab3
      #    title = "3.Map of World", 
      #    fluidRow(
      #       column(2, selectInput(inputId = "only_world_map_country", label = "Countries", 
      #                             choices = NULL, multiple = FALSE)),
      #       column(2, selectInput(inputId = "only_world_map_value", label = "Value", 
      #                             choices = NULL, multiple = FALSE)),
      #       column(2, selectInput(inputId = "only_world_map_visual_type", label = "Map Visual Type", 
      #                             choices = c("continuous", "piecewise"), selected = "continuous", multiple = FALSE))
      #       # ,
      #       # column(2, selectInput(inputId = "only_world_is_show_label", label = "Is Show Label",
      #       #                       choices = c('TRUE', 'FALSE'), selected = 'FALSE', selectize = TRUE,  multiple = FALSE)),
      #       # column(2, numericInput(inputId = "only_world_map_label_fontsize", label = "Map Label FontSize", 
      #       #                        min = 0, max = 100, value = 10))
      #    ),
      #    ## 第二排参数
      #    fluidRow(
      #       column(3, textInput(inputId = "only_world_map_title", label = "Title of Chart", value = NULL,
      #                           placeholder = "Please Input the Title of This Chart")),
      #       column(3, textInput(inputId = "only_world_map_sub_title", label = "Sub Title of Chart", value = NULL,
      #                           placeholder = "Please Input the Sub Title of This Chart if Requested")),
      #       column(2, selectInput(inputId = "only_world_map_color_of_min_value", label = "Color of Min Value",
      #                             choices = chart_color$English, selected = 'White', selectize = TRUE,  multiple = FALSE)),
      #       column(2, selectInput(inputId = "only_world_map_color_of_max_value", label = "Color of Max Value",
      #                             choices = chart_color$English, selected = 'Red', selectize = TRUE,  multiple = FALSE))
      #    ),
      #    echarts4rOutput("only_world_map_chart", width = "1200px", height = "1000px")
      # )
      # ,
      # # 行政区划数据
      # tabPanel(# tab4
      #    title = "4.中国行政区划数据", 
      #    fluidRow(
      #       column(2, selectInput(inputId = "map_keywords", label = "查询关键字", 
      #                             choices = c(Choose = '', map_adcode$name_cn), selectize = TRUE, multiple = FALSE)),
      #       column(2, selectInput(inputId = "map_subdistrict", label = "子级行政区", 
      #                             choices = c(0, 1, 2, 3), selectize = TRUE, multiple = FALSE))
      #    ),
      #    ## 第二排参数
      #    tableOutput("map_administrative_divisions")
      # )
   )
)

# p1.c chart: Data Table
map_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   
   column(3, offset = 1, numericInput(inputId = "map_data_selected_row", label = "Rows View", 
                                      min = 0, max = 200, value = 10, step = 5)), 
   tableOutput("map_data_selected")
   
)

# p1.d chart: Example Data
map_box_table_example <- box(
   title = "Example Data", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(2, tableOutput("map_data_example_china")), 
      column(2, tableOutput("map_data_example_henan")), 
      column(2, tableOutput("map_data_example_zhengzhou")), 
      column(2, tableOutput("map_data_example_japan"))
   )
)

# P2 Candle Chart---------------------------------------------------------------------------------------------------
# p2.a chart:upload
candle_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12,
   # fluidRow(
   #    column(3, h4(icon("upload"), "Upload")), 
   #    column(3, offset = 0, h4(uiOutput("candle_tab"))),
   #    column(2, downloadButton("download_candel", "Download the Example Data"))
   # ),
   fluidRow(
      column(
         6, fileInput("candle_file", label = "Upload Data", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv Data")
      ),
      column(2, downloadButton("download_candel", "Download the Example Data"))
   )
)

# p2.b chart:draw the candle chart
candle_box_draw <- box(
   # 本模块标题设置
   title = "Candle Chart：Stock Market Trends", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(2, selectInput(inputId = "candle_date", label = "Date",
                            choices = NULL, selectize = TRUE, multiple = FALSE)),
      column(2, selectInput(inputId = "candle_opening", label = "Opening Price", 
                            choices = NULL, multiple = FALSE)),
      column(2, selectInput(inputId = "candle_closing", label = "Closing Price", 
                            choices = NULL, multiple = FALSE)),
      column(2, selectInput(inputId = "candle_high", label = "Highest Price", 
                            choices = NULL, multiple = FALSE)),
      column(2, selectInput(inputId = "candle_low", label = "Min Price", 
                            choices = NULL, multiple = FALSE)),
      column(1, numericInput(inputId = "candle_y_axis_max", label = "Max Vlue of Y-axis", min = -Inf, max = Inf, value = NULL)),
      column(1, numericInput(inputId = "candle_y_axis_min", label = "Min Vlue of Y-axis", min = -Inf, max = Inf, value = NULL))
   ),
   ## 第二排参数
   # fluidRow(
   #    column(3, textInput(inputId = "candle_title", label = "图标题", value = NULL,
   #                        placeholder = "请输入图标题")),
   #    column(3, textInput(inputId = "candle_sub_title", label = "图副标题", value = NULL,
   #                        placeholder = "请输入图副标题"))
   #    
   # ),
   echarts4rOutput("candle_chart", width = "1200px", height = "600px")
)

# p2.c Data View
candle_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   
   column(3, offset = 1, numericInput(inputId = "candle_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("candle_data_selected")
)


# P3 Funnel Chart---------------------------------------------------------------------------------------------------
# P3.a chart:upload
funnel_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12,
   # fluidRow(
   #    column(3, h4(icon("upload"), "Upload")), 
   #    column(3, offset = 0, h4(uiOutput("funnel_tab")))
   # ),
   fluidRow(
      column(
         6, fileInput("funnel_file", label = "Upload Data", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv Data")
      ),
      column(2, downloadButton("download_funnel", "Download the Example Data"))
   )
)

# P3.b chart:draw the funnel chart
funnel_box_draw <- box(
   # 本模块标题设置
   title = "Funnel Chart：Conversion Rate of Each Link", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(2, selectInput(inputId = "funnel_label", label = "Funnel Label",
                            choices = NULL, selectize = TRUE, multiple = FALSE)),
      column(2, selectInput(inputId = "funnel_value", label = "Funnel Value", 
                            choices = NULL, multiple = FALSE)),
      column(2, selectInput(inputId = "funnel_sort", label = "Funnel Sort", 
                            choices = c('ascending', 'descending', 'none'), selected = 'descending', multiple = FALSE)),
      column(2, selectInput(inputId = "funnel_orient", label = "Funnel Direct", 
                            choices = c('vertical', 'horizontal'), selected = 'vertical', multiple = FALSE)),
      column(2, numericInput(inputId = "funnel_gap", label = "Funnel Gap", min = 0, max = 100, value = 3)),
      column(2, selectInput(inputId = "funnel_theme", label = "Themes Style", 
                            choices = chart_theme$chart_theme, selected = 'default', multiple = FALSE))
   ),
   ## 第二排参数
   # fluidRow(
   #    column(3, textInput(inputId = "funnel_title", label = "图标题", value = NULL,
   #                        placeholder = "请输入图标题")),
   #    column(3, textInput(inputId = "funnel_sub_title", label = "图副标题", value = NULL,
   #                        placeholder = "请输入图副标题"))
   #    
   # ),
   echarts4rOutput("funnel_chart", width = "900px", height = "600px")
)

# P3.c Data View
funnel_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   
   column(3, offset = 1, numericInput(inputId = "funnel_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("funnel_data_selected")
   
)


# P4 sankey Chart---------------------------------------------------------------------------------------------------
# P4.a chart:upload
sankey_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12,
   # fluidRow(
   #    column(3, h4(icon("upload"), "Upload")), 
   #    column(3, offset = 0, h4(uiOutput("sankey_tab")))
   # ),
   fluidRow(
      column(
         6, fileInput("sankey_file", label = "Upload Data", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv Data")
      ),
      column(2, downloadButton("download_sankey", "Download the Example Data"))
   )
)

# P4.b chart:draw the sankey chart
sankey_box_draw <- box(
   # 本模块标题设置
   title = "Sankey Chart：Flow Path", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(2, selectInput(inputId = "sankey_source", label = "Start",
                            choices = NULL, multiple = FALSE)),
      column(2, selectInput(inputId = "sankey_target", label = "Final", 
                            choices = NULL, multiple = FALSE)),
      column(2, selectInput(inputId = "sankey_value", label = "Value", 
                            choices = NULL, multiple = FALSE)),
      column(2, selectInput(inputId = "sankey_theme", label = "Themes Style", 
                            choices = chart_theme$chart_theme, selected = 'default', multiple = FALSE))
   ),
   ## 第二排参数
   # fluidRow(
   #    column(3, textInput(inputId = "sankey_title", label = "图标题", value = NULL,
   #                        placeholder = "请输入图标题")),
   #    column(3, textInput(inputId = "sankey_sub_title", label = "图副标题", value = NULL,
   #                        placeholder = "请输入图副标题"))
   #    
   # ),
   echarts4rOutput("sankey_chart", width = "1000px", height = "800px")
)

# P4.c Data View
sankey_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "sankey_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("sankey_data_selected")
   
)


# P5 heatmap Chart---------------------------------------------------------------------------------------------------
# P5.a chart:upload
heatmap_2d_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12,
   # fluidRow(
   #    column(3, h4(icon("upload"), "Upload")), 
   #    column(3, offset = 0, h4(uiOutput("heatmap_2d_tab"))),
   #    column(2, downloadButton("download_heatmap", "Download the Example Data"))
   # ),
   fluidRow(
      column(
         6, fileInput("heatmap_2d_file", label = "Upload Data", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv Data")
      ),
      column(2, downloadButton("download_heatmap", "Download the Example Data"))
   )
)

# P5.b chart:draw the heatmap chart
heatmap_2d_box_draw <- box(
   # 本模块标题设置
   title = "Heatmap：Data Size comparsion & Visual Rendering", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   
   # 图形展示
   tabBox(
      width = 12, 
      tabPanel(
         title = "1.Heatmap",
         fluidRow(
            column(2, selectInput(inputId = "heatmap_2d_x", label = "X-axis",
                                  choices = NULL, selectize = TRUE, multiple = FALSE)),
            column(2, selectInput(inputId = "heatmap_2d_y", label = "Y-axis", 
                                  choices = NULL, multiple = FALSE)),
            column(2, selectInput(inputId = "heatmap_2d_z", label = "值", 
                                  choices = NULL, multiple = FALSE)),
            column(2, selectInput(inputId = "heatmap_2d_theme", label = "Themes Style", 
                                  choices = chart_theme$chart_theme, selected = 'default', multiple = FALSE))
         ),
         # ## 第二排参数
         # fluidRow(
         #    column(3, textInput(inputId = "heatmap_2d_title", label = "图标题", value = NULL,
         #                        placeholder = "请输入图标题")),
         #    column(3, textInput(inputId = "heatmap_2d_sub_title", label = "图副标题", value = NULL,
         #                        placeholder = "请输入图副标题"))
         #    
         # ),
         echarts4rOutput("heatmap_2d_chart", width = "1000px", height = "600px")
      )
      # ,
      # tabPanel(
      #    title = "2.Heatmap-滚动",
      #    fluidRow(
      #       column(2, selectInput(inputId = "scroll_heatmap_2d_x", label = "X-axis",
      #                             choices = NULL, selectize = TRUE, multiple = FALSE)),
      #       column(2, selectInput(inputId = "scroll_heatmap_2d_y", label = "Y-axis", 
      #                             choices = NULL, multiple = FALSE)),
      #       column(2, selectInput(inputId = "scroll_heatmap_2d_z", label = "值", 
      #                             choices = NULL, multiple = FALSE)),
      #       column(2, selectInput(inputId = "scroll_heatmap_2d_group", label = "滚动轴", 
      #                             choices = NULL, multiple = FALSE)),
      #       column(2, selectInput(inputId = "scroll_heatmap_2d_theme", label = "Themes Style", 
      #                             choices = chart_theme$chart_theme, selected = 'default', multiple = FALSE))
      #    ),
      #    ## 第二排参数
      #    fluidRow(
      #       column(3, textInput(inputId = "scroll_heatmap_2d_title", label = "图标题", value = NULL,
      #                           placeholder = "请输入图标题")),
      #       column(3, textInput(inputId = "scroll_heatmap_2d_sub_title", label = "图副标题", value = NULL,
      #                           placeholder = "请输入图副标题"))
      #       
      #    ),
      #    echarts4rOutput("scroll_heatmap_2d_chart", width = "1000px", height = "600px")
      # )
   )
)

# P5.c Data View
heatmap_2d_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "heatmap_2d_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("heatmap_2d_data_selected")
   
)


# P6 parallel Chart---------------------------------------------------------------------------------------------------
# P6.a chart:upload
parallel_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12,
   # fluidRow(
   #    column(3, h4(icon("upload"), "Upload")), 
   #    column(3, offset = 0, h4(uiOutput("parallel_tab"))),
   #    column(2, downloadButton("download_parallel", "Download the Example Data"))
   # ),
   fluidRow(
      column(
         6, fileInput("parallel_file", label = "Upload Data", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv Data")
      ),
      column(2, downloadButton("download_parallel", "Download the Example Data"))
   )
)

# P6.b chart:draw the parallel chart
parallel_box_draw <- box(
   # 本模块标题设置
   title = "Parallel_title: Event Relationship", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   # fluidRow(
   #    column(3, textInput(inputId = "parallel_title", label = "图标题", value = NULL,
   #                        placeholder = "请输入图标题")),
   #    column(3, textInput(inputId = "parallel_sub_title", label = "图副标题", value = NULL,
   #                        placeholder = "请输入图副标题"))
   #    
   # ),
   echarts4rOutput("parallel_chart", width = "1000px", height = "600px")
)

# P6.c Data View
parallel_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "parallel_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("parallel_data_selected")
)

# P7 rosetype Chart---------------------------------------------------------------------------------------------------
# P7.a chart:upload
rosetype_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12,
   # fluidRow(
   #    column(3, h4(icon("upload"), "Upload")), 
   #    column(3, offset = 0, h4(uiOutput("rosetype_tab"))),
   #    column(2, downloadButton("download_rosetype", "Download the Example Data"))
   # ),
   fluidRow(
      column(
         6, fileInput("rosetype_file", label = "Upload Data", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv Data")
      ),
      column(2, downloadButton("download_rosetype", "Download the Example Data"))
   )
)

# P7.b chart:draw the rosetype chart
rosetype_box_draw <- box(
   # 本模块标题设置
   title = "Rosetype Chart：Data Size comparsion & Data Rate", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(2, selectInput(inputId = "rosetype_x", label = "Rosetype Label",
                            choices = NULL, selectize = TRUE, multiple = FALSE)),
      column(2, selectInput(inputId = "rosetype_y", label = "Value", 
                            choices = NULL, multiple = FALSE)),
      column(2, selectInput(inputId = "rosetype_type", label = "Rosetype Type", 
                            choices = c('radius', 'area'), multiple = FALSE)),
      column(2, selectInput(inputId = "rosetype_theme", label = "Themes Style", 
                            choices = chart_theme$chart_theme, selected = 'default', multiple = FALSE))
   ),
   # fluidRow(
   #    column(3, textInput(inputId = "rosetype_title", label = "图标题", value = NULL,
   #                        placeholder = "请输入图标题")),
   #    column(3, textInput(inputId = "rosetype_sub_title", label = "图副标题", value = NULL,
   #                        placeholder = "请输入图副标题"))
   #    
   # ),
   echarts4rOutput("rosetype_chart", width = "1000px", height = "600px")
)

# P7.c Data View
rosetype_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "rosetype_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("rosetype_data_selected")
)



# P8 river Chart---------------------------------------------------------------------------------------------------
# P8.a chart:upload
river_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12,
   # fluidRow(
   #    column(3, h4(icon("upload"), "Upload")), 
   #    column(3, offset = 0, h4(uiOutput("river_tab"))),
   #    column(2, downloadButton("download_river", "Download the Example Data"))
   # ),
   fluidRow(
      column(
         6, fileInput("river_file", label = "Upload Data", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv Data")
      ),
      column(2, downloadButton("download_river", "Download the Example Data"))
   )
)

# P8.b chart:draw the river chart
river_box_draw <- box(
   # 本模块标题设置
   title = "River Chart：Time Trend & Visual Rendering", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(2, selectInput(inputId = "river_x", label = "X-axis",
                            choices = NULL, selectize = TRUE, multiple = FALSE)),
      column(2, selectInput(inputId = "river_y", label = "Vlue", 
                            choices = NULL, multiple = FALSE)),
      column(2, selectInput(inputId = "river_type", label = "By Group", 
                            choices = NULL, multiple = FALSE)),
      column(2, selectInput(inputId = "river_theme", label = "Themes Style", 
                            choices = chart_theme$chart_theme, selected = 'default', multiple = FALSE))
   ),
   # fluidRow(
   #    column(3, textInput(inputId = "river_title", label = "图标题", value = NULL,
   #                        placeholder = "请输入图标题")),
   #    column(3, textInput(inputId = "river_sub_title", label = "图副标题", value = NULL,
   #                        placeholder = "请输入图副标题"))
   #    
   # ),
   echarts4rOutput("river_chart", width = "1000px", height = "600px")
)

# P8.c Data View
river_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "river_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("river_data_selected")
)

# P9 gauge Chart---------------------------------------------------------------------------------------------------
# P9.b chart:draw the gauge chart
gauge_box_draw <- box(
   # 本模块标题设置
   title = "Gauge：Complete Rate", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(2, textInput(inputId = "gauge_name", label = "Label", value = "Percent", placeholder = "请输入仪表盘数字的意义")),
      column(2, numericInput(inputId = "gauge_value", label = "Value", value = 50, step = 5)),
      column(2, numericInput(inputId = "gauge_min", label = "Min Value", value = 0, step = 5)), 
      column(2, numericInput(inputId = "gauge_max", label = "Max Value", value = 100, step = 5)), 
      column(2, numericInput(inputId = "gauge_splitnumber", label = "Number of Partitions", value = 10, step = 5)), 
      column(2, selectInput(inputId = "gauge_theme", label = "Themes Style", 
                            choices = chart_theme$chart_theme, selected = 'default', multiple = FALSE))
   ),
   # fluidRow(
   #    column(3, textInput(inputId = "gauge_title", label = "图标题", value = NULL,
   #                        placeholder = "请输入图标题")),
   #    column(3, textInput(inputId = "gauge_sub_title", label = "图副标题", value = NULL,
   #                        placeholder = "请输入图副标题"))
   #    
   # ),
   echarts4rOutput("gauge_chart", width = "600px", height = "600px")
)

# P10 wordcloud Chart---------------------------------------------------------------------------------------------------
# P10.a chart:upload
wordcloud_box_upload <- box(
   title = "Upload Data",
   status = "info", 
   solidHeader = TRUE, 
   width = 12,
   # fluidRow(
   #    column(3, h4(icon("upload"), "Upload")), 
   #    column(3, offset = 0, h4(uiOutput("wordcloud_tab"))),
   #    column(2, downloadButton("download_wordcloud", "Download the Example Data"))
   # ),
   fluidRow(
      column(
         6, fileInput("wordcloud_file", label = "Upload Data", multiple = FALSE, 
                      buttonLabel = "Upload Data", placeholder = ".xlsx, .xls, .csv, .tsv Data")
      ),
      column(2, downloadButton("download_wordcloud", "Download the Example Data"))
   )
)

# P10.b chart:draw the wordcloud chart
wordcloud_box_draw <- box(
   # 本模块标题设置
   title = "Word Cloud：Data Size comparsion&Visual Rendering", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12, 
   fluidRow(
      column(2, selectInput(inputId = "wordcloud_terms", label = "Word",
                            choices = NULL, selectize = TRUE, multiple = FALSE)),
      column(2, selectInput(inputId = "wordcloud_freq", label = "Value", 
                            choices = NULL, multiple = FALSE)),
      column(2, selectInput(inputId = "wordcloud_shape", label = "Wordcloud Shape", 
                            choices = word_shape$shape_cn, multiple = FALSE)),
      column(2, numericInput(inputId = "wordcloud_sizerange_min", label = "Min Value of Word", 
                             value = 3, min = 1, max = 20, step = 2)),
      column(2, numericInput(inputId = "wordcloud_sizerange_max", label = "Max Value of Word", 
                             value = 35, min = 15, max = 50, step = 2)),
      column(2, selectInput(inputId = "wordcloud_theme", label = "Themes Style", 
                            choices = chart_theme$chart_theme, selected = 'default', multiple = FALSE))
   ),
   # fluidRow(
   #    column(3, textInput(inputId = "wordcloud_title", label = "图标题", value = NULL,
   #                        placeholder = "请输入图标题")),
   #    column(3, textInput(inputId = "wordcloud_sub_title", label = "图副标题", value = NULL,
   #                        placeholder = "请输入图副标题"))
   #    
   # ),
   echarts4rOutput("wordcloud_chart", width = "1000px", height = "800px")
)

# P10.c Data View
wordcloud_box_table <- box(
   title = "Data View", 
   status = "info", 
   solidHeader = TRUE, 
   width = 12,    
   column(3, offset = 1, numericInput(inputId = "wordcloud_data_selected_row", label = "Rows View", 
                                      min = 0, max = 1000, value = 10, step = 5)), 
   tableOutput("wordcloud_data_selected")
)

public_statement_ui <- fluidPage(includeMarkdown("help/public_statement.md"))

# body ----
body <- dashboardBody(
   #includeCSS("www/styles.css"), 
   tabItems(
      tabItem(tabName = "line_chart", fluidRow(line_box_upload, line_box_draw, line_box_table, line_box_beian)),
      tabItem(tabName = "bar_chart", fluidRow(bar_box_upload, bar_box_draw, bar_box_table)),
      tabItem(tabName = "area_chart", fluidRow(area_box_upload, area_box_draw, area_box_table)),
      tabItem(tabName = "point_chart", fluidRow(point_box_upload, point_box_draw, point_box_table)),
      tabItem(tabName = "pie_chart", fluidRow(pie_box_upload, pie_box_draw, pie_box_table)),
      tabItem(tabName = "boxplot_chart", fluidRow(boxplot_box_upload, boxplot_box_draw, boxplot_box_table)),
      tabItem(tabName = "violin_chart", fluidRow(violin_box_upload, violin_box_draw, violin_box_table)),
      tabItem(tabName = "candle_chart", fluidRow(candle_box_upload, candle_box_draw, candle_box_table)),
      tabItem(tabName = "funnel_chart", fluidRow(funnel_box_upload, funnel_box_draw, funnel_box_table)),
      tabItem(tabName = "sankey_chart", fluidRow(sankey_box_upload, sankey_box_draw, sankey_box_table)),
      tabItem(tabName = "heatmap_2d_chart", fluidRow(heatmap_2d_box_upload, heatmap_2d_box_draw, heatmap_2d_box_table)),
      tabItem(tabName = "parallel_chart", fluidRow(parallel_box_upload, parallel_box_draw, parallel_box_table)),
      tabItem(tabName = "rosetype_chart", fluidRow(rosetype_box_upload, rosetype_box_draw, rosetype_box_table)),
      tabItem(tabName = "river_chart", fluidRow(river_box_upload, river_box_draw, river_box_table)),
      tabItem(tabName = "gauge_chart", fluidRow(gauge_box_draw)),
      tabItem(tabName = "wordcloud_chart", fluidRow(wordcloud_box_upload, wordcloud_box_draw, wordcloud_box_table)),
      tabItem(tabName = "map_chart", fluidRow(map_box_upload, map_box_draw, map_box_table, map_box_table_example)),
      tabItem(tabName = "public_statement", fluidRow(public_statement_ui))
   )
)

ui <- dashboardPage(header = header, sidebar = sidebar, body = body, skin = "green")

# Wrap your UI with secure_app
# ui <- secure_app(ui)










