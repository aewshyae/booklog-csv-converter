#!/usr/bin/ruby
# coding: utf-8
# Convert Csv To Bibliography−Style.
# Input: booklogYYYYMMDDHH24MISS.csv (Downloaded from http://booklog.jp/export/csv)
# Output:bibgraphYYYYMMDDHH24MISS.txt
class BCCUtility
  PAR_OPEN="『"
  PAR_CLOSE="』" 
  COMMA="、"
  PERIOD="。"
  def BCCUtility.conv2bibstyle(author, title, publisher, year)
    re_kana=/([ァ-ン]+|[A-Z])\K +(?=[ァ-ン]+|[A-Z])/
    re_nonword=/(\W+)\K +(?=\W+)/
    return author.gsub(re_kana,"・").gsub(re_nonword, "")+PAR_OPEN+title+PAR_CLOSE+publisher+COMMA+getKanjiYear(year)+PERIOD
  end
  
  KANJI_NUM = { 0=>'〇', 1=>'一', 2=>'二', 3=>'三', 4=>'四', 5=>'五', 6=>'六', 7=>'七', 8=>'八', 9=>'九' }
  NEN_KANJI="年"
  private
  def BCCUtility.getKanjiYear(year)
    yearKanji=""
    year.to_s.each_char{|c| yearKanji<<KANJI_NUM[c.to_i]}
    return yearKanji+NEN_KANJI
  end
end

class BooklogCsvConverter 
  if /booklog\d{14}\.csv/.match(ARGV[0])==nil then
      raise ArgumentError, 'ファイル名が異なります。ファイル名は"booklog99999999999999.csv"(9は数字,14桁)です。'
  end
  FILE_NAME='bibgraph' + Time.now.strftime("%Y%m%d_%H%M%S")+ '.txt'
  File.open(FILE_NAME, "w") { |o|
      File.open(ARGV[0], "r:Shift_jis:utf-8") { |f|
          f.each_line { |l| 
              array = l.delete("\"").split(",").slice(11,4)
              o.puts  BCCUtility.conv2bibstyle(array[1],array[0],array[2],array[3])
          }
      } 
  }
end

