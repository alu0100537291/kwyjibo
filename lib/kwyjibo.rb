require "kwyjibo/version"

module Kwyjibo
    class Matriz
    	attr_accessor :rows, :cols, :data

    	undef rows=, cols=

    	def initialize(rows, cols)
    		@rows, @cols = rows, cols
    		@data = Array.new(@rows) {Array.new(@cols)}
    	end

    	def [](i)
    		@data[i]
    	end

    	def [](i, value)
    		@data[i] = value
    	end
    end
end
