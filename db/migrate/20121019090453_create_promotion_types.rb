class CreatePromotionTypes < ActiveRecord::Migration
  def change
    create_table :promotion_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    PromotionType.create(:name=>'Cash refund', :description=>'')
    PromotionType.create(:name=>'Competition - skill based', :description=>'')
    PromotionType.create(:name=>'Competition - skill based', :description=>'')
    PromotionType.create(:name=>'Extra free', :description=>'')
    PromotionType.create(:name=>'Free prize draw - non skill based', :description=>'')
    PromotionType.create(:name=>'Instant wins', :description=>'')
    PromotionType.create(:name=>'Jumbo packs', :description=>'')
    PromotionType.create(:name=>'Environmental/social/ ethical', :description=>'')
    PromotionType.create(:name=>'Health', :description=>'')
    PromotionType.create(:name=>'Launch / new product', :description=>'')
    PromotionType.create(:name=>'Licensing tie in (movie/sports property)', :description=>'')
    PromotionType.create(:name=>'Multibuy', :description=>'')
    PromotionType.create(:name=>'Price comparison', :description=>'')
    PromotionType.create(:name=>'Product information', :description=>'')
    PromotionType.create(:name=>'Satisfaction challenge', :description=>'')
    PromotionType.create(:name=>'Seasonal', :description=>'')
    PromotionType.create(:name=>'Discount', :description=>'')
    PromotionType.create(:name=>'Premium incentive (gift)', :description=>'')
    PromotionType.create(:name=>'Free trial (enclosed/attached)', :description=>'')
    PromotionType.create(:name=>'Loyalty', :description=>'')
    PromotionType.create(:name=>'Experiential/sampling', :description=>'')
    PromotionType.create(:name=>'Endorsement', :description=>'')
    PromotionType.create(:name=>'Bespoke product/limited edition', :description=>'')
    PromotionType.create(:name=>'Collector scheme', :description=>'')
    PromotionType.create(:name=>'Self promotion', :description=>'')
    PromotionType.create(:name=>'Image only', :description=>'')
    PromotionType.create(:name=>'Award recognition', :description=>'')
  end
end



























