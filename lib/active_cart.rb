$:.unshift(File.join(File.dirname(__FILE__), 'active_cart'))

require 'rubygems'
require 'singleton'
require 'forwardable'
require 'aasm'
require 'active_cart/item'
require 'active_cart/cart_storage'
require 'active_cart/order_total'
require 'active_cart/order_total_collection'
require 'active_cart/cart'

module ActiveCart
  VERSION = File.exist?('VERSION') ? File.read('VERSION') : ""
end
