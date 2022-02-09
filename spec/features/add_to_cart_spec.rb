require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do
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

  scenario "They can add an item to their cart" do
    visit root_path
    expect(page).to have_css 'article.product', count: 10
    first('.product button.btn-primary').click
    expect(page).to have_text 'My Cart (1)'
    save_screenshot
  end

  scenario "They can add an item to their cart and see the item when they visit the cart" do
    visit root_path
    expect(page).to have_css 'article.product', count: 10
    first('.product button.btn-primary').click
    expect(page).to have_text 'My Cart (1)'
    click_on 'My Cart (1)'
    expect(page).to have_css '.table'
    save_screenshot
  end
end
