namespace :lessons do
  desc  'Load lessons'
  task :load, [:html] => :environment do |t, args|
    html = open(args[:html]).read
    doc = Nokogiri::HTML(html)
    doc.css('#lessonlinks_all_content .lessonlinks_all_row').each do |lesson_doc|
      name = lesson_doc.css('.lessonlinks_all_lessontitle').text
      link = lesson_doc.at_css('a.lessonlinks_all_lesson_link')[:href]
      teacher = lesson_doc.at_css('.avatar')[:alt].try(:match, /Avatar of (.*)/).try(:[], 1)
      categories = lesson_doc.css('.lessonlinks_all_category_item').text.split('•').map do |category|
        category.encode(
          Encoding.find('ASCII'),
          invalid:           :replace,
          undef:             :replace,
          replace:           '',
          universal_newline: true
        )
      end

      next if Lesson.exists?(link: link)

      Lesson.create!(
        name:       name,
        link:       link,
        teacher:    teacher,
        categories: categories
      )
    end
  end
end
