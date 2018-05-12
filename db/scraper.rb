require 'nokogiri'
require 'httparty'

class Scraper
    
    attr_accessor :parse_page

    def initialize
        doc = HTTParty.get("http://www.businessinsider.com/where-can-you-can-legally-smoke-weed-2018-1")
        @parse_page ||= Nokogiri::HTML(doc)
        
    end

    def states
        parse_page.css(".slide-title").css(".slide-title-text").children.map { |name| name.text }.compact
    end

    def descriptions
        parse_page.css(".slide-padding").css("div").children.map { |name| name.text.strip }.delete_if{|str| str.size < 78}.uniq
    end

    def description_scraper(word) 
        self.descriptions.select do |str|
            str.include?(word)
        end
    end

    def each_state_description
        self.states.map do |state|
            if state.include?("DC")
                self.description_scraper("capital")
            elsif state == "Washington"
                self.description_scraper(state).delete_if{|str| str.include?("Colorado")} 
            else 
                self.description_scraper(state)
            end.first
        end
    end
    
    def grow? 
        self.each_state_description.map do |state|
            state.include?("grow")
        end
    end

    def possession_data
        self.each_state_description.map do |state|
            state.split(". ").map do |sentence| 
                sentence.split(", ").find {|words| words.include?(" ounce")}
            end
        end.flatten.compact
    end

    def legal_to_possess
        self.possession_data.map do |sentence|
            if sentence.include?("an ounce") || sentence.include?("one ounce")
                1.0
            elsif sentence.include?("two ounce")
                2.0
            elsif sentence.include?("2.5 ounce")
                2.5
            end
        end
    end

    def scrape_hash(i) 
        hash = {}
        hash[:name] =  self.states[i]
        hash[:description] = self.each_state_description[i]
        hash[:legal_to_grow] = self.grow?[i]
        hash[:legal_to_possess] = self.legal_to_possess[i]
        hash
    end
end