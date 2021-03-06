# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Breads" do
    describe "Admin" do
      describe "breads", type: :feature do
        refinery_login

        describe "breads list" do
          before do
            FactoryGirl.create(:bread, :name => "UniqueTitleOne")
            FactoryGirl.create(:bread, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.breads_admin_breads_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.breads_admin_breads_path

            click_link "Add New Bread"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::Breads::Bread, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::Breads::Bread, :count)

              expect(page).to have_content("Name can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:bread, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.breads_admin_breads_path

              click_link "Add New Bread"

              fill_in "Name", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::Breads::Bread, :count)

              expect(page).to have_content("There were problems")
            end
          end

          context "with translations" do
            before do
              Refinery::I18n.stub(:frontend_locales).and_return([:en, :cs])
            end

            describe "add a page with title for default locale" do
              before do
                visit refinery.breads_admin_breads_path
                click_link "Add New Bread"
                fill_in "Name", :with => "First column"
                click_button "Save"
              end

              it "should succeed" do
                expect(Refinery::Breads::Bread.count).to eq(1)
              end

              it "should show locale marker for page" do
                p = Refinery::Breads::Bread.last
                within "#bread_#{p.id}" do
                  expect(page).to have_css(".locale_marker", text: 'EN')
                end
              end

              it "should show name in the admin menu" do
                p = Refinery::Breads::Bread.last
                within "#bread_#{p.id}" do
                  expect(page).to have_content('First column')
                end
              end
            end

            describe "add a bread with title for primary and secondary locale" do
              before do
                visit refinery.breads_admin_breads_path
                click_link "Add New Bread"
                fill_in "Name", :with => "First column"
                click_button "Save"

                visit refinery.breads_admin_breads_path
                within ".actions" do
                  click_link "Edit this bread"
                end
                within "#switch_locale_picker" do
                  click_link "CS"
                end
                fill_in "Name", :with => "First translated column"
                click_button "Save"
              end

              it "should succeed" do
                expect(Refinery::Breads::Bread.count).to eq(1)
                expect(Refinery::Breads::Bread::Translation.count).to eq(2)
              end

              it "should show locale flag for page" do
                p = Refinery::Breads::Bread.last
                within "#bread_#{p.id}" do
                  ##expect(page).to have_css(".locale_marker", text: 'EN')
                  expect(page).to have_css(".locale_marker", text: 'CS')
                end
              end

              it "should show name in backend locale in the admin menu" do
                p = Refinery::Breads::Bread.last
                within "#bread_#{p.id}" do
                  expect(page).to have_content('First translated column CS')
                end
              end
            end

            describe "add a name with title only for secondary locale" do
              before do
                visit refinery.breads_admin_breads_path
                click_link "Add New Bread"
                within "#switch_locale_picker" do
                  click_link "CS"
                end

                fill_in "Name", :with => "First translated column"
                click_button "Save"
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Breads::Bread.last
                within "#bread_#{p.id}" do
                  expect(page).to have_content('First translated column')
                end
              end

              it "should show locale flag for page" do
                p = Refinery::Breads::Bread.last
                within "#bread_#{p.id}" do
                  expect(page).to have_css(".locale_marker", text: 'CS')
                end
              end
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:bread, :name => "A name") }

          it "should succeed" do
            visit refinery.breads_admin_breads_path

            within ".actions" do
              click_link "Edit this bread"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            expect(page).to have_content("'A different name' was successfully updated.")
            expect(page).not_to have_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:bread, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.breads_admin_breads_path

            click_link "Remove this bread forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Breads::Bread.count).to eq(0)
          end
        end

      end
    end
  end
end
