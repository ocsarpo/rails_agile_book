require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_path
    assert_response :success
    assert_select 'nav.side_nav a', minimum: 4
    assert_select 'main ul.catalog li', 3
    assert_select 'h2', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/  # $표시, 적어도 1개의 숫자, 소수점 . , 그 뒤 두자리 숫자를 포함하는가?
  end

  test "markup needed for store.js is in place" do
    get store_path
    assert_select '.store .catalog > li > img', 3
    assert_select '.catalog input[type=submit]', 3
  end

end
