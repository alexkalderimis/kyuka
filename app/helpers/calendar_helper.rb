module CalendarHelper

  TITLE_CLASS = ""

  def cell_class current_date
    classes = []
    classes << 'weekend' if (current_date.saturday? || current_date.sunday?)
    classes.join ' '
  end

  def calendar_title
    ->(start_date) {
      render partial: 'title', locals: {start_date: start_date}
    }
  end

  def calendar_link which
    ->(_, _) {
      render partial: 'page_link', locals: {
        arrow: (which == :prev ? "&laquo;" : "&raquo;"),
        delta: (which == :prev ? (-1.month) : (1.month)),
        which: which
      }
    }
  end

end
