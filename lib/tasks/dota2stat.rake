namespace :dota2stat do
  namespace :update do
    desc "Update heroes table"
    task :heroes => :environment do
      Hero.destroy_all
      json_heroes = Dota2api.get_heroes({:language => 'en'})
      fields = [:name, :localized_name]
      json_heroes.each do |json_hero|
        hero = Hero.find_or_initialize_by(:id => json_hero[:id])
        fields.each do |field|
          hero[field] = json_hero[field]
        end
        hero.save

        print "Update hero #{hero.name}\r\n"
      end
    end

    desc "Update items table"
    task :items => :environment do
      Item.destroy_all
      json_items = Dota2api.get_game_items({:language => 'en'})
      fields = [:name, :cost, :secret_shop, :side_shop, :recipe, :localized_name]
      json_items.each do |json_item|
        item = Item.find_or_initialize_by(:id => json_item[:id])
        fields.each do |field|
          item[field] = json_item[field]
        end
        item.save

        print "Update item #{item.name}\r\n"
      end
    end

    desc "Update lobbies table"
    task :lobbies => :environment do
      Lobby.destroy_all
      url = "https://raw.githubusercontent.com/kronusme/dota2-api/master/data/lobbies.json"
      page = open(url)
      text = page.read
      json_items = JSON.parse(text, :symbolize_names => true)[:lobbies]

      json_items.each do |json_item|
        item = Lobby.find_or_initialize_by(:id => json_item[:id])
        item.id = json_item[:id]

        item.name = json_item[:name]
        item.save({:id => json_item[:id]})

        print "Update item #{item.name}\r\n"
      end
    end

    desc "Update modes table"
    task :modes => :environment do
      Mode.destroy_all
      url = "https://raw.githubusercontent.com/kronusme/dota2-api/master/data/mods.json"
      page = open(url)
      text = page.read
      json_items = JSON.parse(text, :symbolize_names => true)[:mods]

      json_items.each do |json_item|
        item = Mode.find_or_initialize_by(:id => json_item[:id])
        item.name = json_item[:name]
        item.save

        print "Update item #{item.name}\r\n"
      end
    end

    desc "Update regions table"
    task :regions => :environment do
      Region.destroy_all
      url = "https://raw.githubusercontent.com/kronusme/dota2-api/master/data/regions.json"
      page = open(url)
      text = page.read
      json_items = JSON.parse(text, :symbolize_names => true)[:regions]

      json_items.each do |json_item|
        item = Region.find_or_initialize_by(:id => json_item[:id])
        item.name = json_item[:name]
        item.save

        print "Update item #{item.name}\r\n"
      end
    end

    desc "Update all matches for all users"
    task :all_matches => :environment do
      User.find_each do |user|
        params = {:account_id => user.account_id, :matches_requested => 50}

        first_match_id = nil
        is_break_loop = false

        loop do
          json_matches = Dota2api.get_match_history(params)

          json_matches.each do |json_match|
            first_match_id = json_match[:match_id] if first_match_id == nil

            user_last_match_found = user.last_updated_match_id == json_match[:match_id]
            json_matches_last_pack = json_matches.length < 2

            if user_last_match_found or json_matches_last_pack
              user.last_updated_match_id = first_match_id
              user.save
              is_break_loop = true
            end
            if user_last_match_found
              break
            end

            params[:start_at_match_id] = json_match[:match_id]
            unless match = Match.find_by_id(json_match[:match_id])
              json_detail_match = Dota2api.get_match_details({:match_id => json_match[:match_id]})
              match = Match.create_from_json(json_detail_match)

              print "Update match #{match.id}\r\n"
            end
          end
          break if is_break_loop
        end
      end
    end

    desc "temp_items"
    task :temp_items => :environment do
      Player.find_each do |player|
        player.items_old.each do |item|
          player.items << item
        end
      end
    end


  end
end