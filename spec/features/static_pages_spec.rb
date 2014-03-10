require 'spec_helper'
require 'database_cleaner'
require 'capybara-webkit'

describe "StaticPages" do

  subject { page }
  let(:home_h1) { "Learn Web Development for Free"}

  describe "Splash Page" do

    before { visit root_path }

    it "should have a title" do
      # save_and_open_page
      subject.source.should have_selector('title', text: "Odin") 
    end

    it { should have_selector('h1', text: home_h1) }
    it { should_not have_link :href => scheduler_path } # worthless test? It may need the link text too.
    it { should have_button "Explore the full curriculum" }
    it { should have_link 'Login', :href => login_path(:ref => "homenav") }
  end

  describe "study group page" do
  
    before { visit root_path }    
    context "should be linked to from the site footer" do  
      it { expect(page).to have_link("Study Group", :href => studygroup_path) }   
    end
    before { click_link "Study Group" }
    context "should load when link is clicked" do  
      it { current_path.should == studygroup_path }   
    end
    before { visit studygroup_path } 
    context "should contain an h1 title" do  
      it {expect(page).to have_selector("h1", :text => "Web Development Study Group")}
    end  
  end

  describe "legal pages" do
    
    context "on the home page" do
      before { visit root_path }

      it "should have a link in the footer for legal" do
        within("#footer") do
          expect(page).to have_link("Legal",:href => legal_path)
        end
      end
    end

    context "on the legal page" do
      before { visit legal_path }

      it "should have a relevant h1" do
        expect(page).to have_selector("h1",:text => "Legal Stuff")
      end

      it "should link to the Terms of Use" do
        expect(page).to have_link("Terms of Use", :href => tou_path)
      end

      it "should link to the CLA" do
        expect(page).to have_link("Contributor Licensing Agreement", :href => cla_path)
      end
    end

    context "on the Terms of Use page" do
      
      before { visit tou_path }

      it "should have a relevant h1 from the markdown" do
        expect(page).to have_selector("h1", :text => "Terms of Use")
      end
      it "should have a back button to the legal page" do
        expect(page).to have_link("", :href => legal_path)
      end
    end

    context "on the Contributor Licensing Agreement page" do

      before { visit cla_path }

      it "should have a relevant h1 from the markdown" do
        expect(page).to have_selector("h1", :text => "Contributor Licensing Agreement")
      end
      it "should have a back button to the legal page" do
        expect(page).to have_link("", :href => legal_path)
      end
    end
  end
end
