require File.dirname(__FILE__) + '/spec_helper'

module Rebay
  describe Shopping do
    before(:each) do
      @shopper = Shopping.new
      @shopper.stub!(:get_json_response).and_return(Rebay::Response.new({"Ack" => "Success"}))
    end

    it "should specify base url" do
      Shopping.base_url.should_not be_nil
    end

    it "should specify version" do
      Shopping::VERSION.should_not be_nil
    end

    context "siteid" do
      it "should default siteid" do
        @shopper.should_receive(:get_json_response).with(/EBAY-SOA-GLOBAL-ID=EBAY-US&/)
        @shopper.get_category_info(:CategoryID => '-1')
      end

      it "should default siteid" do
        Rebay::Api.default_site_id = "EBAY-IT"
        @shopper.should_receive(:get_json_response).with(/EBAY-SOA-GLOBAL-ID=EBAY-IT&/)
        @shopper.get_category_info(:CategoryID => '-1')
      end

      it "should default siteid" do
        Rebay::Api.default_site_id = "EBAY-MOTOR"
        @shopper.should_receive(:get_json_response).with(/EBAY-SOA-GLOBAL-ID=EBAY-MOTOR&/)
        @shopper.get_category_info(:CategoryID => '-1', :siteid => 99)
      end
    end

    context "after creation" do
      it "should provide get_category_info" do
        @shopper.should respond_to(:get_category_info)
      end

      it "should provide get_category_info_with_children" do
        @shopper.should respond_to(:get_category_info_with_children)
      end

      it "should provide find_products" do
        @shopper.should respond_to(:find_products)
      end

      it "should provide find_half_products" do
        @shopper.should respond_to(:find_half_products)
      end

      it "should provide get_single_item" do
        @shopper.should respond_to(:get_single_item)
      end

      it "should provide get_item_status" do
        @shopper.should respond_to(:get_item_status)
      end

      it "should provide get_shipping_costs" do
        @shopper.should respond_to(:get_shipping_costs)
      end

      it "should provide get_multiple_items" do
        @shopper.should respond_to(:get_multiple_items)
      end

      it "should provide get_user_profile" do
        @shopper.should respond_to(:get_user_profile)
      end

      it "should provide find_popular_searches" do
        @shopper.should respond_to(:find_popular_searches)
      end

      it "should provide find_popular_items" do
        @shopper.should respond_to(:find_popular_items)
      end

      it "should provide find_reviews_and_guides" do
        @shopper.should respond_to(:find_reviews_and_guides)
      end
    end

    context "when calling get_category_info" do
      it "should fail without args" do
        lambda { @shopper.get_category_info }.should raise_error(ArgumentError)
      end

      it "should return a hash response" do
        @shopper.get_category_info({:CategoryID => 29223}).class.should eq(Rebay::Response)
      end

      it "should succeed" do
        @shopper.get_category_info({:CategoryID => 29223}).success?.should be_true
      end

      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/shopping/get_category_info"))
        @shopper.stub!(:get_json_response).and_return(Rebay::Response.new(json))
        
        response = @shopper.get_category_info({:CategoryID => 1})
        
        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(1)
      end
    end

    context "when calling find_products" do
      it "should fail without args" do
        lambda { @shopper.find_products }.should raise_error(ArgumentError)
      end

      it "should return a hash response" do
        @shopper.find_products({:QueryKeywords => 'harry potter'}).class.should eq(Rebay::Response)
      end

      it "should succeed" do
        @shopper.find_products({:QueryKeywords => 'harry potter'}).success?.should be_true
      end

      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/shopping/find_products"))
        @shopper.stub!(:get_json_response).and_return(Rebay::Response.new(json))

        response = @shopper.find_products({:QueryKeywords => 'whatevs'})
        
        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(2)
      end
    end

    context "when calling find_half_products" do
      it "should fail without args" do
        lambda { @shopper.find_half_products }.should raise_error(ArgumentError)
      end

      it "should return a hash response" do
        @shopper.find_half_products({:QueryKeywords => 'harry potter'}).class.should eq(Rebay::Response)
      end

      it "should succeed" do
        @shopper.find_half_products({:QueryKeywords => 'harry potter'}).success?.should be_true
      end

      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/shopping/find_half_products"))
        @shopper.stub!(:get_json_response).and_return(Rebay::Response.new(json))

        response = @shopper.find_half_products({:QueryKeywords => 'whatevs'})
        
        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(2)
      end
    end

    context "when calling get_single_item" do
      it "should fail without args" do
        lambda { @shopper.get_single_item }.should raise_error(ArgumentError)
      end

      it "should return a hash response" do
        @shopper.get_single_item({:ItemID => 230139965209}).class.should eq(Rebay::Response)
      end

      it "should succeed" do
        @shopper.get_single_item({:ItemID => 230139965209}).success?.should be_true
      end
    end

    context "when calling get_item_status" do
      it "should fail without args" do
        lambda { @shopper.get_item_status }.should raise_error(ArgumentError)
      end

      it "should return a hash response" do
        @shopper.get_item_status({:ItemID => 230139965209}).class.should eq(Rebay::Response)
      end

      it "should succeed" do
        @shopper.get_item_status({:ItemID => 230139965209}).success?.should be_true
      end
    end

    context "when calling get_shipping_costs" do
      it "should fail without args" do
        lambda { @shopper.get_shipping_costs }.should raise_error(ArgumentError)
      end

      it "should return a hash response" do
        @shopper.get_shipping_costs({:ItemID => 230139965209}).class.should eq(Rebay::Response)
      end

      it "should succeed" do
        @shopper.get_shipping_costs({:ItemID => 230139965209}).success?.should be_true
      end
    end

    context "when calling get_multiple_items" do
      it "should fail without args" do
        lambda { @shopper.get_multiple_items }.should raise_error(ArgumentError)
      end

      it "should return a hash response" do
        @shopper.get_multiple_items({:ItemID => 230139965209}).class.should eq(Rebay::Response)
      end

      it "should succeed" do
        @shopper.get_multiple_items({:ItemID => 230139965209}).success?.should be_true
      end
    end

    context "when calling get_user_profile" do
      it "should fail without args" do
        lambda { @shopper.get_user_profile }.should raise_error(ArgumentError)
      end

      it "should return a hash response" do
        @shopper.get_user_profile({:UserID => 1}).class.should eq(Rebay::Response)
      end

      it "should succeed" do
        @shopper.get_user_profile({:UserID => 1}).success?.should be_true
      end
    end

    context "when calling find_popular_searches" do
      it "should fail without args" do
        lambda { @shopper.find_popular_searches }.should raise_error(ArgumentError)
      end

      it "should return a hash response" do
        @shopper.find_popular_searches({:CategoryID => 1}).class.should eq(Rebay::Response)
      end

      it "should succeed" do
        @shopper.find_popular_searches({:CategoryID => 1}).success?.should be_true
      end

      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/shopping/find_popular_searches"))
        @shopper.stub!(:get_json_response).and_return(Rebay::Response.new(json))

        response = @shopper.find_popular_searches({:CategoryID => 1})
        
        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(1)
      end
    end

    context "when calling find_popular_items" do
      it "should return a hash response" do
        @shopper.find_popular_items({:CategoryID => 1}).class.should eq(Rebay::Response)
      end

      it "should succeed" do
        @shopper.find_popular_items({:CategoryID => 1}).success?.should be_true
      end

      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/shopping/find_popular_items"))
        @shopper.stub!(:get_json_response).and_return(Rebay::Response.new(json))

        response = @shopper.find_popular_items({:CategoryID => 1})
        
        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(19)
      end
    end

    context "when calling find_reviews_and_guides" do
      it "should return a hash response" do
        @shopper.find_reviews_and_guides.class.should eq(Rebay::Response)
      end

      it "should succeed" do
        @shopper.find_reviews_and_guides.success?.should be_true
      end

      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/shopping/find_reviews_and_guides"))
        @shopper.stub!(:get_json_response).and_return(Rebay::Response.new(json))
        response = @shopper.find_reviews_and_guides

        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(5)
      end
    end
  end
end
