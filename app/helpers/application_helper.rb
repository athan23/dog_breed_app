module ApplicationHelper
  def format_breed_name(name)
    words_array = name.split(' ')
    reversed_words_array = words_array.reverse
    result = reversed_words_array.join('/')
    result
  end
end
