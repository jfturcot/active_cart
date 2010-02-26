require 'test_helper'

class CartTest < Test::Unit::TestCase
  context '' do
    context 'after setup' do
      setup do
        @cart_storage_engine = TestCartStorage.new
        @cart = ActiveCart::Cart.new(@cart_storage_engine)
      end

      context 'delegate to cart storage' do
        should 'delegate []' do
          @cart_storage_engine.expects(:[]).with(0)
          @cart[0]
        end

        should 'delegate <<' do
          test = TestItem.new
          @cart_storage_engine.expects(:<<).with(test)
          @cart << test
        end

        should 'delegate []=' do
          test = TestItem.new
          @cart_storage_engine.expects(:[]=).with(0, test)
          @cart[0] = test
        end

        should 'delegate :at' do
          @cart_storage_engine.expects(:at).with(1)
          @cart.at(1)
        end

        should 'delegate :clear' do
          @cart_storage_engine.expects(:clear)
          @cart.clear
        end

        should 'delegate :collect' do
          @cart_storage_engine.expects(:collect)
          @cart.collect
        end

        should 'delegate :map' do
          @cart_storage_engine.expects(:map)
          @cart.map
        end

        should 'delegate :delete' do
          test = TestItem.new
          @cart_storage_engine.expects(:delete).with(test)
          @cart.delete(test)
        end

        should 'delegate :delete_at' do
          @cart_storage_engine.expects(:delete_at).with(3)
          @cart.delete_at(3)
        end

        should 'delegate :each' do
          @cart_storage_engine.expects(:each)
          @cart.each
        end

        should 'delegate :each_index' do
          @cart_storage_engine.expects(:each_index)
          @cart.each_index
        end

        should 'delegate :empty' do
          @cart_storage_engine.expects(:empty?)
          @cart.empty?
        end

        should 'delegate :eql?' do
          @cart_storage_engine.expects(:eql?)
          @cart.eql?
        end

        should 'delegate :first' do
          @cart_storage_engine.expects(:first)
          @cart.first
        end

        should 'delegate :include?' do
          @cart_storage_engine.expects(:include?)
          @cart.include?
        end

        should 'delegate :index' do
          @cart_storage_engine.expects(:index)
          @cart.index
        end

        should 'delegate :inject' do
          @cart_storage_engine.expects(:inject)
          @cart.inject
        end

        should 'delegate :last' do
          @cart_storage_engine.expects(:last)
          @cart.last
        end

        should 'delegate :length' do
          @cart_storage_engine.expects(:length)
          @cart.length
        end

        should 'delegate :pop' do
          @cart_storage_engine.expects(:pop)
          @cart.pop
        end

        should 'delegate :push' do
          @cart_storage_engine.expects(:push)
          @cart.push
        end

        should 'delegate :shift' do
          @cart_storage_engine.expects(:shift)
          @cart.shift
        end

        should 'delegate :size' do
          @cart_storage_engine.expects(:size)
          @cart.size
        end

        should 'delegate :unshift' do
          @cart_storage_engine.expects(:unshift)
          @cart.unshift
        end

        should 'delegate :invoice_id' do
          @cart_storage_engine.expects(:invoice_id)
          @cart.invoice_id
        end

        should 'delegate :sub_total' do
          @cart_storage_engine.expects(:sub_total)
          @cart.sub_total
        end
      end

      context 'setup' do
        should 'take a block to add order_totals' do
          @total_1 = TestOrderTotal.new(10, true)
          @total_2 = TestOrderTotal.new(20, true)
          
          @cart_storage_engine = TestCartStorage.new
          @cart = ActiveCart::Cart.new(@cart_storage_engine) do |o|
            o << @total_1
            o << @total_2
          end
          assert_equal [ @total_1, @total_2 ], @cart.order_total_calculators
        end
      end

      context 'total' do
        should 'sum all the items in the cart with order totals' do
          @item_1 = TestItem.new(1)
          @item_1.price = 10
          @item_2 = TestItem.new(2)
          @item_2.price = 20
          @item_3 = TestItem.new(3)
          @item_3.price = 30
          @total_1 = TestOrderTotal.new(10, true)
          @total_2 = TestOrderTotal.new(20, true)

          @cart.order_total_calculators += [ @total_1, @total_2 ]
          @cart.add_to_cart(@item_1)
          @cart.add_to_cart(@item_2)
          @cart.add_to_cart(@item_3)

          assert_equal 90, @cart.total
        end
      end
    end
  end
end 
