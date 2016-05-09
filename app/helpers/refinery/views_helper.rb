module Refinery
  module ViewsHelper
             
    # Style classes used in views/refinery/breads/breads/index.html.erb  
    # See the style applied in /app/assets/stylesheets/foundation_and_overrides.scss 
    def foundation_styles
      [
        "fade-in", 
        #"slide-in-left", 
        #"fade-in-new-background"
      ]
    end

    # Animated classes from animate.css used in views/refinery/breads/breads/index.html.erb  
    def animated_animations
      [
        "fadeInLeftBig", 
        "fadeInUpBig", 
        "fadeInRightBig"
      ]
    end

    # In order to display properly all breads/news in my view, 
    # I need to add empty columns if the number 
    # of breads/news is not a divisor of 3, therefore all of those functions
    # defined here and used in views/refinery/breads/breads/index.html.erb 
    # and in views/refinery/news/items/index.html.erb 
    def number_of_slices_of_three(elements)
      elements.count / 3.0
    end

    def number_of_slices_of_two(elements)
      elements.count / 2.0
    end

    def last_slice_of_three(elements)
      number_of_slices_of_three(elements).ceil
    end

    def last_slice_of_two(elements)
      number_of_slices_of_two(elements).ceil
    end

    def last_index_slice_of_three(elements)
      last_slice_of_three(elements) -1
    end

    def last_index_slice_of_two(elements)
      last_slice_of_two(elements) -1
    end

    def extra_empty_rows_of_three(elements)
      empty_rows = 0
      last_slice = last_slice_of_three(elements)
      slices = number_of_slices_of_three(elements)

      if last_slice - slices == 0
        empty_rows = 0
      elsif last_slice - slices > 0.5
        empty_rows = 2
      elsif last_slice - slices < 0.5
        empty_rows = 1
      end

      empty_rows
    end

    def extra_empty_rows_of_two(elements)
      empty_rows = 0
      last_slice = last_slice_of_two(elements)
      slices = number_of_slices_of_two(elements)

      if last_slice - slices == 0
        empty_rows = 0
      else
        empty_rows = 1
      end

      empty_rows
    end

    # Returns (one) latest news if any or nil
    # if there are no news
    def last_news_in_home_page
      news = nil
      if Refinery::News::Item.count > 0 
        items = Refinery::News::Item.latest(1)
        if items.count == 1 && items.first
          item = items.first

          # This is needed in order to avoid issues if the new is not available in other languages -%>
          if item.body != nil && item.title != nil
            news = item
          end
        end
      end
    end

    # Returns videos or nil
    # if there are no videos
    def videos_in_home_page
      videos = nil
      if Refinery::Videos::Video.count > 0 
        videos = Refinery::Videos::Video.all
      end
    end

  end # Module ViewsHelper
end   # Module Refinery
