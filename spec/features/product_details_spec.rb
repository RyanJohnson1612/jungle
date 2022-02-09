require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can navigate to a product page" do
    visit root_path

    expect(page).to have_css 'article.product', count: 10
    first('.product a.btn-default').click
    expect(page).to have_css '.products-show'

    save_screenshot

  end
end
