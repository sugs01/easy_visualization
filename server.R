# The max file size is 1 MB
options(shiny.maxRequestSize = .1 * 1024^2)
options(shiny.usecairo = FALSE)

# Build the server function
server <- function(input, output, session) {
   track_usage(storage_mode = store_json(path = "logs/"))
   # 
   # # 零、权限控制
   # # call the server part
   # # check_credentials returns a function to authenticate users
   # res_auth <- secure_server(
   #    check_credentials = check_credentials(credentials)
   # )
   # 
   # output$auth_output <- renderPrint({
   #    reactiveValuesToList(res_auth)
   # })

   ##################################################################################################################################################################
   ##################################################################################################################################################################
   # 零、商务风 ---------------------------------------------------------------------------------------------------------------------
   # 1.折线图
   #示例数据
   su_line <- reactive(read_csv("data/tmp_data/line.csv"))
   output$download_line <- download_file(su_line)
   
   # 上传数据
   line_df <- eventReactive(input$line_file, {
      req(input$line_file)
      if (is.null(input$line_file)) {return(NULL)}
      data <- read_files(input$line_file$datapath)
      return(data)
   })
   
   # 更新X/Y轴
   observeEvent(input$line_file, {
      updateSelectInput(session, "line_label", label = "X轴-横轴",  choices = names(line_df()), selected = NULL)
      updateSelectInput(session, "line_value", label = "Y轴-纵轴", choices = names(line_df()), selected = NULL)
      updateSelectInput(session, "line_group", label = "分组", choices = names(line_df()))
   })
   
   # 画图
   line_plot <- reactive({
      if (is.null(input$line_file)) {
         su_line() %>%
            ggplot(aes(x = date1, y = value, color = factor(group))) +
            geom_line(size = 1) +
            theme_my(input$line_theme) +
            scale_color_my(input$line_color) 
      } else if (is.factor(input$line_label) || is.character(input$line_label)) {
         line_df() %>%
            ggplot(aes_string(x = input$line_label, y = input$line_value, group = 1, color = input$line_group)) +
            geom_line(size = 1) +
            theme_my(input$line_theme) +
            scale_color_my(input$line_color)
      } else {
         line_df() %>%
            ggplot(aes_string(x = input$line_label, y = input$line_value, color = input$line_group)) +
            geom_line(size = 1) +
            theme_my(input$line_theme) +
            scale_color_my(input$line_color)
      }
   })
   
   output$line_chart <- renderPlot({
      line_plot()
   })
   
   output$download_line_plot <- download_plot(line_plot)
   
   # 选择展示样例数据还是用户数据
   datasetinput_line <- reactive({
      if (is.null(input$line_file)) return(su_line())
      return(line_df())
   })
   output$line_data_selected <- renderTable({
      datasetinput_line() %>% 
         head(input$line_data_selected_row)
   })

   beian_url <- a("浙ICP备2021006949号", href = "https://beian.miit.gov.cn")
   output$beian <- renderUI({
      tagList("", beian_url)
   })
   
   
   # 2.柱状图
   #示例数据
   su_bar <- reactive(read_csv("data/tmp_data/bar.csv"))
   output$download_bar <- download_file(su_bar)
   
   # 上传数据
   bar_df <- eventReactive(input$bar_file, {
      req(input$bar_file)
      if (is.null(input$bar_file)) {return(NULL)}
      data <- read_files(input$bar_file$datapath)
      return(data)
   })
   
   # 更新X/Y轴
   observeEvent(input$bar_file, {
      updateSelectInput(session, "bar_label", label = "X轴-横轴", choices = names(bar_df()))
      updateSelectInput(session, "bar_value", label = "Y轴-纵轴", choices = names(bar_df()))
      updateSelectInput(session, "bar_group", label = "分组", choices = names(bar_df()))
   })
   
   # 画图
   bar_plot <- reactive({
      if (is.null(input$bar_file)) {
         su_bar() %>%
            ggplot(aes(x = Month, y = PersonNo., fill = Class)) +
            geom_bar(stat = 'identity', position = input$bar_type) +
            theme_my(input$bar_theme) +
            scale_fill_my(input$bar_fill)
      } else {
         bar_df() %>%
            ggplot(aes_string(x = input$bar_label, y = input$bar_value, fill = input$bar_group)) +
            geom_bar(stat = 'identity', position = input$bar_type) +
            theme_my(input$bar_theme) +
            scale_fill_my(input$bar_fill)
      }
   })
   
   output$bar_chart <- renderPlot({
      bar_plot()
   })
   output$download_bar_plot <- download_plot(bar_plot)
   
   # 选择展示样例数据还是用户数据
   datasetinput_bar <- reactive({
      if (is.null(input$bar_file)) return(su_bar())
      return(bar_df())
   })
   output$bar_data_selected <- renderTable({
      datasetinput_bar() %>% 
         head(input$bar_data_selected_row)
   })
   
   # 3.面积图
   #示例数据
   su_area <- reactive(read_csv("data/tmp_data/area.csv"))
   output$download_area <- download_file(su_area)
   
   # 上传数据
   area_df <- eventReactive(input$area_file, {
      req(input$area_file)
      if (is.null(input$area_file)) {return(NULL)}
      data <- read_files(input$area_file$datapath)
      return(data)
   })
   
   # 更新X/Y轴
   observeEvent(input$area_file, {
      updateSelectInput(session, "area_label", label = "X轴-横轴", choices = names(area_df()))
      updateSelectInput(session, "area_value", label = "Y轴-纵轴", choices = names(area_df()))
      updateSelectInput(session, "area_group", label = "分组", choices = names(area_df()))
   })
   
   # 画图
   area_plot <- reactive({
      if (is.null(input$area_file)) {
         su_area() %>%
            ggplot(aes(x = label, y = n, fill = group)) +
            geom_area(alpha = .5) +
            theme_my(input$area_theme) +
            scale_fill_my(input$area_fill) 
      } else if (is.factor(input$label) || is.character(input$label)) {
         area_df() %>%
            ggplot(aes_string(x = input$area_label, y = input$area_value, group = 1, color = input$area_group)) +
            geom_area(alpha = .5) +
            theme_my(input$area_theme) +
            scale_fill_my(input$area_fill) 
      } else {
         area_df() %>%
            ggplot(aes_string(x = input$area_label, y = input$area_value, color = input$area_group)) +
            geom_area(alpha = .5) +
            theme_my(input$area_theme) +
            scale_fill_my(input$area_fill) 
      }
   })
   
   output$area_chart <- renderPlot({
      area_plot()
   })
   
   output$download_area_plot <- download_plot(area_plot)
   
   # 选择展示样例数据还是用户数据
   datasetinput_area <- reactive({
      if (is.null(input$area_file)) return(su_area())
      return(area_df())
   })
   output$area_data_selected <- renderTable({
      datasetinput_area() %>% 
         head(input$area_data_selected_row)
   })

   # 4.散点图
   #示例数据
   
   su_point <- reactive({dsamp %>% select(x, price, color, y) %>% rename(x = x, price = price, color = color, size = y)})
   output$download_point <- download_file(su_point)
   
   # 上传数据
   point_df <- eventReactive(input$point_file, {
      req(input$point_file)
      if (is.null(input$point_file)) {return(NULL)}
      data <- read_files(input$point_file$datapath)
      return(data)
   })
   
   # 更新X/Y轴
   observeEvent(input$point_file, {
      updateSelectInput(session, "point_label", label = "X轴-横轴", choices = names(point_df()))
      updateSelectInput(session, "point_value", label = "Y轴-纵轴", choices = names(point_df()))
      updateSelectInput(session, "point_group", label = "分组", choices = names(point_df()))
      updateSelectInput(session, "point_size", label = "散点大小", choices = names(point_df()))
   })
   
   # 画图
   point_plot <- reactive({
      if (is.null(input$point_file)) {
         su_point() %>%
            ggplot(aes(x = x, y = price, color = color, size = size)) +
            geom_point(alpha = .5) +
            theme_my(input$point_theme) +
            scale_fill_my(input$point_fill) +
            scale_color_my(input$point_fill)
      } else {
         point_df() %>%
            ggplot(aes_string(x = input$point_label, y = input$point_value, color = input$point_group, size = input$point_size)) +
            geom_point(alpha = .5) +
            theme_my(input$point_theme) +
            scale_fill_my(input$point_fill) +
            scale_color_my(input$point_fill)
      }
   })
   
   output$point_chart <- renderPlot({
      point_plot()
   })
   output$download_point_plot <- download_plot(point_plot)
   
   # 选择展示样例数据还是用户数据
   datasetinput_point <- reactive({
      if (is.null(input$point_file)) return(su_point())
      return(point_df())
   })
   output$point_data_selected <- renderTable({
      datasetinput_point() %>% 
         head(input$point_data_selected_row)
   })

   # 5.饼图
   #示例数据
   
   su_pie <- reactive({dsamp %>% count(cut)})
   output$download_pie <- download_file(su_pie)
   
   # 上传数据
   pie_df <- eventReactive(input$pie_file, {
      req(input$pie_file)
      if (is.null(input$pie_file)) {return(NULL)}
      data <- read_files(input$pie_file$datapath)
      return(data)
   })
   
   # 更新X/Y轴
   observeEvent(input$pie_file, {
      updateSelectInput(session, "pie_label", label = "饼标签", choices = names(pie_df()))
      updateSelectInput(session, "pie_value", label = "饼大小", choices = names(pie_df()))
      updateSelectInput(session, "pie_type", label = "饼类型", choices = names(pie_df()))
   })
   
   # 画图
   pie_plot <- reactive({
      if (is.null(input$pie_file)) {
         su_pie() %>%
            ggplot(aes(x = 1, y = n, fill = cut)) +
            geom_col() +
            coord_polar('y') + 
            theme_my(input$pie_theme) +
            scale_fill_my(input$pie_fill) +
            scale_color_my(input$pie_fill)
      } else {
         pie_df() %>%
            ggplot(aes_string(x = input$pie_type, y = input$pie_value, fill = input$pie_label)) +
            geom_col() +
            coord_polar('y') + 
            theme_my(input$pie_theme) +
            scale_fill_my(input$pie_fill) +
            scale_color_my(input$pie_fill)
      }
   })
   
   output$pie_chart <- renderPlot({
      pie_plot()
   })
   
   output$download_pie_plot <- download_plot(pie_plot)
   
   # 选择展示样例数据还是用户数据
   datasetinput_pie <- reactive({
      if (is.null(input$pie_file)) return(su_pie())
      return(pie_df())
   })
   output$pie_data_selected <- renderTable({
      datasetinput_pie() %>% 
         head(input$pie_data_selected_row)
   })
   
   
   # 6.箱线图
   #示例数据
   su_boxplot <- reactive({dsamp})
   output$download_boxplot <- download_file(su_boxplot)
   
   # 上传数据
   boxplot_df <- eventReactive(input$boxplot_file, {
      req(input$boxplot_file)
      if (is.null(input$boxplot_file)) {return(NULL)}
      data <- read_files(input$boxplot_file$datapath)
      return(data)
   })
   
   # 更新X/Y轴
   observeEvent(input$boxplot_file, {
      updateSelectInput(session, "boxplot_label", label = "X轴-横轴", choices = names(boxplot_df()))
      updateSelectInput(session, "boxplot_value", label = "Y轴-纵轴", choices = names(boxplot_df()))
   })
   
   # 画图
   boxplot_plot <- reactive({
      if (is.null(input$boxplot_file)) {
         su_boxplot() %>%
            ggplot(aes_string(x = input$boxplot_label, y = input$boxplot_value, fill = input$boxplot_label, color = input$boxplot_label)) +
            geom_boxplot(alpha = .5) +
            theme_my(input$boxplot_theme) +
            scale_fill_my(input$boxplot_fill)
      } else {
         boxplot_df() %>%
            ggplot(aes_string(x = input$boxplot_label, y = input$boxplot_value, fill = input$boxplot_label, color = input$boxplot_label)) +
            geom_boxplot(alpha = .5) +
            theme_my(input$boxplot_theme) +
            scale_fill_my(input$boxplot_fill)
      }
   })
   
   output$boxplot_chart <- renderPlot({
      boxplot_plot()
   })
   
   output$download_boxplot_plot <- download_plot(boxplot_plot)
   
   # 选择展示样例数据还是用户数据
   datasetinput_boxplot <- reactive({
      if (is.null(input$boxplot_file)) return(su_boxplot())
      return(boxplot_df())
   })
   output$boxplot_data_selected <- renderTable({
      datasetinput_boxplot() %>% 
         head(input$boxplot_data_selected_row)
   })
   
   # 7.小提琴图
   #示例数据
   su_violin <- reactive({dsamp})
   output$download_violin <- download_file(su_violin)
   
   # 上传数据
   violin_df <- eventReactive(input$violin_file, {
      req(input$violin_file)
      if (is.null(input$violin_file)) {return(NULL)}
      data <- read_files(input$violin_file$datapath)
      return(data)
   })
   
   # 更新X/Y轴
   observeEvent(input$violin_file, {
      updateSelectInput(session, "violin_label", label = "X轴-横轴", choices = names(violin_df()))
      updateSelectInput(session, "violin_value", label = "Y轴-纵轴", choices = names(violin_df()))
   })
   
   # 画图
   violin_plot <- reactive({
      if (is.null(input$violin_file)) {
         su_violin() %>%
            ggplot(aes_string(x = input$violin_label, y = input$violin_value, fill = input$violin_label, color = input$violin_label)) +
            geom_violin(alpha = .5) +
            theme_my(input$violin_theme) +
            scale_fill_my(input$violin_fill)
      } else {
         violin_df() %>%
            ggplot(aes_string(x = input$violin_label, y = input$violin_value, fill = input$violin_label, color = input$violin_label)) +
            geom_violin(alpha = .5) +
            theme_my(input$violin_theme) +
            scale_fill_my(input$violin_fill)
      }
   })
   
   output$violin_chart <- renderPlot({
      violin_plot()
   })
   
   output$download_violin_plot <- download_plot(violin_plot)
   
   # 选择展示样例数据还是用户数据
   datasetinput_violin <- reactive({
      if (is.null(input$violin_file)) return(su_violin())
      return(violin_df())
   })
   output$violin_data_selected <- renderTable({
      datasetinput_violin() %>% 
         head(input$violin_data_selected_row)
   })
   
   
   
   
   
   # 一、Map Chart ---------------------------------------------------------------------------------------------------------------------
   # Vedio URL
   map_url <- a("Map Chart Vedio", href = "https://www.bilibili.com/video/BV1sK4y1577J/")
   output$map_tab <- renderUI({
      tagList("URL Link: ", map_url)
   })
   
   # 示例数据
   su_map_china <- reactive(read_csv("data/tmp_data/map_china.csv"))
   su_map_henan <- reactive(read_csv("data/tmp_data/map_henan.csv"))
   su_map_zhengzhou <- reactive(read_csv("data/tmp_data/map_henan_zhengzhou.csv"))
   su_map_japan <- reactive(read_csv("data/tmp_data/map_japan.csv"))
   
   output$download_china <- download_file(su_map_china)
   output$download_province <- download_file(su_map_henan)
   output$download_town <- download_file(su_map_zhengzhou)
   output$download_other_country <- download_file(su_map_japan)
   # Data
   map_df <- eventReactive(input$map_file, {
      req(input$map_file)
      if (is.null(input$map_file)) {return(NULL)}
      data <- read_files(input$map_file$datapath)
      return(data)
   })
   
   # 1.Map of China--------------
   
   
   # update Line Axis
   observeEvent(input$map_file, {
      updateSelectInput(session, "map_area_adress", label = "省/市/区（县）", choices = names(map_df()))
      updateSelectInput(session, "map_value", label = "数值", choices = names(map_df()))
   }) 
   
   
   # map_name Turn adcode
   geo_json <- eventReactive(input$map_button, {
      tmp_map_adcode <- map_adcode %>% filter(name_cn == input$map_area)
      tmp_map_adcode_vector <- tmp_map_adcode$adcode
      url <- paste0("https://geo.datav.aliyun.com/areas_v2/bound/", tmp_map_adcode_vector, "_full.json")
      tmp_geo_json <- jsonlite::read_json(path = url)
   })
   
   # 数据大小对应地图颜色选择
   map_color_of_min_value <- eventReactive(input$map_color_of_min_value, {
      tmp1_map_color_selected_min <- chart_color %>% 
         filter(English == input$map_color_of_min_value)
      tmp2_map_color_selected_min <- tmp1_map_color_selected_min$color_code
      return(tmp2_map_color_selected_min)
   })
   map_color_of_max_value <- eventReactive(input$map_color_of_max_value, {
      tmp1_map_color_selected_max <- chart_color %>% 
         filter(English == input$map_color_of_max_value)
      tmp2_map_color_selected_max <- tmp1_map_color_selected_max$color_code
      return(tmp2_map_color_selected_max)
   })

   
   # Draw Map
   map_plot <- reactive({
      req(map_df)
      req(input$map_area)
      req(input$map_area_adress)
      req(input$map_value)
      req(geo_json)
      tmp_plot <- if (is.null(map_df())) {
         return(NULL)
      } else {
         map_df() %>%
            e_charts_(input$map_area_adress) %>% 
            e_map_register(name = input$map_area, json = geo_json()) %>%
            e_map_(
               serie = input$map_value,
               map = input$map_area
            ) %>%
            e_visual_map_(
               serie = input$map_value, 
               type = input$map_visual_type,
               # text = list('High', 'Low'),
               inRange = list(color = list(map_color_of_min_value(), map_color_of_max_value()))
            ) %>%
            # e_labels(show = input$is_show_label, fontSize = input$map_label_fontsize) %>%
            e_title(text = input$map_title, subtext = input$map_sub_title) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      }
      return(tmp_plot)
   })
   
   # Output Map Chart
   output$map_chart <- renderEcharts4r({
      map_plot()
   })
   
   # 2.Map of World--------------
   # update Line Axis
   observeEvent(input$map_file, {
      updateSelectInput(session, "world_map_country", label = "China/Province/City", choices = names(map_df()))
      updateSelectInput(session, "world_map_value", label = "Value", choices = names(map_df()))
   }) 
   
   # 数据大小对应地图颜色选择
   world_map_color_of_min_value <- eventReactive(input$world_map_color_of_min_value, {
      tmp1_world_map_color_selected_min <- chart_color %>% 
         filter(English == input$world_map_color_of_min_value)
      tmp2_world_map_color_selected_min <- tmp1_world_map_color_selected_min$color_code
      return(tmp2_world_map_color_selected_min)
   })
   world_map_color_of_max_value <- eventReactive(input$world_map_color_of_max_value, {
      tmp1_world_map_color_selected_max <- chart_color %>% 
         filter(English == input$world_map_color_of_max_value)
      tmp2_world_map_color_selected_max <- tmp1_world_map_color_selected_max$color_code
      return(tmp2_world_map_color_selected_max)
   })
   
   # Draw Map
   world_map_plot <- reactive({
      req(map_df)
      req(input$world_map_area)
      req(input$world_map_country)
      req(input$world_map_value)
      req(geo_json)
      tmp_world_plot <- if (is.null(map_df())) {
         return(NULL)
      } else {
         map_df() %>%
            e_charts_(input$world_map_country) %>% 
            em_map(map = input$world_map_area) %>%
            e_map_(
               serie = input$world_map_value,
               map = input$world_map_area
            ) %>%
            e_visual_map_(
               serie = input$world_map_value, 
               type = input$world_map_visual_type,
               # text = list('High', 'Low'),
               inRange = list(color = list(world_map_color_of_min_value(), world_map_color_of_max_value()))
            ) %>%
            # e_labels(show = input$world_is_show_label, fontSize = input$world_map_label_fontsize) %>%
            e_title(text = input$world_map_title, subtext = input$world_map_sub_title) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      }
      return(tmp_world_plot)
   })
   
   # Output Map Chart
   output$world_map_chart <- renderEcharts4r({
      world_map_plot()
   })
   
   # Map Data
   output$map_data_selected <- renderTable({
      map_df() %>%
         head(input$map_data_selected_row)
   })
   
   # 示例数据
   output$map_data_example_china <- renderTable({su_map_china()})
   output$map_data_example_henan <- renderTable({su_map_henan()})
   output$map_data_example_zhengzhou <- renderTable({su_map_zhengzhou()})
   output$map_data_example_japan <- renderTable({su_map_japan()})
   
   # # 3.Map of Only World--------------
   # # update Line Axis
   # observeEvent(input$map_file, {
   #    updateSelectInput(session, "only_world_map_country", label = "Countries", choices = names(map_df()))
   #    updateSelectInput(session, "only_world_map_value", label = "Value", choices = names(map_df()))
   # }) 
   # 
   # # 数据大小对应地图颜色选择
   # only_world_map_color_of_min_value <- eventReactive(input$only_world_map_color_of_min_value, {
   #    tmp1_only_world_map_color_selected_min <- chart_color %>% 
   #       filter(English == input$only_world_map_color_of_min_value)
   #    tmp2_only_world_map_color_selected_min <- tmp1_only_world_map_color_selected_min$color_code
   #    return(tmp2_only_world_map_color_selected_min)
   # })
   # only_world_map_color_of_max_value <- eventReactive(input$only_world_map_color_of_max_value, {
   #    tmp1_only_world_map_color_selected_max <- chart_color %>% 
   #       filter(English == input$only_world_map_color_of_max_value)
   #    tmp2_only_world_map_color_selected_max <- tmp1_only_world_map_color_selected_max$color_code
   #    return(tmp2_only_world_map_color_selected_max)
   # })
   # 
   # # Draw Map
   # only_world_map_plot <- reactive({
   #    req(map_df)
   #    req(input$only_world_map_country)
   #    req(input$only_world_map_value)
   #    req(geo_json)
   #    tmp_only_world_plot <- if (is.null(map_df())) {
   #       return(NULL)
   #    } else {
   #       map_df() %>%
   #          e_charts_(input$only_world_map_country) %>% 
   #          e_map_(
   #             serie = input$only_world_map_value,
   #             map = 'world'
   #          ) %>%
   #          e_visual_map_(
   #             serie = input$only_world_map_value, 
   #             type = input$only_world_map_visual_type, 
   #             # text = list('High', 'Low'),
   #             inRange = list(color = list(only_world_map_color_of_min_value(), only_world_map_color_of_max_value()))
   #          ) %>%
   #          # e_labels(show = input$only_world_is_show_label, fontSize = input$only_world_map_label_fontsize) %>%
   #          e_title(text = input$only_world_map_title, subtext = input$only_world_map_sub_title) %>%
   #          e_toolbox() %>%
   #          e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
   #    }
   #    return(tmp_only_world_plot)
   # })
   # 
   # # Output Map Chart
   # output$only_world_map_chart <- renderEcharts4r({
   #    only_world_map_plot()
   # })
   
   # 二、candle Chart ---------------------------------------------------------------------------------------------------------------------
   
   # # Vedio URL
   # candle_url <- a("candle Chart Vedio", href = "https://www.bilibili.com/video/BV13t4y1r7Sk/")
   # output$candle_tab <- renderUI({
   #    tagList("URL Link: ", candle_url)
   # })
   
   # 示例数据
   su_candle <- reactive(read_csv("data/tmp_data/candle.csv"))
   output$download_candel <- download_file(su_candle)
   
   # Data
   candle_df <- eventReactive(input$candle_file, {
      req(input$candle_file)
      if (is.null(input$candle_file)) {return(NULL)}
      data <- read_files(input$candle_file$datapath)
      return(data)
   })
   
   # update candle Axis
   observeEvent(input$candle_file, {
      updateSelectInput(session, "candle_date", label = "日期", choices = names(candle_df()))
      updateSelectInput(session, "candle_opening", label = "开盘价", choices = names(candle_df()))
      updateSelectInput(session, "candle_closing", label = "收盘价", choices = names(candle_df()))
      updateSelectInput(session, "candle_high", label = "最高价", choices = names(candle_df()))
      updateSelectInput(session, "candle_low", label = "最小价", choices = names(candle_df()))
   }) 
   
   # draw chart
   candle_plot <- reactive({
      # req(candle_df)
      # req(input$candle_date)
      # req(input$candle_opening)
      # req(input$candle_closing)
      # req(input$candle_high)
      # req(input$candle_low)
      tmp_plot <- if (is.null(input$candle_file)) {
         su_candle() %>%
            e_charts(`日期`) %>% 
            e_candle(`开盘价`, `收盘价`, `最高价`, `最低价`) %>%
            e_y_axis(
               min = input$candle_y_axis_min, 
               max = input$candle_y_axis_max
            ) %>%
            e_title(text = input$candle_title, subtext = input$candle_sub_title, width = "400px") %>%
            e_datazoom() %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      } else {
         candle_df() %>%
            e_charts_(input$candle_date) %>% 
            e_candle_(input$candle_opening, input$candle_closing, input$candle_high, input$candle_low) %>%
            e_y_axis(
               min = input$candle_y_axis_min, 
               max = input$candle_y_axis_max
            ) %>%
            e_title(text = input$candle_title, subtext = input$candle_sub_title, width = "400px") %>%
            e_datazoom() %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      }
      return(tmp_plot)
   })
   # candle Chart
   output$candle_chart <- renderEcharts4r({
      candle_plot()
   })

   # 选择展示样例数据还是用户数据
   datasetinput_candle <- reactive({
      if (is.null(input$candle_file)) return(su_candle()) 
      return(candle_df())
   })
   
   # candle Data
   output$candle_data_selected <- renderTable({
      datasetinput_candle() %>%
         head(input$candle_data_selected_row)
   })
   
   
   # 三、funnel Chart ---------------------------------------------------------------------------------------------------------------------
   # # Vedio URL
   # funnel_url <- a("funnel Chart Vedio", href = "https://www.bilibili.com/video/BV13t4y1r7Sk/")
   # output$funnel_tab <- renderUI({
   #    tagList("URL Link: ", funnel_url)
   # })

   # 示例数据
   su_funnel <- reactive(read_csv("data/tmp_data/funnel.csv"))
   output$download_funnel <- download_file(su_funnel)
   
   # Data
   funnel_df <- eventReactive(input$funnel_file, {
      req(input$funnel_file)
      if (is.null(input$funnel_file)) {return(NULL)}
      data <- read_files(input$funnel_file$datapath)
      return(data)
   })
   
   # update funnel Axis
   observeEvent(input$funnel_file, {
      updateSelectInput(session, "funnel_label", label = "漏斗标签", choices = names(funnel_df()))
      updateSelectInput(session, "funnel_value", label = "漏斗数值", choices = names(funnel_df()))
   }) 
   
   # draw chart
   funnel_plot <- reactive({
      # req(funnel_df)
      # req(input$funnel_label)
      # req(input$funnel_value)
      tmp_plot <- if (is.null(input$funnel_file)) {
         su_funnel() %>%
            e_charts() %>% 
            e_funnel(values = values, labels = labels, legend = TRUE, sort = input$funnel_sort, orient = input$funnel_orient, gap = input$funnel_gap) %>%
            e_title(text = input$funnel_title, subtext = input$funnel_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross')
            ) %>% 
            e_theme(name = input$funnel_theme) %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      } else {
         funnel_df() %>%
            e_charts_() %>% 
            e_funnel_(values = input$funnel_value, labels = input$funnel_label, legend = TRUE, sort = input$funnel_sort, orient = input$funnel_orient, gap = input$funnel_gap) %>%
            e_title(text = input$funnel_title, subtext = input$funnel_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross')
            ) %>% 
            e_theme(name = input$funnel_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      }
      return(tmp_plot)
   })
   # funnel Chart
   output$funnel_chart <- renderEcharts4r({
      funnel_plot()
   })
   
   # 选择展示样例数据还是用户数据
   datasetinput_funnel <- reactive({
      if (is.null(input$funnel_file)) return(su_funnel()) 
      return(funnel_df())
   })
   
   # funnel Data
   output$funnel_data_selected <- renderTable({
      datasetinput_funnel() %>%
         head(input$funnel_data_selected_row)
   })
   
   
   # 四、sankey Chart ---------------------------------------------------------------------------------------------------------------------
   # # Vedio URL
   # sankey_url <- a("sankey Chart Vedio", href = "https://www.bilibili.com/video/BV13t4y1r7Sk/")
   # output$sankey_tab <- renderUI({
   #    tagList("URL Link: ", sankey_url)
   # })
   # 示例数据
   su_sankey <- reactive(read_csv("data/tmp_data/sankey.csv"))
   output$download_sankey <- download_file(su_sankey)
   
   # Data
   sankey_df <- eventReactive(input$sankey_file, {
      req(input$sankey_file)
      if (is.null(input$sankey_file)) {return(NULL)}
      data <- read_files(input$sankey_file$datapath)
      return(data)
   })
   
   # update sankey Axis
   observeEvent(input$sankey_file, {
      updateSelectInput(session, "sankey_source", label = "起点", choices = names(sankey_df()))
      updateSelectInput(session, "sankey_target", label = "终点", choices = names(sankey_df()))
      updateSelectInput(session, "sankey_value", label = "值", choices = names(sankey_df()))
   }) 
   
   # draw chart
   sankey_plot <- reactive({
      # req(sankey_df)
      # req(input$sankey_source)
      # req(input$sankey_target)
      # req(input$sankey_value)
      tmp_plot <- if (is.null(input$sankey_file)) {
         su_sankey() %>%
            e_charts() %>% 
            e_sankey(source = `起点`, target = `终点`, value = `流水量`) %>%
            e_title(text = input$sankey_title, subtext = input$sankey_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross')
            ) %>% 
            e_theme(name = input$sankey_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      } else {
         sankey_df() %>%
            e_charts_() %>% 
            e_sankey_(source = input$sankey_source, target = input$sankey_target, value = input$sankey_value) %>%
            e_title(text = input$sankey_title, subtext = input$sankey_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross')
            ) %>% 
            e_theme(name = input$sankey_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      }
      return(tmp_plot)
   })
   # sankey Chart
   output$sankey_chart <- renderEcharts4r({
      sankey_plot()
   })
   
   # 选择展示样例数据还是用户数据
   datasetinput_sankey <- reactive({
      if (is.null(input$sankey_file)) return(su_sankey()) 
      return(sankey_df())
   })
   
   # sankey Data
   output$sankey_data_selected <- renderTable({
      datasetinput_sankey() %>%
         head(input$sankey_data_selected_row)
   })
   
   
   # 五、heatmap Chart ---------------------------------------------------------------------------------------------------------------------
   # # Vedio URL
   # heatmap_2d_url <- a("heatmap Chart Vedio", href = "https://www.bilibili.com/video/BV13t4y1r7Sk/")
   # output$heatmap_2d_tab <- renderUI({
   #    tagList("URL Link: ", heatmap_2d_url)
   # })
   
   # 示例数据
   su_heatmap <- reactive(read_csv("data/tmp_data/heatmap.csv"))
   output$download_heatmap <- download_file(su_heatmap)
   
   # Data
   heatmap_2d_df <- eventReactive(input$heatmap_2d_file, {
      req(input$heatmap_2d_file)
      if (is.null(input$heatmap_2d_file)) {return(NULL)}
      data <- read_files(input$heatmap_2d_file$datapath)
      return(data)
   })
   
   # update heatmap Axis
   observeEvent(input$heatmap_2d_file, {
      updateSelectInput(session, "heatmap_2d_x", label = "X轴-横轴", choices = names(heatmap_2d_df()))
      updateSelectInput(session, "heatmap_2d_y", label = "Y轴-纵轴", choices = names(heatmap_2d_df()))
      updateSelectInput(session, "heatmap_2d_z", label = "值", choices = names(heatmap_2d_df()))
      updateSelectInput(session, "scroll_heatmap_2d_x", label = "X轴-横轴", choices = names(heatmap_2d_df()))
      updateSelectInput(session, "scroll_heatmap_2d_y", label = "Y轴-纵轴", choices = names(heatmap_2d_df()))
      updateSelectInput(session, "scroll_heatmap_2d_z", label = "值", choices = names(heatmap_2d_df()))
      updateSelectInput(session, "scroll_heatmap_2d_group", label = "滚动轴", choices = names(heatmap_2d_df()))
   }) 
   
   # draw chart
   heatmap_2d_plot <- reactive({
      # req(heatmap_2d_df)
      # req(input$heatmap_2d_x)
      # req(input$heatmap_2d_y)
      # req(input$heatmap_2d_z)
      tmp_plot <- if (is.null(input$heatmap_2d_file)) {
         su_heatmap() %>%
            e_charts(x = `职业`) %>% 
            e_heatmap(y = `年龄`, z = `工资`, label = list(show = TRUE)) %>%
            e_visual_map(serie = `工资`) %>%
            e_title(text = input$heatmap_2d_title, subtext = input$heatmap_2d_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross')
            ) %>% 
            e_theme(name = input$heatmap_2d_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      } else {
         heatmap_2d_df() %>%
            e_charts_(x = input$heatmap_2d_x) %>% 
            e_heatmap_(y = input$heatmap_2d_y, z = input$heatmap_2d_z, label = list(show = TRUE)) %>%
            e_visual_map_(serie = input$heatmap_2d_z) %>%
            e_title(text = input$heatmap_2d_title, subtext = input$heatmap_2d_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross')
            ) %>% 
            e_theme(name = input$heatmap_2d_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      }
      return(tmp_plot)
   })
   # heatmap Chart
   output$heatmap_2d_chart <- renderEcharts4r({
      heatmap_2d_plot()
   })
   
   # # draw chart - 滚动
   # scroll_heatmap_2d_plot <- reactive({
   #    req(heatmap_2d_df)
   #    req(input$scroll_heatmap_2d_x)
   #    req(input$scroll_heatmap_2d_y)
   #    req(input$scroll_heatmap_2d_z)
   #    req(input$scroll_heatmap_2d_group)
   #    scroll_tmp_plot <- if (is.null(heatmap_2d_df())) {
   #       return(NULL)
   #    } else {
   #       heatmap_2d_df() %>%
   #          group_by_(input$scroll_heatmap_2d_group) %>%
   #          e_charts_(x = input$scroll_heatmap_2d_x, timeline = TRUE) %>% 
   #          e_heatmap_(y = input$scroll_heatmap_2d_y, z = input$scroll_heatmap_2d_z, label = list(show = TRUE), name = c(input$scroll_heatmap_2d_y, input$scroll_heatmap_2d_z)) %>%
   #          e_visual_map_(serie = input$scroll_heatmap_2d_z) %>%
   #          e_title(text = input$scroll_heatmap_2d_title, subtext = input$scroll_heatmap_2d_sub_title, width = "400px") %>%
   #          e_tooltip(
   #             axisPointer = list(type = 'cross')
   #          ) %>% 
   #          e_theme(name = input$scroll_heatmap_2d_theme) %>%
   #          e_toolbox() %>%
   #          e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
   #    }
   #    return(scroll_tmp_plot)
   # })
   # # heatmap Chart - 滚动
   # output$scroll_heatmap_2d_chart <- renderEcharts4r({
   #    scroll_heatmap_2d_plot()
   # })
   
   # 选择展示样例数据还是用户数据
   datasetinput_heatmap <- reactive({
      if (is.null(input$heatmap_file)) return(su_heatmap()) 
      return(heatmap_2d_df())
   })
   
   # heatmap Data
   output$heatmap_2d_data_selected <- renderTable({
      datasetinput_heatmap() %>%
         head(input$heatmap_2d_data_selected_row)
   })
   
   
   # 六、parallel Chart ---------------------------------------------------------------------------------------------------------------------
   # # Vedio URL
   # parallel_url <- a("parallel Chart Vedio", href = "https://www.bilibili.com/video/BV13t4y1r7Sk/")
   # output$parallel_tab <- renderUI({
   #    tagList("URL Link: ", parallel_url)
   # })
   # 示例数据
   su_parallel <- reactive(read_csv("data/tmp_data/parallel.csv"))
   su_parallel_colnames <- reactive(colnames(su_parallel()))
   output$download_parallel <- download_file(su_parallel)
   
   # Data
   parallel_df <- eventReactive(input$parallel_file, {
      req(input$parallel_file)
      if (is.null(input$parallel_file)) {return(NULL)}
      data <- read_files(input$parallel_file$datapath)
      return(data)
   })
   
   # 列名
   parallel_colnames <- reactive({
      req(parallel_df)
      tmp_parallel_colnames <- colnames(parallel_df())
      return(tmp_parallel_colnames)
   })
   
   # draw chart
   parallel_plot <- reactive({
      # req(parallel_df)
      # req(parallel_colnames)
      tmp_plot <- if (is.null(input$parallel_file)) {
         su_parallel() %>%
            e_charts() %>% 
            e_parallel(su_parallel_colnames()) %>%
            e_title(text = input$parallel_title, subtext = input$parallel_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross')
            ) %>% 
            # e_theme(name = input$parallel_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      } else {
         parallel_df() %>%
            e_charts_() %>% 
            e_parallel_(parallel_colnames()) %>%
            e_title(text = input$parallel_title, subtext = input$parallel_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross')
            ) %>% 
            # e_theme(name = input$parallel_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      }
      return(tmp_plot)
   })
   # parallel Chart
   output$parallel_chart <- renderEcharts4r({
      parallel_plot()
   })
   
   # 选择展示样例数据还是用户数据
   datasetinput_parallel <- reactive({
      if (is.null(input$parallel_file)) return(su_parallel()) 
      return(parallel_df())
   })
   
   # parallel Data
   output$parallel_data_selected <- renderTable({
      datasetinput_parallel() %>%
         head(input$parallel_data_selected_row)
   })

   
   # 七、rosetype Chart ---------------------------------------------------------------------------------------------------------------------
   # # Vedio URL
   # rosetype_url <- a("rosetype Chart Vedio", href = "https://www.bilibili.com/video/BV13t4y1r7Sk/")
   # output$rosetype_tab <- renderUI({
   #    tagList("URL Link: ", rosetype_url)
   # })
   # 示例数据
   su_rosetype <- reactive(read_csv("data/tmp_data/rosetype.csv"))
   output$download_rosetype <- download_file(su_rosetype)
   
   # Data
   rosetype_df <- eventReactive(input$rosetype_file, {
      req(input$rosetype_file)
      if (is.null(input$rosetype_file)) {return(NULL)}
      data <- read_files(input$rosetype_file$datapath)
      return(data)
   })
   
   # update heatmap Axis
   observeEvent(input$rosetype_file, {
      updateSelectInput(session, "rosetype_x", label = "类别", choices = names(rosetype_df()))
      updateSelectInput(session, "rosetype_y", label = "数值", choices = names(rosetype_df()))
   }) 
   
   # draw chart
   rosetype_plot <- reactive({
      # req(rosetype_df)
      # req(input$rosetype_x)
      # req(input$rosetype_y)
      # req(input$rosetype_type)
      tmp_plot <- if (is.null(input$rosetype_file)) {
         su_rosetype() %>%
            e_charts(`类别`) %>% 
            e_pie(serie = `数值`, roseType = input$rosetype_type, legend = FALSE, label = list(show = TRUE)) %>%
            e_title(text = input$rosetype_title, subtext = input$rosetype_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross')
            ) %>% 
            e_theme(name = input$rosetype_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      } else {
         rosetype_df() %>%
            e_charts_(input$rosetype_x) %>% 
            e_pie_(serie = input$rosetype_y, roseType = input$rosetype_type, legend = FALSE, label = list(show = TRUE)) %>%
            e_title(text = input$rosetype_title, subtext = input$rosetype_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross')
            ) %>% 
            e_theme(name = input$rosetype_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      }
      return(tmp_plot)
   })
   # rosetype Chart
   output$rosetype_chart <- renderEcharts4r({
      rosetype_plot()
   })
   
   # 选择展示样例数据还是用户数据
   datasetinput_rosetype <- reactive({
      if (is.null(input$rosetype_file)) return(su_rosetype()) 
      return(rosetype_df())
   })
   
   # rosetype Data
   output$rosetype_data_selected <- renderTable({
      datasetinput_rosetype() %>%
         head(input$rosetype_data_selected_row)
   })
   
   
   # 八、river Chart ---------------------------------------------------------------------------------------------------------------------
   # # Vedio URL
   # river_url <- a("river Chart Vedio", href = "https://www.bilibili.com/video/BV13t4y1r7Sk/")
   # output$river_tab <- renderUI({
   #    tagList("URL Link: ", river_url)
   # })
   # 示例数据
   su_river <- reactive(read_csv("data/tmp_data/river.csv"))
   output$download_river <- download_file(su_river)
   
   # Data
   river_df <- eventReactive(input$river_file, {
      req(input$river_file)
      if (is.null(input$river_file)) {return(NULL)}
      data <- read_files(input$river_file$datapath)
      return(data)
   })
   
   # update heatmap Axis
   observeEvent(input$river_file, {
      updateSelectInput(session, "river_x", label = "X轴-横轴", choices = names(river_df()))
      updateSelectInput(session, "river_y", label = "数值", choices = names(river_df()))
      updateSelectInput(session, "river_type", label = "流水类别", choices = names(river_df()))
   }) 
   
   # draw chart
   river_plot <- reactive({
      # req(river_df)
      # req(input$river_x)
      # req(input$river_y)
      # req(input$river_type)
      tmp_plot <- if (is.null(input$river_file)) {
         su_river() %>%
            group_by(`水果`) %>%
            e_charts(`日期`) %>% 
            e_river(serie = `价格`, label = list(show = TRUE, fontSize = 12)) %>%
            e_title(text = input$river_title, subtext = input$river_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross'),
               trigger = 'axis'
            ) %>% 
            e_theme(name = input$river_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      } else {
         river_df() %>%
            group_by_(input$river_type) %>%
            e_charts_(input$river_x) %>% 
            e_river_(serie = input$river_y, label = list(show = TRUE, fontSize = 12)) %>%
            e_title(text = input$river_title, subtext = input$river_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross'),
               trigger = 'axis'
            ) %>% 
            e_theme(name = input$river_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      }
      return(tmp_plot)
   })
   # river Chart
   output$river_chart <- renderEcharts4r({
      river_plot()
   })
   
   # 选择展示样例数据还是用户数据
   datasetinput_river <- reactive({
      if (is.null(input$river_file)) return(su_river()) 
      return(river_df())
   })
   # river Data
   output$river_data_selected <- renderTable({
      datasetinput_river() %>%
         head(input$river_data_selected_row)
   })
   
   # 九、gauge Chart ---------------------------------------------------------------------------------------------------------------------
   # # Vedio URL
   # gauge_url <- a("gauge Chart Vedio", href = "https://www.bilibili.com/video/BV13t4y1r7Sk/")
   # output$gauge_tab <- renderUI({
   #    tagList("URL Link: ", gauge_url)
   # })
   # draw chart
   gauge_plot <- reactive({
      req(input$gauge_value)
      req(input$gauge_name)
      req(input$gauge_min)
      req(input$gauge_max)
      req(input$gauge_splitnumber)
      tmp_plot <- 
         e_charts_() %>% 
         e_gauge(
            value = as.numeric(input$gauge_value),
            name = input$gauge_name,
            min = input$gauge_min,
            max = input$gauge_max, 
            splitNumber = input$gauge_splitnumber
         ) %>%
         e_title(text = input$gauge_title, subtext = input$gauge_sub_title) %>%
         e_theme(name = input$gauge_theme) %>%
         e_toolbox() %>%
         e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      return(tmp_plot)
})
   # gauge Chart
   output$gauge_chart <- renderEcharts4r({
      gauge_plot()
   })
   
   
   # 十、wordcloud Chart ---------------------------------------------------------------------------------------------------------------------
   # # Vedio URL
   # wordcloud_url <- a("wordcloud Chart Vedio", href = "https://www.bilibili.com/video/BV13t4y1r7Sk/")
   # output$wordcloud_tab <- renderUI({
   #    tagList("URL Link: ", wordcloud_url)
   # })

   # 示例数据
   su_wordcloud <- reactive(read_csv("data/tmp_data/wordcloud.csv"))
   output$download_wordcloud <- download_file(su_wordcloud)
   
   # Data
   wordcloud_df <- eventReactive(input$wordcloud_file, {
      req(input$wordcloud_file)
      if (is.null(input$wordcloud_file)) {return(NULL)}
      data <- read_files(input$wordcloud_file$datapath)
      return(data)
   })
   
   
   wordcloud_shape_eng <- eventReactive(input$wordcloud_shape, {
      tmp1_wordcloud_shape_eng <- word_shape %>% filter(shape_cn == input$wordcloud_shape)
      tmp2_wordcloud_shape_eng <- tmp1_wordcloud_shape_eng$shape_eng
      return(tmp2_wordcloud_shape_eng)
   })
   # update heatmap Axis
   observeEvent(input$wordcloud_file, {
      updateSelectInput(session, "wordcloud_terms", label = "词", choices = names(wordcloud_df()))
      updateSelectInput(session, "wordcloud_freq", label = "数值", choices = names(wordcloud_df()))
   }) 
   
   # draw chart
   wordcloud_plot <- reactive({
      tmp_plot <- if (is.null(input$wordcloud_file)) {
         su_wordcloud() %>%
            e_charts() %>% 
            e_cloud(word = wordcn, freq = hotcn, sizeRange = c(input$wordcloud_sizerange_min, input$wordcloud_sizerange_max), shape = wordcloud_shape_eng()) %>%
            e_title(text = input$wordcloud_title, subtext = input$wordcloud_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross'),
               trigger = 'axis'
            ) %>% 
            e_theme(name = input$wordcloud_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      } else {
         wordcloud_df() %>%
            e_charts_() %>% 
            e_cloud_(word = input$wordcloud_terms, freq = input$wordcloud_freq, sizeRange = c(input$wordcloud_sizerange_min, input$wordcloud_sizerange_max), shape = wordcloud_shape_eng()) %>%
            e_title(text = input$wordcloud_title, subtext = input$wordcloud_sub_title, width = "400px") %>%
            e_tooltip(
               axisPointer = list(type = 'cross'),
               trigger = 'axis'
            ) %>% 
            e_theme(name = input$wordcloud_theme) %>%
            e_toolbox() %>%
            e_toolbox_feature(feature = 'saveAsImage') #adds all the features by default
      }
      return(tmp_plot)
   })


   # wordcloud Chart
   output$wordcloud_chart <- renderEcharts4r({
      wordcloud_plot()
   })
   
   
   # 选择展示样例数据还是用户数据
   datasetinput_wordcloud <- reactive({
      if (is.null(input$wordcloud_file)) return(su_wordcloud()) 
      return(wordcloud_df())
   })
   # wordcloud Data
   output$wordcloud_data_selected <- renderTable({
      datasetinput_wordcloud() %>%
         head(input$wordcloud_data_selected_row)
   })
   
   
      
   
}










